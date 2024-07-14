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
import 'package:lifebloodworld/constants/colors.dart';
import 'package:lifebloodworld/features/Community/components/communities.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:lifebloodworld/provider/prefs_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class wmerchandise extends StatefulWidget {
  @override
  State createState() {
    return wmerchandiseState();
  }
}

class wmerchandiseState extends State<wmerchandise> {
  String? address;
  String? agecategory;
  String? bloodtype;
  String? district;
  String? email;
  String? gender;
  String? phonenumber;
  String? prevdonation;
  String query = '';
  String? ufname;
  String? ulname;
  String? umname;
  String? communityCheck;
  @override
  void initState() {
    super.initState();
    getPref();
    communityCheckGet();
  }

  communityCheckCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('communityCheck', 'Yes');
  }

  communityCheckGet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    communityCheck = prefs.getString('communityCheck');
  }

  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      phonenumber = prefs.getString('phonenumber');
      ufname = prefs.getString('name');
      umname = prefs.getString('umname');
      ulname = prefs.getString('ulname');
    });
  }

  Future<bool> getInternetUsingInternetConnectivity() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  Widget build(BuildContext context) {
    var id = Provider.of<PrefsProvider>(context, listen: false).userId;
    return Scaffold(
      backgroundColor: Color(0xFFe0e9e4),
      appBar: AppBar(
          backgroundColor: Color(0xFFe0e9e4),
          leading: IconButton(
            icon: Icon(
              Icons.cancel_rounded,
              color: kLifeBloodRed,
            ),
            onPressed: () {},
          )),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/lifebloodlogo.png",
                  height: 150.h,
                  width: 150.w,
                  // width: size.width * 0.4,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              style: const TextStyle(
                                  color: Color(0xff329d9c), fontSize: 15),
                              children: [
                                TextSpan(
                                  text:
                                      'Welcome to the \nCommunities on LifeBlood!',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20.sp,
                                    height: 1,
                                    letterSpacing: 0,
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
                            height: 5.h,
                          ),
                          Container(
                            width: double.infinity,
                            child: SizedBox(
                              child: Divider(
                                color: Colors.teal,
                                thickness: 0.2,
                              ),
                              height: 5.h,
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.lightbulb,
                                size: 20,
                                color: Colors.orange,
                              ),
                              Text(' Do You Know?',
                                  softWrap: true,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange)),
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'Sierra Leone has one of the highest maternal mortality rates in the world.\n\nAnd the leading cause is bleeding. This is because the number of voluntary blood donations in Sierra Leone can only meet 15% of patients blood needs. 85% of the time, the patient\’s relatives have to buy blood and most of the time struggle to find a match.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 7.h,
                          ),
                          Container(
                            width: double.infinity,
                            child: SizedBox(
                              child: Divider(
                                color: Colors.teal,
                                thickness: 0.2,
                              ),
                              height: 5.h,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'LifeBlood is a safe blood management system, made available to Government and private blood bank facilities as a Digital Public Good, to help improve their Blood bank data management and workflow processes.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          Text(
                              '\nUsing technology at LifeBlood, we want to increase voluntary blood donation in Sierra Leone thereby increasing the stock and supply of blood products.\n\nWhen we do this, we will reduce the number of maternal death substantially.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Through our Public Mobile App;',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal)),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text.rich(
                            TextSpan(
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                              children: [
                                TextSpan(
                                  text:
                                      'Users can schedule and manage blood group tests (for self, friend, and family) as ',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xff406986)),
                                ),
                                TextSpan(
                                  text:
                                      '4 out of 5 Sierra Leoneans do not know their blood group.',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 13,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff406986)),
                                ),
                              ],
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "assets/images/bgsch.png",
                                height: 100.h,
                                width: 100.h,
                              ),
                              Image.asset(
                                "assets/images/trackbg.png",
                                height: 100.h,
                                width: 100.h,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "assets/images/mabg.png",
                                height: 200.h,
                                width: 200.h,
                              ),
                            ],
                          ),
                          Text(
                              '\nUsers can also schedule, track and manage voluntary blood donations',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "assets/images/bdsch.png",
                                height: 100.h,
                                width: 100.h,
                              ),
                              Image.asset(
                                "assets/images/bdschtrack.png",
                                height: 100.h,
                                width: 100.h,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "assets/images/mapp.png",
                                height: 200.h,
                                width: 200.h,
                              ),
                            ],
                          ),
                          Text('\nUsers can know about their blood types',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "assets/images/knwbg.png",
                                height: 100.h,
                                width: 100.h,
                              ),
                              Image.asset(
                                "assets/images/ABbg.png",
                                height: 100.h,
                                width: 100.h,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                              '\nUsers can join community donation drives and request community donors in cases of emergencies',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "assets/images/doncamp.png",
                                height: 200.h,
                                width: 200.h,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                              'Through our Blood Bank web app, facilities can;',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal)),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                              'Confirm blood test and donation appointments, Manage real time data, stocks and oversee the entire blood donation workflows.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Through our NSBS web App, Authorities can;',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal)),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                              'View data, manage privileges and generate reports from all blood bank services.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('we aim to',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal)),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                              '1. Increase safe blood availability, blood data and donor support.\n\n2. Establish proper communication between the demand side and the donor side.\n\n3. Provide proper blood education thereby reducing false blood beliefs.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text('This is in accordance with the SDGs',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal)),
                          SizedBox(
                            height: 5.h,
                          ),
                          SingleChildScrollView(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  "assets/images/sdg3.png",
                                  height: 60.h,
                                  width: 60.h,
                                ),
                                Image.asset(
                                  "assets/images/sdg4.png",
                                  height: 60.h,
                                  width: 60.h,
                                ),
                                Image.asset(
                                  "assets/images/sdg10.png",
                                  height: 60.h,
                                  width: 60.h,
                                ),
                                Image.asset(
                                  "assets/images/sdg17.png",
                                  height: 60.h,
                                  width: 60.h,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Column(
                            children: <Widget>[
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    child: Text(
                                        'Explore Communities on LifeBlood',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 13,
                                            letterSpacing: 0,
                                            color: Colors.white)),
                                    style: TextButton.styleFrom(
                                      shape: StadiumBorder(),
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.teal,
                                    ),
                                    onPressed: () async {
                                      communityCheckCheck();
                                      // if (await getInternetUsingInternetConnectivity()) {
                                      // communityCheck ==  "Yes" ?
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => Communities(
                                            title: 'Communities on LifeBlood',
                                            // userId: id.toString(),
                                          ),
                                        ),
                                      );
                                      // } else {
                                      //   ScaffoldMessenger.of(context)
                                      //       .showSnackBar(SnackBar(
                                      //     content: Text(
                                      //         'You are offline, Kindly turn on Wifi or Mobile Data to continue',
                                      //         textAlign: TextAlign.center,
                                      //         style: GoogleFonts.montserrat(
                                      //             fontSize: 14)),
                                      //     backgroundColor: kLifeBloodRed,
                                      //     behavior: SnackBarBehavior.fixed,
                                      //     duration: const Duration(seconds: 5),
                                      //     // duration: Duration(seconds: 3),
                                      //   ));
                                      // }
                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}
