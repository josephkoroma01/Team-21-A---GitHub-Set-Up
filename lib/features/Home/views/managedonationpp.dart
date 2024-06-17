import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifebloodworld/features/Home/views/managebloodtestapp.dart';
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
import '../../../models/blooddonationschedule.dart';
import '../../../models/donationschedule.dart';
import 'search.dart';

class managedonationAppointments extends StatefulWidget {
  const managedonationAppointments({
    Key? key,
  }) : super(key: key);
  @override
  State<managedonationAppointments> createState() =>
      _managedonationAppointmentsState();
}

class _managedonationAppointmentsState
    extends State<managedonationAppointments> {
  String? address;
  String? agecategory;
  String? bloodtype;
  Timer? debouncer;
  String? district;
  String donationquery = '';
  List<Schedule> donationschedule = [];
  String? email;
  String? gender;
  String? phonenumber;
  String? prevdonation;
  bool ratingappbar = false;
  String? refcode = '';
  String? selectedRating = '';
  String? totaldonationrep;
  String? totaldonationvol;
  String? totaldonationvolcan;
  String? totaldonationvolcon;
  String? totaldonationvold;
  String? totaldonationvolp;
  String? totaldonationvolr;
  String? ufname;
  String? ulname;
  String? umname;

  final _formKey = GlobalKey<FormState>();
  Future<bool> getInternetUsingInternetConnectivity() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<List<BloodDonationSchAppdata>> getBloodDonationApp(
      String donationquery) async {
    var data = {'phonenumber': '+23278621647'};

    var response = await http.post(
        Uri.parse(
            "https://community.lifebloodsl.com/managedonationappointments.php"),
        body: json.encode(data));

    if (response.statusCode == 200) {
      final List donationschedule = json.decode(response.body);

      return donationschedule
          .map((json) => BloodDonationSchAppdata.fromJson(json))
          .where((donationschedule) {
        final facilityLower = donationschedule.facility.toLowerCase();
        final refcodeLower = donationschedule.refcode.toLowerCase();
        final searchLower = donationquery.toLowerCase();

        return facilityLower.contains(searchLower) ||
            refcodeLower.contains(searchLower);
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
            "phonenumber": '+23278621647',
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

  Widget builddonationSearch() => SearchWidget(
        text: donationquery,
        hintText: 'Facility or Reference Code',
        onChanged: searchBook,
      );

  Future searchBook(String donationquery) async => debounce(() async {
        final donationschedule = await getBloodDonationApp(donationquery);

        if (!mounted) return;

        setState(() {
          this.donationquery = donationquery;
        });
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe0e9e4),
      appBar: AppBar(
          title: FutureBuilder<List<BloodDonationSchAppdata>>(
            future: getBloodDonationApp(donationquery),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text(
                  'Blood Donation Schedule',
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                );
              } else if (!snapshot.hasData) {
                return Text(
                  'Blood Donation Schedule',
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                );
              } else {
                return Text.rich(
                  TextSpan(
                    style: TextStyle(
                      color: const Color(0xFF205072),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: 'Blood Donation Schedule, ',
                        style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: snapshot.data?.length.toString(),
                        style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.left,
                );
              }
            },
          ),
          automaticallyImplyLeading: true,
          elevation: 0,
          backgroundColor: Colors.teal,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              })),
      body: Column(children: <Widget>[
        builddonationSearch(),
        _donationScheduleCard(context),
      ]),
    );
  }

  Column _donationScheduleCard(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: donationschedule
                  .map((data) => Column(
                        children: <Widget>[
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 3.h,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Container(
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
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.teal),
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Image.asset(
                                                              'assets/icons/blood-bag.png',
                                                              height: 40.h,
                                                              width: 40.w,
                                                            ),
                                                            SizedBox(
                                                              height: 5.h,
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
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                children: [
                                                                  TextSpan(
                                                                    text: data
                                                                        .donorType,
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      fontSize:
                                                                          12.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
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
                                                                  TextAlign
                                                                      .left,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          child: Container(
                                                            color: Color(
                                                                0xFFe0e9e4),
                                                            height: 50.h,
                                                            width: 1.w,
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                'Blood Donation Schedule Information',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: GoogleFonts.montserrat(
                                                                    fontSize:
                                                                        10.sp,
                                                                    color: Color(
                                                                        0xff389e9d))),
                                                            SizedBox(
                                                              height: 5.h,
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
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        'Facility: ',
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      fontSize:
                                                                          13.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color: Color(
                                                                          0xFF205072),
                                                                    ),
                                                                  ),
                                                                  TextSpan(
                                                                    text: data
                                                                        .facility,
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      fontSize:
                                                                          13.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color(
                                                                          0xFF205072),
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
                                                            SizedBox(
                                                              height: 2.h,
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
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        'Date: ',
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      fontSize:
                                                                          13.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color: Color(
                                                                          0xFF205072),
                                                                    ),
                                                                  ),
                                                                  TextSpan(
                                                                    text: data
                                                                        .date,
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      fontSize:
                                                                          13.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color(
                                                                          0xFF205072),
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
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        'Time Slot: ',
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      fontSize:
                                                                          13.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color: Color(
                                                                          0xFF205072),
                                                                    ),
                                                                  ),
                                                                  TextSpan(
                                                                    text: data
                                                                        .timeslot,
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      fontSize:
                                                                          13.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color(
                                                                          0xFF205072),
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
                                                            SizedBox(
                                                              height: 2.h,
                                                            ),
                                                            Row(
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
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                    children: [
                                                                      TextSpan(
                                                                        text:
                                                                            'Refcode: ',
                                                                        style: GoogleFonts
                                                                            .montserrat(
                                                                          fontSize:
                                                                              13.sp,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          color:
                                                                              Color(0xFF205072),
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                        text: data
                                                                            .refcode,
                                                                        style: GoogleFonts
                                                                            .montserrat(
                                                                          fontSize:
                                                                              13.sp,
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
                                                                SizedBox(
                                                                  width: 5.h,
                                                                ),
                                                                InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    await Clipboard.setData(ClipboardData(
                                                                        text: data
                                                                            .refcode
                                                                            .toString()));
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                            SnackBar(
                                                                      duration: Duration(
                                                                          seconds:
                                                                              5),
                                                                      content: Text(
                                                                          'Copied to clipboard',
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style:
                                                                              GoogleFonts.montserrat()),
                                                                    ));
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .copy,
                                                                        size:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                          ' Copy Code ',
                                                                          style:
                                                                              GoogleFonts.montserrat(
                                                                            fontSize:
                                                                                10.sp,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            color:
                                                                                Colors.black,
                                                                          )),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 2.h,
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
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        'Status: ',
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      fontSize:
                                                                          13.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color: Color(
                                                                          0xFF205072),
                                                                    ),
                                                                  ),
                                                                  TextSpan(
                                                                    text: data
                                                                        .status,
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      fontSize:
                                                                          13.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: (data.status ==
                                                                              "Pending")
                                                                          ? Colors
                                                                              .amber
                                                                          : (data.status == "Confirmed")
                                                                              ? Colors.green
                                                                              : (data.status == "Donated")
                                                                                  ? Color(0xff389e9d)
                                                                                  : Color(0xFFE02020),
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
                                                            SizedBox(
                                                              height: 5.h,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    (data.status == "Donated")
                                                        ? Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              (data.review ==
                                                                      "Yes")
                                                                  ? Container(
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          TextButton(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.symmetric(horizontal: 5.w),
                                                                          child:
                                                                              Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text('Your Experience: ', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.teal)),
                                                                              (data.rating == "Highly Dissatisfied")
                                                                                  ? Row(
                                                                                      children: [
                                                                                        Image.asset(
                                                                                          'assets/icons/hdis.png',
                                                                                          height: 20.h,
                                                                                          width: 20.w,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 3.w,
                                                                                        ),
                                                                                        Text(data.rating.toString(), textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.red[300])),
                                                                                      ],
                                                                                    )
                                                                                  : (data.rating == "Dissatisfied")
                                                                                      ? Row(
                                                                                          children: [
                                                                                            Image.asset(
                                                                                              'assets/icons/dis.png',
                                                                                              height: 20.h,
                                                                                              width: 20.w,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 3.w,
                                                                                            ),
                                                                                            Text(data.rating.toString(), textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.red[300])),
                                                                                          ],
                                                                                        )
                                                                                      : (data.rating == "Neutral")
                                                                                          ? Row(
                                                                                              children: [
                                                                                                Image.asset(
                                                                                                  'assets/icons/neutral.png',
                                                                                                  height: 20.h,
                                                                                                  width: 20.w,
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  width: 3.w,
                                                                                                ),
                                                                                                Text(data.rating.toString(), textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.amber)),
                                                                                              ],
                                                                                            )
                                                                                          : (data.rating == "Satisified")
                                                                                              ? Row(
                                                                                                  children: [
                                                                                                    Image.asset(
                                                                                                      'assets/icons/sat.png',
                                                                                                      height: 20.h,
                                                                                                      width: 20.w,
                                                                                                    ),
                                                                                                    SizedBox(
                                                                                                      width: 3.w,
                                                                                                    ),
                                                                                                    Text(data.rating.toString(), textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.green[300])),
                                                                                                  ],
                                                                                                )
                                                                                              : Row(
                                                                                                  children: [
                                                                                                    Image.asset(
                                                                                                      'assets/icons/hsat.png',
                                                                                                      height: 20.h,
                                                                                                      width: 20.w,
                                                                                                    ),
                                                                                                    SizedBox(
                                                                                                      width: 3.w,
                                                                                                    ),
                                                                                                    Text(data.rating.toString(), textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.green)),
                                                                                                  ],
                                                                                                ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        style: TextButton
                                                                            .styleFrom(
                                                                          foregroundColor:
                                                                              Colors.red,
                                                                          backgroundColor:
                                                                              Colors.grey[100],
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                        ),
                                                                        onPressed:
                                                                            () {},
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          TextButton(
                                                                        child:
                                                                            Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Text('Rate Your Experience',
                                                                                textAlign: TextAlign.center,
                                                                                style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                          ],
                                                                        ),
                                                                        style: TextButton
                                                                            .styleFrom(
                                                                          foregroundColor:
                                                                              Colors.white,
                                                                          backgroundColor:
                                                                              Colors.teal,
                                                                          shape:
                                                                              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          showModalBottomSheet(
                                                                              isScrollControlled: true,
                                                                              backgroundColor: Color(0xFFebf5f5),
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return SingleChildScrollView(
                                                                                  child: Container(
                                                                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                      child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                                                                        SizedBox(
                                                                                          height: 3.h,
                                                                                        ),
                                                                                        Text('Rate Your Experience', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff389e9d))),
                                                                                        SizedBox(
                                                                                          height: 5.h,
                                                                                        ),
                                                                                        Text('Let us know how we can improve.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.normal, color: Color(0xff406986))),
                                                                                        SizedBox(
                                                                                          height: 5.h,
                                                                                        ),
                                                                                        Container(
                                                                                          width: double.infinity,
                                                                                          child: SizedBox(
                                                                                            child: Divider(
                                                                                              color: Colors.teal,
                                                                                              thickness: 1,
                                                                                            ),
                                                                                            height: 5.h,
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 5.h,
                                                                                        ),
                                                                                        Form(
                                                                                          key: _formKey,
                                                                                          child: Column(
                                                                                            children: [
                                                                                              FormBuilderRadioGroup(
                                                                                                decoration: InputDecoration(border: InputBorder.none, labelText: 'Rate Your Experience', labelStyle: TextStyle(fontSize: 14.sp, fontFamily: 'Montserrat')),
                                                                                                name: '$selectedRating',
                                                                                                onChanged: (String? value) {
                                                                                                  setState(() {
                                                                                                    selectedRating = value;
                                                                                                    refcode = data.refcode;
                                                                                                  });
                                                                                                },
                                                                                                initialValue: selectedRating,
                                                                                                orientation: OptionsOrientation.vertical,
                                                                                                validator: FormBuilderValidators.required(
                                                                                                  errorText: 'Kindly Select an option',
                                                                                                ),
                                                                                                options: [
                                                                                                  'Highly Dissatisfied',
                                                                                                  'Dissatisfied',
                                                                                                  'Neutral',
                                                                                                  'Satisified',
                                                                                                  'Highly Satisfied'
                                                                                                ].map((selectedRating) => FormBuilderFieldOption(value: selectedRating)).toList(growable: false),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: double.infinity,
                                                                                                child: ElevatedButton(
                                                                                                  style: ButtonStyle(
                                                                                                    backgroundColor: MaterialStateProperty.all(Colors.teal),
                                                                                                  ),
                                                                                                  onPressed: () async {
                                                                                                    if (_formKey.currentState!.validate()) {
                                                                                                      if (await getInternetUsingInternetConnectivity()) {
                                                                                                        Navigator.pop(context);
                                                                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                                                                          SnackBar(
                                                                                                              backgroundColor: Colors.teal,
                                                                                                              content: SingleChildScrollView(
                                                                                                                  child: Container(
                                                                                                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                                child: Padding(
                                                                                                                  padding: EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 0.0),
                                                                                                                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                                                    SizedBox(
                                                                                                                      height: 15.0,
                                                                                                                      width: 15.0,
                                                                                                                      child: CircularProgressIndicator(
                                                                                                                        color: Colors.white,
                                                                                                                        strokeWidth: 2.0,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    SizedBox(
                                                                                                                      height: 5.h,
                                                                                                                    ),
                                                                                                                    Text('Sending your rating',
                                                                                                                        textAlign: TextAlign.center,
                                                                                                                        style: GoogleFonts.montserrat(
                                                                                                                          fontSize: 14.sp,
                                                                                                                          fontWeight: FontWeight.normal,
                                                                                                                        ))
                                                                                                                  ]),
                                                                                                                ),
                                                                                                              ))),
                                                                                                        );
                                                                                                        Future.delayed(Duration(seconds: 5), () async {
                                                                                                          sendrating();
                                                                                                        });
                                                                                                      } else {
                                                                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                                          content: Text('You are offline, Turn On Data or Wifi', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 11.sp)),
                                                                                                          backgroundColor: Color(0xFFE02020),
                                                                                                          behavior: SnackBarBehavior.fixed,
                                                                                                          duration: const Duration(seconds: 5),
                                                                                                          // duration: Duration(seconds: 3),
                                                                                                        ));
                                                                                                      }
                                                                                                    }
                                                                                                  },
                                                                                                  child: const Text(
                                                                                                    'Rate Your Experience',
                                                                                                    style: TextStyle(fontFamily: 'Montserrat'),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(height: 20.h),
                                                                                            ],
                                                                                          ),
                                                                                        )
                                                                                      ]),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              });
                                                                        },
                                                                      ),
                                                                    ),
                                                            ],
                                                          )
                                                        : SizedBox(
                                                            height: 0.h,
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
                                  height: 0.h,
                                )
                              ])
                        ],
                      ))
                  .toList(),
            ),
          )
        ]);
  }
}
