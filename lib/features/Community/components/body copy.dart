import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifebloodworld/features/Community/components/bloodcommunity.dart';
import 'package:lifebloodworld/features/Community/components/donationcampaigns.dart';
import 'package:lifebloodworld/features/Community/components/supportlifeblood.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommunityBody extends StatefulWidget {
  @override
  State createState() {
    return CommunityBodyState();
  }
}

class CommunityBodyState extends State<CommunityBody> {
  String? email;
  String? ufname;
  String? ulname;
  String? umname;
  String? age;
  String? gender;
  String? phonenumber;
  String? address;
  String? district;
  String? bloodtype;
  String? prevdonation;
  String? community;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getPref();
  }

  getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      ufname = prefs.getString('ufname');
      umname = prefs.getString('umname');
      ulname = prefs.getString('ulname');
      age = prefs.getString('age');
      gender = prefs.getString('gender');
      phonenumber = prefs.getString('phonenumber');
      address = prefs.getString('address');
      district = prefs.getString('district');
      bloodtype = prefs.getString('bloodtype');
      prevdonation = prefs.getString('prevdonation');
      community = prefs.getString('community');
    });
  }

  savebloodPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('community', 'Joined');
  }

  Future joinbloodcommunity() async {
    await Future.delayed(Duration(seconds: 5));

    var response = await http.post(
        Uri.parse("http://lifebloodsl.com/communityapi/joincommunity.php"),
        body: {
          "firstname": ufname,
          "middlename": umname,
          "lastname": ulname,
          "gender": gender,
          "phonenumber": phonenumber,
          "email": email,
          "address": address,
          "district": district,
          "bloodtype": bloodtype,
        });
    var data = json.decode(response.body);
    if (data == "Error") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please Try Again,'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 5),
      ));
    } else {
      setState(() {
        community = 'Joined';
      });
      savebloodPref();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
          height: 15.h,
          child: Column(
            children: [
              Text('Joined Blood Community Successfully',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(fontSize: 12.sp)),
            ],
          ),
        ),
        backgroundColor: Colors.teal,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 5),
      ));

      setState(() {
        _isLoading = false;
      });
      // scheduleAlarm()
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BloodCommunity(),
        ),
      );
    }
  }

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
            SizedBox(height: 10.h),
            Image.asset(
              "assets/images/blood-donation.png",
              height: 100.h,
              // width: size.width * 0.4,
            ),
            Text(
              "LifeBlood",
              style: GoogleFonts.montserrat(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF205072)),
            ),
            SizedBox(height: 2.h),
            Text(
              "Give Blood. Save Lives",
              style: GoogleFonts.montserrat(
                  fontSize: 14.sp,
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
                                  'assets/icons/community.png',
                                  height: 40.h,
                                  width: 40.w,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text('Blood\nCommunities',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14.sp,
                                        color: Color(0xff406986))),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text('Find Blood Community',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 11.sp, color: Colors.grey)),
                                SizedBox(
                                  height: 5.h,
                                ),
                                (community == 'Joined')
                                    ? Container(
                                        width: double.infinity,
                                        child: TextButton(
                                          child: Text('Open',
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
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BloodCommunity(),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : Container(
                                        width: double.infinity,
                                        child: TextButton(
                                          child: _isLoading
                                              ? SizedBox(
                                                  height: 15.0,
                                                  width: 15.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 2.0,
                                                  ),
                                                )
                                              : Text('Join',
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
                                          onPressed: () {
                                            showModalBottomSheet(
                                              backgroundColor:
                                                  Color(0xFFebf5f5),
                                              context: context,
                                              builder: (context) {
                                                return SingleChildScrollView(
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                                context)
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
                                                                    fontSize:
                                                                        14.sp,
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
                                                                    fontSize:
                                                                        14.sp,
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
                                                            textAlign: TextAlign
                                                                .center,
                                                            softWrap: true,
                                                          ),
                                                          Text(
                                                              '\nDo you want\n to join the \nblood community?',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts.montserrat(
                                                                  fontSize:
                                                                      17.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color(
                                                                      0xff406986))),
                                                          SizedBox(
                                                            height: 10.h,
                                                          ),
                                                          Text(
                                                              'Your donation changes lives.\nBeing part of a blood community and joining forces to make blood readily available.',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                      fontSize:
                                                                          14.sp,
                                                                      color: Color(
                                                                          0xff406986))),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Text(
                                                              'You can make triggers \nfor someone who needs blood.',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                      fontSize:
                                                                          14.sp,
                                                                      color: Color(
                                                                          0xff406986))),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              TextButton(
                                                                  child: Text(
                                                                      'Join Now',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts.montserrat(
                                                                          fontSize: 12
                                                                              .sp,
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
                                                                            BorderRadius.all(Radius.circular(10))),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    showModalBottomSheet(
                                                                      backgroundColor:
                                                                          Color(
                                                                              0xFFebf5f5),
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return SingleChildScrollView(
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Text('Join the Blood Community', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                  SizedBox(
                                                                                    height: 10.h,
                                                                                  ),
                                                                                  Image.asset(
                                                                                    "assets/icons/community.png",
                                                                                    height: 40.h,
                                                                                    width: 40.w,
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                  Text('You will be receiving a lot of \nnotifications for any trigger made.\n\nAre you okay to be \ncontacted most times?', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                                                                  SizedBox(
                                                                                    height: 5.h,
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      TextButton(
                                                                                          child: Text('Yes', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                          style: TextButton.styleFrom(
                                                                                            foregroundColor: Colors.white,
                                                                                            backgroundColor: Color(0xff389e9d),
                                                                                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                          ),
                                                                                          onPressed: () {
                                                                                            Navigator.pop(context);
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
                                                                                                          Text('Join the Blood Community', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                          SizedBox(
                                                                                                            height: 10.h,
                                                                                                          ),
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
                                                                                                            textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                                            textAlign: TextAlign.center,
                                                                                                            softWrap: true,
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: 10.h,
                                                                                                          ),
                                                                                                          Image.asset(
                                                                                                            "assets/icons/fireworks.png",
                                                                                                            height: 40.h,
                                                                                                            width: 40.w,
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: 10.h,
                                                                                                          ),
                                                                                                          Text('We are happy you have decided \nto join the blood community.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.normal, color: Color(0xff406986))),
                                                                                                          SizedBox(
                                                                                                            height: 10.h,
                                                                                                          ),
                                                                                                          Row(
                                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                                            children: [
                                                                                                              TextButton(
                                                                                                                  child: Text('Join Now', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                  style: TextButton.styleFrom(
                                                                                                                    foregroundColor: Colors.white,
                                                                                                                    backgroundColor: Color(0xff389e9d),
                                                                                                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                  ),
                                                                                                                  onPressed: () async {
                                                                                                                    Navigator.pop(context);
                                                                                                                    if (await getInternetUsingInternetConnectivity()) {
                                                                                                                      setState(() {
                                                                                                                        _isLoading = true;
                                                                                                                      });
                                                                                                                      joinbloodcommunity();
                                                                                                                    } else {
                                                                                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                                                        content: Text('You are offline, Kindly turn on Wifi or Mobile Data to continue', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 10.sp)),
                                                                                                                        backgroundColor: Color(0xFFE02020),
                                                                                                                        behavior: SnackBarBehavior.fixed,
                                                                                                                        duration: const Duration(seconds: 10),
                                                                                                                        // duration: Duration(seconds: 3),
                                                                                                                      ));
                                                                                                                    }
                                                                                                                  }),
                                                                                                              SizedBox(
                                                                                                                width: 5.h,
                                                                                                              ),
                                                                                                              TextButton(
                                                                                                                  child: Text('Close', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                  style: TextButton.styleFrom(
                                                                                                                    foregroundColor: Colors.white,
                                                                                                                    backgroundColor: Color(0xffd12624),
                                                                                                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                  ),
                                                                                                                  onPressed: () {
                                                                                                                    Navigator.pop(context);
                                                                                                                  }),
                                                                                                            ],
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
                                                                                          }),
                                                                                      SizedBox(
                                                                                        width: 5.h,
                                                                                      ),
                                                                                      TextButton(
                                                                                          child: Text('No', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                          style: TextButton.styleFrom(
                                                                                            foregroundColor: Colors.white,
                                                                                            backgroundColor: Color(0xffd12624),
                                                                                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                          ),
                                                                                          onPressed: () {
                                                                                            Navigator.pop(context);
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
                                                                                                          Text('Join Blood Community', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                          SizedBox(
                                                                                                            height: 10.h,
                                                                                                          ),
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
                                                                                                            textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                                            textAlign: TextAlign.center,
                                                                                                            softWrap: true,
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: 10.h,
                                                                                                          ),
                                                                                                          Image.asset(
                                                                                                            "assets/icons/happy.png",
                                                                                                            height: 40.h,
                                                                                                            width: 40.w,
                                                                                                          ),
                                                                                                          SizedBox(
                                                                                                            height: 10.h,
                                                                                                          ),
                                                                                                          Text('We are okay with your decision and hope you could change your mind.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                                                                                          SizedBox(
                                                                                                            height: 5.h,
                                                                                                          ),
                                                                                                          Text('Unfortunately, you can \n not join the blood community.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                          SizedBox(
                                                                                                            height: 10.h,
                                                                                                          ),
                                                                                                          Row(
                                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                                            children: [
                                                                                                              TextButton(
                                                                                                                  child: Text('Close', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                  style: TextButton.styleFrom(
                                                                                                                    foregroundColor: Colors.white,
                                                                                                                    backgroundColor: Color(0xffd12624),
                                                                                                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                  ),
                                                                                                                  onPressed: () {
                                                                                                                    Navigator.pop(context);
                                                                                                                  }),
                                                                                                            ],
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
                                                                                          }),
                                                                                    ],
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
                                                                  }),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              TextButton(
                                                                  child: Text(
                                                                      'Close',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts.montserrat(
                                                                          fontSize: 12
                                                                              .sp,
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
                                                                            BorderRadius.all(Radius.circular(10))),
                                                                  ),
                                                                  onPressed:
                                                                      () {
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
                                Image.asset(
                                  'assets/icons/blog.png',
                                  height: 40.h,
                                  width: 40.h,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text('Health \nBlog Tips',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14.sp,
                                        color: Color(0xff406986))),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text('Get Recent Health Facts',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 11.sp, color: Colors.grey)),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Container(
                                  width: double.infinity,
                                  child: TextButton(
                                    child: Text('Know More',
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
                                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Healthtips()));
                                        ;
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
                                Image.asset(
                                  'assets/icons/megaphone.png',
                                  height: 40.h,
                                  width: 40.h,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text('Donation Campaigns',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14.sp,
                                        color: Color(0xff406986))),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text('Join Blood Campaigns',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 11.sp, color: Colors.grey)),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Container(
                                  width: double.infinity,
                                  child: TextButton(
                                    child: Text('Explore',
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
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DonationCampaigns()));
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
                                Image.asset(
                                  'assets/icons/coins.png',
                                  height: 40.h,
                                  width: 40.w,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text('Support \nLifeBlood',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14.sp,
                                        color: Color(0xff406986))),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text('Support Blood Banks',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 11.sp, color: Colors.grey)),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Container(
                                  width: double.infinity,
                                  child: TextButton(
                                    child: Text('Support',
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
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SupportLifeBloodScreen()));
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
          ],
        ),
      ),
    );
  }
}
