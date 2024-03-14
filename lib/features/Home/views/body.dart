import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:lifebloodworld/features/Community/welcome_screen.dart';
import 'package:lifebloodworld/features/Donate/views/home.dart';
import 'package:lifebloodworld/models/blooddonationschedule.dart';
import 'package:lifebloodworld/models/bloodtestschedule.dart';
import 'package:lifebloodworld/features/Home/views/knowbloodtype.dart';
import 'package:lifebloodworld/features/Home/views/managebloodtestapp.dart';
import 'package:lifebloodworld/features/Home/views/schedulebloodtest.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:lifebloodworld/features/Labs/views/labs.dart';
import 'package:lifebloodworld/features/More/components/body.dart';
import 'package:lifebloodworld/features/More/home_screen.dart';
import 'package:lifebloodworld/features/Notification/views/body.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../main.dart';
import '../../../constants/colors.dart';
import 'home.dart';
import 'search.dart';

class DonationCarddata {
  DonationCarddata({required this.donortype, required this.date});

  factory DonationCarddata.fromJson(Map<String, dynamic> json) {
    return DonationCarddata(donortype: json['donor_type'], date: json['date']);
  }

  String date;
  String donortype;
}

DateTime now = DateTime.now();
String formattedNewDate = DateFormat('d MMM yyyy').format(now);
String formattedNextDonationDateFormat = DateFormat('yyyy-MM-dd').format(now);
String formattedNewMonth = DateFormat('LLLL').format(now);
String formattedNewYear = DateFormat('y').format(now);

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.pageIndex}) : super(key: key);

  int pageIndex;

  @override
  HomePageState createState() => HomePageState(pageIndex: pageIndex);
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  HomePageState({Key? key, required this.pageIndex});

  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFFe0e9e4),
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: Center(
        child: SafeArea(
          child: IndexedStack(
            index: pageIndex,
            children: <Widget>[
              home(),
              donate(),
              // labbody(),
              CommunityPageScreen(),
              notification(),
              // memorebody(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyle(
            color: Color(0xff389e9d),
            fontFamily: 'Montserrat',
            overflow: TextOverflow.fade,
            letterSpacing: 0,
            fontSize: 11),
        unselectedLabelStyle: TextStyle(
            fontFamily: 'Montserrat',
            overflow: TextOverflow.fade,
            letterSpacing: 0,
            fontSize: 11),
        selectedItemColor: const Color(0xff389e9d),
        backgroundColor: const Color(0xFFebf5f5),
        type: BottomNavigationBarType.fixed,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.houseUser),
            activeIcon: FaIcon(FontAwesomeIcons.houseUser),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.droplet),
            activeIcon: FaIcon(FontAwesomeIcons.droplet),
            label: '',
          ), BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.peopleGroup),
            activeIcon: FaIcon(FontAwesomeIcons.peopleGroup),
            label: '',
          ),
         BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.bell),
            activeIcon: FaIcon(FontAwesomeIcons.solidBell),
            label: '',
          ),
         
          
          
        ],
        currentIndex: pageIndex,
        onTap: (int index) {
          setState(
            () {
              pageIndex = index;
            },
          );
        },
      ),
    );
  }
}



class manageAppointments extends StatefulWidget {
  const manageAppointments({Key? key}) : super(key: key);

  @override
  State<manageAppointments> createState() => _manageAppointmentsState();
}

class _manageAppointmentsState extends State<manageAppointments> {
  String? address;
  String? agecategory;
  String? bloodtype;
  Timer? debouncer;
  String? district;
  String? email;
  String? gender;
  String? phonenumber;
  String? prevdonation;
  String query = '';
  List<BloodTestSchAppdata> schedule = [];
  String? totalsch;
  String? totalschfamily;
  String? totalschfriend;
  String? totalschmyself;
  String? ufname;
  String? ulname;
  String? umname;

@override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      phonenumber = prefs.getString('phonenumber');
      ufname = prefs.getString('ufname');
      umname = prefs.getString('umname');
      ulname = prefs.getString('ulname');
      totalsch = prefs.getString('totalsch');
      totalschmyself = prefs.getString('totalschmyself');
      totalschfriend = prefs.getString('totalschfriend');
      totalschfamily = prefs.getString('totalschfamily');
    });
  }

  Future<List<BloodTestSchAppdata>> getBloodTestApp(String query) async {
    var data = {'phonenumber': phonenumber};

    var response = await http.post(
        Uri.parse("https://community.lifebloodsl.com/manageappointments.php"),
        body: json.encode(data));

    if (response.statusCode == 200) {
      final List schedule = json.decode(response.body);

      return schedule
          .map((json) => BloodTestSchAppdata.fromJson(json))
          .where((schedule) {
        final facilityLower = schedule.facility.toLowerCase();
        final refcodeLower = schedule.refcode.toLowerCase();
        final searchLower = query.toLowerCase();

        return facilityLower.contains(searchLower) ||
            refcodeLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<BloodTestSchAppdata>> getMyBloodTestApp(String query) async {
    var data = {'phonenumber': phonenumber, 'bloodtestfor': 'Myself'};

    var response = await http.post(
        Uri.parse(
            "https://community.lifebloodsl.com/managemybgtappointments.php"),
        body: json.encode(data));

    if (response.statusCode == 200) {
      final List schedule = json.decode(response.body);

      return schedule
          .map((json) => BloodTestSchAppdata.fromJson(json))
          .where((schedule) {
        final facilityLower = schedule.facility.toLowerCase();
        final refcodeLower = schedule.refcode.toLowerCase();
        final dateLower = schedule.date.toLowerCase();
        final timeslotLower = schedule.timeslot.toLowerCase();
        final statusLower = schedule.status.toLowerCase();
        final firstnameLower = schedule.firstname.toLowerCase();
        final middlenameLower = schedule.middlename.toLowerCase();
        final lastnameLower = schedule.lastname.toLowerCase();
        final emailLower = schedule.email.toLowerCase();
        final phonenumberLower = schedule.phonenumber.toLowerCase();
        final searchLower = query.toLowerCase();

        return facilityLower.contains(searchLower) ||
            dateLower.contains(searchLower) ||
            timeslotLower.contains(searchLower) ||
            statusLower.contains(searchLower) ||
            firstnameLower.contains(searchLower) ||
            middlenameLower.contains(searchLower) ||
            lastnameLower.contains(searchLower) ||
            emailLower.contains(searchLower) ||
            phonenumberLower.contains(searchLower) ||
            refcodeLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<BloodTestSchAppdata>> getFamilyBloodTestApp(String query) async {
    var data = {'phonenumber': phonenumber, 'bloodtestfor': 'Family'};

    var response = await http.post(
        Uri.parse(
            "https://community.lifebloodsl.com/managebgtappointments.php"),
        body: json.encode(data));

    if (response.statusCode == 200) {
      final List schedule = json.decode(response.body);

      return schedule
          .map((json) => BloodTestSchAppdata.fromJson(json))
          .where((schedule) {
        final facilityLower = schedule.facility.toLowerCase();
        final refcodeLower = schedule.refcode.toLowerCase();
        final dateLower = schedule.date.toLowerCase();
        final timeslotLower = schedule.timeslot.toLowerCase();
        final statusLower = schedule.status.toLowerCase();
        final firstnameLower = schedule.firstname.toLowerCase();
        final middlenameLower = schedule.middlename.toLowerCase();
        final lastnameLower = schedule.lastname.toLowerCase();
        final emailLower = schedule.email.toLowerCase();
        final phonenumberLower = schedule.phonenumber.toLowerCase();
        final searchLower = query.toLowerCase();

        return facilityLower.contains(searchLower) ||
            dateLower.contains(searchLower) ||
            timeslotLower.contains(searchLower) ||
            statusLower.contains(searchLower) ||
            firstnameLower.contains(searchLower) ||
            middlenameLower.contains(searchLower) ||
            lastnameLower.contains(searchLower) ||
            emailLower.contains(searchLower) ||
            phonenumberLower.contains(searchLower) ||
            refcodeLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<BloodTestSchAppdata>> getFriendBloodTestApp(String query) async {
    var data = {'phonenumber': phonenumber, 'bloodtestfor': 'Friend'};

    var response = await http.post(
        Uri.parse(
            "https://community.lifebloodsl.com/managebgtappointments.php"),
        body: json.encode(data));

    if (response.statusCode == 200) {
      final List schedule = json.decode(response.body);

      return schedule
          .map((json) => BloodTestSchAppdata.fromJson(json))
          .where((schedule) {
        final facilityLower = schedule.facility.toLowerCase();
        final refcodeLower = schedule.refcode.toLowerCase();
        final dateLower = schedule.date.toLowerCase();
        final timeslotLower = schedule.timeslot.toLowerCase();
        final statusLower = schedule.status.toLowerCase();
        final firstnameLower = schedule.firstname.toLowerCase();
        final middlenameLower = schedule.middlename.toLowerCase();
        final lastnameLower = schedule.lastname.toLowerCase();
        final emailLower = schedule.email.toLowerCase();
        final phonenumberLower = schedule.phonenumber.toLowerCase();
        final searchLower = query.toLowerCase();

        return facilityLower.contains(searchLower) ||
            dateLower.contains(searchLower) ||
            timeslotLower.contains(searchLower) ||
            statusLower.contains(searchLower) ||
            firstnameLower.contains(searchLower) ||
            middlenameLower.contains(searchLower) ||
            lastnameLower.contains(searchLower) ||
            emailLower.contains(searchLower) ||
            phonenumberLower.contains(searchLower) ||
            refcodeLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Widget buildbloodtestallSearch() => SearchWidget(
        text: query,
        hintText: 'Search for a schedule..',
        onChanged: searchBook,
      );

  Future searchBook(String query) async => debounce(() async {
        final schedule = await getBloodTestApp(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.schedule = schedule;
        });
      });

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  // if (response.statusCode == 200) {
  //
  //   print(response.statusCode);
  //
  //   final items = json.decode(response.body).cast<Map<String, dynamic>>();
  //   List<BloodTestSchAppdata> bloodtestschList = items.map<BloodTestSchAppdata>((json) {
  //     return BloodTestSchAppdata.fromJson(json);
  //   }).toList();
  //   return bloodtestschList;
  // }
  // else {
  //   print(response.statusCode.toString());
  //   throw Exception('Failed load data with status code ${response.statusCode}');
  // }

  // }catch(e){
  //   print (e);
  //   throw e;}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
           backgroundColor: Color(0xFFe0e9e4),
          appBar: AppBar(
            automaticallyImplyLeading: true,
            elevation: 0,
            backgroundColor: Colors.teal,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => managebloodtestAppointments(),
                      ),
            )),
            title: Text.rich(
              TextSpan(
                style: TextStyle(
                  color: Color(0xFF205072),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: 'Blood Group Test Schedule, ',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: '$totalsch',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.left,
            ),
          ),
          body: Column(children: <Widget>[
        buildbloodtestallSearch(),
        Expanded(
          child: FutureBuilder<List<BloodTestSchAppdata>>(
              future: getBloodTestApp(query),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.teal,
                  ));
                } else if (!snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/icons/sad.png",
                            height: 60.h,
                            width: 60.w,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "No Blood Group Test\nschedule found..",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 15,
                                color: Color(0xFFE02020)),
                          ),
                           (totalsch == "0")?Text(
                                "No  Blood Group Test schedule found..",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                    color: Color(0xFFE02020)),
                              ):Column(
                                children: [
                                  Text(
                                    "No Blood Group Test schedule found..\nPlease check your internet connection",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 12,
                                        color: Color(0xFFE02020)),
                                  ),
                                  Padding(
                                padding: EdgeInsets.only(
                                    top: 5.r, right: 15.r, left: 15.r),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.refresh, color: Colors.teal,),
                                        Text('Refresh Page',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color: Colors.teal)),
                                      ],
                                    ),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white, shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => super.widget));
                                    },
                                  ),
                                ),
                              ),
                                ]),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                color: Color(0xFF205072),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Hi, ',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xFF205072),
                                  ),
                                ),
                                TextSpan(
                                  text: "$ufname $ulname",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF205072),
                                  ),
                                ),
                              ],
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Do you want to know your blood group?\nKindly schedule a Blood Group Test.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13,
                                color: Color(0xFF205072)),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                child: Text('Schedule Now',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12, color: Colors.white)),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.teal,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (context) => scheduletypebody(),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  );
                } else {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text.rich(
                            //   TextSpan(
                            //     style: TextStyle(
                            //       color: Color(
                            //           0xFF205072),
                            //       fontSize: 15,
                            //       fontWeight: FontWeight
                            //           .bold,
                            //     ),
                            //     children: [
                            //       TextSpan(
                            //         text: 'Total Donations : ',
                            //         style: GoogleFonts
                            //             .montserrat(
                            //             fontSize: 14,
                            //             fontWeight: FontWeight
                            //                 .normal,
                            //             color: Colors.teal),
                            //       ),
                            //       TextSpan(
                            //         text: snapshot.data?.length.toString(),
                            //         style: GoogleFonts
                            //             .montserrat(
                            //           fontSize: 14,
                            //           fontWeight: FontWeight
                            //               .bold,
                            //           color: Colors.teal,),
                            //       ),
                            //     ],
                            //   ),
                            //   textHeightBehavior: TextHeightBehavior(
                            //       applyHeightToFirstAscent: false),
                            //   textAlign: TextAlign.left,
                            // ),
                          ],
                        ),
                        Expanded(
                          child: ListView(
                            children: snapshot.data!
                                .map((data) => Column(
                                      children: <Widget>[
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Container(
                                                        padding: EdgeInsets.only(
                                                            bottom:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(.0, 5.0,
                                                                  5.0, 5.0),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10.w),
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.r),
                                                              width: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFFebf5f5),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .teal),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16),
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      Column(
                                                                        children: [
                                                                          Image
                                                                              .asset(
                                                                            'assets/icons/calendar.png',
                                                                            height:
                                                                                40.h,
                                                                            width:
                                                                                40.w,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5.h,
                                                                          ),
                                                                          Text.rich(
                                                                            TextSpan(
                                                                              style: TextStyle(
                                                                                color: Color(0xFF205072),
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                              children: [
                                                                                TextSpan(
                                                                                  text: data.bloodtestfor,
                                                                                  style: GoogleFonts.montserrat(
                                                                                    fontSize: 13,
                                                                                    fontWeight: FontWeight.normal,
                                                                                    color: Color(0xff389e9d),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            textHeightBehavior:
                                                                                TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        child:
                                                                            Container(
                                                                          color:
                                                                              Color(0xFFe0e9e4),
                                                                          height:
                                                                              50.h,
                                                                          width:
                                                                              1.w,
                                                                        ),
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                              'Blood Group Test Schedule Information',
                                                                              textAlign: TextAlign.center,
                                                                              style: GoogleFonts.montserrat(fontSize: 10, color: Color(0xff389e9d))),
                                                                          SizedBox(
                                                                            height:
                                                                                5.h,
                                                                          ),
                                                                          Text.rich(
                                                                            TextSpan(
                                                                              style: TextStyle(
                                                                                color: Color(0xFF205072),
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                              children: [
                                                                                TextSpan(
                                                                                  text: 'Facility: ',
                                                                                  style: GoogleFonts.montserrat(
                                                                                    fontSize: 13,
                                                                                    fontWeight: FontWeight.normal,
                                                                                    color: Color(0xFF205072),
                                                                                  ),
                                                                                ),
                                                                                TextSpan(
                                                                                  text: data.facility,
                                                                                  style: GoogleFonts.montserrat(
                                                                                    fontSize: 13,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Color(0xFF205072),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            textHeightBehavior:
                                                                                TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                2.h,
                                                                          ),
                                                                          Text.rich(
                                                                            TextSpan(
                                                                              style: TextStyle(
                                                                                color: Color(0xFF205072),
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                              children: [
                                                                                TextSpan(
                                                                                  text: 'Date: ',
                                                                                  style: GoogleFonts.montserrat(
                                                                                    fontSize: 13,
                                                                                    fontWeight: FontWeight.normal,
                                                                                    color: Color(0xFF205072),
                                                                                  ),
                                                                                ),
                                                                                TextSpan(
                                                                                  text: data.date,
                                                                                  style: GoogleFonts.montserrat(
                                                                                    fontSize: 13,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Color(0xFF205072),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            textHeightBehavior:
                                                                                TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                2.h,
                                                                          ),
                                                                          Text.rich(
                                                                            TextSpan(
                                                                              style: TextStyle(
                                                                                color: Color(0xFF205072),
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                              children: [
                                                                                TextSpan(
                                                                                  text: 'Time Slot: ',
                                                                                  style: GoogleFonts.montserrat(
                                                                                    fontSize: 13,
                                                                                    fontWeight: FontWeight.normal,
                                                                                    color: Color(0xFF205072),
                                                                                  ),
                                                                                ),
                                                                                TextSpan(
                                                                                  text: data.timeslot,
                                                                                  style: GoogleFonts.montserrat(
                                                                                    fontSize: 13,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Color(0xFF205072),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            textHeightBehavior:
                                                                                TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                2.h,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Text.rich(
                                                                                TextSpan(
                                                                                  style: TextStyle(
                                                                                    color: Color(0xFF205072),
                                                                                    fontSize: 15,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                  children: [
                                                                                    TextSpan(
                                                                                      text: 'Refcode: ',
                                                                                      style: GoogleFonts.montserrat(
                                                                                        fontSize: 13,
                                                                                        fontWeight: FontWeight.normal,
                                                                                        color: Color(0xFF205072),
                                                                                      ),
                                                                                    ),
                                                                                    TextSpan(
                                                                                      text: data.refcode,
                                                                                      style: GoogleFonts.montserrat(
                                                                                        fontSize: 13,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Color(0xFF205072),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                textAlign: TextAlign.left,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 5.h,
                                                                              ),
                                                                              InkWell(
                                                                                onTap: () async {
                                                                                  await Clipboard.setData(ClipboardData(text: data.refcode));
                                                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                    duration: Duration(seconds: 5),
                                                                                    content: Text('Copied to clipboard', textAlign: TextAlign.center, style: GoogleFonts.montserrat()),
                                                                                  ));
                                                                                },
                                                                                child: Row(
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.copy,
                                                                                      size: 10,
                                                                                    ),
                                                                                    Text(' Copy Code ',
                                                                                        style: GoogleFonts.montserrat(
                                                                                          fontSize: 10,
                                                                                          fontWeight: FontWeight.normal,
                                                                                          color: Colors.black,
                                                                                        )),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                2.h,
                                                                          ),
                                                                          Text.rich(
                                                                            TextSpan(
                                                                              style: TextStyle(
                                                                                color: Color(0xFF205072),
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                              children: [
                                                                                TextSpan(
                                                                                  text: 'Status: ',
                                                                                  style: GoogleFonts.montserrat(
                                                                                    fontSize: 13,
                                                                                    fontWeight: FontWeight.normal,
                                                                                    color: Color(0xFF205072),
                                                                                  ),
                                                                                ),
                                                                                TextSpan(
                                                                                  text: data.status,
                                                                                  style: GoogleFonts.montserrat(
                                                                                    fontSize: 13,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: (data.status == "Pending")
                                                                                        ? Colors.amber
                                                                                        : (data.status == "Confirmed")
                                                                                            ? Color(0xff389e9d)
                                                                                            : (data.status == "Rescheduled")
                                                                                                ? Colors.blue
                                                                                                : Color(0xFFE02020),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            textHeightBehavior:
                                                                                TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                          ),
                                                                          Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              TextButton(
                                                                                child: Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.add,
                                                                                      color: Color(0xff389e9d),
                                                                                      size: 11.h,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 3.w,
                                                                                    ),
                                                                                    Text('More Information', style: GoogleFonts.montserrat(fontSize: 11, color: Color(0xff389e9d))),
                                                                                  ],
                                                                                ),
                                                                                style: TextButton.styleFrom(
                                                                                  foregroundColor: Colors.white,
                                                                                  backgroundColor: Colors.transparent,
                                                                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
                                                                                ),
                                                                                onPressed: () {
                                                                                  showModalBottomSheet(
                                                                                    backgroundColor: Color(0xFFebf5f5),
                                                                                    context: context,
                                                                                    builder: (context) {
                                                                                      return SingleChildScrollView(
                                                                                        child: Container(
                                                                                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                            child: Column(
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              children: [
                                                                                                InkWell(
                                                                                                  onTap: () {
                                                                                                    Navigator.pop(context);
                                                                                                  },
                                                                                                  child: Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                    children: [
                                                                                                      Text(' Close', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 13, color: Colors.red)),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                Text('More Information', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                SizedBox(
                                                                                                  height: 10.h,
                                                                                                ),
                                                                                                Form(
                                                                                                  // key: _formKey,
                                                                                                  autovalidateMode: AutovalidateMode.always,
                                                                                                  child: Column(
                                                                                                    children: [
                                                                                                      TextFormField(
                                                                                                        keyboardType: TextInputType.number,
                                                                                                        initialValue: data.firstname,
                                                                                                        style: TextStyle(fontSize: 15, fontFamily: 'Montserrat'),
                                                                                                        enabled: false,
                                                                                                        readOnly: true,
                                                                                                        validator: (value) {
                                                                                                          if (value!.isEmpty) {
                                                                                                            return 'Phone Number is required';
                                                                                                          }
                                                                                                          return null;
                                                                                                        },
                                                                                                        decoration: InputDecoration(labelText: 'First Name', hintText: 'Enter New Phone Number', labelStyle: TextStyle(fontSize: 15, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15, fontFamily: 'Montserrat')),
                                                                                                      ),
                                                                                                      // ignore: unnecessary_null_comparison
                                                                                                      (data.middlename == null)
                                                                                                          ? SizedBox(width: 0.w)
                                                                                                          : TextFormField(
                                                                                                              keyboardType: TextInputType.number,
                                                                                                              initialValue: data.middlename,
                                                                                                              style: TextStyle(fontSize: 15, fontFamily: 'Montserrat'),
                                                                                                              enabled: false,
                                                                                                              readOnly: true,
                                                                                                              validator: (value) {
                                                                                                                if (value!.isEmpty) {
                                                                                                                  return 'Phone Number is required';
                                                                                                                }
                                                                                                                return null;
                                                                                                              },
                                                                                                              decoration: InputDecoration(labelText: 'Middle Name', hintText: 'Enter New Phone Number', labelStyle: TextStyle(fontSize: 15, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15, fontFamily: 'Montserrat')),
                                                                                                            ),
                                                                                                      TextFormField(
                                                                                                        keyboardType: TextInputType.number,
                                                                                                        initialValue: data.lastname,
                                                                                                        style: TextStyle(fontSize: 15, fontFamily: 'Montserrat'),
                                                                                                        enabled: false,
                                                                                                        readOnly: true,
                                                                                                        validator: (value) {
                                                                                                          if (value!.isEmpty) {
                                                                                                            return 'Phone Number is required';
                                                                                                          }
                                                                                                          return null;
                                                                                                        },
                                                                                                        decoration: InputDecoration(labelText: 'Last Name', hintText: 'Enter New Phone Number', labelStyle: TextStyle(fontSize: 15, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15, fontFamily: 'Montserrat')),
                                                                                                      ),
                                                                                                      TextFormField(
                                                                                                        keyboardType: TextInputType.number,
                                                                                                        initialValue: data.gender,
                                                                                                        style: TextStyle(fontSize: 15, fontFamily: 'Montserrat'),
                                                                                                        enabled: false,
                                                                                                        readOnly: true,
                                                                                                        validator: (value) {
                                                                                                          if (value!.isEmpty) {
                                                                                                            return 'Phone Number is required';
                                                                                                          }
                                                                                                          return null;
                                                                                                        },
                                                                                                        decoration: InputDecoration(labelText: 'Gender', hintText: 'Enter New Phone Number', labelStyle: TextStyle(fontSize: 15, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15, fontFamily: 'Montserrat')),
                                                                                                      ),
                                                                                                      TextFormField(
                                                                                                        keyboardType: TextInputType.text,
                                                                                                        initialValue: data.phonenumber,
                                                                                                        style: TextStyle(fontSize: 15, fontFamily: 'Montserrat'),
                                                                                                        enabled: false,
                                                                                                        readOnly: true,
                                                                                                        decoration: InputDecoration(labelText: 'Phonenumber', labelStyle: TextStyle(fontSize: 15, fontFamily: 'Montserrat')),
                                                                                                      ),
                                                                                                      TextFormField(
                                                                                                        keyboardType: TextInputType.text,
                                                                                                        initialValue: data.email,
                                                                                                        style: TextStyle(fontSize: 15, fontFamily: 'Montserrat'),
                                                                                                        enabled: false,
                                                                                                        readOnly: true,
                                                                                                        decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(fontSize: 15, fontFamily: 'Montserrat')),
                                                                                                      ),
                                                                                                      (data.address != null)
                                                                                                          ? TextFormField(
                                                                                                              keyboardType: TextInputType.text,
                                                                                                              enabled: false,
                                                                                                              readOnly: true,
                                                                                                              initialValue: data.address,
                                                                                                              style: TextStyle(fontSize: 15, fontFamily: 'Montserrat'),
                                                                                                              validator: (value) {
                                                                                                                if (value!.isEmpty) {
                                                                                                                  return 'Address is required';
                                                                                                                }
                                                                                                                return null;
                                                                                                              },
                                                                                                              decoration: InputDecoration(labelText: 'Address', hintText: 'Enter New Address', labelStyle: TextStyle(fontSize: 15, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15, fontFamily: 'Montserrat')),
                                                                                                            )
                                                                                                          : SizedBox(
                                                                                                              height: 0.h,
                                                                                                            ),
                                                                                                      SizedBox(height: 10.h),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 10.h,
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  );
                                                                                },
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              )
                                            ])
                                      ],
                                    ))
                                .toList(),
                          ),
                        )
                      ]);
                }
              }),
        ),
      ]),
        ));
  }
}




