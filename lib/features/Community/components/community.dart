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
import 'package:lifebloodworld/widgets/custom_textfield.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl_phone_field/countries.dart';

import '../../../constants/colors.dart';

DateTime now = DateTime.now();
String formattedNewDate = DateFormat('d MMM yyyy').format(now);
String formattedNewMonth = DateFormat('LLLL').format(now);
String formattedNewYear = DateFormat('y').format(now);

class AppCountry {
  final String name;
  final Map<String, String> nameTranslations;
  final String flag;
  final String code;
  final String dialCode;
  final String regionCode;
  final int minLength;
  final int maxLength;

  const AppCountry({
    required this.name,
    required this.flag,
    required this.code,
    required this.dialCode,
    required this.nameTranslations,
    required this.minLength,
    required this.maxLength,
    this.regionCode = "",
  });
}

Country convertToCountry(AppCountry appCountry) {
  return Country(
    name: appCountry.name,
    flag: appCountry.flag,
    code: appCountry.code,
    dialCode: appCountry.dialCode,
    nameTranslations: appCountry.nameTranslations,
    minLength: appCountry.minLength,
    maxLength: appCountry.maxLength,
    regionCode: appCountry.regionCode,
  );
}


class Community extends StatefulWidget {
  Community({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String? title;

  @override
  //text editing controller for text field
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> with TickerProviderStateMixin {
  // Convert AppCountry to Country

  final _formKey = GlobalKey<FormBuilderState>();
  String? selectedGender = '';
  String? selectedDistrict = '';
  String? selectedBloodType = '';
  String? selectedRh = '';
  String? selectedPhenotypeRh = '';
  String? selectedKell = '';
  String? selectedHealthStatus = '';
  String? selectedLastEatTime = '';
  String? selectedHBVVaccination = '';
  String? selectedDonorType = '';
  String? selectedInofkin = '';
  String? selectedConsent = '';
  String? selectedMaritalStatus = '';
  String? selectedID = '';

  final TextEditingController _agecategoryinput = TextEditingController();
  final TextEditingController _phone2Ctrl = TextEditingController();
  final TextEditingController monthinput =
      TextEditingController(text: formattedNewMonth.toString());
  final TextEditingController donatedateinput =
      TextEditingController(text: formattedNewDate.toString());
final TextEditingController dateinput =
      TextEditingController(text: formattedNewDate.toString());  final TextEditingController yearinput =
      TextEditingController(text: formattedNewYear.toString());
  final TextEditingController _addressCtrl = TextEditingController();
  final TextEditingController _townCtrl = TextEditingController();
  final TextEditingController _occupationCtrl = TextEditingController();
  final TextEditingController _nextofkinCtrl = TextEditingController();
  final TextEditingController _nextofkinphoneCtrl = TextEditingController();
  final TextEditingController _idnumberCtrl = TextEditingController();
  final TextEditingController _HBVwhendateinput = TextEditingController();
  final TextEditingController _dateinput = TextEditingController();
  final TextEditingController refCodeCtrl = TextEditingController(
    text: randomAlphaNumeric(6).toString(),
  );
  final TextEditingController timeinput = TextEditingController();

  // Your list of AppCountry instances

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

  getPref() async {
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

  String? selectedMiddleName = '';

  String query = '';
  List facilityList = [];
  List timeslotList = [];

  final List<String> genderItems = ['Male', 'Female'];

  final List<String> maritalstatusItems = [
    'Single',
    'Married',
    'Divorced',
    'Separated',
    'Widowed'
  ];

  final List<String> idItems = [
    'Passport',
    'Voters ID',
    'Driving License',
    'National ID',
    'Not Available'
  ];

  dynamic facility;
  dynamic timeslot;

  final List<String> facilityItems = [
    '34 Military Hospital',
    'Cottage/PCMH',
    'Connaught',
    'Rokupa',
  ];

  final List<String> timeslotItems = [
    '9:00 am - 9:30 am',
    '9:30 am - 10:00 am',
    '10:00 am - 10:30 am',
    '10:30 am - 11:00 am',
    '11:00 am - 11:30 am',
    '11:30 am - 12:00',
    '12:00 am - 12:30 am',
    '12:30 pm - 1:00 pm',
    '1:00 pm - 1:30 pm',
    '1:30 pm - 2:00 pm',
    '2:00 pm - 2:30 pm',
    '2:30 pm - 3:00 pm',
    '3:00 pm - 3:30 pm',
    '3:30 pm - 4:00 pm',
    '4:00 pm - 4:30 pm',
    '4:30 pm - 5:00 pm',
    '5:00 pm - 5:30 pm',
    '5:30 pm - 6:00 pm'
  ];

  String? selectedFacility = '';
  String? selectedTimeslot = '';

  Future findfacility() async {
    var response = await http
        .get(Uri.parse("https://community.lifebloodsl.com/findfacility.php"));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        facilityList = jsonData;
      });
    }
    print(facilityList);
  }

  Future findtimeslots() async {
    var response = await http
        .get(Uri.parse("https://community.lifebloodsl.com/findtimeslots.php"));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        timeslotList = jsonData;
      });
    }
    print(timeslotList);
  }

  String bloodtestfor = 'Family';
  bool _scheduling = false;
  final List<String> bloodgrouplist = [
    'Not Known',
    'A+',
    'A-',
    'AB+',
    'AB-',
    'B+',
    'B-',
    'O+',
    'O-'
  ];

  Future register() async {
    await Future.delayed(Duration(seconds: 2));
    var response = await http.post(
        Uri.parse(
            "https://community.lifebloodsl.com/blooddonationnewschedule.php"),
        body: {
          "DonorType": 'Voluntary',
          "surname": ulname,
          "middlename": umname,
          "firstname": ufname,
          "agecategory": agecategory,
          "gender": gender,
          "address": address,
          "district": district,
          "phonenumber": phonenumber,
          "maritalstatus": selectedMaritalStatus,
          "occupation": _occupationCtrl.text,
          "email": email,
          "nextofkin": _nextofkinCtrl.text,
          "informednextofkin": selectedInofkin,
          "nextofkinphonenumber": _nextofkinphoneCtrl.text,
          "personalID": selectedID,
          "IDnumber": _idnumberCtrl.text,
          "bloodgroup": bloodtype,
          "HBVvaccination": selectedHBVVaccination,
          "HBVwhendateinput": _HBVwhendateinput.text,
          "facility": selectedFacility,
          "date": dateinput.text,
          "month": monthinput.text,
          "year": yearinput.text,
          "timeslot": selectedTimeslot,
          "refcode": refCodeCtrl.text
        });
    var data = json.decode(response.body);
    if (data == "Error") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Please Try Again, Schedule Already Exists, Try Tracking Schedule',
            style: GoogleFonts.montserrat()),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 4),
      ));
      await Future.delayed(Duration(seconds: 2));
      // scheduleAlarm()
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePageScreen(pageIndex: 2),
        ),
      );
    } else {
      showModalBottomSheet(
          backgroundColor: Colors.teal,
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
                    children: [
                      Text(
                          'Schedule Successful, You will be contacted shortly !!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontSize: 11.sp, color: Colors.white)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 12.sp,
                                color: Colors.white,
                                height: 1.3846153846153846,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      'Your reference code to track Schedule is ',
                                ),
                                TextSpan(
                                  text: refCodeCtrl.text,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.copy,
                                        size: 13, color: Colors.teal),
                                    SizedBox(
                                      width: 5.h,
                                    ),
                                    Text('Copy Code',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 13.sp,
                                            color: Colors.teal)),
                                  ],
                                ),
                              ),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.teal,
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ),
                              onPressed: () async {
                                await Clipboard.setData(
                                    ClipboardData(text: refCodeCtrl.text));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  duration: Duration(seconds: 5),
                                  content: Text('Copied to clipboard',
                                      style: GoogleFonts.montserrat()),
                                ));
                                // scheduleAlarm()
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HomePageScreen(pageIndex: 2),
                                  ),
                                );
                                Navigator.pop(context);
                              }),
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

  String calculateAge() {
    if (selectedYear != null && selectedMonth != null && selectedDay != null) {
      DateTime selectedDate =
          DateTime(selectedYear!, selectedMonth!, selectedDay!);
      DateTime currentDate = DateTime.now();
      Duration difference = currentDate.difference(selectedDate);
      int age = (difference.inDays / 365).floor();
      setState(() {
        selectedAge = age.toString();
      });
      if (age < 18) {
        setState(() {
          selectedAgeCategory = "Teenager";
        });
      } else if (age >= 18 && age <= 24) {
        setState(() {
          selectedAgeCategory = "Young Adult";
        });
      } else if (age >= 25 && age <= 44) {
        setState(() {
          selectedAgeCategory = "Adult";
        });
      } else if (age >= 45 && age <= 64) {
        setState(() {
          selectedAgeCategory = "Middle Age";
        });
      } else {
        setState(() {
          selectedAgeCategory = "Old Age";
        });
      }
      return '$age years';
    }
    return '';
  }

  // void scheduleAlarm() async{
  //   var tz;
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       'LifeBlood',
  //       'Thank You For Registering, You Have Saved A Life',
  //       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
  //       const NotificationDetails(
  //         android: AndroidNotificationDetails(
  //           'alarm_notify',
  //           'alarm_notify',
  //           channelDescription: 'Channel For Registeration',
  //           icon: 'lifeblood',
  //           sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
  //           largeIcon: DrawableResourceAndroidBitmap('lifeblood'),),
  //         iOS: IOSNotificationDetails(
  //             sound: 'a_long_cold_sting.wav',
  //             presentAlert: true,
  //             presentBadge: true,
  //             presentSound: true),),
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //       UILocalNotificationDateInterpretation.absoluteTime);
  // }

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
    tabs = ['Activities', 'Members'];
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(_handleTabControllerTick);
    getPref(); //set the initial value of text field
    super.initState();
  }


 _tabsContent() {
    if (_currentIndex == 0) {
      return Column(
        children: [
          Padding(
                                  padding: const EdgeInsets.only(top:0, right:8.0, left:8.0, bottom: 0.0),
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
                                                          borderRadius:
                                                              BorderRadius.circular(0)),
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
                                                          borderRadius:
                                                              BorderRadius.circular(0)),
                                                      child: Text(
                                                        'Ongoing',
                                                        style: TextStyle(
                                                            fontSize: 10.sp,
                                                            color: kPrimaryColor,
                                                            letterSpacing: 0,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),)
                                              
                                            ],
                                          ),
                                          10.verticalSpace,
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text('There is a meeting on the 1 Jun 2024, at 7 Malama Thomas Street',
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
       
        Padding(
                        padding: const EdgeInsets.only(top:0, right:8.0, left:8.0, bottom: 0.0),
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
                                                borderRadius:
                                                    BorderRadius.circular(0)),
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
                                          ),),
                                                    ],
                                                  ),
                                          
                                ],
                              ),
                              
                              // Column(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //      Text('LifeLine Donors',
                              //         textAlign: TextAlign.left,
                              //         style: TextStyle(
                              //             fontFamily: 'Montserrat',
                              //             letterSpacing: 0,
                              //             fontSize: 13.sp,
                              //             fontWeight: FontWeight.bold,
                              //             color: kGreyColor)),
                              //            5.verticalSpace,
                              //            Container(
                              //               padding: EdgeInsets.symmetric(
                              //                   vertical: 0, horizontal: 5),
                              //               decoration: BoxDecoration(
                              //                   color: kIconBcgColor,
                              //                   borderRadius:
                              //                       BorderRadius.circular(0)),
                              //               child: Expanded(
                              //         child: Text(
                              //                 'Blood Donation Community',
                              //                 style: TextStyle(
                              //                     fontSize: 10.sp,
                              //                     overflow: TextOverflow.ellipsis,
                              //                     color: kPrimaryColor,
                              //                     letterSpacing: 0,
                              //                     fontWeight: FontWeight.bold),
                              //               ),
                              //             ),),
                              //             5.verticalSpace,
                              //   Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Flexible(
                              //         flex: 3,
                              //         child: Row(
                              //           children: [
                              //             Container(
                              //               padding: EdgeInsets.symmetric(
                              //                   vertical: 0, horizontal: 5),
                              //               decoration: BoxDecoration(
                              //                   color: kIconBcgColor,
                              //                   borderRadius:
                              //                       BorderRadius.circular(0)),
                              //               child: Expanded(
                              //         child: Text(
                              //                 'Western Area Urban',
                              //                 style: TextStyle(
                              //                     fontSize: 10.sp,
                              //                     color: kPrimaryColor,
                              //                     letterSpacing: 0,
                              //                     overflow: TextOverflow.ellipsis,
                              //                     fontWeight: FontWeight.bold),
                              //               ),)
                              //             ),
                              //             5.horizontalSpace,
                              //             Container(
                              //               padding: EdgeInsets.symmetric(
                              //                   vertical: 0, horizontal: 5),
                              //               decoration: BoxDecoration(
                              //                   color: kIconBcgColor,
                              //                   borderRadius:
                              //                       BorderRadius.circular(0)),
                              //               child:  Expanded(
                              //         child: Text(
                              //                 'Lumley',
                              //                 style: TextStyle(
                              //                     fontSize: 10.sp,
                              //                     color: kPrimaryColor,
                              //                     overflow: TextOverflow.ellipsis,
                              //                     letterSpacing: 0,
                              //                     fontWeight: FontWeight.bold),
                              //               ),
                              //             ),
                              //             )
                              //           ],
                              //         ),
                              //       ),
                              //       Flexible(
                              //         flex: 1,
                              //         child: Container(
                              //               padding: EdgeInsets.symmetric(
                              //                   vertical: 0, horizontal: 5),
                              //               decoration: BoxDecoration(
                              //                   color: kWhiteColor,
                              //                   border: Border.all(color: Colors.teal, width: 0.2),
                              //                   borderRadius:
                              //                       BorderRadius.circular(0)),
                              //               child: Text(
                              //                 'Joined',
                              //                 style: TextStyle(
                              //                     fontSize: 10.sp,
                              //                     color: kPrimaryColor,
                              //                     letterSpacing: 0,
                              //                     fontWeight: FontWeight.bold),
                              //               ),
                              //             ),)
                                    
                              //     ],
                              //   ),
                              //   10.verticalSpace,
                              //   Row(
                              //     children: [
                              //       Expanded(
                              //         child: Text('There is a meeting on the 1 Jun 2024, at 7 Malama Thomas Street',
                              //               textAlign: TextAlign.left,
                              //               style: TextStyle(
                              //                   fontFamily: 'Montserrat',
                              //                   letterSpacing: 0,
                              //                   overflow: TextOverflow.clip,
                              //                   fontSize: 11.sp,
                              //                   fontWeight: FontWeight.normal,
                              //                   color: kBlackColor)),
                              //       ),
                              //     ],
                              //   ),
                                  
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 2.h,
                              // ),
                            ],
                          ),
                        ),
                      ),
              
          
          // (bgdataready == "Yes")
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
          //                     text: 'Blood Group For: ',
          //                     style: TextStyle(
          //                       fontFamily: 'Montserrat',
          //                       letterSpacing: 0,
          //                       fontSize: 12,
          //                       fontWeight: FontWeight.normal,
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                   TextSpan(
          //                     text: '$bgbloodtestfor',
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
          //                   fontSize: 15,
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
          //                     text: '$bgfacility',
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
          //                   fontSize: 15,
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
          //                     text: "$bgtimeslot",
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
          //                     text: "$bgstatus",
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
          //           ])
          //     : Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Column(
          //             children: [
          //               Row(
          //                 children: [
          //                   Text(
          //                     'No Blood Group Test Schedule',
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
        final regionLower = donationschedule.region.toLowerCase();
        final facilitynameLower = donationschedule.facilityname.toLowerCase();
        final servicetypeLower = donationschedule.facilityname.toLowerCase();
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
   return 
  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => HomePageScreen(pageIndex: 0),
              ),
            );
          },
          icon: FaIcon(
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
                        FaIcon(FontAwesomeIcons.plus, size: 15,),
                        SizedBox(
                          width: 5.h,
                        ),
                        Text('Create Activity',
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
                                builder: (context) => CreateActivity(
                                  title: '',
                                )));
                      },
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
                                         child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 0, horizontal: 5),
                                            decoration: BoxDecoration(
                                                color: kIconBcgColor,
                                                borderRadius:
                                                    BorderRadius.circular(0)),
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
                                          ),),
                                       ),
                                       Flexible(
                                        flex:1,
                                        child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius:
                                              BorderRadius.circular(0)),
                                      child:  Expanded(
                                child: Text(
                                        '10 '+'members',
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
                                        'Western Area Urban',
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            color: kPrimaryColor,
                                            letterSpacing: 0,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold),
                                      ),)
                                    ),
                                    5.horizontalSpace,
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 5),
                                      decoration: BoxDecoration(
                                          color: kIconBcgColor,
                                          borderRadius:
                                              BorderRadius.circular(0)),
                                      child:  Expanded(
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
                                          border: Border.all(color: Colors.teal, width: 0.2),
                                          borderRadius:
                                              BorderRadius.circular(0)),
                                      child: Text(
                                        'Joined',
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            color: kPrimaryColor,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),)
                              
                            ],
                          ),
                          10.verticalSpace,
                          Row(
                            children: [
                              Expanded(
                                child: Text('There is a meeting on the 1 Jun 2024, at 7 Malama Thomas Street',
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
                                                            indicatorColor:
                                                                kPrimaryColor,
                                                                indicatorSize: TabBarIndicatorSize.tab,
                                                            labelColor:
                                                              kPrimaryColor,
                                                            labelStyle: GoogleFonts
                                                                .montserrat(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        13.sp),
                                                            unselectedLabelColor:
                                                                Colors.grey,
                                                            controller:
                                                                tabController,
                                                            tabs: tabs
                                                                .map((e) => Tab(
                                                                        child: Text(
                                                                      e,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              11.sp),
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

  Widget _buildTextField({
    String? labelText,
    FormFieldValidator<String>? validator,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        validator: validator,
        controller: controller,
      ),
    );
  }

  Widget _buildBloodTypeSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedBloodType;

    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context!).primaryColor : null,
          border: Border.all(
            width: 0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: RadioListTile(
          value: name,
          activeColor: Colors.white,
          groupValue: selectedBloodType,
          onChanged: (String? v) {
            setState(() {
              selectedBloodType = v;
            });
          },
          title: Text(
            name,
            style: TextStyle(
              color: isActive ? Colors.white : null,
              // fontSize: width * 0.035,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInformedNextOfKinSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedInofkin;

    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context!).primaryColor : null,
          border: Border.all(
            width: 0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: RadioListTile(
          value: name,
          activeColor: Colors.white,
          groupValue: selectedInofkin,
          onChanged: (String? v) {
            setState(() {
              selectedInofkin = v;
            });
          },
          title: Text(
            name,
            style: TextStyle(
              color: isActive ? Colors.white : null,
              // fontSize: width * 0.035,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRhTypeSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedRh;

    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context!).primaryColor : null,
          border: Border.all(
            width: 0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: RadioListTile(
          value: name,
          activeColor: Colors.white,
          groupValue: selectedRh,
          onChanged: (String? v) {
            setState(() {
              selectedRh = v;
            });
          },
          title: Text(
            name,
            style: TextStyle(
              color: isActive ? Colors.white : null,
              // fontSize: width * 0.035,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhenotypeRhTypeSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedPhenotypeRh;

    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context!).primaryColor : null,
          border: Border.all(
            width: 0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: RadioListTile(
          value: name,
          activeColor: Colors.white,
          groupValue: selectedPhenotypeRh,
          onChanged: (String? v) {
            setState(() {
              selectedPhenotypeRh = v;
            });
          },
          title: Text(
            name,
            style: TextStyle(
              color: isActive ? Colors.white : null,
              // fontSize: width * 0.035,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKellTypeSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedKell;

    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context!).primaryColor : null,
          border: Border.all(
            width: 0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: RadioListTile(
          value: name,
          activeColor: Colors.white,
          groupValue: selectedKell,
          onChanged: (String? v) {
            setState(() {
              selectedKell = v;
            });
          },
          title: Text(
            name,
            style: TextStyle(
              color: isActive ? Colors.white : null,
              // fontSize: width * 0.035,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHealthStatusTypeSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedHealthStatus;
    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context!).primaryColor : null,
          border: Border.all(
            width: 0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: RadioListTile(
          value: name,
          activeColor: Colors.white,
          groupValue: selectedHealthStatus,
          onChanged: (String? v) {
            setState(() {
              selectedHealthStatus = v;
            });
          },
          title: Text(
            name,
            style: TextStyle(
              color: isActive ? Colors.white : null,
              // fontSize: width * 0.035,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLastTimeEatenSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedLastEatTime;

    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context!).primaryColor : null,
          border: Border.all(
            width: 0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: RadioListTile(
          value: name,
          activeColor: Colors.white,
          groupValue: selectedLastEatTime,
          onChanged: (String? v) {
            setState(() {
              selectedLastEatTime = v;
            });
          },
          title: Text(
            name,
            style: TextStyle(
              color: isActive ? Colors.white : null,
              // fontSize: width * 0.035,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHBVVaccincationSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedHBVVaccination;

    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context!).primaryColor : null,
          border: Border.all(
            width: 0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: RadioListTile(
          value: name,
          activeColor: Colors.white,
          groupValue: selectedHBVVaccination,
          onChanged: (String? v) {
            setState(() {
              selectedHBVVaccination = v;
            });
          },
          title: Text(
            name,
            style: TextStyle(
              color: isActive ? Colors.white : null,
              // fontSize: width * 0.035,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConsentTypeSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedConsent;

    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context!).primaryColor : null,
          border: Border.all(
            width: 0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: RadioListTile(
          value: name,
          activeColor: Colors.white,
          groupValue: selectedConsent,
          onChanged: (String? v) {
            setState(() {
              selectedConsent = v;
            });
          },
          title: Text(
            name,
            style: TextStyle(
              color: isActive ? Colors.white : null,
              // fontSize: width * 0.035,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedGender;

    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context!).primaryColor : null,
          border: Border.all(
            width: 0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: RadioListTile(
          value: name,
          activeColor: Colors.white,
          groupValue: selectedGender,
          onChanged: (String? v) {
            setState(() {
              selectedGender = v;
            });
          },
          title: Text(
            name,
            style: TextStyle(
              color: isActive ? Colors.white : null,
              // fontSize: width * 0.035,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDonorTypeSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedDonorType;

    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context!).primaryColor : null,
          border: Border.all(
            width: 0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: RadioListTile(
          value: name,
          activeColor: Colors.white,
          groupValue: selectedDonorType,
          onChanged: (String? v) {
            setState(() {
              selectedDonorType = v;
            });
          },
          title: Text(
            name,
            style: TextStyle(
              color: isActive ? Colors.white : null,
              // fontSize: width * 0.035,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDistrictSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedDistrict;

    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context!).primaryColor : null,
          border: Border.all(
            width: 0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: RadioListTile(
          value: name,
          activeColor: Colors.white,
          groupValue: selectedDistrict,
          onChanged: (String? v) {
            setState(() {
              selectedDistrict = v;
            });
          },
          title: Text(
            name,
            style: TextStyle(
              color: isActive ? Colors.white : null,
              // fontSize: width * 0.035,
            ),
          ),
        ),
      ),
    );
  }
}
