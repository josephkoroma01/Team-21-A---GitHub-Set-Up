import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:expandable/expandable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifebloodworld/constants/colors.dart';
import 'package:lifebloodworld/features/Community/components/createdonationcampaigns.dart';
import 'package:lifebloodworld/features/Community/components/finddonationcampaigns.dart';
import 'package:lifebloodworld/features/Community/components/healthtips.dart';
import 'package:lifebloodworld/features/Community/components/mydonationcampaigns.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:lifebloodworld/widgets/text_field_container.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DonationCampaigns extends StatefulWidget {
  const DonationCampaigns({Key? key}) : super(key: key);

  @override
  State<DonationCampaigns> createState() => _DonationCampaignsState();
}

class _DonationCampaignsState extends State<DonationCampaigns> {
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;

  TextEditingController refcode = TextEditingController();

  Future trackref() async {
    if (refcode.text.isNotEmpty) {
      // Getting username and password from Controller
      var data = {
        'email': email,
        'refcode': refcode.text,
      };

      //Starting Web API Call.
      var response = await http.post(
          Uri.parse("http://lifebloodsl.com/communityapi/reftrackerdonationcampaignreview.php"),
          body: json.encode(data));
      if (response.statusCode == 200) {
        //Server response into variable
        print(response.body);

        var msg = jsonDecode(response.body);

        //Check Login Status
        if (msg['refStatus'] == true) {
          // Navigate to Home Screen
          if (msg['scheduleInfo']["status"] == "Pending") {
            showModalBottomSheet(
                backgroundColor: Color(0xFFebf5f5),
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            20.0, 20.0, 20.0, 0.0), // content padding
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Track Campaign',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff406986))),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text('Hi, $ufname $umname $ulname',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                    fontSize: 14.sp, color: Color(0xff406986))),
                            SizedBox(
                              height: 15.h,
                            ),
                            Image.asset(
                              'assets/icons/wait.png',
                              height: 40.h,
                              width: 40.h,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                             Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15.sp,
                                  color: Color(0xff389e9d),
                                  height: 1.3846153846153846,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Your Donation \nCampaign is ',
                                  ),
                                  TextSpan(
                                    text: 'Pending',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15.sp,
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
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              'Please check again in few hours.\nResponse shall be available',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff406986),
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 120.w,
                                  child: TextButton(
                                      child: Text('Close',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14.sp,
                                              color: Colors.white)),
                                      style: TextButton.styleFrom(
                                        primary: Colors.white,
                                        backgroundColor: Color(0xFFE02020),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else if (msg['scheduleInfo']["status"] == "Confirmed") {
            showModalBottomSheet(
                backgroundColor: Color(0xFFebf5f5),
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            20.0, 20.0, 20.0, 0.0), // content padding
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 5.h,
                            ),
                            Text('Track Campaign',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff406986))),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text('Hi, $ufname $umname $ulname',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                    fontSize: 14.sp, color: Color(0xff406986))),
                            SizedBox(
                              height: 15.h,
                            ),
                            Image.asset(
                              'assets/icons/check-mark.png',
                              height: 40.h,
                              width: 40.h,
                            ),
                            SizedBox(
                              height: 15.h,
                            ), Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15.sp,
                                  color: Color(0xff389e9d),
                                  height: 1.3846153846153846,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Your Donation Campaign \nhas been ',
                                  ),
                                  TextSpan(
                                    text: 'Confirmed',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15.sp,
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

                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              'A step closer to saving lives',
                              style: GoogleFonts.montserrat(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff406986),
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 120.w,
                                  child: TextButton(
                                      child: Text('Close',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14.sp,
                                              color: Colors.white)),
                                      style: TextButton.styleFrom(
                                        primary: Colors.white,
                                        backgroundColor: Color(0xFFE02020),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else if (msg['scheduleInfo']["status"] == "Active") {
            showModalBottomSheet(
                backgroundColor: Color(0xFFebf5f5),
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            20.0, 20.0, 20.0, 0.0), // content padding
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 5.h,
                            ),
                            Text('Track Campaign',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff406986))),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text('Hi, $ufname $umname $ulname',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                    fontSize: 14.sp, color: Color(0xff406986))),
                            SizedBox(
                              height: 15.h,
                            ),
                            Image.asset(
                              'assets/icons/fireworks.png',
                              height: 40.h,
                              width: 40.h,
                            ),
                            SizedBox(
                              height: 15.h,
                            ), Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15.sp,
                                  color: Color(0xff389e9d),
                                  height: 1.3846153846153846,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Your Donation Campaign \nis ',
                                  ),
                                  TextSpan(
                                    text: 'Active',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15.sp,
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

                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              'We are happy and wish you well',
                              style: GoogleFonts.montserrat(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff406986),
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 120.w,
                                  child: TextButton(
                                      child: Text('Close',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14.sp,
                                              color: Colors.white)),
                                      style: TextButton.styleFrom(
                                        primary: Colors.white,
                                        backgroundColor: Color(0xFFE02020),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else if (msg['scheduleInfo']["status"] == "Rejected"){
            showModalBottomSheet(
                backgroundColor: Color(0xFFebf5f5),
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            20.0, 20.0, 20.0, 0.0), // content padding
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 5.h,
                            ),
                            Text('Track Campaign',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff406986))),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text('Hi, $ufname $umname $ulname',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                    fontSize: 14.sp, color: Color(0xff406986))),
                            SizedBox(
                              height: 15.h,
                            ),
                            Image.asset(
                              'assets/icons/sad.png',
                              height: 40.h,
                              width: 40.h,
                            ),
                            SizedBox(
                              height: 15.h,
                            ), Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15.sp,
                                  color: Color(0xff389e9d),
                                  height: 1.3846153846153846,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Your Donation Campaign \nhas been ',
                                  ),
                                  TextSpan(
                                    text: 'Rejected',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15.sp,
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

                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              'We were not clear with your application.',
                              style: GoogleFonts.montserrat(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff406986),
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 120.w,
                                  child: TextButton(
                                      child: Text('Close',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14.sp,
                                              color: Colors.white)),
                                      style: TextButton.styleFrom(
                                        primary: Colors.white,
                                        backgroundColor: Color(0xFFE02020),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
            else{
            showModalBottomSheet(
                backgroundColor: Color(0xFFebf5f5),
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            20.0, 20.0, 20.0, 0.0), // content padding
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 5.h,
                              ),
                              Text('Track Campaign',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff406986))),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text('Hi, $ufname $umname $ulname',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 14.sp,
                                      color: Color(0xff406986))),
                              SizedBox(
                                height: 15.h,
                              ),
                              Image.asset(
                                'assets/icons/happy.png',
                                height: 40.h,
                                width: 40.h,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text.rich(
                                TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 15.sp,
                                    color: Color(0xff389e9d),
                                    height: 1.3846153846153846,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Your Donation Campaign is ',
                                    ),
                                    TextSpan(
                                      text: 'Not Active',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15.sp,
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
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                'You have stop your campaign. \nWe are hope your targets were reached',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986),
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                            ]),
                      ),
                    ),
                  );
                });
          }
        } else {
          showModalBottomSheet(
              backgroundColor: Color(0xFFebf5f5),
              context: context,
              builder: (context) {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          20.0, 20.0, 20.0, 0.0), // content padding
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          Text('Track Campaign',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text('Hi, $ufname $umname $ulname',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontSize: 15.sp, color: Color(0xff406986))),
                          SizedBox(
                            height: 15.h,
                          ),
                          Image.asset(
                            'assets/icons/error.png',
                            height: 50.h,
                            width: 50.h,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13.sp,
                                color: Color(0xff406986),
                                height: 1.3846153846153846,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                  'Donation Campaign Reference Code  not found!!!\n',
                                ),
                                TextSpan(
                                  text: 'Do not worry, Try Creating a Campaign',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff406986),
                                  ),
                                ),
                              ],
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.center,
                            softWrap: true,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 120.w,
                                child: TextButton(
                                    child: Text('Create Now',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14.sp,
                                            color: Colors.white)),
                                    style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: Color(0xff389e9d),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                          builder: (context) =>
                                              CreateDonationCampaignsScreen(),
                                        ),
                                      );
                                    }),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Container(
                                width: 120.w,
                                child: TextButton(
                                    child: Text('Close',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14.sp,
                                            color: Colors.white)),
                                    style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: Color(0xFFE02020),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error Connecting to Server',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(fontSize: 10.sp)),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.fixed,
          duration: Duration(seconds: 3),
        ));
      }
    }
  }

  int pageIndex = 0;

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

  @override
  void initState() {
    super.initState();
    getPref();
  }

  void getPref() async {
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
    });
  }



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
                  builder: (context) => HomePageScreen(pageIndex: 3,),
                ),
              );
            },
            icon: Icon(Icons.arrow_back)),
        elevation: 0,
        title: Text('Donation Campaigns',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                fontSize: size.width * 0.045, color: Colors.white)),
      ),
      backgroundColor: Color(0xFFe0e9e4),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            SizedBox(
              height: 15.h,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                                Image.asset('assets/icons/add.png', height: 40.h, width: 40.w,),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text('Create Donation\nCampaign', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Container(
                                  width: double.infinity,
                                  child: TextButton(
                                    child: Text('Create', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                    style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: Color(0xff389e9d),
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                    ),
                                    onPressed: () async{
                                      if (await getInternetUsingInternetConnectivity()) {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateDonationCampaignsScreen()));
                                        
                                      } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                      content: Text(
                                      'You are offline, Kindly turn on Wifi or Mobile Data to continue',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                      fontSize: 10.sp)),
                                      backgroundColor:
                                      Color(0xFFE02020),
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
                    ),),),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                                Image.asset('assets/icons/search.png', height: 40.h, width: 40.h,),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text('Find Donation \nCampaigns', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Container(
                                  width: double.infinity,
                                  child: TextButton(
                                    child: Text('Find More', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                    style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: Color(0xff389e9d),
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                    ),
                                    onPressed: () async{
                                      if (await getInternetUsingInternetConnectivity()) {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => findDonationCampaigns()));

                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              'You are offline, Kindly turn on Wifi or Mobile Data to continue',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 10.sp)),
                                          backgroundColor:
                                          Color(0xFFE02020),
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
            Row(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                                Image.asset('assets/icons/user.png', height: 40.h, width: 40.h,),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text('My Donation \nCampaigns', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Container(
                                  width: double.infinity,
                                  child: TextButton(
                                    child: Text('Manage', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                    style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: Color(0xff389e9d),
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                    ),
                                    onPressed: () async{
                                      if (await getInternetUsingInternetConnectivity()) {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => myDonationCampaigns()));

                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              'You are offline, Kindly turn on Wifi or Mobile Data to continue',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 10.sp)),
                                          backgroundColor:
                                          Color(0xFFE02020),
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
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                                Image.asset('assets/icons/track.png', height: 40.h, width: 40.w,),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text('Track Campaigns\nReview Status', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Container(
                                  width: double.infinity,
                                  child: TextButton(
                                    child: Text('Track', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                    style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: Color(0xff389e9d),
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
                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
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
                                                  MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Image.asset(
                                                      'assets/icons/track.png',
                                                      height: 30.h,
                                                      width: 30.h,
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text('Track Campaign \nReview Process',
                                                        textAlign: TextAlign.center,
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 18.sp,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            color:
                                                            Color(0xff406986))),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    TextFieldContainer(
                                                      child: Form(
                                                        key: _formKey,
                                                        child: TextFormField(
                                                          controller: refcode,
                                                          cursorColor: kPrimaryColor,
                                                          decoration: InputDecoration(
                                                            focusColor: Colors.teal,
                                                            labelStyle: GoogleFonts
                                                                .montserrat(
                                                                color:
                                                                Colors.teal,
                                                                fontSize: 13.sp),
                                                            labelText:
                                                            'Enter Reference Code',
                                                            // icon: Icon(
                                                            //   Icons.email,
                                                            //   color: Color(0xFF205072),
                                                            // ),
                                                            hintText:
                                                            'Reference Code',
                                                            hintStyle: GoogleFonts
                                                                .montserrat(),
                                                            border: InputBorder.none,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          width: size.width * 0.8,
                                                          child: TextButton(
                                                              child: Text('Track Now',
                                                                  textAlign: TextAlign
                                                                      .center,
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                      fontSize:
                                                                      14.sp,
                                                                      color: Colors
                                                                          .white)),
                                                              style: TextButton
                                                                  .styleFrom(
                                                                primary: Colors.white,
                                                                backgroundColor:
                                                                Color(0xff389e9d),
                                                                shape: const RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius
                                                                        .all(Radius
                                                                        .circular(
                                                                        5))),
                                                              ),
                                                              onPressed: () async {
                                                                if (await getInternetUsingInternetConnectivity()) {
                                                                  Navigator.pop(
                                                                      context);
                                                                  trackref();
                                                                } else {
                                                                  Navigator.pop(
                                                                      context);
                                                                  ScaffoldMessenger
                                                                      .of(context)
                                                                      .showSnackBar(
                                                                      SnackBar(
                                                                        content: Text(
                                                                            'You are offline, Kindly turn on Wifi or Mobile Data to continue',
                                                                            textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                            style: GoogleFonts
                                                                                .montserrat(
                                                                                fontSize:
                                                                                10.sp)),
                                                                        backgroundColor:
                                                                        Color(
                                                                            0xFFE02020),
                                                                        behavior:
                                                                        SnackBarBehavior
                                                                            .fixed,
                                                                        duration:
                                                                        const Duration(
                                                                            seconds:
                                                                            10),
                                                                        // duration: Duration(seconds: 3),
                                                                      ));
                                                                }

                                                                // Navigator.push(
                                                                //   context,
                                                                //   new MaterialPageRoute(
                                                                //     builder: (context) => scheduletypebody(),
                                                                //   ),
                                                                // );
                                                              }),
                                                        )
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
