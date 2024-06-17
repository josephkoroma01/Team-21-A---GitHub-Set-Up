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
import 'package:url_launcher/url_launcher.dart';
import '../../../main.dart';
import '../../../constants/colors.dart';
import '../../../models/bloodtestschedule.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../models/facility.dart';
import '../models/community_donor_request_model.dart';
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

class blooddonorrequest extends StatefulWidget {
  @override
  State createState() {
    return blooddonorrequestState();
  }
}

class blooddonorrequestState extends State<blooddonorrequest> {
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
  String? name;
  String? ulname;
  String? umname;

  final _formKey = GlobalKey<FormState>();
  late Timer _getBgresulttimer;
  late Timer _getTotalDonationstimer;
  bool _validate = false;
  List<Facility> facilityList = [];

  final List<String> costlist = ['Free', 'Paid'];

  String? selectedFacility = '';
  String? selectedCost = '';
  @override
  Future<List<CommunityDonorRequest>> getCommunityDonorRequest(context) async {
    List<CommunityDonorRequest> communityDonorRequest = [];

    try {
      var response = await http.get(
        Uri.parse(
            "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/communitydonorrequests"),
      );

      if (response.statusCode == 200) {
        List<dynamic> msg = jsonDecode(response.body);

        List<CommunityDonorRequest> requests =
            msg.map((e) => CommunityDonorRequest.fromJson(e)).toList();

        setState(() {
          communityDonorRequest = requests;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Sorry, Something went wrong. ${response.statusCode}',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(fontSize: 10)),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.fixed,
          duration: const Duration(seconds: 3),
        ));
      }

      // return communityDonorRequest;
      return communityDonorRequest;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            // 'Sorry, we are unable to fetch the data at the moment. Please try again later. ${e.toString()}',
            e.toString(),
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(fontSize: 10)),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.fixed,
        duration: const Duration(seconds: 30),
      ));
    }

    return communityDonorRequest;
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
      name = prefs.getString('name');
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
    getCommunityDonorRequest(context);

    _getBgresulttimer =
        Timer.periodic(const Duration(seconds: 2), (timer) => getBgresult());
  }

  void getRefPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      name = prefs.getString('name');
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

  Future<List<BloodTestingFacilities>> getBloodFacilities(
      String donationquery) async {
    final url = Uri.parse(
        'http://api.famcaresl.com/communityapp/index.php?route=facilities');
    final response = await http.post(
      url,
      body: jsonEncode({
        "country": 'Sierra Leone'

        // Additional data
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List donationschedule = json.decode(response.body);
      return donationschedule
          .map((json) => BloodTestingFacilities.fromJson(json))
          .where((donationschedule) {
        final regionLower = donationschedule.district!.toLowerCase();
        final facilitynameLower = donationschedule.name!.toLowerCase();
        final servicetypeLower = donationschedule.name!.toLowerCase();
        final searchLower = donationquery.toLowerCase();
        return regionLower.contains(searchLower) ||
            facilitynameLower.contains(searchLower) ||
            servicetypeLower.contains(searchLower);
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
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => HomePageScreen(pageIndex: 0),
              ),
            );
          },
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: kWhiteColor,
          ),
        ),
        elevation: 0,
        title: Text('Schedule A Blood Group Test',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(fontSize: 14, color: Colors.white)),
      ),
      backgroundColor: Color(0xFFF6F6F6),
      body: SafeArea(
          child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Color(0xFFF6F6F6),
        child: Stack(children: [
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
                child: FutureBuilder<List<CommunityDonorRequest>>(
                  future: getCommunityDonorRequest(context),
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
                                            style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color: Colors.teal)),
                                      ],
                                    ),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
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
                                .map((e) => Padding(
                                      padding: const EdgeInsets.all(1),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
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
                                                    color: Color.fromARGB(
                                                        255, 53, 87, 112),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text.rich(
                                                                TextSpan(
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xFF205072),
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                  children: [
                                                                    TextSpan(
                                                                      text: e
                                                                          .facility,
                                                                      style: GoogleFonts
                                                                          .montserrat(
                                                                        fontSize:
                                                                            13,
                                                                        letterSpacing:
                                                                            0,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color:
                                                                            kWhiteColor,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                textHeightBehavior:
                                                                    TextHeightBehavior(
                                                                        applyHeightToFirstAscent:
                                                                            false),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            2),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    color:
                                                                        kWhiteColor),
                                                                child: Text(
                                                                  e.bloodtype
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontFamily:
                                                                        'Montserrat',
                                                                    letterSpacing:
                                                                        0,
                                                                    color:
                                                                        kLifeBloodBlue,
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 2.h,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Flexible(
                                                                child: Expanded(
                                                                  child: Text(
                                                                    e.address
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      letterSpacing:
                                                                          0,
                                                                      color:
                                                                          kWhiteColor,
                                                                    ),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Text.rich(
                                                            TextSpan(
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFF205072),
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text: e
                                                                      .district,
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                    fontSize:
                                                                        13,
                                                                    letterSpacing:
                                                                        0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color:
                                                                        kWhiteColor,
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
                                                          SizedBox(
                                                            height: 10.h,
                                                          ),
                                                          TextButton(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                    'Volunteer to Donate',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      fontSize:
                                                                          12,
                                                                      letterSpacing:
                                                                          0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color:
                                                                          kLifeBloodBlue,
                                                                    )),
                                                              ],
                                                            ),
                                                            style: TextButton
                                                                .styleFrom(
                                                              foregroundColor:
                                                                  Colors.white,
                                                              backgroundColor:
                                                                  kWhiteColor,
                                                              shape: const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10))),
                                                            ),
                                                            onPressed: () {
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus();
                                                              var whatsappUrl =
                                                                  "whatsapp://send?phone=${'+23278621647'}" +
                                                                      "&text=${Uri.encodeComponent('Hi LifeBlood, I want to volunteer to donate')}";
                                                              try {
                                                                launch(
                                                                    whatsappUrl);
                                                              } catch (e) {
                                                                //To handle error and display error message
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        SnackBar(
                                                                  content: Text(
                                                                      'Could Not Launch WhatsApp',
                                                                      style: GoogleFonts
                                                                          .montserrat()),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  behavior:
                                                                      SnackBarBehavior
                                                                          .fixed,
                                                                  duration:
                                                                      Duration(
                                                                          seconds:
                                                                              3),
                                                                ));
                                                              }
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
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: SizedBox(
                                              height: 5.h,
                                              child: Divider(
                                                color: Colors.white,
                                                thickness: 0.2,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: TextButton(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.view_agenda_outlined,
                                                    size: 15,
                                                    color: kWhiteColor,
                                                  ),
                                                  5.horizontalSpace,
                                                  Text(
                                                      'View All Blood Donor Requests',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontSize: 11.sp,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white,
                                                      )),
                                                ],
                                              ),
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                backgroundColor: Color.fromARGB(
                                                    255, 53, 87, 112),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          blooddonorrequest()),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          )),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ]),
      )),
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
