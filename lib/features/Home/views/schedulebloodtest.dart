import 'dart:async';
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifebloodworld/models/blooddonationschedule.dart';
import 'package:lifebloodworld/models/bloodtestingfacilities.dart';
import 'package:lifebloodworld/features/Home/views/bgresults.dart';
import 'package:lifebloodworld/features/Home/views/bloodtestbody.dart';
import 'package:lifebloodworld/features/Home/views/bloodtestbodyfam.dart';
import 'package:lifebloodworld/features/Home/views/famregister.dart';
import 'package:lifebloodworld/features/Home/views/managedonationpp.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:lifebloodworld/models/facility.dart';
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
import '../../../models/bloodtestschedule.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'search.dart';

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

class scheduletypebody extends StatefulWidget {
  @override
  State createState() {
    return scheduletypebodyState();
  }
}

class scheduletypebodyState extends State<scheduletypebody> {
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

  // Future findfacility() async {
  //   var response = await http.get(Uri.parse(
  //       "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/login"));
  //   if (response.statusCode == 200) {
  //     List<dynamic> jsonData = json.decode(response.body);
  //     List<Facility> data = jsonData.map((e) => Facility.fromJson(e)).toList();
  //     setState(() {
  //       facilityList = data;
  //     });
  //   }
  //   print(facilityList);
  // }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  String? uname;
  String? avartar;
  String? countryId;
  String? country;
  String? userId;
  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      uname = prefs.getString('uname');
      avartar = prefs.getString('avatar');
      countryId = prefs.getString('country_id');
    });
  }

  Future<List<BloodTestingFacilities>> getBloodFacilities(
      String donationquery) async {
    final url = Uri.parse(
        'https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/tfsbycountry/$countryId');
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List donationschedule = json.decode(response.body);
      return donationschedule
          .map((json) => BloodTestingFacilities.fromJson(json))
          .where((donationschedule) {
        final regionLower = donationschedule.district!.toLowerCase();
        final facilitynameLower = donationschedule.name!.toLowerCase();
        final servicetypeLower = donationschedule.communityname!.toLowerCase();
        final searchLower = donationquery.toLowerCase();
        return regionLower.contains(searchLower) ||
            facilitynameLower.contains(searchLower) ||
            servicetypeLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
    getBgresult();
    // getBloodFacilities(donationquery);
    // findfacility();

    // _getBgresulttimer =
    // Timer.periodic(const Duration(seconds: 2), (timer) => getBgresult());
  }

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
                      fontSize: 14,
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

  final List<String> facilityItems = [
    'Western Area Rural',
    'Bo',
    'Connaught',
    'Rokupa',
  ];

  Widget builddonationSearch() => SearchWidget(
        text: donationquery,
        hintText: 'Search Facility Name',
        onChanged: searchBook,
      );

  Future searchBook(String donationquery) async => debounce(() async {
        final donationschedule = await getBloodFacilities(donationquery);

        if (!mounted) return;

        setState(() {
          this.donationquery = donationquery;
          this.donationschedule =
              donationschedule.cast<BloodDonationSchAppdata>();
        });
      });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: kWhiteColor,
          ),
        ),
        elevation: 0,
        title: Text('Schedule A Blood Group Test',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(fontSize: 14, color: Colors.white)),
      ),
      backgroundColor: Color(0xFFe0e9e4),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10),
          color: Color(0xFFF6F6F6),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  builddonationSearch(),
                  Expanded(
                      child: FutureBuilder<List<BloodTestingFacilities>>(
                          future: getBloodFacilities(donationquery),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FaIcon(FontAwesomeIcons.faceSadCry),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        "No facility found",
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.refresh,
                                                  color: Colors.teal,
                                                ),
                                                Text('Refresh Page',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.teal)),
                                              ],
                                            ),
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))),
                                            ),
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          super.widget));
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ListView(
                                        children: snapshot.data!
                                            .map((data) => Column(
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Container(
                                                              padding: EdgeInsets.only(
                                                                  bottom: MediaQuery.of(
                                                                          context)
                                                                      .viewInsets
                                                                      .bottom),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .fromLTRB(
                                                                        .0,
                                                                        5.0,
                                                                        5.0,
                                                                        5.0),
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              10.w),
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets
                                                                        .all(10
                                                                            .r),
                                                                    width: double
                                                                        .infinity,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      border: Border.all(
                                                                          color:
                                                                              Colors.teal),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              16),
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Text('Blood Group Testing Facilties',
                                                                                textAlign: TextAlign.center,
                                                                                style: GoogleFonts.montserrat(fontSize: 10, letterSpacing: 0, color: Color(0xff389e9d))),
                                                                            SizedBox(
                                                                              height: 5.h,
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                                                        text: data.name!,
                                                                                        style: GoogleFonts.montserrat(
                                                                                          fontSize: 13,
                                                                                          letterSpacing: 0,
                                                                                          fontWeight: FontWeight.bold,
                                                                                          color: Color(0xFF205072),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                  textAlign: TextAlign.left,
                                                                                ),
                                                                                Container(
                                                                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFF205072)),
                                                                                  child: Text(
                                                                                    '${data.testPrice!}',
                                                                                    style: TextStyle(
                                                                                      fontSize: 12,
                                                                                      fontWeight: FontWeight.normal,
                                                                                      fontFamily: 'Montserrat',
                                                                                      letterSpacing: 0,
                                                                                      color: kWhiteColor,
                                                                                    ),
                                                                                    overflow: TextOverflow.clip,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 2.h,
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Flexible(
                                                                                  child: Expanded(
                                                                                    child: Text(
                                                                                      data.address!,
                                                                                      style: TextStyle(
                                                                                        fontSize: 13,
                                                                                        overflow: TextOverflow.clip,
                                                                                        fontWeight: FontWeight.normal,
                                                                                        fontFamily: 'Montserrat',
                                                                                        letterSpacing: 0,
                                                                                        color: Color(0xFF205072),
                                                                                      ),
                                                                                      overflow: TextOverflow.clip,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
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
                                                                                    text: data.district,
                                                                                    style: GoogleFonts.montserrat(
                                                                                      fontSize: 13,
                                                                                      letterSpacing: 0,
                                                                                      fontWeight: FontWeight.normal,
                                                                                      color: Color(0xFF205072),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                              textAlign: TextAlign.left,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 2.h,
                                                                            ),
                                                                            TextButton(
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Text('Schedule Blood Group Test',
                                                                                      textAlign: TextAlign.center,
                                                                                      style: GoogleFonts.montserrat(
                                                                                        fontSize: 13,
                                                                                        letterSpacing: 0,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: kPrimaryColor,
                                                                                      )),
                                                                                ],
                                                                              ),
                                                                              style: TextButton.styleFrom(
                                                                                foregroundColor: Colors.white,
                                                                                backgroundColor: Colors.teal.shade100,
                                                                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                              ),
                                                                              onPressed: () {
                                                                                showModalBottomSheet(
                                                                                    isScrollControlled: true,
                                                                                    backgroundColor: Color(0xFFebf5f5),
                                                                                    context: context,
                                                                                    builder: (context) {
                                                                                      return SingleChildScrollView(
                                                                                        child: Container(
                                                                                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                              Text('Blood Group Test Schedule', style: GoogleFonts.montserrat(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xff389e9d))),
                                                                                              SizedBox(
                                                                                                height: 5.h,
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: 10.h,
                                                                                              ),
                                                                                              Row(
                                                                                                children: <Widget>[
                                                                                                  Expanded(
                                                                                                    child: SingleChildScrollView(
                                                                                                      child: InkWell(
                                                                                                        onTap: () {
                                                                                                          Navigator.push(
                                                                                                            context,
                                                                                                            MaterialPageRoute(
                                                                                                              builder: (context) => BloodTestPage(
                                                                                                                title: 'Blood Group Test for Myself',
                                                                                                                facility: data.name!,
                                                                                                                facilityId: data.id.toString(),
                                                                                                              ),
                                                                                                            ),
                                                                                                          );
                                                                                                        },
                                                                                                        child: Container(
                                                                                                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                                                                                            child: Padding(
                                                                                                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                                                                                                              child: Container(
                                                                                                                padding: EdgeInsets.all(10.r),
                                                                                                                width: double.infinity,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: Colors.white,
                                                                                                                  borderRadius: BorderRadius.circular(16),
                                                                                                                ),
                                                                                                                child: Column(
                                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                                  children: [
                                                                                                                    FaIcon(
                                                                                                                      FontAwesomeIcons.userLarge,
                                                                                                                      color: kLifeBloodBlue,
                                                                                                                    ),
                                                                                                                    SizedBox(
                                                                                                                      height: 5.h,
                                                                                                                    ),
                                                                                                                    Text('Myself', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14, color: Color(0xff406986))),
                                                                                                                    SizedBox(
                                                                                                                      height: 5.h,
                                                                                                                    ),
                                                                                                                    // Text('Know Your Blood Type',
                                                                                                                    //     textAlign: TextAlign.center,
                                                                                                                    //     style: GoogleFonts.montserrat(
                                                                                                                    //         fontSize: 10,
                                                                                                                    //         color: Colors.grey)),
                                                                                                                    // SizedBox(
                                                                                                                    //   height: 5.h,
                                                                                                                    // ),
                                                                                                                  ],
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    child: SingleChildScrollView(
                                                                                                        child: InkWell(
                                                                                                      onTap: () {
                                                                                                        Navigator.push(
                                                                                                          context,
                                                                                                          MaterialPageRoute(
                                                                                                            builder: (context) => BloodTestPageFam(
                                                                                                              title: 'Blood Group Test for Others',
                                                                                                              facility: data.name,
                                                                                                              facilityId: data.id.toString(),
                                                                                                            ),
                                                                                                          ),
                                                                                                        );
                                                                                                      },
                                                                                                      child: Container(
                                                                                                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                        child: Padding(
                                                                                                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                                                                                                            child: Container(
                                                                                                              padding: EdgeInsets.all(10.r),
                                                                                                              width: double.infinity,
                                                                                                              decoration: BoxDecoration(
                                                                                                                color: Colors.white,
                                                                                                                borderRadius: BorderRadius.circular(16),
                                                                                                              ),
                                                                                                              child: Column(
                                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                                children: [
                                                                                                                  const FaIcon(
                                                                                                                    FontAwesomeIcons.peopleGroup,
                                                                                                                    color: kLifeBloodBlue,
                                                                                                                  ),
                                                                                                                  SizedBox(
                                                                                                                    height: 5.h,
                                                                                                                  ),
                                                                                                                  Text('Others', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14, color: Color(0xff406986))),
                                                                                                                  SizedBox(
                                                                                                                    height: 5.h,
                                                                                                                  ),
                                                                                                                  // Text('Know Your Blood Type',
                                                                                                                  //     textAlign: TextAlign.center,
                                                                                                                  //     style: GoogleFonts.montserrat(
                                                                                                                  //         fontSize: 10,
                                                                                                                  //         color: Colors.grey)),
                                                                                                                  // SizedBox(
                                                                                                                  //   height: 5.h,
                                                                                                                  // ),
                                                                                                                ],
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    )),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: 25.h,
                                                                                              ),
                                                                                            ]),
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    });
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
                                                  ],
                                                ))
                                            .toList(),
                                      ),
                                    )
                                  ]);
                            }
                          }))
                ],
              ),
              Positioned(
                bottom: 24.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Color(0xFFebf5f5),
                        context: context,
                        builder: (context) {
                          return SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    20.0, 20.0, 20.0, 0.0), // content padding
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Admit Patient',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff389e9d))),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text('Select the Type of Patient',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Color(0xff406986))),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: InkWell(
                                                onTap: () {
                                                  // Navigator.push(
                                                  //   context,
                                                  //   new MaterialPageRoute(
                                                  //     builder: (context) =>
                                                  //         AdmitPatient(
                                                  //             patientType:
                                                  //                 'Man'),
                                                  //   ),
                                                  // );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          MediaQuery.of(context)
                                                              .viewInsets
                                                              .bottom),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.w),
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                            10.r),
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/icons/man.png',
                                                              height: 40.h,
                                                              width: 40.w,
                                                            ),
                                                            SizedBox(
                                                              height: 5.h,
                                                            ),
                                                            Text('Man',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontSize:
                                                                            14,
                                                                        color: Color(
                                                                            0xff406986))),
                                                            SizedBox(
                                                              height: 5.h,
                                                            ),
                                                            // Text('Know Your Blood Type',
                                                            //     textAlign: TextAlign.center,
                                                            //     style: GoogleFonts.montserrat(
                                                            //         fontSize: 10,
                                                            //         color: Colors.grey)),
                                                            // SizedBox(
                                                            //   height: 5.h,
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: SingleChildScrollView(
                                                child: InkWell(
                                              onTap: () {
                                                // Navigator.push(
                                                //   context,
                                                //   new MaterialPageRoute(
                                                //     builder: (context) =>
                                                //         AdmitPatient(
                                                //             patientType:
                                                //                 'Woman'),
                                                //   ),
                                                // );
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0.0, 0.0, 0.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5.w),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(10.r),
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image.asset(
                                                            'assets/icons/woman.png',
                                                            height: 40.h,
                                                            width: 40.w,
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Text('Woman',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                      fontSize:
                                                                          14,
                                                                      color: Color(
                                                                          0xff406986))),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          // Text('Know Your Blood Type',
                                                          //     textAlign: TextAlign.center,
                                                          //     style: GoogleFonts.montserrat(
                                                          //         fontSize: 10,
                                                          //         color: Colors.grey)),
                                                          // SizedBox(
                                                          //   height: 5.h,
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )),
                                          ),
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: InkWell(
                                                onTap: () {
                                                  // Navigator.push(
                                                  //   context,
                                                  //   new MaterialPageRoute(
                                                  //     builder: (context) =>
                                                  //         AdmitPatient(
                                                  //             patientType:
                                                  //                 'Child'),
                                                  //   ),
                                                  // );
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          MediaQuery.of(context)
                                                              .viewInsets
                                                              .bottom),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.w),
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                            10.r),
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/icons/children.png',
                                                              height: 40.h,
                                                              width: 40.w,
                                                            ),
                                                            SizedBox(
                                                              height: 5.h,
                                                            ),
                                                            Text('Child',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                        fontSize:
                                                                            14,
                                                                        color: Color(
                                                                            0xff406986))),
                                                            SizedBox(
                                                              height: 5.h,
                                                            ),
                                                            // Text('Know Your Blood Type',
                                                            //     textAlign: TextAlign.center,
                                                            //     style: GoogleFonts.montserrat(
                                                            //         fontSize: 10,
                                                            //         color: Colors.grey)),
                                                            // SizedBox(
                                                            //   height: 5.h,
                                                            // ),
                                                          ],
                                                        ),
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
                                        height: 25.h,
                                      ),
                                    ]),
                              ),
                            ),
                          );
                        });
                  },
                  child: TextButton(
                    child: Row(children: [
                      FaIcon(FontAwesomeIcons.vialCircleCheck),
                      SizedBox(
                        width: 5.h,
                      ),
                      Text('Results',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontSize: 12, color: Colors.white)),
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
                              builder: (context) => BloodGroupResults()));
                    },
                  ),
                ),
              )
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
