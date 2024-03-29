import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
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
import 'search.dart';

class bloodtypebody extends StatefulWidget {
  @override
  State createState() {
    return bloodtypebodyState();
  }
}

class bloodtypebodyState extends State<bloodtypebody> {
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
                  builder: (context) => HomePageScreen(
                    pageIndex: 0,
                  ),
                ),
              );
            },
            icon: FaIcon(FontAwesomeIcons.arrowLeft, color: kWhiteColor,)),
        elevation: 0,
        title: Text('Know About Your Blood Type',
            textAlign: TextAlign.center,
            style:
                GoogleFonts.montserrat(fontSize: 14.sp, color: Colors.white)),
      ),
      backgroundColor: Color(0xFFe0e9e4),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.02),
            SizedBox(
              height: 5,
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
                                  'assets/icons/bloodapov.png',
                                  height: size.height * 0.05,
                                  width: size.height * 0.05,
                                ),
                                SizedBox(
                                  height: 10.h
                                ),
                                Text('A(+ve) \nBlood Group',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14.h,
                                        letterSpacing: 0,
                                        color: Color(0xff406986))),
                                SizedBox(
                                  height: 5.h
                                ),
                                Text('Blood Type Facts',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 11.h,
                                        color: Colors.grey)),
                                
                                Container(
                                  width: double.infinity,
                                  child: TextButton(
                                    child: Text('Learn More',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 10.sp,
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
                                          builder: (context) => apovbloodtype(),
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
                                  'assets/icons/bloodaneg.png',
                                  height: size.height * 0.05,
                                  width: size.height * 0.05,
                                ),
                                SizedBox(
                                  height: 10.h
                                ),
                                Text('A(-ve) \nBlood Group',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize:14.h,
letterSpacing: 0,
                                        color: Color(0xff406986))),
                                SizedBox(
                                  height: 5.h
                                ),
                                Text('Blood Type Facts',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 10.sp,
letterSpacing: 0,
                                        color: Colors.grey)),
                                
                                Container(
                                  width: double.infinity,
                                  child: TextButton(
                                    child: Text('Learn More',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 10.sp,
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
                                          builder: (context) => anegbloodtype(),
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
              ],
            ),
            SizedBox(
              height: 20,
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
                                  'assets/icons/bloodabpov.png',
                                  height: size.height * 0.05,
                                  width: size.height * 0.05,
                                ),
                                SizedBox(
                                  height: 10.h
                                ),
                                Text('AB(+ve) \nBlood Group',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize:14.h,
letterSpacing: 0,
                                        color: Color(0xff406986))),
                                SizedBox(
                                  height: 10.h
                                ),
                                Text('Universal Recepient',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 10.sp,
letterSpacing: 0,
                                        color: Colors.grey)),
                                
                                Container(
                                  width: double.infinity,
                                  child: TextButton(
                                    child: Text('Learn More',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 10.sp,
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
                                              abpovbloodtype(),
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
                                  'assets/icons/bloodabneg.png',
                                  height: size.height * 0.05,
                                  width: size.height * 0.05,
                                ),
                                SizedBox(
                                  height: 10.h
                                ),
                                Text('AB(-ve) \nBlood Group',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize:14.h,
letterSpacing: 0,
                                        color: Color(0xff406986))),
                                SizedBox(
                                  height: 5.h
                                ),
                                Text('Blood Type Facts',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 10.sp,
letterSpacing: 0,
                                        color: Colors.grey)),
                                
                                Container(
                                  width: double.infinity,
                                  child: TextButton(
                                    child: Text('Learn More',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 10.sp,
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
                                              abnegbloodtype(),
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
              ],
            ),
            SizedBox(
              height: 20,
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
                                  'assets/icons/bloodbpov.png',
                                  height: size.height * 0.05,
                                  width: size.height * 0.05,
                                ),
                                SizedBox(
                                  height: 10.h
                                ),
                                Text('B(+ve) \nBlood Group',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize:14.h,
letterSpacing: 0,
                                        color: Color(0xff406986))),
                                SizedBox(
                                  height: 5.h
                                ),
                                Text('Least Common',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 10.sp,
letterSpacing: 0,
                                        color: Colors.grey)),
                                
                                Container(
                                  width: double.infinity,
                                  child: TextButton(
                                    child: Text('Learn More',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 10.sp,
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
                                          builder: (context) => bpovbloodtype(),
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
                                  'assets/icons/bloodbneg.png',
                                  height: size.height * 0.05,
                                  width: size.height * 0.05,
                                ),
                                SizedBox(
                                  height: 10.h
                                ),
                                Text('B(-ve) \nBlood Group',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize:14.h,
letterSpacing: 0,
                                        color: Color(0xff406986))),
                                SizedBox(
                                  height: 5.h
                                ),
                                Text('Blood Type Facts',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 10.sp,
letterSpacing: 0,
                                        color: Colors.grey)),
                                
                                Container(
                                  width: double.infinity,
                                  child: TextButton(
                                    child: Text('Learn More',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 10.sp,
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
                                          builder: (context) => bnegbloodtype(),
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
              ],
            ),
            SizedBox(
              height: 20,
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
                                  'assets/icons/bloodopos.png',
                                  height: size.height * 0.05,
                                  width: size.height * 0.05,
                                ),
                                SizedBox(
                                  height: 10.h
                                ),
                                Text('O(+ve) \nBlood Group',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize:14.h,
letterSpacing: 0,
                                        color: Color(0xff406986))),
                                SizedBox(
                                  height: 5.h
                                ),
                                Text('Most Common',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 10.sp,
letterSpacing: 0,
                                        color: Colors.grey)),
                               
                                Container(
                                  width: double.infinity,
                                  child: TextButton(
                                    child: Text('Learn More',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 10.sp,
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
                                          builder: (context) => opovbloodtype(),
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
                                  'assets/icons/bloodoneg.png',
                                  height: size.height * 0.05,
                                  width: size.height * 0.05,
                                ),
                                SizedBox(
                                  height: 10.h
                                ),
                                Text('0(-ve) \nBlood Group',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize:14.h,
letterSpacing: 0,
                                        color: Color(0xff406986))),
                                SizedBox(
                                  height: 5.h
                                ),
                                Text('Universal Donor',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 10.sp,
letterSpacing: 0,
                                        color: Colors.grey)),
                                
                                Container(
                                  width: double.infinity,
                                  child: TextButton(
                                    child: Text('Learn More',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 10.sp,
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
                                          builder: (context) => onegbloodtype(),
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


class apovbloodtype extends StatefulWidget {
  @override
  State createState() {
    return apovbloodtypeState();
  }
}

class apovbloodtypeState extends State<apovbloodtype> {
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
                  builder: (context) => bloodtypebody(),
                ),
              );
            },
            icon: FaIcon(FontAwesomeIcons.arrowLeft, color: kWhiteColor,)),
        elevation: 0,
        title: Text('A(+ve) Blood Group',
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
            SizedBox(height: size.height * 0.02),
            SizedBox(
              height: 5,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/bloodapov.png',
                            height: 70.h,
                            width: 70.w,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                              'Your blood type is determined by genes inherited from your parents. Whether your blood type is rare, common or somewhere in between, your donations are vital in helping save and improve lives.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp, color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('How rare is A positive blood?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              '1 in 3 donors is A positive\nAround 30% of donors have A positive blood, making it the second most common blood type after O positive (36%).',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Who can receive A positive blood?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Image.asset(
                            'assets/images/apositive.png',
                            height: 150.h,
                            width: 150.w,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'A positive red blood cells can be given to people with:\n\nA positive blood\nAB positive blood',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('What blood can A positive people receive?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'Groups A and O\n\nPeople with A positive blood can receive donations from:\nA positive donors\nA negative donors\nO negative donors\nO positive donors',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Why is A positive blood important?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'It\u0027s always in demand\n\nA positive makes up almost a third of requests for blood from hospitals so we need to maintain a regular supply.\n\nPlatelets from A positive donations are also important. Last year more A positive platelets were issued to hospitals than any other blood type.\n\n',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
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

class anegbloodtype extends StatefulWidget {
  @override
  State createState() {
    return anegbloodtypeState();
  }
}

class anegbloodtypeState extends State<anegbloodtype> {
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
                  builder: (context) => bloodtypebody(),
                ),
              );
            },
            icon: FaIcon(FontAwesomeIcons.arrowLeft, color: kWhiteColor,)),
        elevation: 0,
        title: Text('A(-ve) Blood Group',
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
            SizedBox(height: size.height * 0.02),
            SizedBox(
              height: 5,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/bloodaneg.png',
                            height: 70.h,
                            width: 70.w,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                              'Your blood type is determined by genes inherited from your parents. Whether your blood type is rare, common or somewhere in between, your donations are vital in helping save and improve lives.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp, color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('How rare is A negative blood?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              '1 in 13 donors is A negative\n\nAround 8% of donors have A negative blood.\nIn comparison, 30% of donors have A positive blood.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Who can receive A negative blood?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Image.asset(
                            'assets/images/anegative.png',
                            height: 150.h,
                            width: 150.w,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'Group A and AB people\n\nA negative red blood cells can be used to treat people with:\n\nA negative blood\nA positive blood\nAB positive blood\nAB negative blood',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('What blood can A negative people receive?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'A negative and O negative\n\nPeople with A negative blood can receive donations from:\n\nA negative donors\nO negative donors',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Why is A negative blood important?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'Anyone can receive A negative platelets\n\nA negative red blood cells can be used to treat around 40% of the population.\n\nHowever, A negative platelets are particularly important because they can be given to people from all blood groups. That’s why A negative platelets are called the ‘universal platelet type’.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
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

class abnegbloodtype extends StatefulWidget {
  @override
  State createState() {
    return abnegbloodtypeState();
  }
}

class abnegbloodtypeState extends State<abnegbloodtype> {
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
                  builder: (context) => bloodtypebody(),
                ),
              );
            },
            icon: FaIcon(FontAwesomeIcons.arrowLeft, color: kWhiteColor,)),
        elevation: 0,
        title: Text('AB(-ve) Blood Group',
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
            SizedBox(height: size.height * 0.02),
            SizedBox(
              height: 5,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/bloodabneg.png',
                            height: 70.h,
                            width: 70.w,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                              'Your blood type is determined by genes inherited from your parents. Whether your blood type is rare, common or somewhere in between, your donations are vital in helping save and improve lives.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp, color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('How rare is AB negative blood?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              '1 in 100 donors is AB negative\nAB negative is the rarest blood type in the ABO blood group, accounting for just 1% of our blood donors.\nIn total only 3% of donors belong to the AB blood group.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Who can receive AB negative blood?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Image.asset(
                            'assets/images/abnegative.png',
                            height: 150.h,
                            width: 150.w,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'You can receive AB negative red blood cells if you are:\nAB negative\nAB positive',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('What blood can AB negative people receive?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'People with AB negative blood can receive donations from:\n\nAB negative donors\nO negative donors\nA negative donors\nB negative donors',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Why is AB negative blood important?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'It\u0027s the rarest blood type\n\nAB negative donations are extremely versatile, but because it is the rarest blood type finding new donors can be a challenge.\n\nPlasma from AB negative donations can help treat patients of all blood types, however fresh frozen plasma is only produced from male donations. This is because female donors (especially those who have been pregnant) can develop antibodies that, while no danger to themselves, can prove life threatening to patients transfused with their plasma.\n\nTo avoid waste and to achieve the balance of plasma and red cells required by patients, we manage AB negative donations differently to other blood groups.\n\nWe encourage our male donors to donate as frequently as possible while asking female donors to wait to donate until contacted directly by us.\n\nAs the scarcest blood type, relatively small changes in the number of donations collected or requested by hospital can have a dramatic and immediate effect on the amount of AB negative we store.\n\nAt these times, we rely on the support of all AB negative donors to help prevent waste and ensure patients continue to receive the blood and blood products needed to save and improve lives.\n\nWe are looking for AB negative blood donors to switch to giving platelets. Each time you donate your could help up to 3 adults or 12 children.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
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

class abpovbloodtype extends StatefulWidget {
  @override
  State createState() {
    return abpovbloodtypeState();
  }
}

class abpovbloodtypeState extends State<abpovbloodtype> {
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
                  builder: (context) => bloodtypebody(),
                ),
              );
            },
            icon: FaIcon(FontAwesomeIcons.arrowLeft, color: kWhiteColor,)),
        elevation: 0,
        title: Text('AB(+ve) Blood Group',
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
            SizedBox(height: size.height * 0.02),
            SizedBox(
              height: 5,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/bloodabpov.png',
                            height: 70.h,
                            width: 70.w,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                              'Your blood type is determined by genes inherited from your parents. Whether your blood type is rare, common or somewhere in between, your donations are vital in helping save and improve lives.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp, color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('How rare is AB positive blood?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              '1 in 50 donors is AB positive, \nJust 2% of donors have AB positive blood making it one of the rarest blood types in the country',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Who can receive AB positive blood?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Image.asset(
                            'assets/images/abpov.png',
                            height: 150.h,
                            width: 150.w,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'Only AB positive people AB positive red blood cells can only be used to treat people with AB positive blood.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('What blood can AB positive people receive?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'All blood types are safe\nPeople with AB positive blood can safely receive red blood cells from any blood type. This means that demand for AB positive red blood cells is at its lowest level in a decade.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Why is AB positive blood important?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'It\u0027s rare\n\nAlthough the need for AB positive red blood cells is falling, the demand for AB positive plasma hasn’t changed.\n\nTo avoid wastage while ensuring the correct balance of plasma and red cells from AB positive donors, we manage donations differently to other blood types.\n\nFresh frozen plasma is only produced from male donations.\n\nThis is because female donors (especially those who have been pregnant) can develop antibodies that, while no danger to themselves, can prove life threatening to patients transfused with their plasma.\n\nWe can generally meet the demand for frozen plasma and most red cells from our male donors, which is good news.\n\nWe encourage our male donors to donate as frequently as possible but ask that female donors wait to donate until contacted directly by us.\n\nThere are occasions when demand for AB positive rises.\n\nDuring these times we contact our female donors directly and rely on their support to ensure patients continue to receive the blood and blood products they need.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
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

class bpovbloodtype extends StatefulWidget {
  @override
  State createState() {
    return bpovbloodtypeState();
  }
}

class bpovbloodtypeState extends State<bpovbloodtype> {
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
                  builder: (context) => bloodtypebody(),
                ),
              );
            },
            icon: FaIcon(FontAwesomeIcons.arrowLeft, color: kWhiteColor,)),
        elevation: 0,
        title: Text('B(+ve) Blood Group',
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
            SizedBox(height: size.height * 0.02),
            SizedBox(
              height: 5,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/bloodbpov.png',
                            height: 70.h,
                            width: 70.w,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                              'Your blood type is determined by genes inherited from your parents. Whether your blood type is rare, common or somewhere in between, your donations are vital in helping save and improve lives.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp, color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('How rare is B positive blood?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              '1 in 13 donors is B positive\n\nThis means only 8% of donors have B positive blood.\nIn total, 10% of people belong to blood group B, making it one of the least common blood groups.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Who can receive B positive blood?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Image.asset(
                            'assets/images/bpov.png',
                            height: 150.h,
                            width: 150.w,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'B positive and AB positive people\n\nB positive red blood cells can be given to people with:\nB positive blood\nAB positive blood ',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('What blood can B positive people receive?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'Blood from groups B and O\n\nPeople with B positive blood can receive donations from:\n\nB positive donors\nB negative donors\nO negative donors\nO positive donors',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Why is B positive blood important?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'It helps treat sickle cell disease\n\nB positive is an important blood type for treating people with sickle cell disease and thalassemia who need regular transfusions.\n\nThese conditions affect South Asian and Black communities where B positive blood is more common.\n\nThere is currently a very high demand for B positive donations with the subtype Ro.\n\nApproximately 2% of donors have this rare subtype and we need more',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
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

class bnegbloodtype extends StatefulWidget {
  @override
  State createState() {
    return bnegbloodtypeState();
  }
}

class bnegbloodtypeState extends State<bnegbloodtype> {
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
                  builder: (context) => bloodtypebody(),
                ),
              );
            },
           icon: FaIcon(FontAwesomeIcons.arrowLeft, color: kWhiteColor,)),
        elevation: 0,
        title: Text('B(-ve) Blood Group',
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
            SizedBox(height: size.height * 0.02),
            SizedBox(
              height: 5,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/bloodbneg.png',
                            height: 70.h,
                            width: 70.w,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                              'Your blood type is determined by genes inherited from your parents. Whether your blood type is rare, common or somewhere in between, your donations are vital in helping save and improve lives.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp, color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('How rare is B negative blood?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              '1 in 50 donors is B negative\n\nB negative blood is one of the rarest blood types as just 2% of our blood donors have it.\nIn comparison, 36% of donors have O positive blood which is the most common type.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Who can receive B negative blood?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Image.asset(
                            'assets/images/bneg.png',
                            height: 150.h,
                            width: 150.w,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'Group B and AB people\n\nAround 1 in 8 people can receive red blood cells from B negative donors.\nB negative blood can help people who are:\n\nB negative\nB positive\nAB negative\nAB positive',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('What blood can B negative people receive?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'B negative and O negative blood\n\nB negative people can receive red blood cells from:\n\nB negative donors\nO negative donors',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Why is B negative blood important?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'It’s one of the rarest blood types\n\nB negative donors are immensely important to our lifesaving work.\n\nAs B negative is one of the rarest blood types, it is hard to find new donors and to ensure we always collect enough blood.\n\nWe always need more B negative donors and rely heavily on the support and commitment of existing donors to ensure patients receive the blood they need.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
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

class opovbloodtype extends StatefulWidget {
  @override
  State createState() {
    return opovbloodtypeState();
  }
}

class opovbloodtypeState extends State<opovbloodtype> {
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
                  builder: (context) => bloodtypebody(),
                ),
              );
            },
            icon: FaIcon(FontAwesomeIcons.arrowLeft, color: kWhiteColor,)),
        elevation: 0,
        title: Text('O(+ve) Blood Group',
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
            SizedBox(height: size.height * 0.02),
            SizedBox(
              height: 5,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/bloodopos.png',
                            height: 70.h,
                            width: 70.w,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                              'Your blood type is determined by genes inherited from your parents. Whether your blood type is rare, common or somewhere in between, your donations are vital in helping save and improve lives.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp, color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('How common is O positive blood?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              '1 in 3 donors is O positive\n\nO positive is the most common blood type as around 35% of our blood donors have it.\nThe second most common blood type is A positive (30%), while AB negative (1%) is the rarest',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Who can receive O positive blood?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Image.asset(
                            'assets/images/opov.png',
                            height: 150.h,
                            width: 150.w,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'Anyone with an Rh positive blood type\n\nAnyone with an Rh positive blood type can receive O positive red blood cells – so that’s A positive, B positive and AB positive as well as O positive.\n\nThat means 3 in 4 people, or around 76% of the population, can benefit from your donation.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('What blood can O positive people receive?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'Blood from O positive and O negative donors\n\nPeople with O positive blood can receive donations from:\n\nO positive blood donors\nO negative blood donors',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Why is 0 positive blood important?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'It’s always in demand\n\nO positive is the blood type most commonly requested by hospitals so we need to make sure there is a steady supply.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
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

class onegbloodtype extends StatefulWidget {
  @override
  State createState() {
    return onegbloodtypeState();
  }
}

class onegbloodtypeState extends State<onegbloodtype> {
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
                  builder: (context) => bloodtypebody(),
                ),
              );
            },
            icon: FaIcon(FontAwesomeIcons.arrowLeft, color: kWhiteColor,)),
        elevation: 0,
        title: Text('O(-ve) Blood Group',
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
            SizedBox(height: size.height * 0.02),
            SizedBox(
              height: 5,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/bloodoneg.png',
                            height: 70.h,
                            width: 70.w,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Text(
                              'Your blood type is determined by genes inherited from your parents. Whether your blood type is rare, common or somewhere in between, your donations are vital in helping save and improve lives.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp, color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('How common is O negative blood?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'Around 1 in 7 people have O negative blood\n\nAround 13% of our blood donors have O negative blood.\nIn comparison, 35% of donors have O positive blood.\nAir ambulances and emergency response vehicles carry O negative supplies for emergencies. Collecting enough O negative blood is a constant challenge and we always need your donations.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Who can receive O negative blood?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Image.asset(
                            'assets/images/oneg.png',
                            height: 150.h,
                            width: 150.w,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'Everyone can receive O negative red blood cells\n\nO negative donors are often called ‘universal donors’ because anyone can receive the red blood cells from their donations.\n\nAlthough about 8% of the population has O negative blood, it accounts for around 13% of hospital requests for red blood cells.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('What blood can O negative people receive?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'Only O negative blood\n\nPeople with O negative blood can only receive red cell donations from O negative donors.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Why is O negative blood important?',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986))),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                              'It’s used in emergencies\n\nO negative blood is often called the ‘universal blood type’ because people of any blood type can receive it.\n\nThis makes it vitally important in an emergency or when a patient’s blood type is unknown.',
                              softWrap: true,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xff406986))),
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
