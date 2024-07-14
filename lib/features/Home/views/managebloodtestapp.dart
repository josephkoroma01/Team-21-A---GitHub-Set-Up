import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifebloodworld/features/Home/views/body.dart';
import 'package:lifebloodworld/features/Home/views/managedonationpp.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:lifebloodworld/models/bhloodtestschedule_model.dart';
import 'package:provider/provider.dart';
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
import '../../../models/donationschedule.dart';
import '../../../provider/manage_appointment_provider.dart';
import 'search.dart';

class managebloodtestAppointments extends StatefulWidget {
  const managebloodtestAppointments({Key? key}) : super(key: key);

  @override
  State<managebloodtestAppointments> createState() =>
      _managebloodtestAppointmentsState();
}

class _managebloodtestAppointmentsState
    extends State<managebloodtestAppointments> {
  String? phonenumber;
  List<TestSchedule> bloodtestAppointments = [];
  List<Schedule> blooddonationAppointments = [];
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
  int? totalBloodTestSchedule = 0;
  int? totalBloodTestScheduleMyself = 0;
  int? totalBloodTestScheduleOthers = 0;
  int? totalBloodTestScheduleResult = 0;
  int? totalBloodDonationReplacement = 0;
  int? totalBloodDonationVolumtary = 0;

  final _formKey = GlobalKey<FormState>();
  late Timer _getRefPreftimer;
  Future<bool> getInternetUsingInternetConnectivity() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  @override
  void initState() {
    // _getRefPreftimer =
    //     Timer.periodic(const Duration(seconds: 2), (timer) => getRefPref());
    // TODO: implement initState
    getPref();

    super.initState();
  }

  String? uname;
  String? name;
  String? agecategory;
  String? avartar;
  String? countryId;
  String? country;
  String? userId;
  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      name = prefs.getString('name');
      uname = prefs.getString('uname');
      avartar = prefs.getString('avatar');
      agecategory = prefs.getString('agecategory');
      // gender = prefs.getString('gender');
      phonenumber = prefs.getString('phonenumber');
      // address = prefs.getString('address');
      // district = prefs.getString('district');
      countryId = prefs.getString('country_id');
      country = prefs.getString('country');
      // bloodtype = prefs.getString('bloodtype');
      // prevdonation = prefs.getString('prevdonation');
      // prevdonationamt = prefs.getString('prevdonationamt');
      // community = prefs.getString('community');
      // communitydonor = prefs.getString('communitydonor');
      userId = prefs.getString('id');
      totalBloodTestSchedule = prefs.getInt('totalschedule');
      totalBloodTestScheduleMyself = prefs.getInt('BcountMyself');
      totalBloodTestScheduleOthers = prefs.getInt('BcountOther');
      totalBloodTestScheduleResult = prefs.getInt('Bresult');
      totalBloodDonationReplacement = prefs.getInt('replacement');
      totalBloodDonationVolumtary = prefs.getInt('voluntary');
      // totaldonation = prefs.getString('totaldonation');
    });
  }

  void dispose() {
    if (_getRefPreftimer.isActive) _getRefPreftimer.cancel();
  }

  Future getBloodTestAllAppointment() async {
    // Getting username and password from Controller
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await http.get(
        Uri.parse(
            "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/getuserbloostestschedule/$userId"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        BloodTestSchedule data = BloodTestSchedule.fromJson(jsonData);

        List<TestSchedule> schedules = data.schedule!;

        print(data);

        setState(() {
          bloodtestAppointments = schedules;
          totalBloodTestSchedule = bloodtestAppointments.length;
          totalBloodTestScheduleMyself = bloodtestAppointments
              .where((item) => item.bloodtestfor == 'Myself')
              .length;
          totalBloodTestScheduleOthers = bloodtestAppointments
              .where((item) => item.bloodtestfor != 'Myself')
              .length;
          totalBloodTestScheduleResult = bloodtestAppointments
              .where((item) => item.result == 'Yes')
              .length;
        });
        setState(() {
          prefs.setInt('totalschedule', totalBloodTestSchedule!);
          prefs.setInt('BcountMyself', totalBloodTestScheduleMyself!);
          prefs.setInt('BcountOther', totalBloodTestScheduleOthers!);
          prefs.setInt('Bresult', totalBloodTestScheduleResult!);
        });

        return bloodtestAppointments;
      } else {}
    } catch (e) {}
  }

  Future getBloodDonationAllAppointment() async {
    // Getting username and password from Controller
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await http.get(
        Uri.parse(
            "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/getuserbloosdonationschedule/$userId"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        DonationSchedule data = DonationSchedule.fromJson(jsonData);

        List<Schedule> schedules = data.schedule!;
        print(data);
        setState(() {
          blooddonationAppointments = schedules;
          totalBloodDonationReplacement = blooddonationAppointments
              .where((item) => item.donorType == 'Replacement')
              .length;
          totalBloodDonationVolumtary = blooddonationAppointments
              .where((item) => item.donorType == 'Volunteer')
              .length;
        });
        setState(() {
          prefs.setInt('replacement', totalBloodDonationReplacement!);
          prefs.setInt('voluntary', totalBloodDonationVolumtary!);
        });

        return bloodtestAppointments;
      } else {}
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final testAppointmentProvider = Provider.of<ManageAppoiynmentProvider>(context, listen: false).getBloodTestAllAppointment();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePageScreen(pageIndex: 0)));
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: kWhiteColor,
            )),
        elevation: 0,
        title: Text('Manage Appointments',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                fontSize: size.width * 0.045, color: Colors.white)),
      ),
      backgroundColor: const Color(0xFFe0e9e4),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10.h),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Container(
                              padding: EdgeInsets.all(10.r),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                // color: Color(0xFFebf5f5),
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.teal[200]!,
                                      Colors.teal[400]!,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                                borderRadius: BorderRadius.circular(16),
                                // color: Colors.green[200]
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    children: [
                                      Text('Manage Appointments',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 9.sp,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Blood Group Test Result',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14.sp,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                      Text('$totalBloodTestScheduleResult',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14.sp,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: SizedBox(
                                      child: Divider(
                                        color: Colors.white,
                                        thickness: 0.5,
                                      ),
                                      height: 5.h,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Blood Group Test Schedule',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14.sp,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                      Text('$totalBloodTestSchedule',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Myself',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 10.sp,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white)),
                                      Text('$totalBloodTestScheduleMyself',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 10.sp,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Others',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white)),
                                      Text('$totalBloodTestScheduleOthers',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 10.sp,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white)),
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
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Container(
                              padding: EdgeInsets.all(10.r),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                // color: Color(0xFFebf5f5),
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.teal[200]!,
                                      Colors.teal[400]!,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                                borderRadius: BorderRadius.circular(16),
                                // color: Colors.green[200]
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    children: [
                                      Text('Manage Appointments',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 9.sp,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Replacement Donation',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14.sp,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                      Text('$totalBloodDonationReplacement',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14.sp,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: SizedBox(
                                      child: Divider(
                                        color: Colors.white,
                                        thickness: 0.5,
                                      ),
                                      height: 5.h,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Voluntary Donation',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14.sp,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                      Text('$totalBloodDonationVolumtary',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14.sp,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.h,
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
                height: 10.h,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Container(
                              padding: EdgeInsets.all(10.r),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFebf5f5),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.calendarCheck,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text('Blood Group \nTest Appointments',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
                                          letterSpacing: 0,
                                          color: Color(0xff406986))),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: TextButton(
                                      child: Text('Manage',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12.sp,
                                              color: Colors.white)),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Color(0xff389e9d),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      onPressed: () async {
                                        if (await getInternetUsingInternetConnectivity()) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  manageAppointments(
                                                schedule: bloodtestAppointments,
                                              ),
                                            ),
                                          );
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
                                            duration:
                                                const Duration(seconds: 5),
                                            // duration: Duration(seconds: 3),
                                          ));
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Container(
                              padding: EdgeInsets.all(10.r),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFebf5f5),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.calendarCheck,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text('Blood Donation \nAppointments',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
                                          color: Color(0xff406986))),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: TextButton(
                                      child: Text('Manage',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12.sp,
                                              color: Colors.white)),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Color(0xff389e9d),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      onPressed: () async {
                                        if (await getInternetUsingInternetConnectivity()) {
                                          Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                              builder: (context) =>
                                                  managedonationAppointments(),
                                            ),
                                          );
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
                                            duration:
                                                const Duration(seconds: 5),
                                            // duration: Duration(seconds: 3),
                                          ));
                                        }
                                      },
                                    ),
                                  )
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
                height: 20.h,
              ),
            ]),
      ),
    );
  }
}
