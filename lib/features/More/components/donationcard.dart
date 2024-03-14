import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:expandable/expandable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class donationcard extends StatefulWidget {
  @override
  State createState() {
    return donationcardState();
  }
}

class donationcardState extends State<donationcard> {
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
  String? nextdonationdate;
  String? donorid;
  String? donated;
  bool donatenow = false;
  late Timer _getDatatimer;
  late Timer _getDonationCardtimer;

  @override
  void initState() {
    super.initState();
    getPref();
  }

  void dispose() {
    if (_getDatatimer.isActive) _getDatatimer.cancel();
    if (_getDonationCardtimer.isActive) _getDatatimer.cancel();
    super.dispose();
  }

  savenextdonationPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nextdonationdate', nextdonationdate!);
  }

  Future<List<DonationCarddata>> getDonationCard() async {
    var data = {'phonenumber': phonenumber};

    var response = await http.post(
          Uri.parse("https://community.lifebloodsl.com/donationcard.php"),
          body: json.encode(data));

    if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        List<DonationCarddata> bloodtestschList =
            items.map<DonationCarddata>((json) {
          return DonationCarddata.fromJson(json);
        }).toList();
        return bloodtestschList;
    } else {
      throw Exception();
    }
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
      nextdonationdate = prefs.getString('nextdonationdate');
      donorid = prefs.getString('donorid');
      donated = prefs.getString('donated');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => HomePageScreen(pageIndex: 3),
                ),
              );
            },
            icon: Icon(Icons.arrow_back)),
        elevation: 0,
        title: Text(
          "Donation Card",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 15.sp),
        ),
      ),
      backgroundColor: Color(0xFFe0e9e4),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.h),
            Image.asset(
              (gender == "Female")
                  ? "assets/icons/woman.png"
                  : "assets/icons/man.png",
              height: 60.h,
              // width: size.width * 0.4,
            ),
            SizedBox(height: 10.h),
            Text(
              "$ufname $umname $ulname",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff389e9d)),
            ),
            SizedBox(height: 2.h),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    style: TextStyle(
                                      color: Color(0xFF205072),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Birth Date: ',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF205072),
                                        ),
                                      ),
                                      TextSpan(
                                        text: "$agecategory",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
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
                                Row(
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        style: TextStyle(
                                          color: Color(0xFF205072),
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Gender: ',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.normal,
                                              color: Color(0xFF205072),
                                            ),
                                          ),
                                          TextSpan(
                                            text: gender,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14.sp,
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
                                    ("$gender" == "Male")
                                        ? Icon(
                                            Icons.male_outlined,
                                            color: Color(0xFF205072),
                                          )
                                        : Icon(Icons.female_outlined),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text.rich(
                                  TextSpan(
                                    style: TextStyle(
                                      color: Color(0xFF205072),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Blood Type: ',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF205072),
                                        ),
                                      ),
                                      TextSpan(
                                        text: "$bloodtype",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
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
                                Text.rich(
                                  TextSpan(
                                    style: TextStyle(
                                      color: Color(0xFF205072),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Previous Donation: ',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF205072),
                                        ),
                                      ),
                                      TextSpan(
                                        text: "$prevdonation",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
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
                                (prevdonation == "Yes")
                                    ? Text.rich(
                                        TextSpan(
                                          style: TextStyle(
                                            color: Color(0xFF205072),
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  'Number of Previous Donations: ',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.normal,
                                                color: Color(0xFF205072),
                                              ),
                                            ),
                                            TextSpan(
                                              text: "$prevdonationamt",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF205072),
                                              ),
                                            ),
                                          ],
                                        ),
                                        textHeightBehavior: TextHeightBehavior(
                                            applyHeightToFirstAscent: false),
                                        textAlign: TextAlign.left,
                                      )
                                    : SizedBox(
                                        height: 0.h,
                                      ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                (donated == "Yes")
                                    ? Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text.rich(
                                            TextSpan(
                                              style: TextStyle(
                                                color: Color(0xFF205072),
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'Donor ID: ',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Color(0xFF205072),
                                                  ),
                                                ),
                                                
                                                    TextSpan(
                                                        text: "$donorid",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Color(0xFF205072),
                                                        ),
                                                      )
                                                    
                                              ],
                                            ),
                                            textHeightBehavior:
                                                TextHeightBehavior(
                                                    applyHeightToFirstAscent:
                                                        false),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              style: TextStyle(
                                                color: Color(0xFF205072),
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'Next Donation Date: ',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Color(0xFF205072),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: "$nextdonationdate",
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF205072),
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
                                        ],
                                      )
                                    : SizedBox(
                                        height: 0.h,
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
              height: 20.h,
            ),
            Divider(
              height: 0.3.h,
              thickness: 0.3.h,
              color: Colors.teal,
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      height: 500.h,
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
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: FutureBuilder<List<DonationCarddata>>(
                                future: getDonationCard(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: SizedBox(
                                                          height: 20.0,
                                                          width: 20.0,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Colors.teal,
                                                            strokeWidth: 2.0,
                                                          ),
                                                        ),);
                                  } else if (!snapshot.hasData) {
                                    return Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/icons/sad.png",
                                              height: 60.h,
                                              width: 60.w,
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                              "No blood donation yet..",
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 15.sp,
                                                  color: Color(0xFFE02020)),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                style: TextStyle(
                                                  color: Color(0xFF205072),
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: 'Hi, ',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Color(0xFF205072),
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: "$ufname $ulname",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFF205072),
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
                                              height: 10.h,
                                            ),
                                            Text(
                                              "Do you want to donate? \nKindly Schedule or Track a Blood Donation",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 13.sp,
                                                  color: Color(0xFF205072)),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            ElevatedButton(
                                              child: Text('Schedule Now',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12.sp,
                                                      color: Colors.white)),
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                backgroundColor: Colors.teal,
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomePageScreen(
                                                            pageIndex: 2),
                                                  ),
                                                );
                                              },
                                            ),
                                            ElevatedButton(
                                              child: Text('Track Schedule',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12.sp,
                                                      color: Colors.white)),
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.white,
                                                backgroundColor:
                                                    Color(0xFF205072),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomePageScreen(
                                                            pageIndex: 2),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text.rich(
                                                TextSpan(
                                                  style: TextStyle(
                                                    color: Color(0xFF205072),
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          'Total Donations with LifeBlood : ',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.teal),
                                                    ),
                                                    TextSpan(
                                                      text: snapshot
                                                          .data?.length
                                                          .toString(),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.teal,
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
                                            ],
                                          ),
                                          Expanded(
                                            child: ListView(
                                              children: snapshot.data!
                                                  .map((data) => Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Column(children: [
                                                            SizedBox(
                                                              height: 10.h,
                                                            ),
                                                            Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text.rich(
                                                                    TextSpan(
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xFF205072),
                                                                        fontSize:
                                                                            15.sp,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              'Donation Type: ',
                                                                          style:
                                                                              GoogleFonts.montserrat(
                                                                            fontSize:
                                                                                14.sp,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            color:
                                                                                Color(0xFF205072),
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              data.donortype,
                                                                          style:
                                                                              GoogleFonts.montserrat(
                                                                            fontSize:
                                                                                14.sp,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color:
                                                                                Color(0xFF205072),
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
                                                                  Text.rich(
                                                                    TextSpan(
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xFF205072),
                                                                        fontSize:
                                                                            15.sp,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              'Facility: ',
                                                                          style:
                                                                              GoogleFonts.montserrat(
                                                                            fontSize:
                                                                                14.sp,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            color:
                                                                                Color(0xFF205072),
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              data.facility,
                                                                          style:
                                                                              GoogleFonts.montserrat(
                                                                            fontSize:
                                                                                14.sp,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color:
                                                                                Color(0xFF205072),
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
                                                                  Text.rich(
                                                                    TextSpan(
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xFF205072),
                                                                        fontSize:
                                                                            15.sp,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              'Reg No: ',
                                                                          style:
                                                                              GoogleFonts.montserrat(
                                                                            fontSize:
                                                                                14.sp,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            color:
                                                                                Color(0xFF205072),
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              data.regno,
                                                                          style:
                                                                              GoogleFonts.montserrat(
                                                                            fontSize:
                                                                                14.sp,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color:
                                                                                Color(0xFF205072),
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
                                                                  Text.rich(
                                                                    TextSpan(
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xFF205072),
                                                                        fontSize:
                                                                            15.sp,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              'Date: ',
                                                                          style:
                                                                              GoogleFonts.montserrat(
                                                                            fontSize:
                                                                                14.sp,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            color:
                                                                                Color(0xFF205072),
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              data.date,
                                                                          style:
                                                                              GoogleFonts.montserrat(
                                                                            fontSize:
                                                                                14.sp,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color:
                                                                                Color(0xFF205072),
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
                                                                  Text.rich(
                                                                    TextSpan(
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xFF205072),
                                                                        fontSize:
                                                                            15.sp,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              'Next Donation Date: ',
                                                                          style:
                                                                              GoogleFonts.montserrat(
                                                                            fontSize:
                                                                                14.sp,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            color:
                                                                                Color(0xFF205072),
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              data.nextdonationdate,
                                                                          style:
                                                                              GoogleFonts.montserrat(
                                                                            fontSize:
                                                                                14.sp,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color:
                                                                                Color(0xFF205072),
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
                                                                ]),
                                                            SizedBox(
                                                              height: 10.h,
                                                            )
                                                          ])
                                                        ],
                                                      ))
                                                  .toList(),
                                            ),
                                          )
                                        ]);
                                  }
                                },
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DonationCarddata {
  String donortype;
  String facility;
  String regno;
  String date;
  String nextdonationdate;
  String donorid;

  DonationCarddata(
      {required this.donortype,
      required this.facility,
      required this.regno,
      required this.date,
      required this.donorid,
      required this.nextdonationdate});

  factory DonationCarddata.fromJson(Map<String, dynamic> json) {
    return DonationCarddata(
        donortype: json['donor_type'].toString(),
        regno: json['regno'].toString(),
        facility: json['tfs_name'].toString(),
        date: json['date'].toString(),
        donorid: json['donorid'].toString(),
        nextdonationdate: json['nextdonation'].toString());
  }
}
