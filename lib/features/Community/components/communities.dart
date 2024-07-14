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
import 'package:lifebloodworld/features/Community/components/body.dart';
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
    this.userId,
  }) : super(key: key);

  final String? title;
  final String? userId;

  @override
  //text editing controller for text field
  _CommunitiesState createState() => _CommunitiesState();
}

class _CommunitiesState extends State<Communities>
    with SingleTickerProviderStateMixin {
  // Convert AppCountry to Country

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

  List<CommunityModel> communities = [];
  bool isCommunityLoading = true;

  Future getAllCommunities() async {
    try {
      var response = await http.get(Uri.parse(
          "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/donorgroups"));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<CommunityModel> data =
            jsonData.map((e) => CommunityModel.fromJson(e)).toList();
        if (mounted) {
          setState(() {
            communities = data;
            isCommunityLoading = false;
          });
        }
      }
    } catch (e) {
      isCommunityLoading = false;
    }
  }

  Future<List<String>> getUserMembershipsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('userMemberships') ?? [];
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
    super.initState();

    getPref(); //set the initial value of text field
    getAllCommunities();
    getAllActivities();
    _dateinput.text = "";
    tabs = ['Activities', 'Communities'];
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(_handleTabControllerTick);

  }

  _tabsContent() {
    if (_currentIndex == 0) {
      return Expanded(
        child: isCommunityLoading
            ? ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ShimmerContainer();
                },
              )
            : communityActivity.isNotEmpty
                ? ListView.builder(
                    itemCount: communityActivity.length,
                    itemBuilder: (context, index) {
                      var e = communityActivity[index];
                      return CommunityActivityCardd(
                        title: e.title.toString(),
                        location: e.location.toString(),
                        activityDate: e.activityDate.toString(),
                        description: e.description.toString(),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'No Community Activities',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        letterSpacing: 0,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
      );
    } else if (_currentIndex == 1) {
      return Expanded(
        child: isCommunityLoading
            ? ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ShimmerContainer();
                },
              )
            : FutureBuilder<List<String>>(
                future: getUserMembershipsFromPrefs(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text(
                            'Error loading memberships ${snapshot.error}'));
                  } else if (!snapshot.hasData || communities.isEmpty) {
                    return const Center(
                        child: Text('No communities available'));
                  } else {
                    final memberships = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: communities.length,
                      itemBuilder: (context, index) {
                        var community = communities[index];
                        bool isMember =
                            memberships.contains(community.id.toString());

                        return CommunityCard(
                          context: context,
                          communityName: community.name.toString(),
                          location: community.location.toString(),
                          description: community.description.toString(),
                          communityId: community.id.toString(),
                          data: community,
                          userId: widget.userId.toString(),
                          place: community.place.toString(),
                          category: community.category.toString(),
                          isMember: isMember,
                        );
                      },
                    );
                  }
                },
              ),
      );
    }
  }

  Widget builddonationSearch() => SearchWidget(
        text: donationquery,
        hintText: 'Search..',
        onChanged: (val) {},
      );

  List<CommunityActivity> communityActivity = [];
  Future getAllActivities() async {
    String url =
        "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/donorgroups/activities/${widget.userId}";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<CommunityActivity> data =
            jsonData.map((e) => CommunityActivity.fromJson(e)).toList();

        if (mounted) {
          setState(() {
            communityActivity = data;
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    _dateinput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePageScreen(
                          pageIndex: 2,
                        )),
                (route) => false);
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
                ),
              ),
            );
          },
          child: Row(children: [
            const FaIcon(
              FontAwesomeIcons.plus,
              size: 15,
            ),
            SizedBox(
              width: 5.h,
            ),
            Text(
              'Create Community',
              textAlign: TextAlign.center,
              style:
                  GoogleFonts.montserrat(fontSize: 11.sp, color: Colors.white),
            ),
          ]),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10),
          color: const Color(0xFFe0e9e4),
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
    required this.place,
    required this.description,
    required this.communityId,
    required this.data,
    required this.userId,
    required this.category,
    this.isMember,
    // required this.communityMembership,
  });
  String communityName;
  // CommunityMembership communityMembership;
  String userId;
  String location;
  String place;
  String description;
  String communityId;
  String category;
  CommunityModel data;
  bool? isMember = false;
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
    // getJoinedStatus();
    super.initState();
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
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
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
                        widget.category,
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
                                  widget.place,
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
                            child: joined || widget.isMember!
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

class ShimmerContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
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

class CommunityActivityCardd extends StatelessWidget {
  final String title;
  final String location;
  final String activityDate;
  final String description;

  const CommunityActivityCardd({
    Key? key,
    required this.title,
    required this.location,
    required this.activityDate,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 0,
        right: 8.0,
        left: 8.0,
        bottom: 0.0,
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.r),
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Montserrat',
                letterSpacing: 0,
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: kGreyColor,
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
                        padding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: kIconBcgColor,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Text(
                          location,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      5.horizontalSpace,
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: kIconBcgColor,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Text(
                          'Ongoing',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: kPrimaryColor,
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        activityDate,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.normal,
                          color: kBlackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            10.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: Text(
                    description,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      letterSpacing: 0,
                      overflow: TextOverflow.clip,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.normal,
                      color: kBlackColor,
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
