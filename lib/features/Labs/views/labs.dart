import 'dart:async';
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifebloodworld/models/blooddonationschedule.dart';
import 'package:lifebloodworld/models/bloodtestschedule.dart';
import 'package:lifebloodworld/features/Home/views/bgresults.dart';
import 'package:lifebloodworld/features/Home/views/bloodtestbody.dart';
import 'package:lifebloodworld/features/Home/views/bloodtestbodyfam.dart';
import 'package:lifebloodworld/features/Home/views/famregister.dart';
import 'package:lifebloodworld/features/Home/views/managedonationpp.dart';
import 'package:lifebloodworld/features/Home/views/search.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:lifebloodworld/features/Labs/views/labresults.dart';
import 'package:lifebloodworld/features/Labs/views/labstests.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:lifebloodworld/widgets/text_field_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../main.dart';
import '../../../constants/colors.dart';


class facilitydata {
  String rbtc;
  String rbtcid;
  String name;
  String communityname;
  String district;

  facilitydata(
      {required this.rbtc,
      required this.rbtcid,
      required this.name,
      required this.communityname,
      required this.district});

  factory facilitydata.fromJson(Map<String, dynamic> json) {
    return facilitydata(
        rbtc: json['rbtc'],
        rbtcid: json['rbtcid'].toString(),
        name: json['name'],
        communityname: json['communityname'],
        district: json['district']);
  }

  Map<String, dynamic> toJson() => {
        'rbtc': rbtc,
        'rbtcid': rbtcid,
        'name': name,
        'communityname': communityname
      };
}

class labbody extends StatefulWidget {
  @override
  State createState() {
    return labbodyState();
  }
}

class labbodyState extends State<labbody> {
  String? address;
  String? agecategory;
  String? bloodtestfor;
  String? bloodtype;
  Timer? debouncer;
  String? district;
  String donationquery = '';
  List<BloodDonationSchAppdata> donationschedule = [];
  String? email;
  String? gender;
  String? phonenumber;
  String? prevdonation;
  String query = "";
  bool ratingappbar = false;
  TextEditingController refcode = TextEditingController();
  String? schufname;
  String? schulname;
  String? schumname;
  String? selectedRating = '';
  String? status;
  String? totalbgresult;
  String? totaldonationrep;
  String? totaldonationvol;
  String? totaldonationvolcan;
  String? totaldonationvolcon;
  String? totaldonationvold;
  String? totaldonationvolp;
  String? totaldonationvolr;
  String? totalsch;
  String? totalschfamily;
  String? totalschfriend;
  String? totalschmyself;
  String? ufname;
  String? ulname;
  String? umname;

  final _formKey = GlobalKey<FormState>();
  late Timer _getBgresulttimer;
  late Timer _getTotalDonationstimer;
  bool _validate = false;
  List facilityList = [];

  final List<String> costlist = ['Free', 'Paid'];

  String? selectedFacility = '';
  String? selectedCost = '';

  Future findfacility() async {
    var response = await http
        .get(Uri.parse("https://community.lifebloodsl.com/findfacility.php"));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        facilityList = jsonData;
      });
    }
    print(facilityList);
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  @override
  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      phonenumber = prefs.getString('phonenumber');
      ufname = prefs.getString('ufname');
      umname = prefs.getString('umname');
      ulname = prefs.getString('ulname');
      totaldonationrep = prefs.getString('totaldonationrep');
      totaldonationvol = prefs.getString('totaldonationvol');
      totaldonationvold = prefs.getString('totaldonationvold');
      totaldonationvolp = prefs.getString('totaldonationvolp');
      totaldonationvolcon = prefs.getString('totaldonationvolcon');
      totaldonationvolr = prefs.getString('totaldonationvolr');
      totaldonationvolcan = prefs.getString('totaldonationvolcan');
    });
  }

  @override
  void initState() {
    super.initState();
    getRefPref();
    getBgresult();

    _getBgresulttimer =
        Timer.periodic(const Duration(seconds: 2), (timer) => getBgresult());
  }
  
  TextEditingController _password = TextEditingController();
  bool _passwordVisible = false;
  bool _isloginLoading = false;

  void getRefPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      ufname = prefs.getString('ufname');
      umname = prefs.getString('umname');
      ulname = prefs.getString('ulname');
      phonenumber = prefs.getString('phonenumber');
      totalbgresult = prefs.getString('totalbgresult');
      totalsch = prefs.getString('totalsch');
      totalschmyself = prefs.getString('totalschmyself');
      totalschfriend = prefs.getString('totalschfriend');
      totalschfamily = prefs.getString('totalschfamily');
    });
  }

  Future getBgresult() async {
    var data = {'phonenumber': phonenumber};
    var response = await http.post(
        Uri.parse(
            "https://community.lifebloodsl.com/totalbloodgroupresult.php"),
        body: json.encode(data));
    print(response.body);
    var msg = jsonDecode(response.body);
    if (msg['totalbgresults'] == true) {
      setState(() {
        totalbgresult = msg['userInfo'].toString();
      });
      savetbgrPref();
    }
    return totalbgresult;
  }

  savetbgrPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('totalbgresult', totalbgresult!);
  }

  savePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email!);
    prefs.setString('phonenumber', phonenumber!);
    prefs.setString('status', status!);
    prefs.setString('schufname', schufname!);
    prefs.setString('schumname', schumname!);
    prefs.setString('schulname', schulname!);
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

  Future<List<BloodTestSchAppdata>> getBloodTestResultApp(String query) async {
    var data = {'phonenumber': phonenumber};

    var response = await http.post(
        Uri.parse(
            "https://community.lifebloodsl.com/manageappointmentsresults.php"),
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

  Future<bool> getInternetUsingInternetConnectivity() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  Future<List<BloodTestSchAppdata>> getFriendBloodTestApp(String query) async {
    var data = {'phonenumber': phonenumber, 'bloodtestfor': 'Friend'};

    var response = await http.post(
        Uri.parse("http://localhost/sbims/community/managebgtappointments.php"),
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

  Future<List<BloodDonationSchAppdata>> getBloodDonationApp(
      String donationquery) async {
    var data = {'phonenumber': '+23278621647'};

    var response = await http.post(
        Uri.parse(
            "https://community.lifebloodsl.com/managedonationappointments.php"),
        body: json.encode(data));
    if (response.statusCode == 200) {
      final List donationschedule = json.decode(response.body);
      return donationschedule
          .map((json) => BloodDonationSchAppdata.fromJson(json))
          .where((donationschedule) {
        final facilityLower = donationschedule.facility.toLowerCase();
        final refcodeLower = donationschedule.refcode.toLowerCase();
        final searchLower = donationquery.toLowerCase();
        return facilityLower.contains(searchLower) ||
            refcodeLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future sendrating() async {
    if (selectedRating!.isNotEmpty) {
      var response = await http.post(
          Uri.parse(
              "https://community.lifebloodsl.com/blooddonationrating.php"),
          body: {
            "phonenumber": phonenumber,
            "rating": selectedRating,
            "refcode": refcode,
          });

      var data = json.decode(response.body);
      if (data == "Error") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please Try Again, Feedback Already Exists'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.fixed,
          duration: Duration(seconds: 3),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
            height: 20.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Rating Successfully Sent',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                    )),
              ],
            ),
          ),
          backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.fixed,
          duration: Duration(seconds: 5),
        ));
        // scheduleAlarm();
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            ratingappbar = true;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => managedonationAppointments(),
            ),
          );
        });
      }
    }
  }

  Widget builddonationSearch() => SearchWidget(
        text: donationquery,
        hintText: 'Search Laboratory',
        onChanged: searchBook,
      );

  Future searchBook(String donationquery) async => debounce(() async {
        final donationschedule = await getBloodDonationApp(donationquery);

        if (!mounted) return;

        setState(() {
          this.donationquery = donationquery;
          this.donationschedule = donationschedule;
        });
      });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      
      backgroundColor: Color(0xFFe0e9e4),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10),
          color: Color(0xFFe0e9e4),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
              children: [
                SizedBox(height: 15.h),
                Padding(
                  padding: const EdgeInsets.only(left:15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Laboratory",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF205072)),
                          ),
                          ],
                      ),
                      
                    ],
                  ),
                ),
              ],
            ),
                  builddonationSearch(),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 3.h,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            .0, 5.0, 5.0, 5.0),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          child: Container(
                                            padding: EdgeInsets.all(10.r),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.teal),
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        'Laboratory Details',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 10.sp,
                                                                color: Color(
                                                                    0xff389e9d))),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text.rich(
                                                          TextSpan(
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF205072),
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    'Connaught Hospital',
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                          letterSpacing: 0,
                                                                  color: Color(
                                                                      0xFF205072),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          textHeightBehavior:
                                                              TextHeightBehavior(
                                                                  applyHeightToFirstAscent:
                                                                      false),
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                        
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 2.h,
                                                    ),
                                                    Text(
                                                      '7 Lamina Sankoh Street',
                                                      style: TextStyle(
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                            letterSpacing: 0,
                                                        fontFamily:
                                                            'Montserrat',
                                                        color:
                                                            Color(0xFF205072),
                                                      ),
                                                      overflow:
                                                          TextOverflow.clip,
                                                    ),
                                                    Text.rich(
                                                      TextSpan(
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF205072),
                                                          fontSize: 15.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'Western Area Urban',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Color(
                                                                  0xFF205072),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      textHeightBehavior:
                                                          TextHeightBehavior(
                                                              applyHeightToFirstAscent:
                                                                  false),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                    SizedBox(
                                                      height: 2.h,
                                                    ),
                                                    
                                                    TextButton(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text('Explore Laboratory Tests',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                fontSize: 11.sp,
                                                                letterSpacing:
                                                                    0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color:
                                                                    kPrimaryColor,
                                                              )),
                                                        ],
                                                      ),
                                                      style:
                                                          TextButton.styleFrom(
                                                        foregroundColor:
                                                            Colors.white,
                                                        backgroundColor:
                                                            kPrimaryColor
                                                                .shade100,
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            labtestbody()));
                                                         
                                                      },
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
                              height: 0.h,
                            )
                          ])
                    ],
                  ))

                  //           Expanded(
                  //               child: FutureBuilder<List<BloodDonationSchAppdata>>(
                  //                   future: getBloodDonationApp(donationquery),
                  //                   builder: (context, snapshot) {
                  //                     if (snapshot.connectionState ==
                  //                         ConnectionState.waiting) {
                  //                       return Center(
                  //                           child: CircularProgressIndicator(
                  //                         color: Colors.teal,
                  //                       ));
                  //                     } else if (!snapshot.hasData) {
                  //                       return Column(
                  //                         crossAxisAlignment: CrossAxisAlignment.center,
                  //                         mainAxisAlignment: MainAxisAlignment.center,
                  //                         children: [
                  //                           Column(
                  //                             crossAxisAlignment:
                  //                                 CrossAxisAlignment.center,
                  //                             mainAxisAlignment: MainAxisAlignment.center,
                  //                             children: [

                  //                               SizedBox(
                  //                                 height: 10.h,
                  //                               ),
                  //                               Text(
                  //                                       "No blood donation schedule found..",
                  //                                       textAlign: TextAlign.center,
                  //                                       style: TextStyle(
                  //                                           fontFamily: 'Montserrat',
                  //                                           fontSize: 12.sp,
                  //                                           color: Color(0xFFE02020)),
                  //                                     ),

                  //                                  Padding(
                  //                         padding: EdgeInsets.only(
                  //                             top: 5.r, right: 15.r, left: 15.r),
                  //                         child: SizedBox(
                  //                           width: double.infinity,
                  //                           child: TextButton(
                  //                             child: Row(
                  //                               mainAxisAlignment: MainAxisAlignment.center,
                  //                               children: [
                  //                                 Icon(Icons.refresh, color: Colors.teal,),
                  //                                 Text('Refresh Page',
                  //                                     textAlign: TextAlign.center,
                  //                                     style: GoogleFonts.montserrat(
                  //                                         fontSize: 12.sp,
                  //                                         color: Colors.teal)),
                  //                               ],
                  //                             ),
                  //                             style: TextButton.styleFrom(
                  //                               foregroundColor: Colors.white,

                  //                               shape: const RoundedRectangleBorder(
                  //                                   borderRadius: BorderRadius.all(
                  //                                       Radius.circular(10))),
                  //                             ),
                  //                             onPressed: () {
                  //                               Navigator.pushReplacement(
                  // context,
                  // MaterialPageRoute(
                  //     builder: (BuildContext context) => super.widget));
                  //                             },
                  //                           ),
                  //                         ),
                  //                       ),

                  //                               SizedBox(
                  //                                 height: 10.h,
                  //                               ),
                  //                               Text.rich(
                  //                                 TextSpan(
                  //                                   style: TextStyle(
                  //                                     color: Color(0xFF205072),
                  //                                     fontSize: 15.sp,
                  //                                     fontWeight: FontWeight.bold,
                  //                                   ),
                  //                                   children: [
                  //                                     TextSpan(
                  //                                       text: 'Hi, ',
                  //                                       style: GoogleFonts.montserrat(
                  //                                         fontSize: 14.sp,
                  //                                         fontWeight: FontWeight.normal,
                  //                                         color: Color(0xFF205072),
                  //                                       ),
                  //                                     ),
                  //                                     TextSpan(
                  //                                       text: "$ufname $ulname",
                  //                                       style: GoogleFonts.montserrat(
                  //                                         fontSize: 14.sp,
                  //                                         fontWeight: FontWeight.bold,
                  //                                         color: Color(0xFF205072),
                  //                                       ),
                  //                                     ),
                  //                                   ],
                  //                                 ),
                  //                                 textHeightBehavior: TextHeightBehavior(
                  //                                     applyHeightToFirstAscent: false),
                  //                                 textAlign: TextAlign.left,
                  //                               ),
                  //                               SizedBox(
                  //                                 height: 10.h,
                  //                               ),
                  //                               Text(
                  //                                 "Do you want to donate and save lives?\nKindly schedule a blood donation.",
                  //                                 textAlign: TextAlign.center,
                  //                                 style: TextStyle(
                  //                                     fontFamily: 'Montserrat',
                  //                                     fontSize: 13.sp,
                  //                                     color: Color(0xFF205072)),
                  //                               ),
                  //                               Padding(
                  //                                 padding: EdgeInsets.only(
                  //                                     top: 5.r, right: 15.r, left: 15.r),
                  //                                 child: SizedBox(
                  //                                   width: double.infinity,
                  //                                   child: TextButton(
                  //                                     child: Text('Schedule Now',
                  //                                         textAlign: TextAlign.center,
                  //                                         style: GoogleFonts.montserrat(
                  //                                             fontSize: 12.sp,
                  //                                             color: Colors.white)),
                  //                                     style: TextButton.styleFrom(
                  //                                       foregroundColor: Colors.white,
                  //                                       backgroundColor:
                  //                                           Color(0xff389e9d),
                  //                                       shape:
                  //                                           const RoundedRectangleBorder(
                  //                                               borderRadius:
                  //                                                   BorderRadius.all(
                  //                                                       Radius.circular(
                  //                                                           10))),
                  //                                     ),
                  //                                     onPressed: () {
                  //                                       // Navigator.push(
                  //                                       //   context,
                  //                                       //   new MaterialPageRoute(
                  //                                       //     builder: (context) =>
                  //                                       //         HomePageScreen(pageIndex: 2),
                  //                                       //   ),
                  //                                       // );
                  //                                     },
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                               SizedBox(
                  //                                 width: 5.w,
                  //                               )
                  //                             ],
                  //                           ),
                  //                         ],
                  //                       );
                  //                     } else {
                  //                       return Column(
                  //                           mainAxisAlignment: MainAxisAlignment.start,
                  //                           crossAxisAlignment: CrossAxisAlignment.start,
                  //                           children: [
                  //                             Column(
                  //                               mainAxisAlignment:
                  //                                   MainAxisAlignment.start,
                  //                               crossAxisAlignment:
                  //                                   CrossAxisAlignment.start,
                  //                               children: [
                  //                                 // Text.rich(
                  //                                 //   TextSpan(
                  //                                 //     style: TextStyle(
                  //                                 //       color: Color(
                  //                                 //           0xFF205072),
                  //                                 //       fontSize: 15.sp,
                  //                                 //       fontWeight: FontWeight
                  //                                 //           .bold,
                  //                                 //     ),
                  //                                 //     children: [
                  //                                 //       TextSpan(
                  //                                 //         text: 'Total Donations : ',
                  //                                 //         style: GoogleFonts
                  //                                 //             .montserrat(
                  //                                 //             fontSize: 14.sp,
                  //                                 //             fontWeight: FontWeight
                  //                                 //                 .normal,
                  //                                 //             color: Colors.teal),
                  //                                 //       ),
                  //                                 //       TextSpan(
                  //                                 //         text: snapshot.data?.length.toString(),
                  //                                 //         style: GoogleFonts
                  //                                 //             .montserrat(
                  //                                 //           fontSize: 14.sp,
                  //                                 //           fontWeight: FontWeight
                  //                                 //               .bold,
                  //                                 //           color: Colors.teal,),
                  //                                 //       ),
                  //                                 //     ],
                  //                                 //   ),
                  //                                 //   textHeightBehavior: TextHeightBehavior(
                  //                                 //       applyHeightToFirstAscent: false),
                  //                                 //   textAlign: TextAlign.left,
                  //                                 // ),
                  //                               ],
                  //                             ),
                  //                             Expanded(
                  //                               child: ListView(
                  //                                 children: snapshot.data!
                  //                                     .map((data) => Column(
                  //                                           children: <Widget>[
                  //                                             Column(
                  //                                                 crossAxisAlignment:
                  //                                                     CrossAxisAlignment
                  //                                                         .center,
                  //                                                 children: [
                  //                                                   SizedBox(
                  //                                                     height: 3.h,
                  //                                                   ),
                  //                                                   Row(
                  //                                                     children: <Widget>[
                  //                                                       Expanded(
                  //                                                         child:
                  //                                                             SingleChildScrollView(
                  //                                                           child:
                  //                                                               Container(
                  //                                                             padding: EdgeInsets.only(
                  //                                                                 bottom: MediaQuery.of(context)
                  //                                                                     .viewInsets
                  //                                                                     .bottom),
                  //                                                             child:
                  //                                                                 Padding(
                  //                                                               padding: EdgeInsets.fromLTRB(
                  //                                                                   .0,
                  //                                                                   5.0,
                  //                                                                   5.0,
                  //                                                                   5.0),
                  //                                                               child:
                  //                                                                   Padding(
                  //                                                                 padding:
                  //                                                                     EdgeInsets.symmetric(horizontal: 10.w),
                  //                                                                 child:
                  //                                                                     Container(
                  //                                                                   padding:
                  //                                                                       EdgeInsets.all(10.r),
                  //                                                                   width:
                  //                                                                       double.infinity,
                  //                                                                   decoration:
                  //                                                                       BoxDecoration(
                  //                                                                     color:
                  //                                                                         Colors.white,
                  //                                                                     border:
                  //                                                                         Border.all(color: Colors.teal),
                  //                                                                     borderRadius:
                  //                                                                         BorderRadius.circular(16),
                  //                                                                   ),
                  //                                                                   child:
                  //                                                                       Column(
                  //                                                                     mainAxisAlignment:
                  //                                                                         MainAxisAlignment.center,
                  //                                                                     crossAxisAlignment:
                  //                                                                         CrossAxisAlignment.center,
                  //                                                                     children: [
                  //                                                                       Row(
                  //                                                                         crossAxisAlignment: CrossAxisAlignment.center,
                  //                                                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //                                                                         children: [
                  //                                                                           Column(
                  //                                                                             children: [
                  //                                                                               Image.asset(
                  //                                                                                 'assets/icons/blood-bag.png',
                  //                                                                                 height: 40.h,
                  //                                                                                 width: 40.w,
                  //                                                                               ),
                  //                                                                               SizedBox(
                  //                                                                                 height: 5.h,
                  //                                                                               ),
                  //                                                                               Text.rich(
                  //                                                                                 TextSpan(
                  //                                                                                   style: TextStyle(
                  //                                                                                     color: Color(0xFF205072),
                  //                                                                                     fontSize: 15.sp,
                  //                                                                                     fontWeight: FontWeight.bold,
                  //                                                                                   ),
                  //                                                                                   children: [
                  //                                                                                     TextSpan(
                  //                                                                                       text: data.donortype,
                  //                                                                                       style: GoogleFonts.montserrat(
                  //                                                                                         fontSize: 12.sp,
                  //                                                                                         fontWeight: FontWeight.normal,
                  //                                                                                         color: Color(0xff389e9d),
                  //                                                                                       ),
                  //                                                                                     ),
                  //                                                                                   ],
                  //                                                                                 ),
                  //                                                                                 textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                  //                                                                                 textAlign: TextAlign.left,
                  //                                                                               ),
                  //                                                                             ],
                  //                                                                           ),
                  //                                                                           SizedBox(
                  //                                                                             child: Container(
                  //                                                                               color: Color(0xFFe0e9e4),
                  //                                                                               height: 50.h,
                  //                                                                               width: 1.w,
                  //                                                                             ),
                  //                                                                           ),
                  //                                                                           Column(
                  //                                                                             crossAxisAlignment: CrossAxisAlignment.start,
                  //                                                                             mainAxisAlignment: MainAxisAlignment.start,
                  //                                                                             children: [
                  //                                                                               Text('Blood Donation Schedule Information', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 10.sp, color: Color(0xff389e9d))),
                  //                                                                               SizedBox(
                  //                                                                                 height: 5.h,
                  //                                                                               ),
                  //                                                                               Text.rich(
                  //                                                                                 TextSpan(
                  //                                                                                   style: TextStyle(
                  //                                                                                     color: Color(0xFF205072),
                  //                                                                                     fontSize: 15.sp,
                  //                                                                                     fontWeight: FontWeight.bold,
                  //                                                                                   ),
                  //                                                                                   children: [
                  //                                                                                     TextSpan(
                  //                                                                                       text: 'Facility: ',
                  //                                                                                       style: GoogleFonts.montserrat(
                  //                                                                                         fontSize: 13.sp,
                  //                                                                                         fontWeight: FontWeight.normal,
                  //                                                                                         color: Color(0xFF205072),
                  //                                                                                       ),
                  //                                                                                     ),
                  //                                                                                     TextSpan(
                  //                                                                                       text: data.facility,
                  //                                                                                       style: GoogleFonts.montserrat(
                  //                                                                                         fontSize: 13.sp,
                  //                                                                                         fontWeight: FontWeight.bold,
                  //                                                                                         color: Color(0xFF205072),
                  //                                                                                       ),
                  //                                                                                     ),
                  //                                                                                   ],
                  //                                                                                 ),
                  //                                                                                 textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                  //                                                                                 textAlign: TextAlign.left,
                  //                                                                               ),
                  //                                                                               SizedBox(
                  //                                                                                 height: 2.h,
                  //                                                                               ),
                  //                                                                               Text.rich(
                  //                                                                                 TextSpan(
                  //                                                                                   style: TextStyle(
                  //                                                                                     color: Color(0xFF205072),
                  //                                                                                     fontSize: 15.sp,
                  //                                                                                     fontWeight: FontWeight.bold,
                  //                                                                                   ),
                  //                                                                                   children: [
                  //                                                                                     TextSpan(
                  //                                                                                       text: 'Date: ',
                  //                                                                                       style: GoogleFonts.montserrat(
                  //                                                                                         fontSize: 13.sp,
                  //                                                                                         fontWeight: FontWeight.normal,
                  //                                                                                         color: Color(0xFF205072),
                  //                                                                                       ),
                  //                                                                                     ),
                  //                                                                                     TextSpan(
                  //                                                                                       text: data.date,
                  //                                                                                       style: GoogleFonts.montserrat(
                  //                                                                                         fontSize: 13.sp,
                  //                                                                                         fontWeight: FontWeight.bold,
                  //                                                                                         color: Color(0xFF205072),
                  //                                                                                       ),
                  //                                                                                     ),
                  //                                                                                   ],
                  //                                                                                 ),
                  //                                                                                 textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                  //                                                                                 textAlign: TextAlign.left,
                  //                                                                               ),
                  //                                                                               Text.rich(
                  //                                                                                 TextSpan(
                  //                                                                                   style: TextStyle(
                  //                                                                                     color: Color(0xFF205072),
                  //                                                                                     fontSize: 15.sp,
                  //                                                                                     fontWeight: FontWeight.bold,
                  //                                                                                   ),
                  //                                                                                   children: [
                  //                                                                                     TextSpan(
                  //                                                                                       text: 'Time Slot: ',
                  //                                                                                       style: GoogleFonts.montserrat(
                  //                                                                                         fontSize: 13.sp,
                  //                                                                                         fontWeight: FontWeight.normal,
                  //                                                                                         color: Color(0xFF205072),
                  //                                                                                       ),
                  //                                                                                     ),
                  //                                                                                     TextSpan(
                  //                                                                                       text: data.timeslot,
                  //                                                                                       style: GoogleFonts.montserrat(
                  //                                                                                         fontSize: 13.sp,
                  //                                                                                         fontWeight: FontWeight.bold,
                  //                                                                                         color: Color(0xFF205072),
                  //                                                                                       ),
                  //                                                                                     ),
                  //                                                                                   ],
                  //                                                                                 ),
                  //                                                                                 textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                  //                                                                                 textAlign: TextAlign.left,
                  //                                                                               ),
                  //                                                                               SizedBox(
                  //                                                                                 height: 2.h,
                  //                                                                               ),
                  //                                                                               Row(
                  //                                                                                 children: [
                  //                                                                                   Text.rich(
                  //                                                                                     TextSpan(
                  //                                                                                       style: TextStyle(
                  //                                                                                         color: Color(0xFF205072),
                  //                                                                                         fontSize: 15.sp,
                  //                                                                                         fontWeight: FontWeight.bold,
                  //                                                                                       ),
                  //                                                                                       children: [
                  //                                                                                         TextSpan(
                  //                                                                                           text: 'Refcode: ',
                  //                                                                                           style: GoogleFonts.montserrat(
                  //                                                                                             fontSize: 13.sp,
                  //                                                                                             fontWeight: FontWeight.normal,
                  //                                                                                             color: Color(0xFF205072),
                  //                                                                                           ),
                  //                                                                                         ),
                  //                                                                                         TextSpan(
                  //                                                                                           text: data.refcode,
                  //                                                                                           style: GoogleFonts.montserrat(
                  //                                                                                             fontSize: 13.sp,
                  //                                                                                             fontWeight: FontWeight.bold,
                  //                                                                                             color: Color(0xFF205072),
                  //                                                                                           ),
                  //                                                                                         ),
                  //                                                                                       ],
                  //                                                                                     ),
                  //                                                                                     textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                  //                                                                                     textAlign: TextAlign.left,
                  //                                                                                   ),
                  //                                                                                   SizedBox(
                  //                                                                                     width: 5.h,
                  //                                                                                   ),
                  //                                                                                   InkWell(
                  //                                                                                     onTap: () async {
                  //                                                                                       await Clipboard.setData(ClipboardData(text: data.refcode));
                  //                                                                                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //                                                                                         duration: Duration(seconds: 5),
                  //                                                                                         content: Text('Copied to clipboard', textAlign: TextAlign.center, style: GoogleFonts.montserrat()),
                  //                                                                                       ));
                  //                                                                                     },
                  //                                                                                     child: Row(
                  //                                                                                       children: [
                  //                                                                                         Icon(
                  //                                                                                           Icons.copy,
                  //                                                                                           size: 10,
                  //                                                                                         ),
                  //                                                                                         Text(' Copy Code ',
                  //                                                                                             style: GoogleFonts.montserrat(
                  //                                                                                               fontSize: 10.sp,
                  //                                                                                               fontWeight: FontWeight.normal,
                  //                                                                                               color: Colors.black,
                  //                                                                                             )),
                  //                                                                                       ],
                  //                                                                                     ),
                  //                                                                                   )
                  //                                                                                 ],
                  //                                                                               ),
                  //                                                                               SizedBox(
                  //                                                                                 height: 2.h,
                  //                                                                               ),
                  //                                                                               Text.rich(
                  //                                                                                 TextSpan(
                  //                                                                                   style: TextStyle(
                  //                                                                                     color: Color(0xFF205072),
                  //                                                                                     fontSize: 15.sp,
                  //                                                                                     fontWeight: FontWeight.bold,
                  //                                                                                   ),
                  //                                                                                   children: [
                  //                                                                                     TextSpan(
                  //                                                                                       text: 'Status: ',
                  //                                                                                       style: GoogleFonts.montserrat(
                  //                                                                                         fontSize: 13.sp,
                  //                                                                                         fontWeight: FontWeight.normal,
                  //                                                                                         color: Color(0xFF205072),
                  //                                                                                       ),
                  //                                                                                     ),
                  //                                                                                     TextSpan(
                  //                                                                                       text: data.status,
                  //                                                                                       style: GoogleFonts.montserrat(
                  //                                                                                         fontSize: 13.sp,
                  //                                                                                         fontWeight: FontWeight.bold,
                  //                                                                                         color: (data.status == "Pending")
                  //                                                                                             ? Colors.amber
                  //                                                                                             : (data.status == "Confirmed")
                  //                                                                                                 ? Colors.green
                  //                                                                                                 : (data.status == "Donated")
                  //                                                                                                     ? Color(0xff389e9d)
                  //                                                                                                     : Color(0xFFE02020),
                  //                                                                                       ),
                  //                                                                                     ),
                  //                                                                                   ],
                  //                                                                                 ),
                  //                                                                                 textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                  //                                                                                 textAlign: TextAlign.left,
                  //                                                                               ),
                  //                                                                               SizedBox(
                  //                                                                                 height: 5.h,
                  //                                                                               ),
                  //                                                                             ],
                  //                                                                           ),
                  //                                                                         ],
                  //                                                                       ),
                  //                                                                       (data.status == "Donated")
                  //                                                                           ? Column(
                  //                                                                               mainAxisAlignment: MainAxisAlignment.center,
                  //                                                                               crossAxisAlignment: CrossAxisAlignment.center,
                  //                                                                               children: [
                  //                                                                                 (data.review == "Yes")
                  //                                                                                     ? Container(
                  //                                                                                         width: double.infinity,
                  //                                                                                         child: TextButton(
                  //                                                                                           child: Padding(
                  //                                                                                             padding: EdgeInsets.symmetric(horizontal: 5.w),
                  //                                                                                             child: Row(
                  //                                                                                               crossAxisAlignment: CrossAxisAlignment.center,
                  //                                                                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                                                                                               children: [
                  //                                                                                                 Text('Your Experience: ', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.teal)),
                  //                                                                                                 (data.rating == "Highly Dissatisfied")
                  //                                                                                                     ? Row(
                  //                                                                                                         children: [
                  //                                                                                                           Image.asset(
                  //                                                                                                             'assets/icons/hdis.png',
                  //                                                                                                             height: 20.h,
                  //                                                                                                             width: 20.w,
                  //                                                                                                           ),
                  //                                                                                                           SizedBox(
                  //                                                                                                             width: 3.w,
                  //                                                                                                           ),
                  //                                                                                                           Text(data.rating, textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.red[300])),
                  //                                                                                                         ],
                  //                                                                                                       )
                  //                                                                                                     : (data.rating == "Dissatisfied")
                  //                                                                                                         ? Row(
                  //                                                                                                             children: [
                  //                                                                                                               Image.asset(
                  //                                                                                                                 'assets/icons/dis.png',
                  //                                                                                                                 height: 20.h,
                  //                                                                                                                 width: 20.w,
                  //                                                                                                               ),
                  //                                                                                                               SizedBox(
                  //                                                                                                                 width: 3.w,
                  //                                                                                                               ),
                  //                                                                                                               Text(data.rating, textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.red[300])),
                  //                                                                                                             ],
                  //                                                                                                           )
                  //                                                                                                         : (data.rating == "Neutral")
                  //                                                                                                             ? Row(
                  //                                                                                                                 children: [
                  //                                                                                                                   Image.asset(
                  //                                                                                                                     'assets/icons/neutral.png',
                  //                                                                                                                     height: 20.h,
                  //                                                                                                                     width: 20.w,
                  //                                                                                                                   ),
                  //                                                                                                                   SizedBox(
                  //                                                                                                                     width: 3.w,
                  //                                                                                                                   ),
                  //                                                                                                                   Text(data.rating, textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.amber)),
                  //                                                                                                                 ],
                  //                                                                                                               )
                  //                                                                                                             : (data.rating == "Satisified")
                  //                                                                                                                 ? Row(
                  //                                                                                                                     children: [
                  //                                                                                                                       Image.asset(
                  //                                                                                                                         'assets/icons/sat.png',
                  //                                                                                                                         height: 20.h,
                  //                                                                                                                         width: 20.w,
                  //                                                                                                                       ),
                  //                                                                                                                       SizedBox(
                  //                                                                                                                         width: 3.w,
                  //                                                                                                                       ),
                  //                                                                                                                       Text(data.rating, textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.green[300])),
                  //                                                                                                                     ],
                  //                                                                                                                   )
                  //                                                                                                                 : Row(
                  //                                                                                                                     children: [
                  //                                                                                                                       Image.asset(
                  //                                                                                                                         'assets/icons/hsat.png',
                  //                                                                                                                         height: 20.h,
                  //                                                                                                                         width: 20.w,
                  //                                                                                                                       ),
                  //                                                                                                                       SizedBox(
                  //                                                                                                                         width: 3.w,
                  //                                                                                                                       ),
                  //                                                                                                                       Text(data.rating, textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.green)),
                  //                                                                                                                     ],
                  //                                                                                                                   ),
                  //                                                                                               ],
                  //                                                                                             ),
                  //                                                                                           ),
                  //                                                                                           style: TextButton.styleFrom(
                  //                                                                                             foregroundColor: Colors.red,
                  //                                                                                             backgroundColor: Colors.grey[100],
                  //                                                                                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  //                                                                                           ),
                  //                                                                                           onPressed: () {},
                  //                                                                                         ),
                  //                                                                                       )
                  //                                                                                     : Container(
                  //                                                                                         width: double.infinity,
                  //                                                                                         child: TextButton(
                  //                                                                                           child: Row(
                  //                                                                                             crossAxisAlignment: CrossAxisAlignment.center,
                  //                                                                                             mainAxisAlignment: MainAxisAlignment.center,
                  //                                                                                             children: [
                  //                                                                                               Text('Rate Your Experience', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                  //                                                                                             ],
                  //                                                                                           ),
                  //                                                                                           style: TextButton.styleFrom(
                  //                                                                                             foregroundColor: Colors.white,
                  //                                                                                             backgroundColor: Colors.teal,
                  //                                                                                             shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  //                                                                                           ),
                  //                                                                                           onPressed: () {
                  //                                                                                             showModalBottomSheet(
                  //                                                                                                 isScrollControlled: true,
                  //                                                                                                 backgroundColor: Color(0xFFebf5f5),
                  //                                                                                                 context: context,
                  //                                                                                                 builder: (context) {
                  //                                                                                                   return SingleChildScrollView(
                  //                                                                                                     child: Container(
                  //                                                                                                       padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  //                                                                                                       child: Padding(
                  //                                                                                                         padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                  //                                                                                                         child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                  //                                                                                                           SizedBox(
                  //                                                                                                             height: 3.h,
                  //                                                                                                           ),
                  //                                                                                                           Text('Rate Your Experience', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff389e9d))),
                  //                                                                                                           SizedBox(
                  //                                                                                                             height: 5.h,
                  //                                                                                                           ),
                  //                                                                                                           Text('Let us know how we can improve.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.normal, color: Color(0xff406986))),
                  //                                                                                                           SizedBox(
                  //                                                                                                             height: 5.h,
                  //                                                                                                           ),
                  //                                                                                                           Container(
                  //                                                                                                             width: double.infinity,
                  //                                                                                                             child: SizedBox(
                  //                                                                                                               child: Divider(
                  //                                                                                                                 color: Colors.teal,
                  //                                                                                                                 thickness: 1,
                  //                                                                                                               ),
                  //                                                                                                               height: 5.h,
                  //                                                                                                             ),
                  //                                                                                                           ),
                  //                                                                                                           SizedBox(
                  //                                                                                                             height: 5.h,
                  //                                                                                                           ),
                  //                                                                                                           Form(
                  //                                                                                                             key: _formKey,
                  //                                                                                                             child: Column(
                  //                                                                                                               children: [
                  //                                                                                                                 FormBuilderRadioGroup(
                  //                                                                                                                   decoration: InputDecoration(border: InputBorder.none, labelText: 'Rate Your Experience', labelStyle: TextStyle(fontSize: 14.sp, fontFamily: 'Montserrat')),
                  //                                                                                                                   name: '$selectedRating',
                  //                                                                                                                   onChanged: (String? value) {
                  //                                                                                                                     setState(() {
                  //                                                                                                                       selectedRating = value;
                  //                                                                                                                       refcode = data.refcode as TextEditingController;
                  //                                                                                                                     });
                  //                                                                                                                   },
                  //                                                                                                                   initialValue: selectedRating,
                  //                                                                                                                   orientation: OptionsOrientation.vertical,
                  //                                                                                                                   validator: FormBuilderValidators.required(
                  //                                                                                                                     errorText: 'Kindly Select an option',
                  //                                                                                                                   ),
                  //                                                                                                                   options: [
                  //                                                                                                                     'Highly Dissatisfied',
                  //                                                                                                                     'Dissatisfied',
                  //                                                                                                                     'Neutral',
                  //                                                                                                                     'Satisified',
                  //                                                                                                                     'Highly Satisfied'
                  //                                                                                                                   ].map((selectedRating) => FormBuilderFieldOption(value: selectedRating)).toList(growable: false),
                  //                                                                                                                 ),
                  //                                                                                                                 SizedBox(
                  //                                                                                                                   width: double.infinity,
                  //                                                                                                                   child: ElevatedButton(
                  //                                                                                                                     style: ButtonStyle(
                  //                                                                                                                       backgroundColor: MaterialStateProperty.all(Colors.teal),
                  //                                                                                                                     ),
                  //                                                                                                                     onPressed: () async {
                  //                                                                                                                       if (_formKey.currentState!.validate()) {
                  //                                                                                                                         if (await getInternetUsingInternetConnectivity()) {
                  //                                                                                                                           Navigator.pop(context);
                  //                                                                                                                           ScaffoldMessenger.of(context).showSnackBar(
                  //                                                                                                                             SnackBar(
                  //                                                                                                                                 backgroundColor: Colors.teal,
                  //                                                                                                                                 content: SingleChildScrollView(
                  //                                                                                                                                     child: Container(
                  //                                                                                                                                   padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  //                                                                                                                                   child: Padding(
                  //                                                                                                                                     padding: EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 0.0),
                  //                                                                                                                                     child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  //                                                                                                                                       SizedBox(
                  //                                                                                                                                         height: 15.0,
                  //                                                                                                                                         width: 15.0,
                  //                                                                                                                                         child: CircularProgressIndicator(
                  //                                                                                                                                           color: Colors.white,
                  //                                                                                                                                           strokeWidth: 2.0,
                  //                                                                                                                                         ),
                  //                                                                                                                                       ),
                  //                                                                                                                                       SizedBox(
                  //                                                                                                                                         height: 5.h,
                  //                                                                                                                                       ),
                  //                                                                                                                                       Text('Sending your rating',
                  //                                                                                                                                           textAlign: TextAlign.center,
                  //                                                                                                                                           style: GoogleFonts.montserrat(
                  //                                                                                                                                             fontSize: 14.sp,
                  //                                                                                                                                             fontWeight: FontWeight.normal,
                  //                                                                                                                                           ))
                  //                                                                                                                                     ]),
                  //                                                                                                                                   ),
                  //                                                                                                                                 ))),
                  //                                                                                                                           );
                  //                                                                                                                           Future.delayed(Duration(seconds: 5), () async {
                  //                                                                                                                             sendrating();
                  //                                                                                                                           });
                  //                                                                                                                         } else {
                  //                                                                                                                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //                                                                                                                             content: Text('You are offline, Turn On Data or Wifi', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 11.sp)),
                  //                                                                                                                             backgroundColor: Color(0xFFE02020),
                  //                                                                                                                             behavior: SnackBarBehavior.fixed,
                  //                                                                                                                             duration: const Duration(seconds: 5),
                  //                                                                                                                             // duration: Duration(seconds: 3),
                  //                                                                                                                           ));
                  //                                                                                                                         }
                  //                                                                                                                       }
                  //                                                                                                                     },
                  //                                                                                                                     child: const Text(
                  //                                                                                                                       'Rate Your Experience',
                  //                                                                                                                       style: TextStyle(fontFamily: 'Montserrat'),
                  //                                                                                                                     ),
                  //                                                                                                                   ),
                  //                                                                                                                 ),
                  //                                                                                                                 SizedBox(height: 20.h),
                  //                                                                                                               ],
                  //                                                                                                             ),
                  //                                                                                                           )
                  //                                                                                                         ]),
                  //                                                                                                       ),
                  //                                                                                                     ),
                  //                                                                                                   );
                  //                                                                                                 });
                  //                                                                                           },
                  //                                                                                         ),
                  //                                                                                       ),
                  //                                                                               ],
                  //                                                                             )
                  //                                                                           : SizedBox(
                  //                                                                               height: 0.h,
                  //                                                                             )
                  //                                                                     ],
                  //                                                                   ),
                  //                                                                 ),
                  //                                                               ),
                  //                                                             ),
                  //                                                           ),
                  //                                                         ),
                  //                                                       ),
                  //                                                     ],
                  //                                                   ),
                  //                                                   SizedBox(
                  //                                                     height: 0.h,
                  //                                                   )
                  //                                                 ])
                  //                                           ],
                  //                                         ))
                  //                                     .toList(),
                  //                               ),
                  //                             )
                  //                           ]);
                  //                     }
                  //                   }))
                ],
              ),
              Positioned(
                bottom: 24.0,
                right: 0.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Row(children: [
                        FaIcon(FontAwesomeIcons.vialCircleCheck),
                        SizedBox(
                          width: 5.h,
                        ),
                        Text('Lab Results',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                fontSize: 12.sp, color: Colors.white)),
                      ]),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.teal,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () async {
                        _showDialog(context);
                     
                        },
                    ),
                    TextButton(
                      child: Row(children: [
                        FaIcon(FontAwesomeIcons.whatsapp),
                        SizedBox(
                          width: 5.h,
                        ),
                        Text('Chat with us',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                fontSize: 12.sp, color: Colors.white)),
                      ]),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.teal,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () async {
                         Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          BloodGroupResults()));
                        },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context, builder: (BuildContext context) => DialogContent());
  }
}

class DialogContent extends StatefulWidget {
  DialogContent({
    super.key,
  });

  @override
  State<DialogContent> createState() => _DialogContentState();
}

class _DialogContentState extends State<DialogContent> {

  Timer? debouncer;
  String donationquery = '';
  TextEditingController _password = TextEditingController();
  bool _passwordVisible = false;
  bool _isloginLoading = false;
  bool _validate = false;
  final _formKey = GlobalKey<FormState>();

  Future<List<BloodDonationSchAppdata>> getBloodDonationApp(
      String donationquery) async {
    var data = {'phonenumber': '+23278621647'};

    var response = await http.post(
        Uri.parse(
            "https://community.lifebloodsl.com/managedonationappointments.php"),
        body: json.encode(data));
    if (response.statusCode == 200) {
      final List donationschedule = json.decode(response.body);
      return donationschedule
          .map((json) => BloodDonationSchAppdata.fromJson(json))
          .where((donationschedule) {
        final facilityLower = donationschedule.facility.toLowerCase();
        final refcodeLower = donationschedule.refcode.toLowerCase();
        final searchLower = donationquery.toLowerCase();
        return facilityLower.contains(searchLower) ||
            refcodeLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  @override
  final TextEditingController timeInput = TextEditingController();
  String? selectedrc = '';
  String? selectedrcsolved = '';
  String? selectedscsolved = '';
  String? selectedsc = '';
  String? selectedSCategory = '';
  String? selectedSampleBrought = '';
  String? _selectedrcRadioGroupValue;
  Widget builddonationSearch() => SearchWidget(
        text: donationquery,
        hintText: 'Search Laboratory Tests',
        onChanged: searchBook,
      );

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }
  Future searchBook(String donationquery) async => debounce(() async {
        final donationschedule = await getBloodDonationApp(donationquery);

        if (!mounted) return;

        setState(() {
          this.donationquery = donationquery;
          // this.donationschedule = donationschedule;
        });
      });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: IntrinsicHeight(
        child: Container(
          width: MediaQuery.of(context).size.width <= 768 ? 0.7.sw : 0.35.sw,
          decoration: BoxDecoration(
            color: Colors.white,
             borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                 
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Verification',
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Form(
                      key: _formKey, 
                                           child: TextFormField(
                        
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Kindly Enter you Password';
                                    }
                                    
                                    return null;
                                  },
                                  obscureText: !_passwordVisible,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    border: OutlineInputBorder(),
                                    labelStyle: TextStyle(fontSize: 14.sp,  letterSpacing: 0,fontFamily: 'Montserrat'),
                                    errorStyle: TextStyle(letterSpacing: 0,fontFamily: 'Montserrat'),
                                    labelText: 'Enter Your Password',
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.teal,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                      color: Colors.teal,
                                    ),
                                  ),
                                  controller: _password,
                                ),
                    ),
                    
                   SizedBox(height: 5.h),
                                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: _isloginLoading
                                  ? SizedBox(
                                      height: 15.0,
                                      width: 15.0,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.0,
                                      ),
                                    )
                                  : Text(
                                      'Continue',
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontSize: 13.sp,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.bold),
                                    ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (await getInternetUsingInternetConnectivity()) {
                                    setState(() {
                                      _isloginLoading = true;
                                    });
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                labtestresultsbody(
                                                 
                                                )),
                                        );
                                    // userLogin();
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          'You are offline, Kindly turn on Wifi or Mobile Data to continue',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 10.sp)),
                                      backgroundColor: Color(0xFFE02020),
                                      behavior: SnackBarBehavior.fixed,
                                      duration: const Duration(seconds: 10),
                                      // duration: Duration(seconds: 3),
                                    ));
                                  }
                                } else {
                                  _validate;
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  backgroundColor: Colors.teal,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 20),
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
            
                  ],
                ),
              ),
                                       
           10.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
