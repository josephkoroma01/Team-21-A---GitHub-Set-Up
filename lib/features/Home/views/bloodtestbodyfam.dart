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
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lifebloodworld/constants/colors.dart';
import 'package:lifebloodworld/features/Home/views/schedulebloodtest.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class facilitydata {
  String rbtc;
  String rbtcid;
  String name;
  String communityname;
  String district;

  facilitydata(
      {required this.rbtc,
      required this.rbtcid,
      required this.name,
      required this.communityname,
      required this.district});

  factory facilitydata.fromJson(Map<String, dynamic> json) {
    return facilitydata(
        rbtc: json['rbtc'],
        rbtcid: json['rbtcid'].toString(),
        name: json['name'],
        communityname: json['communityname'],
        district: json['district']);
  }

  Map<String, dynamic> toJson() => {
        'rbtc': rbtc,
        'rbtcid': rbtcid,
        'name': name,
        'communityname': communityname
      };
}

DateTime now = DateTime.now();
String formattedNewDate = DateFormat('d LLLL yyyy').format(now);
String formattedNewMonth = DateFormat('LLLL').format(now);
String formattedNewYear = DateFormat('y').format(now);

class BloodTestPageFam extends StatefulWidget {
  BloodTestPageFam({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String? title;

  @override

  //text editing controller for text field

  _BloodTestPageFamState createState() => _BloodTestPageFamState();
}

class _BloodTestPageFamState extends State<BloodTestPageFam> {
  String? email;
  String? ufname;
  String? ulname;
  String? umname;
  String? age;
  String? gender;
  String? phonenumber;
  String? address;
  String? district;
  String? bloodtype;
  String? prevdonation;
  String? selectedMiddleName = '';

  String query = '';
  List facilityList = [];
  List timeslotList = [];

  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  final List<String> ageItems = [
    'Teenager',
    'Young Adult',
    'Adult',
    'Middle Age',
    'Old Age'
  ];

  final List<String> bloodItems = ['Friend', 'Family'];

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
  String? selectedAgeCategory = '';

  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      ufname = prefs.getString('ufname');
      umname = prefs.getString('umname');
      ulname = prefs.getString('ulname');
      age = prefs.getString('age');
      gender = prefs.getString('gender');
      phonenumber = prefs.getString('phonenumber');
      address = prefs.getString('address');
      district = prefs.getString('district');
      bloodtype = prefs.getString('bloodtype');
      prevdonation = prefs.getString('prevdonation');
    });
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController monthinput =
      TextEditingController(text: formattedNewMonth.toString());
  final TextEditingController yearinput =
      TextEditingController(text: formattedNewYear.toString());

  dynamic facility;
  dynamic timeslot;

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

  String dropdownValue = 'Select Facility';
  String bloodtestfor = 'Family';
  bool _scheduling = false;

  final TextEditingController dateinput = TextEditingController();
  final TextEditingController refCodeCtrl = TextEditingController(
    text: randomAlphaNumeric(8).toString(),
  );

  Future register() async {
    setState(() {
      _scheduling = false;
    });
    await Future.delayed(Duration(seconds: 0));
    var response = await http.post(
        Uri.parse("https://community.lifebloodsl.com/bloodtestschedule.php"),
        body: {
          "bloodtestfor": bloodtestfor,
          "schedulerfirstname": ufname,
          "firstname": _firstnameCtrl.text,
          "middlename": _middlenameCtrl.text,
          "lastname": _lastnameCtrl.text,
          "schedulerlastname": ulname,
          "agecategory": selectedAgeCategory,
          "gender": selectedGender,
          "phonenumber": '+232' + _phoneCtrl.text,
          "email": _emailCtrl.text,
          "schedulerphonenumber": phonenumber,
          "address": _addressCtrl.text,
          "facility": selectedFacility,
          "date": dateinput.text,
          "month": monthinput.text,
          "year": yearinput.text,
          "timeslot": selectedTimeslot,
          "refcode": refCodeCtrl.text,
        });
    var data = json.decode(response.body);
    if (data == "Error") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Schedule Already Exists, \nPlease Try Selecting A Different Date or Time Slot.',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat()),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 10),
      ));
      await Future.delayed(Duration(seconds: 1));
      // scheduleAlarm();
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
                      Column(
                        children: [
                          Text(
                              'Schedule Successful, You will be contacted shortly !!',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontSize: 11.sp, color: Colors.white)),
                        ],
                      ),
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
                                            fontSize: 14.sp,
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
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat()),
                                ));
                                // scheduleAlarm()
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => scheduletypebody(),
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

  @override
  void initState() {
    super.initState();
    dateinput.text = "";
    getPref();
  }

  String? selectedGender = '';
  String? selectedDistrict = '';
  String? selectedBloodType = '';
  String? selectedPrevDonation = '';

  final TextEditingController _firstnameCtrl = TextEditingController();
  final TextEditingController _middlenameCtrl = TextEditingController();
  final TextEditingController _lastnameCtrl = TextEditingController();
  final TextEditingController _ageCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();
  final TextEditingController timeinput = TextEditingController();

  FocusNode focusNode = FocusNode();

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

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: kPrimaryColor,
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => scheduletypebody(),
                    ),
                  );
                },
                icon: FaIcon(
                  FontAwesomeIcons.arrowLeft,
                  color: kWhiteColor,
                )),
            elevation: 0,
            title: Text(
              widget.title!,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Montserrat',
                  color: kWhiteColor),
            )),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              SizedBox(
                child: Container(
                  width: double.infinity,
                  color: Colors.teal[50],
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Family Blood Group Test \nAppointment Details',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.montserrat(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal)),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text('Let your relative become a Potential Donor',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.montserrat(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                        Container(
                          width: double.infinity,
                          child: SizedBox(
                            child: Divider(
                              color: Color(0xFF205072),
                              thickness: 1,
                            ),
                            height: 5.h,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        SingleChildScrollView(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Why Know Your Blood Type?',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF205072))),
                              SizedBox(
                                width: 5.h,
                              ),
                              InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      backgroundColor: Color(0xFFe0e9e4),
                                      context: context,
                                      builder: (context) {
                                        return SingleChildScrollView(
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  20.0,
                                                  20.0,
                                                  20.0,
                                                  0.0), // content padding
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(' Close',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontSize:
                                                                        13.sp,
                                                                    color: Colors
                                                                        .red)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Text(
                                                      'Why Should You Know \nAbout Your Blood Type?',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.teal)),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  SizedBox(
                                                    child: Container(
                                                      color: Colors.teal,
                                                      height: 0.5.h,
                                                      width: double.infinity,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Text(
                                                      'First, knowing your blood type can let you know if you are at risk for a variety of health conditions (and other random facts) such as these:\n\nType A increases risk of stomach cancer\nType O reduces fertility\nType AB, B, and A all increase risk of heart disease\nType AB, A, and B increases risk of blood clots\nType AB increases risk of dementia and memory loss\nType O has the lowest risk of heart disease and stroke\nMosquitoes like Type O blood\n\nSecond, knowing your blood type and the type of your significant other can prevent certain pregnancy risks. Knowing whether your blood type is positive or negative (also known as it\’s Rh factor) can indicate harmful Rh-incompatibility problems, which is where the mother\’s Rh blood type is different from the baby’s.\n\nKnowing your blood type can save your life in an emergency. If something happens and you are in sudden need of a blood transfusion, having your blood type in your medical file could save precious time.\n\nFinally, one of the most valuable reasons to know your blood type is to help others. Every 2 seconds, someone in the Sierra Loene needs blood, and there is no way to get blood and platelets other than through donations from volunteers.',
                                                      textAlign: TextAlign.left,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Color(
                                                                  0xff406986))),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  SizedBox(
                                                    height: 20.h,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ); // Single tapped.
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        size: 13.h,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        ' More Info',
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Visibility(
                      visible: false,
                      child: Container(
                        child: TextFormField(
                          enabled: false,
                          keyboardType: TextInputType.number,
                          maxLength: 8,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone Number is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(fontSize: 15.sp),
                          ),
                          controller: refCodeCtrl,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: false,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Select Date';
                              }
                              return null;
                            },
                            controller:
                                monthinput, //editing controller of this TextField
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Date",
                              hintText: 'Enter Date',
                              hintStyle: TextStyle(
                                  fontSize: 11.sp, fontFamily: 'Montserrat'),
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 11.sp), //label text of field
                            ),
                            readOnly:
                                true, //set it true, so that user will not able to edit text
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Select Date';
                              }
                              return null;
                            },
                            controller:
                                yearinput, //editing controller of this TextField
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Date",
                              hintText: 'Enter Date',
                              hintStyle: TextStyle(
                                  fontSize: 11.sp, fontFamily: 'Montserrat'),
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 11.sp), //label text of field
                            ),
                            readOnly:
                                true, //set it true, so that user will not able to edit text
                          ),
                        ],
                      ),
                    ),
                    DropdownButtonFormField2(
                      decoration: InputDecoration(
                        labelText: 'Blood Test For',
                        labelStyle: TextStyle(
                            fontSize: 14.sp,
                            letterSpacing: 0,
                            fontFamily: 'Montserrat'),

                        //Add isDense true and zero Padding.
                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                        isDense: false,
                        contentPadding: EdgeInsets.only(left: 5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        //Add more decoration as you want here
                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                      ),
                      isExpanded: true,
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(right: 0, left: 0),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 30,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      items: bloodItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: 'Montserrat'),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select an option.';
                        }
                      },
                      onChanged: (String? value) {
                        setState(() {
                          selectedAgeCategory = value;
                        });
                      },
                      onSaved: (value) {
                        selectedAgeCategory = value.toString();
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Personal Information',
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              letterSpacing: 0),
                          textAlign: TextAlign.left,
                        ),
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
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        labelStyle: TextStyle(
                            fontSize: 14.sp, fontFamily: 'Montserrat'),
                      ),
                      controller: _firstnameCtrl,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    DropdownButtonFormField2(
                      decoration: InputDecoration(
                        labelText: 'Age Category',
                        labelStyle: TextStyle(
                            fontSize: 14.sp,
                            letterSpacing: 0,
                            fontFamily: 'Montserrat'),
                        helperStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          letterSpacing: 0,
                        ),
                        helperText:
                            '*Teenager (below 18 years), Young Adult (18-25 years),\nAdult (26-45 years), Middle Age (46-59 years)\nOld Age (more than 60 years)',
                        //Add isDense true and zero Padding.
                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                        isDense: false,
                        contentPadding: EdgeInsets.only(left: 5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        //Add more decoration as you want here
                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                      ),
                      isExpanded: true,
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(right: 0, left: 0),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 30,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      items: ageItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select an option.';
                        }
                      },
                      onChanged: (String? value) {
                        setState(() {
                          selectedAgeCategory = value;
                        });
                      },
                      onSaved: (value) {
                        selectedAgeCategory = value.toString();
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    DropdownButtonFormField2(
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        labelStyle: TextStyle(
                            fontSize: 14.sp,
                            letterSpacing: 0,
                            fontFamily: 'Montserrat'),
                        //Add isDense true and zero Padding.
                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                        isDense: false,
                        contentPadding: EdgeInsets.only(left: 5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        //Add more decoration as you want here
                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                      ),
                      isExpanded: true,
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(right: 0, left: 0),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 30,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      items: genderItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select gender.';
                        }
                      },
                      onChanged: (String? value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                      onSaved: (value) {
                        selectedGender = value.toString();
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact Information',
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              letterSpacing: 0),
                          textAlign: TextAlign.left,
                        ),
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
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    IntlPhoneField(
                      style: TextStyle(
                          fontSize: 14.sp,
                          letterSpacing: 0,
                          fontFamily: 'Montserrat'),
                      focusNode: focusNode,
                      validator: (value) {
                        if (value == null) {
                          return 'Phone Number is required';
                        }
                        return null;
                      },
                      controller: _phoneCtrl,
                      decoration: InputDecoration(
                        counterText: '',
                        isDense: true,
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                            fontSize: 14.sp,
                            letterSpacing: 0,
                            fontFamily: 'Montserrat'),
                        errorStyle: TextStyle(
                            fontSize: 12.sp,
                            letterSpacing: 0,
                            fontFamily: 'Montserrat'),
                        helperStyle: TextStyle(
                            fontSize: 12.sp,
                            letterSpacing: 0,
                            fontFamily: 'Montserrat'),
                        hintStyle: TextStyle(
                            fontSize: 12.sp,
                            letterSpacing: 0,
                            fontFamily: 'Montserrat'),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      languageCode: "en",
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                      onCountryChanged: (country) {
                        print('Country changed to: ' + country.name);
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Facility Information',
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              letterSpacing: 0),
                          textAlign: TextAlign.left,
                        ),
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
                          height: 10.h,
                        ),
                      ],
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'First Name';
                        }
                        return null;
                      },
                      style: TextStyle(
                          fontSize: 14.sp,
                          letterSpacing: 0,
                          fontFamily: 'Montserrat'),
                      initialValue: 'Connaught Hospital',
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(),
                        labelText: 'Facility',
                        labelStyle: TextStyle(
                            fontSize: 14.sp,
                            letterSpacing: 0,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Date is required';
                            }
                            return null;
                          },
                          controller: dateinput,
                          style: TextStyle(
                              fontSize: 14.sp,
                              letterSpacing: 0,
                              fontFamily: 'Montserrat'),
                          //editing controller of this TextField
                          decoration: InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            labelText: "Select Date",
                            labelStyle: TextStyle(
                                fontSize: 14.sp,
                                letterSpacing: 0,
                                fontFamily: 'Montserrat'),
                            // label text of field
                          ),
                          readOnly:
                              true, //set it true, so that the user will not be able to edit text
                          onTap: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate:
                                  DateTime.now().add(const Duration(days: 1)),
                              firstDate: DateTime.now()
                                  .add(const Duration(days: 1)), // Next day
                              lastDate: DateTime(2101),
                            );

                            if (pickedDate != null) {
                              print(pickedDate);
                              final String formattedDate =
                                  DateFormat('d MMM yyyy').format(pickedDate);
                              print(formattedDate);
                              setState(() {
                                dateinput.text = formattedDate;
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Time is required';
                            }
                            return null;
                          },
                          controller: timeinput,
                          style: TextStyle(
                              fontSize: 14.sp,
                              letterSpacing: 0,
                              fontFamily: 'Montserrat'),
                          //editing controller of this TextField
                          decoration: InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            labelText: "Select Time",
                            labelStyle: TextStyle(
                                fontSize: 14.sp,
                                letterSpacing: 0,
                                fontFamily: 'Montserrat'),
                            // label text of field
                          ),
                          readOnly:
                              true, //set it true, so that the user will not be able to edit text
                          onTap: () async {
                            TimeOfDay initialTime = TimeOfDay.now();
                            TimeOfDay? selectedTime = await showTimePicker(
                              context: context,
                              initialTime: initialTime,
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context)
                                      .copyWith(alwaysUse24HourFormat: false),
                                  child: child!,
                                );
                              },
                            );

                            if (selectedTime != null) {
                              if (selectedTime.hour < now.hour ||
                                  (selectedTime.hour == now.hour &&
                                      selectedTime.minute <= now.minute)) {
                                // If selected time is before or equal to the current time
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Please select a time after the current time'),
                                  ),
                                );
                              } else {
                                setState(() {
                                  timeinput.text = selectedTime.format(context);
                                });
                              }
                              if (selectedTime.hour < 9 ||
                                  selectedTime.hour >= 18) {
                                // If selected time is before 9:00 or after 18:00
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Please select a time between 9:00 and 18:00'),
                                  ),
                                );
                              } else {
                                setState(() {
                                  timeinput.text = selectedTime.format(context);
                                });
                              }
                            } else {
                              print("Time is not selected");
                            }
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  backgroundColor: Colors.teal,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 20),
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (await getInternetUsingInternetConnectivity()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.teal,
                                          content: SingleChildScrollView(
                                              child: Container(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  3.0, 3.0, 3.0, 0.0),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: 15.0,
                                                      width: 15.0,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: Colors.white,
                                                        strokeWidth: 2.0,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text.rich(
                                                      TextSpan(
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff329d9c),
                                                            fontSize: 15.sp),
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                'Scheduling for ',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            recognizer:
                                                                TapGestureRecognizer()
                                                                  ..onTap = () {
                                                                    // Single tapped.
                                                                  },
                                                            text: _firstnameCtrl
                                                                    .text +
                                                                ' ' +
                                                                _middlenameCtrl
                                                                    .text +
                                                                ' ' +
                                                                _lastnameCtrl
                                                                    .text,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.amber,
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
                                                      height: 5.h,
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      child: SizedBox(
                                                        child: Divider(
                                                          color: Colors.white,
                                                          thickness: 1,
                                                        ),
                                                        height: 5.h,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text(
                                                        'Your blood type is more than a letter and a sign. It’s a priceless gift for people in need of life-saving transfusions.',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ))
                                                  ]),
                                            ),
                                          ))),
                                    );
                                    setState(() {
                                      _scheduling = true;
                                    });
                                    Future.delayed(Duration(seconds: 10),
                                        () async {
                                      register();
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          'You are offline, Turn On Data or Wifi',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 11.sp)),
                                      backgroundColor: Color(0xFFE02020),
                                      behavior: SnackBarBehavior.fixed,
                                      duration: const Duration(seconds: 5),
                                      // duration: Duration(seconds: 3),
                                    ));
                                  }
                                }
                              },
                              child: _scheduling
                                  ? SizedBox(
                                      height: 15.0,
                                      width: 15.0,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.0,
                                      ),
                                    )
                                  : Text(
                                      'Schedule Blood Group Test',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          letterSpacing: 0,
                                          color: Colors.white),
                                    )),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ]),
                ),
              )
            ])));
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

  Widget _buildPrevDonationSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedPrevDonation;

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
          groupValue: selectedPrevDonation,
          onChanged: (String? v) {
            setState(() {
              selectedPrevDonation = v;
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
