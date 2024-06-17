import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lifebloodworld/features/Community/components/communities.dart';
import 'package:lifebloodworld/features/Community/components/wmerchandise.dart';
import 'package:lifebloodworld/features/FAQ/welcome_screen.dart';
import 'dart:async';
import 'dart:convert';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:lifebloodworld/models/blooddonationschedule.dart';
import 'package:lifebloodworld/models/bloodtestschedule.dart';
import 'package:lifebloodworld/features/Home/views/knowbloodtype.dart';
import 'package:lifebloodworld/features/Home/views/managebloodtestapp.dart';
import 'package:lifebloodworld/features/Home/views/schedulebloodtest.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../main.dart';
import '../../../constants/colors.dart';
import '../../../models/community_model.dart';

class DonationCarddata {
  DonationCarddata({required this.donortype, required this.date});

  factory DonationCarddata.fromJson(Map<String, dynamic> json) {
    return DonationCarddata(donortype: json['donor_type'], date: json['date']);
  }

  String date;
  String donortype;
}

DateTime now = DateTime.now();
String formattedNewDate = DateFormat('d MMM yyyy').format(now);
String formattedNextDonationDateFormat = DateFormat('yyyy-MM-dd').format(now);
String formattedNewMonth = DateFormat('LLLL').format(now);
String formattedNewYear = DateFormat('y').format(now);

class community extends StatefulWidget {
  community({Key? key}) : super(key: key);

  @override
  State<community> createState() => _communityState();
}

class _communityState extends State<community> with TickerProviderStateMixin {
  String? address;
  String? agecategory;
  String? bgbloodtestfor;
  String? bgdataready;
  String? bgdonationtype;
  String? bgfacility;
  String? bgstatus;
  String? bgtimeslot;
  String? bloodtype;
  String? community;
  String? communitydonor;
  String? dataready;
  final TextEditingController dateinput =
      TextEditingController(text: formattedNewDate.toString());

  String? district;
  String? donated;
  bool donatenow = false;
  String donationquery = '';
  String? donationtype;
  String? donorid;
  String? email;
  String? facility;
  String? gender;
  String? getbda;
  final TextEditingController monthinput =
      TextEditingController(text: formattedNewMonth.toString());

  String? newscalltoaction;
  String? newsdescription;
  String? newslink;
  String? newsready;
  String? newstitle;
  String? nextdonationdate;
  final TextEditingController nextdonationdateinput =
      TextEditingController(text: formattedNextDonationDateFormat.toString());

  String? nody;
  int pageIndex = 0;
  String? phonenumber;
  String? prevdonation;
  String? prevdonationamt;
  String? status;
  late TabController tabController;
  late List tabs;
  String? timeslot;
  String? totalbgresult;
  String? totaldonation;
  String? totaldonationrep;
  String? totaldonationvol;
  String? totaldonationvolcan;
  String? totaldonationvolcon;
  String? totaldonationvold;
  String? totaldonationvolp;
  String? totaldonationvolr;
  String? totalsch;
  String? totalschfamily;
  String? totalschfriend;
  String? totalschmyself;
  String? ufname;
  String? ulname;
  String? umname;
  final TextEditingController yearinput =
      TextEditingController(text: formattedNewYear.toString());

  int _currentIndex = 0;
  final TextEditingController _feedbackCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isloginLoading = false;
  StreamController _streamController = StreamController();
  bool _validate = false;

  final _stopWatchTimer = StopWatchTimer();
  bool _isRunning = false;
  late Timer _weeklyResetTimer;
  Duration _remainingTime = Duration.zero;
  String communityCheck = "No";

  @override
  void initState() {
    // getAllCommunities();
    getPref();
    super.initState();
    tz.initializeTimeZones();
    tabs = ['Activities', 'Communities'];
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(_handleTabControllerTick);
    communityCheckGet();
  }

  String? userId;
  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      // name = prefs.getString('name');
      // uname = prefs.getString('uname');
      // avartar = prefs.getString('avatar');
      agecategory = prefs.getString('agecategory');
      gender = prefs.getString('gender');
      phonenumber = prefs.getString('phonenumber');
      address = prefs.getString('address');
      district = prefs.getString('district');
      // countryId = prefs.getString('country_id');
      // country = prefs.getString('country');
      bloodtype = prefs.getString('bloodtype');
      prevdonation = prefs.getString('prevdonation');
      userId = prefs.getString('id');
    });
  }

  communityCheckGet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    communityCheck = prefs.getString('communityCheck')!;
  }

  List<CommunityModel> comminities = [];
  //   try {
  //     var response = await http.get(Uri.parse(
  //         "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/donorgroups"));
  //     if (response.statusCode == 200) {
  //       List<dynamic> jsonData = json.decode(response.body);
  //       List<CommunityModel> data =
  //           jsonData.map((e) => CommunityModel.fromJson(e)).toList();

  //       setState(() {
  //         comminities = data;
  //       });
  //   } 
  //   catch (e) {}
  //   }
  // }

  savenextdonationPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nextdonationdate', nextdonationdate!);
    prefs.setString('donorid', donorid!);
    prefs.setString('donated', donated!);
  }

  savetdPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('totaldonation', totaldonation!);
  }

  savenodyPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nody', nody!);
  }

  savenewsPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('newsready', newsready!);
    prefs.setString('newstitle', newstitle!);
    prefs.setString('newsdescription', newsdescription!);
    prefs.setString('newslink', newslink!);
    prefs.setString('newscalltoaction', newscalltoaction!);
  }

  Future<bool> getInternetUsingInternetConnectivity() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  void _handleTabControllerTick() {
    setState(() {
      _currentIndex = tabController.index;
    });
  }

  _tabsContent() {
    if (_currentIndex == 0) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 0, right: 8.0, left: 8.0, bottom: 0.0),
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
                      Text('LifeLine Donors',
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
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 5),
                                  decoration: BoxDecoration(
                                      color: kIconBcgColor,
                                      borderRadius: BorderRadius.circular(0)),
                                  child: Text(
                                    'Bo',
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        color: kPrimaryColor,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                5.horizontalSpace,
                                Text(dateinput.text,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        letterSpacing: 0,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.normal,
                                        color: kBlackColor)),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 5),
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
                            child: Text(
                                'There is a meeting on the 1 Jun 2024, at 7 Malama Thomas Street',
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
          ),

          // (dataready == "Yes")
          //     ? Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //             Text.rich(
          //               TextSpan(
          //                 style: TextStyle(
          //                   color: Color(0xFF205072),
          //                   fontSize: 15,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //                 children: [
          //                   TextSpan(
          //                     text: 'Donor Type: ',
          //                     style: TextStyle(
          //                       fontFamily: 'Montserrat',
          //                       letterSpacing: 0,
          //                       fontSize: 12,
          //                       fontWeight: FontWeight.normal,
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                   TextSpan(
          //                     text: "$donationtype",
          //                     style: TextStyle(
          //                       fontFamily: 'Montserrat',
          //                       letterSpacing: 0,
          //                       fontSize: 12,
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //               textHeightBehavior:
          //                   TextHeightBehavior(applyHeightToFirstAscent: false),
          //               textAlign: TextAlign.left,
          //             ),
          //             Text.rich(
          //               TextSpan(
          //                 style: TextStyle(
          //                   color: Color(0xFF205072),
          //                   fontSize: 12,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //                 children: [
          //                   TextSpan(
          //                     text: 'Facility: ',
          //                     style: TextStyle(
          //                       fontFamily: 'Montserrat',
          //                       letterSpacing: 0,
          //                       fontSize: 12,
          //                       fontWeight: FontWeight.normal,
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                   TextSpan(
          //                     text: "$facility",
          //                     style: TextStyle(
          //                       fontFamily: 'Montserrat',
          //                       letterSpacing: 0,
          //                       fontSize: 12,
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //               textHeightBehavior:
          //                   TextHeightBehavior(applyHeightToFirstAscent: false),
          //               textAlign: TextAlign.left,
          //             ),
          //             Text.rich(
          //               TextSpan(
          //                 style: TextStyle(
          //                   color: Color(0xFF205072),
          //                   fontSize: 12,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //                 children: [
          //                   TextSpan(
          //                     text: 'Time Slot: ',
          //                     style: TextStyle(
          //                       fontFamily: 'Montserrat',
          //                       letterSpacing: 0,
          //                       fontSize: 12,
          //                       fontWeight: FontWeight.normal,
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                   TextSpan(
          //                     text: "$timeslot",
          //                     style: TextStyle(
          //                       fontFamily: 'Montserrat',
          //                       letterSpacing: 0,
          //                       fontSize: 12,
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //               textHeightBehavior:
          //                   TextHeightBehavior(applyHeightToFirstAscent: false),
          //               textAlign: TextAlign.left,
          //             ),
          //             Text.rich(
          //               TextSpan(
          //                 style: TextStyle(
          //                   color: Color(0xFF205072),
          //                   fontSize: 12,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //                 children: [
          //                   TextSpan(
          //                     text: 'Status: ',
          //                     style: TextStyle(
          //                       fontFamily: 'Montserrat',
          //                       letterSpacing: 0,
          //                       fontSize: 12,
          //                       fontWeight: FontWeight.normal,
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                   TextSpan(
          //                     text: "$status",
          //                     style: TextStyle(
          //                       fontFamily: 'Montserrat',
          //                       letterSpacing: 0,
          //                       fontSize: 12,
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //               textHeightBehavior:
          //                   TextHeightBehavior(applyHeightToFirstAscent: false),
          //               textAlign: TextAlign.left,
          //             ),
          //             SizedBox(
          //               height: 5,
          //             )
          //           ])
          //     : Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Column(
          //             children: [
          //               Row(
          //                 children: [
          //                   Text(
          //                     'No Blood Donation Schedule',
          //                     style: TextStyle(
          //                         fontFamily: 'Montserrat',
          //                         color: Colors.white,
          //                         letterSpacing: 0,
          //                         fontWeight: FontWeight.normal,
          //                         fontSize: 11),
          //                   ),
          //                   IconButton(
          //                       onPressed: () {},
          //                       icon: Icon(
          //                         Icons.add_box_rounded,
          //                         color: Colors.white,
          //                       ))
          //                 ],
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
        ],
      );
    } else if (_currentIndex == 1) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: comminities
              .map((e) => CommunityCard(
                    context: context,
                    communityName: e.name.toString(),
                    location: e.location.toString(),
                    description: e.description.toString(),
                    communityId: e.id.toString(),
                    data: e,
                    userId: userId.toString(),
                    // communityMembership: ,
                  ))
              .toList(growable: false)
          // .toList()
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
            Column(
              children: [
                SizedBox(height: 15.h),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Community",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF205072)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                      child: Container(
                        // padding: EdgeInsets.all(10.r),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFebf5f5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Commmunity Updates',
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.sp,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TabBar(
                                  indicatorColor: kPrimaryColor,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  labelColor: kPrimaryColor,
                                  labelStyle: GoogleFonts.montserrat(
                                      color: Colors.white, fontSize: 12.sp),
                                  unselectedLabelColor: Colors.grey,
                                  controller: tabController,
                                  tabs: tabs
                                      .map((e) => Tab(
                                              child: Text(
                                            e,
                                            style: TextStyle(fontSize: 10.sp),
                                          )))
                                      .toList(),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                5.verticalSpace,
                                _tabsContent(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0,
                                      bottom: 2,
                                      left: 8.0,
                                      right: 8.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: SizedBox(
                                      height: 5.h,
                                      child: Divider(
                                        color: Colors.teal,
                                        thickness: 0.2,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0,
                                      bottom: 5.0,
                                      right: 8.0,
                                      left: 8.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: TextButton(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.feed_outlined,
                                            size: 15,
                                            color: kPrimaryColor,
                                          ),
                                          5.horizontalSpace,
                                          Text('Explore Communities',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 11,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.teal,
                                              )),
                                        ],
                                      ),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.teal.shade100,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Communities(
                                                title:
                                                    "Communities on LifeBlood"),
                                          ),
                                        );
                                        // _showRequestsDialog(context);
                                      },
                                    ),
                                  ),
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
            ]),
            10.verticalSpace,

            // GestureDetector(
            //   onTap: () async {
            //     if (await getInternetUsingInternetConnectivity()) {
            //       Navigator.push(
            //         context,
            //         new MaterialPageRoute(
            //           builder: (context) => wmerchandise(),
            //         ),
            //       );
            //     } else {
            //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //         content: Text(
            //             'You are offline, Kindly turn on Wifi or Mobile Data to continue',
            //             textAlign: TextAlign.center,
            //             style: TextStyle(
            //                 fontFamily: 'Montserrat',
            //                 letterSpacing: 0,
            //                 fontSize: 10)),
            //         backgroundColor: Color(0xFFE02020),
            //         behavior: SnackBarBehavior.fixed,
            //         duration: const Duration(seconds: 5),
            //         // duration: Duration(seconds: 3),
            //       ));
            //     }
            //   },
            //   child: Row(
            //     children: <Widget>[
            //       Expanded(
            //         child: SingleChildScrollView(
            //           child: Container(
            //             padding: EdgeInsets.only(
            //                 bottom: MediaQuery.of(context).viewInsets.bottom),
            //             child: Padding(
            //               padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            //               child: Padding(
            //                 padding: EdgeInsets.symmetric(horizontal: 5.w),
            //                 child: Column(
            //                   children: [
            //                     Container(
            //                       height: 200,
            //                       width: double.infinity,
            //                       decoration: BoxDecoration(
            //                         // border: Border.all(color: kLifeBloodRed),
            //                         borderRadius: BorderRadius.circular(16),
            //                       ),
            //                       child: Stack(
            //                         fit: StackFit.expand,
            //                         children: [
            //                           // Image
            //                           Positioned.fill(
            //                             child: ClipRRect(
            //                               borderRadius:
            //                                   BorderRadius.circular(16),
            //                               child: Image.asset(
            //                                 "assets/images/mer.jpg",
            //                                 fit: BoxFit.cover,
            //                               ),
            //                             ),
            //                           ),
            //                           // Gradient
            //                           Positioned.fill(
            //                             child: Container(
            //                               decoration: BoxDecoration(
            //                                 gradient: LinearGradient(
            //                                   begin: Alignment.topCenter,
            //                                   end: Alignment.bottomCenter,
            //                                   colors: [
            //                                     Colors.white.withOpacity(0.9),
            //                                     Colors.red.withOpacity(0.7),
            //                                   ],
            //                                   stops: [0.3, 0.9],
            //                                 ),
            //                                 borderRadius:
            //                                     BorderRadius.circular(16),
            //                               ),
            //                             ),
            //                           ),
            //                           Padding(
            //                             padding: const EdgeInsets.all(8.0),
            //                             child: Column(
            //                               mainAxisAlignment:
            //                                   MainAxisAlignment.start,
            //                               crossAxisAlignment:
            //                                   CrossAxisAlignment.start,
            //                               children: [
            //                                 10.verticalSpace,
            //                                 Expanded(
            //                                   child: Column(
            //                                     crossAxisAlignment:
            //                                         CrossAxisAlignment.start,
            //                                     children: [
            //                                       Text(
            //                                           'Explore LifeBlood\nMerchandise',
            //                                           textAlign: TextAlign.left,
            //                                           style: TextStyle(
            //                                               fontSize: 20,
            //                                               height: 1.2,
            //                                               letterSpacing: 0,
            //                                               overflow:
            //                                                   TextOverflow.clip,
            //                                               fontWeight:
            //                                                   FontWeight.bold,
            //                                               color:
            //                                                   kLifeBloodRed)),
            //                                       10.verticalSpace,
            //                                       IntrinsicWidth(
            //                                         child: SizedBox(
            //                                           height: 25,
            //                                           child: ElevatedButton(
            //                                             style: ElevatedButton
            //                                                 .styleFrom(
            //                                                     backgroundColor:
            //                                                         kWhiteColor,
            //                                                     elevation: 0,
            //                                                     side:
            //                                                         BorderSide(
            //                                                       color: Color(
            //                                                           0x19A2A1A8),
            //                                                       width: 1.0,
            //                                                     ),
            //                                                     padding: EdgeInsets
            //                                                         .symmetric(
            //                                                             horizontal:
            //                                                                 10,
            //                                                             vertical:
            //                                                                 0),
            //                                                     shape:
            //                                                         RoundedRectangleBorder(
            //                                                       borderRadius:
            //                                                           BorderRadius
            //                                                               .circular(
            //                                                                   10),
            //                                                     )),
            //                                             onPressed: () {},
            //                                             child: Text(
            //                                               'Buy One to gift a Blood Donor',
            //                                               style: TextStyle(
            //                                                 color:
            //                                                     kLifeBloodRed,
            //                                                 fontSize: 13,
            //                                                 fontFamily:
            //                                                     'Montserrat',
            //                                                 fontWeight:
            //                                                     FontWeight.w500,
            //                                                 letterSpacing:
            //                                                     -0.26,
            //                                               ),
            //                                             ),
            //                                           ),
            //                                         ),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                 ),
            //                                 Row(
            //                                   children: [
            //                                     IntrinsicWidth(
            //                                       child: SizedBox(
            //                                         child: ElevatedButton(
            //                                           style: ElevatedButton
            //                                               .styleFrom(
            //                                                   backgroundColor:
            //                                                       kWhiteColor,
            //                                                   elevation: 0,
            //                                                   side: BorderSide(
            //                                                     color: Color(
            //                                                         0x19A2A1A8),
            //                                                     width: 1.0,
            //                                                   ),
            //                                                   padding: EdgeInsets
            //                                                       .symmetric(
            //                                                           horizontal:
            //                                                               10,
            //                                                           vertical:
            //                                                               0),
            //                                                   shape:
            //                                                       RoundedRectangleBorder(
            //                                                     borderRadius:
            //                                                         BorderRadius
            //                                                             .circular(
            //                                                                 10),
            //                                                   )),
            //                                           onPressed: () {},
            //                                           child: Text(
            //                                             'T-Shirts',
            //                                             style: TextStyle(
            //                                               color: kLifeBloodRed,
            //                                               fontSize: 13,
            //                                               fontFamily:
            //                                                   'Montserrat',
            //                                               fontWeight:
            //                                                   FontWeight.w500,
            //                                               letterSpacing: -0.26,
            //                                             ),
            //                                           ),
            //                                         ),
            //                                       ),
            //                                     ),
            //                                     5.horizontalSpace,
            //                                     IntrinsicWidth(
            //                                       child: SizedBox(
            //                                         child: ElevatedButton(
            //                                           style: ElevatedButton
            //                                               .styleFrom(
            //                                                   backgroundColor:
            //                                                       kWhiteColor,
            //                                                   elevation: 0,
            //                                                   side: BorderSide(
            //                                                     color: Color(
            //                                                         0x19A2A1A8),
            //                                                     width: 1.0,
            //                                                   ),
            //                                                   padding: EdgeInsets
            //                                                       .symmetric(
            //                                                           horizontal:
            //                                                               10,
            //                                                           vertical:
            //                                                               0),
            //                                                   shape:
            //                                                       RoundedRectangleBorder(
            //                                                     borderRadius:
            //                                                         BorderRadius
            //                                                             .circular(
            //                                                                 10),
            //                                                   )),
            //                                           onPressed: () {},
            //                                           child: Text(
            //                                             'T-Shirts',
            //                                             style: TextStyle(
            //                                               color: kLifeBloodRed,
            //                                               fontSize: 13,
            //                                               fontFamily:
            //                                                   'Montserrat',
            //                                               fontWeight:
            //                                                   FontWeight.w500,
            //                                               letterSpacing: -0.26,
            //                                             ),
            //                                           ),
            //                                         ),
            //                                       ),
            //                                     ),
            //                                     5.horizontalSpace,
            //                                     IntrinsicWidth(
            //                                       child: SizedBox(
            //                                         child: ElevatedButton(
            //                                           style: ElevatedButton
            //                                               .styleFrom(
            //                                                   backgroundColor:
            //                                                       kWhiteColor,
            //                                                   elevation: 0,
            //                                                   side: BorderSide(
            //                                                     color: Color(
            //                                                         0x19A2A1A8),
            //                                                     width: 1.0,
            //                                                   ),
            //                                                   padding: EdgeInsets
            //                                                       .symmetric(
            //                                                           horizontal:
            //                                                               10,
            //                                                           vertical:
            //                                                               0),
            //                                                   shape:
            //                                                       RoundedRectangleBorder(
            //                                                     borderRadius:
            //                                                         BorderRadius
            //                                                             .circular(
            //                                                                 10),
            //                                                   )),
            //                                           onPressed: () {},
            //                                           child: Text(
            //                                             'Bags',
            //                                             style: TextStyle(
            //                                               color: kLifeBloodRed,
            //                                               fontSize: 13,
            //                                               fontFamily:
            //                                                   'Montserrat',
            //                                               fontWeight:
            //                                                   FontWeight.w500,
            //                                               letterSpacing: -0.26,
            //                                             ),
            //                                           ),
            //                                         ),
            //                                       ),
            //                                     ),
            //                                     5.horizontalSpace,
            //                                     IntrinsicWidth(
            //                                       child: SizedBox(
            //                                         child: ElevatedButton(
            //                                           style: ElevatedButton
            //                                               .styleFrom(
            //                                                   backgroundColor:
            //                                                       kWhiteColor,
            //                                                   elevation: 0,
            //                                                   side: BorderSide(
            //                                                     color: Color(
            //                                                         0x19A2A1A8),
            //                                                     width: 1.0,
            //                                                   ),
            //                                                   padding: EdgeInsets
            //                                                       .symmetric(
            //                                                           horizontal:
            //                                                               10,
            //                                                           vertical:
            //                                                               0),
            //                                                   shape:
            //                                                       RoundedRectangleBorder(
            //                                                     borderRadius:
            //                                                         BorderRadius
            //                                                             .circular(
            //                                                                 10),
            //                                                   )),
            //                                           onPressed: () {},
            //                                           child: Text(
            //                                             'Pens',
            //                                             style: TextStyle(
            //                                               color: kLifeBloodRed,
            //                                               fontSize: 13,
            //                                               fontFamily:
            //                                                   'Montserrat',
            //                                               fontWeight:
            //                                                   FontWeight.w500,
            //                                               letterSpacing: -0.26,
            //                                             ),
            //                                           ),
            //                                         ),
            //                                       ),
            //                                     ),
            //                                   ],
            //                                 ),
            //                                 5.horizontalSpace,
            //                               ],
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            communityCheck == "No"
                ? GestureDetector(
                    onTap: () async {
                      // if (await getInternetUsingInternetConnectivity()) {
                      // set prefs
                      communityCheck == "No"
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => wmerchandise(),
                              ),
                            )
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Communities(
                                    title: "Communities on LifeBlood"),
                              ),
                            );
                    },
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.w),
                                  child: Container(
                                    padding: EdgeInsets.all(15.r),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFebf5f5),
                                      // border: Border.all(color: kLifeBloodBlue),
                                      borderRadius: BorderRadius.circular(16),
                                      // color: Colors.green[200]
                                    ),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Image.asset(
                                            'assets/images/communities.png',
                                            width: 45,
                                            height: 45,
                                          ),
                                        ),
                                        20.horizontalSpace,
                                        Flexible(
                                          flex: 3,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                        'Explore Communities on LifeBlood',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                kLifeBloodBlue)),
                                                  ),
                                                ],
                                              ),
                                              2.verticalSpace,
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                        'Get connected with other donors',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            letterSpacing: 0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: kGreyColor)),
                                                  ),
                                                ],
                                              ),
                                            ],
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
                      ],
                    ),
                  )
                : Container(),
            Row(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Container(
                            padding: EdgeInsets.all(15.r),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFebf5f5),
                              // border: Border.all(color: kLifeBloodBlue),
                              borderRadius: BorderRadius.circular(16),
                              // color: Colors.green[200]
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Image.asset(
                                    'assets/images/benefits.png',
                                    width: 45,
                                    height: 45,
                                  ),
                                ),
                                20.horizontalSpace,
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                                'Support LifeBlood Operations',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    overflow: TextOverflow.clip,
                                                    fontWeight: FontWeight.bold,
                                                    color: kLifeBloodBlue)),
                                          ),
                                        ],
                                      ),
                                      2.verticalSpace,
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                                'Keep LifeBlood Operational',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    overflow: TextOverflow.clip,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: kGreyColor)),
                                          ),
                                        ],
                                      ),
                                    ],
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
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Container(
                            padding: EdgeInsets.all(15.r),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFebf5f5),
                              // border: Border.all(color: kLifeBloodBlue),
                              borderRadius: BorderRadius.circular(16),
                              // color: Colors.green[200]
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Image.asset(
                                    'assets/images/ambassador.png',
                                    width: 45,
                                    height: 45,
                                  ),
                                ),
                                20.horizontalSpace,
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                                'Act As liaison officer between LifeBlood & your University',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    overflow: TextOverflow.clip,
                                                    fontWeight: FontWeight.bold,
                                                    color: kLifeBloodBlue)),
                                          ),
                                        ],
                                      ),
                                      2.verticalSpace,
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                                'Become a University Ambassador',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    overflow: TextOverflow.clip,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: kGreyColor)),
                                          ),
                                        ],
                                      ),
                                    ],
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
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Container(
                            padding: EdgeInsets.all(15.r),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFebf5f5),
                              // border: Border.all(color: kLifeBloodBlue),
                              borderRadius: BorderRadius.circular(16),
                              // color: Colors.green[200]
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Image.asset(
                                    'assets/images/champion.png',
                                    width: 45,
                                    height: 45,
                                  ),
                                ),
                                20.horizontalSpace,
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                                'Raise awareness, educate, & mobilize your community.',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    overflow: TextOverflow.clip,
                                                    fontWeight: FontWeight.bold,
                                                    color: kLifeBloodBlue)),
                                          ),
                                        ],
                                      ),
                                      2.verticalSpace,
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                                'Become a Community Champion',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    overflow: TextOverflow.clip,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: kGreyColor)),
                                          ),
                                        ],
                                      ),
                                    ],
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
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Container(
                            padding: EdgeInsets.all(15.r),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFebf5f5),
                              // border: Border.all(color: kLifeBloodBlue),
                              borderRadius: BorderRadius.circular(16),
                              // color: Colors.green[200]
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Image.asset(
                                    'assets/images/school.png',
                                    width: 45,
                                    height: 45,
                                  ),
                                ),
                                20.horizontalSpace,
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                                'Engage students in the safe blood practices.',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    overflow: TextOverflow.clip,
                                                    fontWeight: FontWeight.bold,
                                                    color: kLifeBloodBlue)),
                                          ),
                                        ],
                                      ),
                                      2.verticalSpace,
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text('Register your School',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    overflow: TextOverflow.clip,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: kGreyColor)),
                                          ),
                                        ],
                                      ),
                                    ],
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
              ],
            ),
            5.verticalSpace,
          ],
        ),
      ),
    );
  }
}
