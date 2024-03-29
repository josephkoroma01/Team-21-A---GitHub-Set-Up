import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:expandable/expandable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lifebloodworld/features/Login/views/login_screen.dart';
import 'package:lifebloodworld/features/More/components/profilebody.dart';
import 'package:lifebloodworld/features/More/components/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'donationcard.dart';

class MeBody extends StatefulWidget {
  @override
  State createState() {
    return MeBodyState();
  }
}

class MeBodyState extends State<MeBody> {
  String? email;
  String? password;
  String? ufname;
  String? ulname;
  String? umname;
  String? agecategory;
  String? gender;
  String? phonenumber;
  String? address;
  String? district;
  String? bloodtype;
  String? prevdonation;
  String? prevdonationamt;
  String? community;
  String? communitydonor;

  @override
  void initState() {
    super.initState();
    getPref();
  }

  void logout() async {
    await Future.delayed(Duration(seconds: 5));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false);
  }

  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      password = prefs.getString('password');
      ufname = prefs.getString('ufname');
      umname = prefs.getString('umname');
      ulname = prefs.getString('ulname');
      agecategory = prefs.getString('agecategory');
      gender = prefs.getString('gender');
      phonenumber = prefs.getString('phonenumber');
      address = prefs.getString('address');
      district = prefs.getString('district');
      bloodtype = prefs.getString('bloodtype');
      prevdonation = prefs.getString('prevdonation');
      prevdonationamt = prefs.getString('prevdonationamt');
      community = prefs.getString('community');
      communitydonor = prefs.getString('communitydonor');
    });
  }

  bool _islogoutLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFe0e9e4),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.01),
            Image.asset(
              "assets/images/blood-donation.png",
              height: size.height * 0.1,
              // width: size.width * 0.4,
            ),
            Text(
              "LifeBlood",
              style: GoogleFonts.montserrat(
                  fontSize: size.width * 0.085,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF205072)),
            ),
            SizedBox(height: size.height * 0.0005),
            Text(
              "Give Blood. Save Lives",
              style: GoogleFonts.montserrat(
                  fontSize: size.width * 0.04,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF68B2A0)),
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => donationcard()));
                      },
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
                                  Image.asset(
                                    'assets/icons/donor-card.png',
                                    height: 50.h,
                                    width: 50.w,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text('Donation Card',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
                                          color: Color(0xff406986))),
                                  Container(
                                    width: double.infinity,
                                    child: TextButton(
                                      child: Text('Open',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 11.sp,
                                              color: Colors.white)),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Color(0xff389e9d),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    donationcard()));
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
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          ),
                        );
                      },
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
                                  Image.asset(
                                    'assets/icons/user.png',
                                    height: 50.h,
                                    width: 50.w,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text('Manage Profile',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
                                          color: Color(0xff406986))),
                                  Container(
                                    width: double.infinity,
                                    child: TextButton(
                                      child: Text('Manage',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 11.sp,
                                              color: Colors.white)),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Color(0xff389e9d),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                            builder: (context) => ProfilePage(),
                                          ),
                                        );
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
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => settings()));
                      },
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
                                  Image.asset(
                                    'assets/icons/plus.png',
                                    height: 50.h,
                                    width: 50.w,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text('More Information',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
                                          color: Color(0xff406986))),
                                  Container(
                                    width: double.infinity,
                                    child: TextButton(
                                      child: Text('Know More',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 11.sp,
                                              color: Colors.white)),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Color(0xff389e9d),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    settings()));
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
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Color(0xFFebf5f5),
                          context: context,
                          builder: (context) {
                            return SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      20.0, 20.0, 20.0, 0.0), // content padding
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 15.sp,
                                            color: Color(0xff406986),
                                            height: 1.3846153846153846,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'Hi,',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff406986),
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' $ufname $ulname',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff389e9d),
                                              ),
                                            ),
                                          ],
                                        ),
                                        textHeightBehavior: TextHeightBehavior(
                                            applyHeightToFirstAscent: false),
                                        textAlign: TextAlign.center,
                                        softWrap: true,
                                      ),
                                      SizedBox(height: 10.h),
                                      Text('Are you sure you\nwant to log out?',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.normal,
                                              color: Color(0xff406986))),
                                      SizedBox(height: 10.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                              child: Text('Yes',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12.sp,
                                                      color: Colors.white)),
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                backgroundColor:
                                                    Color(0xff389e9d),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                              ),
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                setState(() {
                                                  _islogoutLoading = true;
                                                });

                                                logout();
                                              }),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          TextButton(
                                              child: Text('No',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12.sp,
                                                      color: Colors.white)),
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                backgroundColor:
                                                    Color(0xFFE02020),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              }),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
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
                                  Image.asset(
                                    'assets/icons/log-out.png',
                                    height: 50.h,
                                    width: 50.w,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text('Log Out',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
                                          color: Color(0xff406986))),
                                  Container(
                                    width: double.infinity,
                                    child: TextButton(
                                      child: _islogoutLoading
                                          ? SizedBox(
                                              height: 15.0,
                                              width: 15.0,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 2.0,
                                              ),
                                            )
                                          : Text('Log Out',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 11.sp,
                                                  color: Colors.white)),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Color(0xFFE02020),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      onPressed: () async {
                                        showModalBottomSheet(
                                          backgroundColor: Color(0xFFebf5f5),
                                          context: context,
                                          builder: (context) {
                                            return SingleChildScrollView(
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      20.0,
                                                      20.0,
                                                      20.0,
                                                      0.0), // content padding
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text.rich(
                                                        TextSpan(
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontSize: 15.sp,
                                                            color: Color(
                                                                0xff406986),
                                                            height:
                                                                1.3846153846153846,
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text: 'Hi,',
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color(
                                                                    0xff406986),
                                                              ),
                                                            ),
                                                            TextSpan(
                                                              text:
                                                                  ' $ufname $ulname',
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color(
                                                                    0xff389e9d),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        textHeightBehavior:
                                                            TextHeightBehavior(
                                                                applyHeightToFirstAscent:
                                                                    false),
                                                        textAlign:
                                                            TextAlign.center,
                                                        softWrap: true,
                                                      ),
                                                      SizedBox(height: 10.h),
                                                      Text(
                                                          'Are you sure you\nwant to log out?',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: Color(
                                                                      0xff406986))),
                                                      SizedBox(height: 10.h),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          TextButton(
                                                              child: Text('Yes',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          12.sp,
                                                                      color: Colors
                                                                          .white)),
                                                              style: TextButton
                                                                  .styleFrom(
                                                                foregroundColor:
                                                                    Colors
                                                                        .white,
                                                                backgroundColor:
                                                                    Color(
                                                                        0xFFE02020),
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10))),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                Navigator.pop(
                                                                    context);
                                                                setState(() {
                                                                  _islogoutLoading =
                                                                      true;
                                                                });

                                                                logout();
                                                              }),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          TextButton(
                                                              child: Text('No',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          12.sp,
                                                                      color: Colors
                                                                          .white)),
                                                              style: TextButton
                                                                  .styleFrom(
                                                                foregroundColor:
                                                                    Colors
                                                                        .white,
                                                                backgroundColor:
                                                                    Color(
                                                                        0xff389e9d),
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10))),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              }),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 20.h,
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
                                  ),
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
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
