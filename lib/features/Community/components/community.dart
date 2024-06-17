import 'dart:async';

import 'package:cool_stepper/cool_stepper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lifebloodworld/features/Community/components/createactivity.dart';
import 'package:lifebloodworld/features/Community/components/createcommunity.dart';
import 'package:lifebloodworld/features/Home/views/search.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:intl/intl.dart';
import 'package:lifebloodworld/features/Login/views/schedulebloodtest.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:lifebloodworld/main.dart';
import 'package:lifebloodworld/models/blooddonationschedule.dart';
import 'package:lifebloodworld/models/bloodtestingfacilities.dart';
import 'package:lifebloodworld/models/community_activity_model.dart';
import 'package:lifebloodworld/widgets/custom_textfield.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/colors.dart';
import '../../../models/community_model.dart';

DateTime now = DateTime.now();
String formattedNewDate = DateFormat('d MMM yyyy').format(now);
String formattedNewMonth = DateFormat('LLLL').format(now);
String formattedNewYear = DateFormat('y').format(now);

// class AppCountry {
//   final String name;
//   final Map<String, String> nameTranslations;
//   final String flag;
//   final String code;
//   final String dialCode;
//   final String regionCode;
//   final int minLength;
//   final int maxLength;

//   const AppCountry({
//     required this.name,
//     required this.flag,
//     required this.code,
//     required this.dialCode,
//     required this.nameTranslations,
//     required this.minLength,
//     required this.maxLength,
//     this.regionCode = "",
//   });
// }

class Community extends StatefulWidget {
  Community({
    super.key,
    required this.communityName,
    required this.location,
    required this.description,
    required this.communityId,
    required this.communityData,
  });
  String communityName;
  String location;
  String description;
  String communityId;
  CommunityModel communityData;

  @override
  //text editing controller for text field
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> with TickerProviderStateMixin {
  // Convert AppCountry to Country

  final _formKey = GlobalKey<FormBuilderState>();

  // Your list of AppCountry instances

  late TabController tabController;
  late List tabs;
  int _currentIndex = 0;
  void _handleTabControllerTick() {
    setState(() {
      _currentIndex = tabController.index;
    });
  }

  @override
  void initState() {
    tabs = ['Activities', 'Members'];
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(_handleTabControllerTick);
    //set the initial value of text field
    getAllCommunitiesActivity();
    super.initState();
  }

  _tabsContent() {
    if (_currentIndex == 0) {
      return Column(
        children: [
          Column(
              children:
                  // children: comminityActivity.isNotEmpty
                  comminityActivity
                      .map(
                        (e) => CommunityActivityCard(
                          communityData: widget.communityData,
                          communityId: widget.communityId,
                          activityName: e.title.toString(),
                          description: e.description.toString(),
                          location: e.location.toString(),
                        ),
                      )
                      .toList()
              //     : [
              //   const SchimmerCard(),
              //   const SchimmerCard(),
              //   const SchimmerCard(),
              // ],
              ),
        ],
      );
    } else if (_currentIndex == 1) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 0, right: 8.0, left: 8.0, bottom: 0.0),
            child: Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/images/man1.png"),
                      ),
                      15.horizontalSpace,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Joseph David Koroma',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  letterSpacing: 0,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  color: kGreyColor)),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 5),
                            decoration: BoxDecoration(
                                color: kIconBcgColor,
                                borderRadius: BorderRadius.circular(0)),
                            child: Expanded(
                              child: Text(
                                'itdoc99',
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    overflow: TextOverflow.ellipsis,
                                    color: kPrimaryColor,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.bold),
                              ),
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
        ],
      );
    }
  }

  List<CommunityActivity> comminityActivity = [];
  Future getAllCommunitiesActivity() async {
    try {
      var response = await http.get(Uri.parse(
          "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/donorgroups/${widget.communityId}/activities"));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<CommunityActivity> data =
            jsonData.map((e) => CommunityActivity.fromJson(e)).toList();

        setState(() {
          comminityActivity = data;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: kWhiteColor,
          ),
        ),
        elevation: 0,
        title: Text('Communities on LifeBlood',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(fontSize: 14, color: Colors.white)),
      ),
      backgroundColor: const Color(0xFFe0e9e4),
      floatingActionButton: IntrinsicWidth(
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.teal,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Row(children: [
            const FaIcon(
              FontAwesomeIcons.plus,
              size: 15,
            ),
            SizedBox(
              width: 5.h,
            ),
            Text('Create Activity',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontSize: 11.sp, color: Colors.white)),
          ]),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          // padding: EdgeInsets.symmetric(horizontal: 10),
          color: Color(0xFFe0e9e4),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.communityName,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    letterSpacing: 0,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: kGreyColor)),
                            5.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 5),
                                    decoration: BoxDecoration(
                                        color: kIconBcgColor,
                                        borderRadius: BorderRadius.circular(0)),
                                    child: Expanded(
                                      child: Text(
                                        'Blood Donation Community',
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            overflow: TextOverflow.ellipsis,
                                            color: kPrimaryColor,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                    flex: 1,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius:
                                              BorderRadius.circular(0)),
                                      child: Expanded(
                                        child: Text(
                                          '10 ' + 'members',
                                          style: TextStyle(
                                              fontSize: 10.sp,
                                              color: kBlackColor,
                                              overflow: TextOverflow.ellipsis,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                            5.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 5),
                                          decoration: BoxDecoration(
                                              color: kIconBcgColor,
                                              borderRadius:
                                                  BorderRadius.circular(0)),
                                          child: Expanded(
                                            child: Text(
                                              widget.location,
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: kPrimaryColor,
                                                  letterSpacing: 0,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                      5.horizontalSpace,
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 5),
                                        decoration: BoxDecoration(
                                            color: kIconBcgColor,
                                            borderRadius:
                                                BorderRadius.circular(0)),
                                        child: Expanded(
                                          child: Text(
                                            'Lumley',
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: kPrimaryColor,
                                                overflow: TextOverflow.ellipsis,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 5),
                                    decoration: BoxDecoration(
                                        color: kWhiteColor,
                                        border: Border.all(
                                            color: Colors.teal, width: 0.2),
                                        borderRadius: BorderRadius.circular(0)),
                                    child: Text(
                                      'Joined',
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: kPrimaryColor,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            10.verticalSpace,
                            Row(
                              children: [
                                Expanded(
                                  child: Text(widget.description,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          letterSpacing: 0,
                                          overflow: TextOverflow.clip,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.normal,
                                          color: kBlackColor)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    indicatorColor: kPrimaryColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: kPrimaryColor,
                    labelStyle: GoogleFonts.montserrat(
                        color: Colors.white, fontSize: 13.sp),
                    unselectedLabelColor: Colors.grey,
                    controller: tabController,
                    tabs: tabs
                        .map((e) => Tab(
                                child: Text(
                              e,
                              style: TextStyle(fontSize: 11.sp),
                            )))
                        .toList(),
                  ),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              5.verticalSpace,
              _tabsContent(),
            ],
          ),
        ),
      ),
    );
  }
}

class SchimmerCard extends StatelessWidget {
  const SchimmerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.r),
      width: double.infinity,
      height: 160.0,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.white38,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}

class CommunityActivityCard extends StatelessWidget {
  CommunityActivityCard({
    super.key,
    required this.activityName,
    required this.location,
    required this.description,
    required this.communityId,
    required this.communityData,
  });
  String activityName;
  String location;
  String description;
  String communityId;
  CommunityModel communityData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 0, right: 8.0, left: 8.0, bottom: 0.0),
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activityName,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        letterSpacing: 0,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: kGreyColor)),
                5.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 5),
                            decoration: BoxDecoration(
                                color: kIconBcgColor,
                                borderRadius: BorderRadius.circular(0)),
                            child: Text(
                              location,
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: kPrimaryColor,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          5.horizontalSpace,
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                        decoration: BoxDecoration(
                            color: kIconBcgColor,
                            borderRadius: BorderRadius.circular(0)),
                        child: Text(
                          'Ongoing',
                          style: TextStyle(
                              fontSize: 10.sp,
                              color: kPrimaryColor,
                              letterSpacing: 0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
                10.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: Text(description,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              letterSpacing: 0,
                              overflow: TextOverflow.clip,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.normal,
                              color: kBlackColor)),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
          ],
        ),
      ),
    );
  }
}
