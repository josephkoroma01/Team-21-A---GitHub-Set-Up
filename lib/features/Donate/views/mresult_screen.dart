import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifebloodworld/constants/colors.dart';
import 'package:lifebloodworld/features/Home/views/search.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:lifebloodworld/features/Login/views/login_screen.dart';
import 'package:lifebloodworld/features/Login/views/schedulebloodtest.dart';
import 'package:lifebloodworld/models/bloodtestingfacilities.dart';
import 'package:http/http.dart' as http;

class MAnalysisScreen extends StatefulWidget {
  MAnalysisScreen({Key? key}) : super(key: key);

  @override
  State<MAnalysisScreen> createState() => _MAnalysisScreenState();
}

class _MAnalysisScreenState extends State<MAnalysisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFe0e9e4),
        title: Text(
          'Eligibility Analysis',
          overflow: TextOverflow.clip,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 17,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
      backgroundColor: Color(0xFFe0e9e4),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.zero,
                                bottomRight: Radius.zero)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Question 1',
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.expand_more,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        // Use Expanded to allow the SingleChildScrollView to take remaining space
                        child: SingleChildScrollView(
                          // Wrap your content with SingleChildScrollView
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                color: Colors.teal[50],
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Text('Intro',
                                      //     textAlign: TextAlign.left,
                                      //     style: GoogleFonts.montserrat(
                                      //         fontSize: 15,
                                      //         fontWeight: FontWeight.bold,
                                      //         color: Colors.teal)),

                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  'Are you between the 18-65?',
                                                  overflow: TextOverflow.clip,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.teal))),
                                        ],
                                      ),
                                      10.verticalSpace,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text('Response',
                                                  textAlign: TextAlign.left,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kPrimaryColor)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 10),
                                                decoration: BoxDecoration(
                                                    color: kIconBcgColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0)),
                                                child: Text(
                                                  'Yes',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: kPrimaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              5.horizontalSpace,
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 10),
                                                decoration: BoxDecoration(
                                                    color: kPrimaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0)),
                                                child: Text(
                                                  'Eligible',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: kWhiteColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                color: kWhiteColor,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 15, right: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('Reason',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    // color: Colors.teal[50],
                                    borderRadius: BorderRadius.only(
                                        // topLeft: Radius.circular(10),
                                        // topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 5, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Text('Intro',
                                      //     textAlign: TextAlign.left,
                                      //     style: GoogleFonts.montserrat(
                                      //         fontSize: 15,
                                      //         fontWeight: FontWeight.bold,
                                      //         color: Colors.teal)),

                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  'Are you between the 18-65?',
                                                  overflow: TextOverflow.clip,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.teal))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 0, right: 0),
                                child: Divider(
                                  thickness: 0.20,
                                  color: Colors.grey,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                color: kWhiteColor,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, left: 15, right: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('How to Prepare',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    // color: Colors.teal[50],
                                    borderRadius: BorderRadius.only(
                                        // topLeft: Radius.circular(10),
                                        // topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 5, bottom: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Text('Intro',
                                      //     textAlign: TextAlign.left,
                                      //     style: GoogleFonts.montserrat(
                                      //         fontSize: 15,
                                      //         fontWeight: FontWeight.bold,
                                      //         color: Colors.teal)),

                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  'Are you between the 18-65?',
                                                  overflow: TextOverflow.clip,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.teal))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // 10.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.zero,
                                bottomRight: Radius.zero)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Question 1',
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.expand_more,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        // Use Expanded to allow the SingleChildScrollView to take remaining space
                        child: SingleChildScrollView(
                          // Wrap your content with SingleChildScrollView
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                color: Colors.teal[50],
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Text('Intro',
                                      //     textAlign: TextAlign.left,
                                      //     style: GoogleFonts.montserrat(
                                      //         fontSize: 15,
                                      //         fontWeight: FontWeight.bold,
                                      //         color: Colors.teal)),

                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  'Are you between the 18-65?',
                                                  overflow: TextOverflow.clip,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.teal))),
                                        ],
                                      ),
                                      10.verticalSpace,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text('Response',
                                                  textAlign: TextAlign.left,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kPrimaryColor)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 10),
                                                decoration: BoxDecoration(
                                                    color: kIconBcgColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0)),
                                                child: Text(
                                                  'Yes',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: kPrimaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              5.horizontalSpace,
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 10),
                                                decoration: BoxDecoration(
                                                    color: kPrimaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0)),
                                                child: Text(
                                                  'Eligible',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: kWhiteColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                color: kWhiteColor,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 15, right: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('Reason',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    // color: Colors.teal[50],
                                    borderRadius: BorderRadius.only(
                                        // topLeft: Radius.circular(10),
                                        // topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 5, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Text('Intro',
                                      //     textAlign: TextAlign.left,
                                      //     style: GoogleFonts.montserrat(
                                      //         fontSize: 15,
                                      //         fontWeight: FontWeight.bold,
                                      //         color: Colors.teal)),

                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  'Are you between the 18-65?',
                                                  overflow: TextOverflow.clip,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.teal))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 0, right: 0),
                                child: Divider(
                                  thickness: 0.20,
                                  color: Colors.grey,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                color: kWhiteColor,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, left: 15, right: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('How to Prepare',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    // color: Colors.teal[50],
                                    borderRadius: BorderRadius.only(
                                        // topLeft: Radius.circular(10),
                                        // topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 5, bottom: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Text('Intro',
                                      //     textAlign: TextAlign.left,
                                      //     style: GoogleFonts.montserrat(
                                      //         fontSize: 15,
                                      //         fontWeight: FontWeight.bold,
                                      //         color: Colors.teal)),

                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  'Are you between the 18-65?',
                                                  overflow: TextOverflow.clip,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.teal))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // 10.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.zero,
                                bottomRight: Radius.zero)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Question 1',
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.expand_more,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        // Use Expanded to allow the SingleChildScrollView to take remaining space
                        child: SingleChildScrollView(
                          // Wrap your content with SingleChildScrollView
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                color: Colors.teal[50],
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Text('Intro',
                                      //     textAlign: TextAlign.left,
                                      //     style: GoogleFonts.montserrat(
                                      //         fontSize: 15,
                                      //         fontWeight: FontWeight.bold,
                                      //         color: Colors.teal)),

                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  'Are you between the 18-65?',
                                                  overflow: TextOverflow.clip,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.teal))),
                                        ],
                                      ),
                                      10.verticalSpace,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text('Response',
                                                  textAlign: TextAlign.left,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kPrimaryColor)),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 10),
                                                decoration: BoxDecoration(
                                                    color: kIconBcgColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0)),
                                                child: Text(
                                                  'Yes',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: kPrimaryColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              5.horizontalSpace,
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 10),
                                                decoration: BoxDecoration(
                                                    color: kPrimaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0)),
                                                child: Text(
                                                  'Eligible',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: kWhiteColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                color: kWhiteColor,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 15, right: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('Reason',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    // color: Colors.teal[50],
                                    borderRadius: BorderRadius.only(
                                        // topLeft: Radius.circular(10),
                                        // topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 5, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Text('Intro',
                                      //     textAlign: TextAlign.left,
                                      //     style: GoogleFonts.montserrat(
                                      //         fontSize: 15,
                                      //         fontWeight: FontWeight.bold,
                                      //         color: Colors.teal)),

                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  'Are you between the 18-65?',
                                                  overflow: TextOverflow.clip,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.teal))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 0, right: 0),
                                child: Divider(
                                  thickness: 0.20,
                                  color: Colors.grey,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                color: kWhiteColor,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, left: 15, right: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('How to Prepare',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    // color: Colors.teal[50],
                                    borderRadius: BorderRadius.only(
                                        // topLeft: Radius.circular(10),
                                        // topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 5, bottom: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Text('Intro',
                                      //     textAlign: TextAlign.left,
                                      //     style: GoogleFonts.montserrat(
                                      //         fontSize: 15,
                                      //         fontWeight: FontWeight.bold,
                                      //         color: Colors.teal)),

                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  'Are you between the 18-65?',
                                                  overflow: TextOverflow.clip,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.teal))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // 10.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.arrowUpRightFromSquare,
                            size: 15,
                            color: kPrimaryColor,
                          ),
                          5.horizontalSpace,
                          Text('Continue Blood Donation Appointment',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: 13,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w400,
                                color: kPrimaryColor,
                              )),
                        ],
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: kWhiteColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => blooddonationfacility()),
                            (route) => false);
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.arrowLeftLong,
                            size: 15,
                            color: kWhiteColor,
                          ),
                          5.horizontalSpace,
                          Text('Go Back',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w400,
                                color: kWhiteColor,
                              )),
                        ],
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: kLifeBloodBlue,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false);
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.reply,
                            size: 15,
                            color: kPrimaryColor,
                          ),
                          5.horizontalSpace,
                          Text('Share Eligibility Analysis Data',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: 13,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w400,
                                color: kPrimaryColor,
                              )),
                        ],
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.teal.shade100,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => HomePageScreen(
                                      pageIndex: 0,
                                    )),
                            (route) => false);
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('This will help improve our AI model ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12,
                              color: kGreyColor)),
                      Text('Hemoglobin',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: kGreyColor)),
                    ],
                  ),
                  10.verticalSpace,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => RequestDialogContent());
  }
}

class RequestDialogContent extends StatefulWidget {
  RequestDialogContent({
    super.key,
  });

  @override
  State<RequestDialogContent> createState() => _RequestDialogContentState();
}

class _RequestDialogContentState extends State<RequestDialogContent> {
  Timer? debouncer;
  String donationquery = '';

  @override
  final TextEditingController timeInput = TextEditingController();
  final TextEditingController _usernameCtrl = TextEditingController();

  final List<String> trivianameItems = [
    'Account Name',
    'Username',
  ];
  String? selectedrc = '';
  String? selectedrcsolved = '';
  String? selectedscsolved = '';
  String? selectedsc = '';
  String? selectedtrivianame = '';
  String? selectedSampleBrought = '';
  String? _selectedrcRadioGroupValue;
  final _formKey = GlobalKey<FormState>();
  bool _scheduling = false;

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  void _onChanged(dynamic val) => setState(() {
        // usercommunity = val;
        debugPrint(val.toString());
      });

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
        final districtLower = donationschedule.district!.toLowerCase();
        final facilitynameLower = donationschedule.name!.toLowerCase();
        final servicetypeLower = donationschedule.name!.toLowerCase();
        final searchLower = donationquery.toLowerCase();
        return districtLower.contains(searchLower) ||
            facilitynameLower.contains(searchLower) ||
            servicetypeLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width <= 768 ? 0.7.sw : 0.35.sw,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: kLifeBloodBlue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: const Text(
                      'Trivia Questions & Answers',
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        overflow: TextOverflow.fade,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: FutureBuilder<List<BloodTestingFacilities>>(
                    future: getBloodFacilities(donationquery),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: kLifeBloodBlue,
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
                                                builder:
                                                    (BuildContext context) =>
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
                                                            bottom:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(.0, 5.0,
                                                                  5.0, 5.0),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10.w),
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.r),
                                                              width: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                border: Border.all(
                                                                    color:
                                                                        kLifeBloodBlue),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16),
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                          'Blood Donor Request',
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style: GoogleFonts.montserrat(
                                                                              fontSize: 10,
                                                                              letterSpacing: 0,
                                                                              color: kGreyColor)),
                                                                      SizedBox(
                                                                        height:
                                                                            5.h,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
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
                                                                                  text: data.name,
                                                                                  style: GoogleFonts.montserrat(
                                                                                    fontSize: 13,
                                                                                    letterSpacing: 0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Color(0xFF205072),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            textHeightBehavior:
                                                                                TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFF205072)),
                                                                            child:
                                                                                Text(
                                                                              data.district!,
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
                                                                        height:
                                                                            2.h,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Flexible(
                                                                            child:
                                                                                Expanded(
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
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Color(0xFF205072),
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.bold,
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
                                                                        textHeightBehavior:
                                                                            TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            2.h,
                                                                      ),
                                                                      TextButton(
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            FaIcon(
                                                                              FontAwesomeIcons.whatsapp,
                                                                              size: 20,
                                                                            ),
                                                                            5.horizontalSpace,
                                                                            Text('Volunteer to Donate',
                                                                                textAlign: TextAlign.center,
                                                                                style: GoogleFonts.montserrat(
                                                                                  fontSize: 13,
                                                                                  letterSpacing: 0,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  color: kWhiteColor,
                                                                                )),
                                                                          ],
                                                                        ),
                                                                        style: TextButton
                                                                            .styleFrom(
                                                                          foregroundColor:
                                                                              Colors.white,
                                                                          backgroundColor:
                                                                              kLifeBloodBlue,
                                                                          shape:
                                                                              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                        ),
                                                                        onPressed:
                                                                            () {},
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
      ),
    );
  }
}
