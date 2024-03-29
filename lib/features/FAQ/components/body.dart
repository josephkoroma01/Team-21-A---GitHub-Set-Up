import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifebloodworld/constants/colors.dart';
import 'package:lifebloodworld/features/FAQ/components/accessibility.dart';
import 'package:lifebloodworld/features/FAQ/components/lifestyleandid.dart';
import 'package:lifebloodworld/features/FAQ/components/medandmedservices.dart';
import 'package:lifebloodworld/features/FAQ/components/medconditions.dart';
import 'package:lifebloodworld/features/FAQ/components/nsbsfaq.dart';
import 'package:lifebloodworld/features/FAQ/components/others.dart';
import 'package:lifebloodworld/features/FAQ/components/pregandchildbirth.dart';
import 'package:lifebloodworld/features/FAQ/components/worktrliv.dart';
import 'package:lifebloodworld/constants/images.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';

class FAQBody extends StatefulWidget {
  @override
  State createState() {
    return FAQBodyState();
  }
}

class FAQBodyState extends State<FAQBody> {
  final _formKey = GlobalKey<FormState>();
  bool _validate = false;
  bool _isloginLoading = false;

  final TextEditingController _feedbackCtrl = TextEditingController();
  Future sendfeedback() async {
    if (_feedbackCtrl.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse("https://community.lifebloodsl.com/communityfeedback.php"),
          body: {
            "firstname": ufname,
            "lastname": ulname,
            "agecategory": agecategory,
            "gender": gender,
            "phonenumber": phonenumber,
            "email": email,
            "district": district,
            "bloodtype": bloodtype,
            "feedback": _feedbackCtrl.text,
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
                Text('Feedback Successful Sent',
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

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePageScreen(
              pageIndex: 0,
            ),
          ),
        );
      }
    }
  }

  int pageIndex = 0;

  String? email;
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
      agecategory = prefs.getString('agecategory');
      gender = prefs.getString('gender');
      phonenumber = prefs.getString('phonenumber');
      address = prefs.getString('address');
      district = prefs.getString('district');
      bloodtype = prefs.getString('bloodtype');
      prevdonation = prefs.getString('prevdonation');
    });
  }

  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: '+23279230776',
      text: "Hey, I want to ask question about LifeBlood",
    );
    // ignore: deprecated_member_use
    await launch('$link');
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
                builder: (context) => HomePageScreen(pageIndex: 1),
              ),
            );
          },
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: kWhiteColor,
          ),
        ),
        elevation: 0,
        title: Text('FAQ',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(fontSize: 14.h, color: Colors.white)),
      ),
      backgroundColor: Color(0xFFe0e9e4),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.01),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    child: Row(children: [
                      Icon(
                        Icons.facebook,
                        //whatsapp logo
                        color: Colors.white,
                        size: 18,
                      ),
                      SizedBox(
                        width: 5.h,
                      ),
                      Text('Send Us A WhatsApp Message',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontSize: 12.sp, color: Colors.white, 
                              letterSpacing: 0)),
                    ]),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.teal,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onPressed: () async {
                      //To remove the keyboard when button is pressed
                      FocusManager.instance.primaryFocus?.unfocus();
                      var whatsappUrl = "whatsapp://send?phone=${'+23278621647'}" +
                          "&text=${Uri.encodeComponent('I want to ask a question about LifeBlood')}";
                      try {
                        launch(whatsappUrl);
                      } catch (e) {
                        //To handle error and display error message
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Could Not Launch WhatsApp',
                              style: GoogleFonts.montserrat()),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.fixed,
                          duration: Duration(seconds: 4),
                        ));
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => NSBSFaq()));
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image.asset('assets/icons/blog.png', height: size.height * 0.05, width: size.height * 0.05,),

                                  Text('NSBS\nFAQ',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 13.sp,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff406986))),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                      'Know where you to donate, see if a transfusion site is nearby',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12.sp, letterSpacing: 0,color: Colors.grey)),
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
                                              letterSpacing: 0,
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
                                                    NSBSFaq()));
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
                            builder: (context) => MedCondition(),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image.asset('assets/icons/community.png', height: size.height * 0.05, width: size.height * 0.05,),

                                  Text('Medication and \nMedical Devices',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 13.sp,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff406986))),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                      'Most medications don’t affect whether you can donate, but some do. See if yours might affect your ability to donate.',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12.sp, letterSpacing: 0,color: Colors.grey)),
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
                                              letterSpacing: 0,
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
                                            builder: (context) =>
                                                MedCondition(),
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
              height: 20.h,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PregandChildBirth()));
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image.asset('assets/icons/community.png', height: size.height * 0.05, width: size.height * 0.05,),
                                  Text('Pregnancy and \nChildbirth',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 13.sp,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff406986))),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                      'It is important you don\u0027t put your body under unnecessary strain. Find out how long you need to wait before you can donate',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12.sp,letterSpacing: 0, color: Colors.grey)),
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
                                              letterSpacing: 0,
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
                                                    PregandChildBirth()));
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WorkTrliv()));
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image.asset('assets/icons/blog.png', height: size.height * 0.05, width: size.height * 0.05,),

                                  Text('Work, travel and\nliving overseas',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 13.sp,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff406986))),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                      'Some places you travel to or live in can affect whether you can donate, or when. Find out how.',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12.sp, letterSpacing: 0,color: Colors.grey)),
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
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    WorkTrliv()));
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
              height: 20.h,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MedConditionandPro()));
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image.asset('assets/icons/community.png', height: size.height * 0.05, width: size.height * 0.05,),

                                  Text('Medical conditions\n& procedures',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 13.sp,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff406986))),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                      'Some medical conditions mean you need to wait before donating blood. Find yours in list',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12.sp,letterSpacing: 0, color: Colors.grey)),
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
                                              letterSpacing: 0,
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
                                                    MedConditionandPro()));
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LifeStyleandid()));
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Image.asset('assets/icons/blog.png', height: size.height * 0.05, width: size.height * 0.05,),

                                  Text('Lifestyle and\nIdentity',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 13.sp,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff406986))),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                      "Unsure whether you can donate blood if you\u0027ve had a drink, got a tattoo, or if you\u0027re lesbian, gay, bisexual, transgender, queer, intersex, asexual, and gende",
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12.sp, color: Colors.grey)),
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
                                              letterSpacing: 0,
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
                                                    LifeStyleandid()));
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
              height: 20.h,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Accessibility()));
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
                                  // Image.asset('assets/icons/community.png', height: size.height * 0.05, width: size.height * 0.05,),
                                  Text('Accessibility',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 13.sp,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff406986))),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                      'Donating blood shouldn\u0027t be exclusive. If you need something special to come and donate comfortably, let us know',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12.sp, letterSpacing: 0, color: Colors.grey)),
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
                                              letterSpacing: 0,
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
                                                    Accessibility()));
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
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Others()));
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
                                  // Image.asset('assets/icons/blog.png', height: size.height * 0.05, width: size.height * 0.05,),

                                  Text('Other',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 13.sp,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff406986))),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                      'Need a different question answered? Take a look and find it here',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12.sp,letterSpacing: 0, color: Colors.grey)),
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
                                              letterSpacing: 0,
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
                                                    Others()));
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
          ],
        ),
      ),
    );
  }
}
