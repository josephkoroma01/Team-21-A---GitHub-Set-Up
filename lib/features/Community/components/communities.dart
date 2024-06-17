import 'dart:async';

import 'package:cool_stepper/cool_stepper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:lifebloodworld/features/Community/components/community.dart';
import 'package:lifebloodworld/features/Community/components/createcommunity.dart';
import 'package:lifebloodworld/features/Home/views/search.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:intl/intl.dart';
import 'package:lifebloodworld/features/Login/views/schedulebloodtest.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:lifebloodworld/main.dart';
import 'package:lifebloodworld/models/blooddonationschedule.dart';
import 'package:lifebloodworld/models/bloodtestingfacilities.dart';
import 'package:lifebloodworld/models/community_model.dart';
import 'package:lifebloodworld/models/communitymembership.dart';
import 'package:lifebloodworld/widgets/custom_textfield.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/colors.dart';
import '../../../models/community_activity_model.dart';

DateTime now = DateTime.now();
String formattedNewDate = DateFormat('d MMM yyyy').format(now);
String formattedNextDonationDateFormat = DateFormat('yyyy-MM-dd').format(now);
String formattedNewMonth = DateFormat('LLLL').format(now);
String formattedNewYear = DateFormat('y').format(now);

class Communities extends StatefulWidget {
  Communities({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String? title;

  @override
  //text editing controller for text field
  _CommunitiesState createState() => _CommunitiesState();
}

class _CommunitiesState extends State<Communities>
    with TickerProviderStateMixin {
  // Convert AppCountry to Country

  final _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController _agecategoryinput = TextEditingController();
  final TextEditingController _phone2Ctrl = TextEditingController();
  final TextEditingController monthinput =
      TextEditingController(text: formattedNewMonth.toString());
  final TextEditingController donatedateinput =
      TextEditingController(text: formattedNewDate.toString());
  final TextEditingController dateinput =
      TextEditingController(text: formattedNewDate.toString());

  final TextEditingController yearinput =
      TextEditingController(text: formattedNewYear.toString());

  final TextEditingController _dateinput = TextEditingController();
  final TextEditingController refCodeCtrl = TextEditingController(
    text: randomAlphaNumeric(6).toString(),
  );
  final TextEditingController timeinput = TextEditingController();

  // Your list of AppCountry instances

  String? email;
  String? agecategory;
  String? gender;
  String? phonenumber;
  String? address;
  String? district;
  String? bloodtype;
  String? prevdonation;

  String? uname;
  String? avartar;
  String? countryId;
  String? country;
  String? userId;
  String? name;

  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      name = prefs.getString('name');
      uname = prefs.getString('uname');
      avartar = prefs.getString('avatar');
      agecategory = prefs.getString('agecategory');
      gender = prefs.getString('gender');
      phonenumber = prefs.getString('phonenumber');
      address = prefs.getString('address');
      district = prefs.getString('district');
      countryId = prefs.getString('country_id');
      country = prefs.getString('country');
      bloodtype = prefs.getString('bloodtype');
      prevdonation = prefs.getString('prevdonation');
      userId = prefs.getString('id');
    });
  }

  List<CommunityModel> comminities = [];
  Future getAllCommunities() async {
    try {
      var response = await http.get(Uri.parse(
          "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/donorgroups"));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<CommunityModel> data =
            jsonData.map((e) => CommunityModel.fromJson(e)).toList();

        setState(() {
          comminities = data;
        });
      }
    } catch (e) {}
  }

  int? selectedYear;
  int? selectedDay;
  int? selectedMonth;
  String? selectedAgeCategory = '';
  String? selectedAge = '';
  String? userphonenumber;
  final TextEditingController dobdateinput =
      TextEditingController(text: formattedNewDate.toString());

  TextEditingController dateInput = TextEditingController();
  FocusNode focusNode = FocusNode();

  Timer? debouncer;
  String donationquery = '';
  List<BloodDonationSchAppdata> donationschedule = [];
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
    _dateinput.text = "";
    tabs = ['Activities', 'Communities'];
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(_handleTabControllerTick);
    getPref(); //set the initial value of text field
    getAllCommunities();

    super.initState();
  }

  List<CommunityActivity> comminityActivity = [];
  Future getAllCommunitiesActivity() async {
    try {
      var response = await http.get(Uri.parse(
          "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/donorgroups/activities"));
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

  // List<CommunityActivity> comminityActivity = [];

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
                      Text(
                        'LifeLine Donors',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            letterSpacing: 0,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: kGreyColor),
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
                                        borderRadius: BorderRadius.circular(0)),
                                    child: Expanded(
                                      child: Text(
                                        'Western Area Urban',
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            color: kPrimaryColor,
                                            letterSpacing: 0,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                5.horizontalSpace,
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 5),
                                  decoration: BoxDecoration(
                                      color: kIconBcgColor,
                                      borderRadius: BorderRadius.circular(0)),
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
                                ),
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
                      5.verticalSpace,
                      Text(dateinput.text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              letterSpacing: 0,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.normal,
                              color: kBlackColor)),
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
        children: [
          builddonationSearch(),

          Column(
            children: comminities.isNotEmpty
                ? comminities
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
                    .toList()
                : [
                    Container(
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
                    ),
                    Container(
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
                    ),
                    SizedBox(
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
                    )
                  ],
          ),
          // CommunityCard(context: context),
          // CommunityCard(context: context),
          // CommunityCard(context: context),
        ],
      );
    }
  }

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
        final regionLower = donationschedule.district!.toLowerCase();
        final facilitynameLower = donationschedule.name!.toLowerCase();
        final servicetypeLower = donationschedule.communityname!.toLowerCase();
        final searchLower = donationquery.toLowerCase();
        return regionLower.contains(searchLower) ||
            facilitynameLower.contains(searchLower) ||
            servicetypeLower.contains(searchLower);
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

  Widget builddonationSearch() => SearchWidget(
        text: donationquery,
        hintText: 'Search..',
        onChanged: searchBook,
      );

  Future searchBook(String donationquery) async => debounce(() async {
        final donationschedule = await getBloodFacilities(donationquery);

        if (!mounted) return;

        setState(() {
          this.donationquery = donationquery;
          this.donationschedule =
              donationschedule.cast<BloodDonationSchAppdata>();
        });
      });

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
      backgroundColor: Color(0xFFe0e9e4),
      floatingActionButton: IntrinsicWidth(
        child: TextButton(
          child: Row(children: [
            FaIcon(
              FontAwesomeIcons.plus,
              size: 15,
            ),
            SizedBox(
              width: 5.h,
            ),
            Text('Create Community',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontSize: 11.sp, color: Colors.white)),
          ]),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.teal,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          onPressed: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateCommunity(
                          title: '',
                        )));
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10),
          color: Color(0xFFe0e9e4),
          child: Column(
            children: [
              Column(
                children: [
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

class CommunityCard extends StatefulWidget {
  CommunityCard({
    super.key,
    required this.context,
    required this.communityName,
    required this.location,
    required this.description,
    required this.communityId,
    required this.data,
    required this.userId,
    // required this.communityMembership,
  });
  String communityName;
  // CommunityMembership communityMembership;
  String userId;
  String location;
  String description;
  String communityId;
  CommunityModel data;
  final BuildContext context;

  @override
  State<CommunityCard> createState() => _CommunityCardState();
}

class _CommunityCardState extends State<CommunityCard> {
  bool isLoading = false;
  bool joined = false;

  @override
  void initState() {
    // TODO: implement initState
    getJoinedStatus();
    super.initState();
  }

  List<CommunityMembership> userJoinedCommunities = [];
  Future getJoinedStatus() async {
    try {
      var response = await http.get(Uri.parse(
          "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/donorgroupmemberships/${widget.userId}"));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<CommunityMembership> data =
            jsonData.map((e) => CommunityMembership.fromJson(e)).toList();
        setState(() {
          userJoinedCommunities = data;
        });

        if (hasUserJoinedCommunity(
            widget.data, userJoinedCommunities, widget.userId)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${userJoinedCommunities.length}"),
            ),
          );
          setState(() {
            joined = true;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Something went wrong"),
          ));
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future joinCommunity(String communityId) async {
    var data = {
      'donor_group_id': communityId,
      'user_id': widget.userId,
    };
    try {
      var response = await http.post(
        Uri.parse(
            "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/donorgroupmemberships"),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 201) {
        setState(() {
          isLoading = false;
          joined = true;
        });
        ScaffoldMessenger.of(widget.context).showSnackBar(
          const SnackBar(
            content: Text("Joined"),
          ),
        );
      } else {
        ScaffoldMessenger.of(widget.context).showSnackBar(
          SnackBar(
            content: Text("${response.statusCode}"),
          ),
        );
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(widget.context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong. Please try again"),
        ),
      );
    }
  }

  bool hasUserJoinedCommunity(CommunityModel community,
      List<CommunityMembership> userJoinedCommunities, userId) {
    return userJoinedCommunities.any((joinedCommunity) =>
        joinedCommunity.donorGroupId == community.id &&
        joinedCommunity.userId == userId);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Community(
              communityId: widget.communityId,
              communityName: widget.communityName,
              description: widget.description,
              location: widget.location,
              communityData: widget.data,
            ),
          ),
        );
      },
      child: Padding(
        padding:
            const EdgeInsets.only(top: 0, right: 8.0, left: 8.0, bottom: 0.0),
        child: Container(
          margin: EdgeInsets.only(bottom: 10.r),
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
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
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
                                child: Expanded(
                                  child: Text(
                                    widget.location,
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        color: kPrimaryColor,
                                        letterSpacing: 0,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                            5.horizontalSpace,
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 5),
                              decoration: BoxDecoration(
                                  color: kIconBcgColor,
                                  borderRadius: BorderRadius.circular(0)),
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
                      // Flexible(
                      //   flex: 1,
                      //   child: Container(
                      //     padding:
                      //        const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                      //     decoration: BoxDecoration(
                      //         color: kWhiteColor,
                      //         border:
                      //             Border.all(color: Colors.teal, width: 0.2),
                      //         borderRadius: BorderRadius.circular(0)),
                      //     child: Text(
                      //       'Joined',
                      //       style: TextStyle(
                      //           fontSize: 10.sp,
                      //           color: kPrimaryColor,
                      //           letterSpacing: 0,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //   ),
                      // ),
                      Flexible(
                        flex: 2,
                        child: SizedBox(
                          height: 25,
                          child: OutlinedButton(
                            child: joined
                                ? Text(
                                    'Joined',
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        color: kPrimaryColor,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.bold),
                                  )
                                : isLoading
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        'Join',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0,
                                            // overflow: TextOverflow.clip,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.normal,
                                            color: kBlackColor),
                                      ),
                            onPressed: () {
                              setState(() {
                                isLoading = true;
                              });
                              joinCommunity(widget.communityId);
                            },
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
      ),
    );
  }
}
