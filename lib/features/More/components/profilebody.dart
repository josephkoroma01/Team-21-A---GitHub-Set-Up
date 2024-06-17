import 'dart:math';

import 'package:cool_stepper/cool_stepper.dart';
import 'package:country_flags/country_flags.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
import 'package:lifebloodworld/constants/colors.dart';
import 'package:lifebloodworld/features/Home/views/schedulebloodtest.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../provider/prefs_provider.dart';
import '../../Home/models/user_model.dart';

class UserData {
  UserData(
      {required this.userfirstname,
      required this.usermiddlename,
      required this.userlastname,
      required this.userdob,
      required this.usergender,
      required this.userphonenumber,
      required this.useremail,
      required this.useraddress,
      required this.usernin,
      required this.userdistrict,
      required this.userethnicity,
      required this.userbloodtype,
      required this.userprevdonation,
      required this.userprevdonationamt,
      required this.userpassword,
      required this.created_at});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        userfirstname: json['firstname'].toString(),
        usermiddlename: json['middlename'].toString(),
        userlastname: json['lastname'].toString(),
        userdob: json['agecategory'].toString(),
        usergender: json['gender'].toString(),
        userphonenumber: json['phonenumber'].toString(),
        useremail: json['email'].toString(),
        useraddress: json['address'].toString(),
        usernin: json['nin'].toString(),
        userethnicity: json['ethnicity'].toString(),
        userdistrict: json['district'].toString(),
        userbloodtype: json['bloodtype'].toString(),
        userprevdonation: json['prevdonation'].toString(),
        userprevdonationamt: json['prevdonationamt'].toString(),
        userpassword: json['password'].toString(),
        created_at: json['created_at'].toString());
  }

  String created_at;
  String useraddress;
  String userbloodtype;
  String userdistrict;
  String userdob;
  String useremail;
  String userethnicity;
  String userfirstname;
  String usergender;
  String userlastname;
  String usermiddlename;
  String usernin;
  String userpassword;
  String userphonenumber;
  String userprevdonation;
  String userprevdonationamt;
}

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override

  //text editing controller for text field

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? address;
  final TextEditingController addressCtrl = TextEditingController();
  String? agecategory;
  final List<String> bloodgrouplist = [
    'A+',
    'A-',
    'AB+',
    'AB-',
    'B+',
    'B-',
    'O+',
    'O-'
  ];

  String bloodtestfor = 'Myself';
  String? bloodtype;
  String? community;
  String? communitydonor;
  String? district;
  String dropdownValue = 'Select Facility';
  String? email;
  String? ethnicity;
  final TextEditingController firstnameCtrl = TextEditingController();
  String? gender;
  String? nin;
  final TextEditingController ninCtrl = TextEditingController();
  String? phonenumber;
  String? prevdonation;
  String? prevdonationamt;
  String? selectedBloodType = '';
  String? avartar;
  String? uname;
  String? name;

  final TextEditingController _ageCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _iscontactLoading = false;
  bool _isemailcontactLoading = false;
  bool _isnincontactLoading = false;
  bool _ispersonalLoading = false;
  final TextEditingController _phoneCtrl = TextEditingController();

  @override
  void initState() {
    getPref();
    super.initState();
  }

  String? countryId;
  String? userId;
  String? totaldonation;
  String? country;

  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      name = prefs.getString('name');
      uname = prefs.getString('uname');
      avartar = prefs.getString('avatar');
      agecategory = prefs.getString('agecategory');
      gender = prefs.getString('gender');
      // nin = prefs.getString('nin');
      phonenumber = prefs.getString('phonenumber');
      address = prefs.getString('address');
      district = prefs.getString('district');
      countryId = prefs.getString('country_id');
      country = prefs.getString('country');
      // ethnicity = prefs.getString('ethnicity');
      bloodtype = prefs.getString('bloodtype');
      prevdonation = prefs.getString('prevdonation');
      prevdonationamt = prefs.getString('prevdonationamt');
      community = prefs.getString('community');
      communitydonor = prefs.getString('communitydonor');
      userId = prefs.getString('id');
      totaldonation = prefs.getString('totaldonation');
    });
  }

  savePref(Users data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', "${data.user!.email}");
    prefs.setString('name', "${data.user!.name}");
    prefs.setString('uname', "${data.user!.username}");
    prefs.setString('avatar', "${data.user!.avartar}");
    prefs.setString('gender', "${data.user!.gender}");
    prefs.setString('agecategory', "${data.user!.ageCategory}");
    prefs.setString('age', "${data.user!.age}");
    prefs.setString('dob', "${data.user!.dob}");
    prefs.setString('country', "${data.user!.country}");
    prefs.setString('country_id', "${data.user!.countryId}");
    prefs.setString('phonenumber', "${data.user!.phone}");
    prefs.setString('address', "${data.user!.address}");
    prefs.setString('district', "${data.user!.distict}");
    prefs.setString('bloodtype', "${data.user!.bloodGroup}");
    prefs.setString('prevdonation', "${data.user!.prvdonation}");
    prefs.setString('prevdonationamt', "${data.user!.prvdonationNo}");
    prefs.setString('totaldonation', "${data.user!.noOfDonation}");
    prefs.setString('community', "${data.user!.community}");
    prefs.setString('id', "${data.user!.id}");
  }

  Future updatUser() async {
    var data = {
      'bloodGroup': selectedBloodType,
    };
    try {
      var response = await http.post(
        Uri.parse(
            "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/updateUser/$userId"),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        var msg = jsonDecode(response.body);
        Users data = Users.fromJson(msg);

        savePref(data);
        setState(() {
          _isLoading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(),
          ),
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              children: [
                Text("${response.statusCode}"),
                Text("${response.body}"),
              ],
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong. Please try again"),
        ),
      );
    }
  }

  // void scheduleAlarm() async{
  //   var tz;
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       'LifeBlood',
  //       'Thank You For Regisering, You Have Saved A Life',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          leading: IconButton(
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePageScreen(pageIndex: 4),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_back)),
          elevation: 0,
          title: Text(
            "$name\u0027s Profile",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontFamily: 'Montserrat', fontSize: 13.sp, color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10),
              SizedBox(
                width: 80,
                height: 80,
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/man1.png",
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "$name",
                style: GoogleFonts.montserrat(
                    fontSize: 13.sp,
                    letterSpacing: 0,
                    fontWeight: FontWeight.bold,
                    color: kLifeBloodBlue),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CountryFlag.fromCountryCode(
                    'sl',
                    height: 20,
                    width: 35,
                    borderRadius: 5,
                  ),
                  5.horizontalSpace,
                  Text(
                    " Sierra Leone",
                    style: GoogleFonts.montserrat(
                        fontSize: 14,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        color: kLifeBloodBlue),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 15,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Personal Details",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff389e9d)),
                                  ),
                                  SizedBox(
                                    height: 10,
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
                                          text: 'Birth Date:  ',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xFF205072),
                                          ),
                                        ),
                                        TextSpan(
                                          // text: agecategory,
                                          text: "ehe",
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
                                    height: 5,
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
                                          text: 'Age Category:  ',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xFF205072),
                                          ),
                                        ),
                                        TextSpan(
                                          // text: agecategory,
                                          text: "1-",
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
                                    height: 5,
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
                                              text: gender ?? " ",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF205072),
                                              ),
                                            ),
                                          ],
                                        ),
                                        textHeightBehavior:
                                            const TextHeightBehavior(
                                                applyHeightToFirstAscent:
                                                    false),
                                        textAlign: TextAlign.left,
                                      ),
                                      (gender == "Male")
                                          ? const Icon(
                                              Icons.male_outlined,
                                              color: Color(0xFF205072),
                                            )
                                          : const Icon(Icons.female_outlined),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
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
              const SizedBox(
                height: 10,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Contact Details",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff389e9d)),
                                  ),
                                  SizedBox(
                                    height: 10,
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
                                          text: 'Phone Number:  ',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xFF205072),
                                          ),
                                        ),
                                        TextSpan(
                                          text: phonenumber,
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
                                    height: 5,
                                  ),
                                  (email == "")
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                                    text: 'Email: ',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.normal,
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
                                            _isemailcontactLoading
                                                ? SizedBox(
                                                    height: 15.0,
                                                    width: 15.0,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.blue,
                                                      strokeWidth: 2.0,
                                                    ),
                                                  )
                                                : InkWell(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        backgroundColor:
                                                            Color(0xFFebf5f5),
                                                        context: context,
                                                        builder: (context) {
                                                          return SingleChildScrollView(
                                                            child: Container(
                                                              padding: EdgeInsets.only(
                                                                  bottom: MediaQuery.of(
                                                                          context)
                                                                      .viewInsets
                                                                      .bottom),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .fromLTRB(
                                                                        20.0,
                                                                        20.0,
                                                                        20.0,
                                                                        0.0),
                                                                // content padding
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.end,
                                                                        children: [
                                                                          Text(
                                                                              ' Close',
                                                                              textAlign: TextAlign.center,
                                                                              style: GoogleFonts.montserrat(fontSize: 13.sp, color: Colors.red)),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                        'Add Email Address',
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style: GoogleFonts.montserrat(
                                                                            fontSize:
                                                                                15.sp,
                                                                            fontWeight: FontWeight.bold,
                                                                            color: Colors.teal)),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Container(
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          SizedBox(
                                                                        child:
                                                                            Divider(
                                                                          color:
                                                                              Colors.teal,
                                                                          thickness:
                                                                              1,
                                                                        ),
                                                                        height:
                                                                            5,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Form(
                                                                      key:
                                                                          _formKey,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          TextFormField(
                                                                            keyboardType:
                                                                                TextInputType.text,
                                                                            style:
                                                                                TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat'),
                                                                            controller:
                                                                                ninCtrl,
                                                                            decoration: InputDecoration(
                                                                                labelText: 'Email Address',
                                                                                hintText: 'Enter Email Address',
                                                                                labelStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat'),
                                                                                hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                          ),
                                                                          SizedBox(
                                                                              height: 10),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: double
                                                                          .infinity,
                                                                      child: ElevatedButton(
                                                                          child: Text('Add Email Address', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 13.sp, color: Colors.white)),
                                                                          style: TextButton.styleFrom(
                                                                            foregroundColor:
                                                                                Colors.white,
                                                                            backgroundColor:
                                                                                Color(0xff389e9d),
                                                                          ),
                                                                          onPressed: () async {
                                                                            if (_formKey.currentState!.validate()) {
                                                                              Navigator.pop(context);
                                                                              if (await getInternetUsingInternetConnectivity()) {
                                                                                setState(() {
                                                                                  _isemailcontactLoading = true;
                                                                                });
                                                                                // emailcontactdetailsupdate();
                                                                              } else {
                                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                  content: Text('You are offline, Kindly turn on Wifi or Mobile Data to continue', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 10.sp)),
                                                                                  backgroundColor: Color(0xFFE02020),
                                                                                  behavior: SnackBarBehavior.fixed,
                                                                                  duration: const Duration(seconds: 10),
                                                                                  // duration: Duration(seconds: 3),
                                                                                ));
                                                                              }
                                                                            }
                                                                          }),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.add,
                                                          color: Colors.blue,
                                                          size: 15,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text('add Email',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontSize:
                                                                        12.sp,
                                                                    color: Colors
                                                                        .blue)),
                                                      ],
                                                    ),
                                                  ),
                                          ],
                                        )
                                      : Text.rich(
                                          TextSpan(
                                            style: TextStyle(
                                              color: Color(0xFF205072),
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: 'Email: ',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.normal,
                                                  color: Color(0xFF205072),
                                                ),
                                              ),
                                              TextSpan(
                                                // text: email ?? " ",
                                                text: " ",
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
                                  SizedBox(
                                    height: 5,
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
                                          text: 'Address: ${address ?? " "} ',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xFF205072),
                                          ),
                                        ),
                                        TextSpan(
                                          text: address,
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
                                    height: 5,
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
                height: 20.0,
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Blood Details",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff389e9d)),
                                  ),
                                  SizedBox(
                                    height: 10,
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
                                          text: 'Blood Group: ',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xFF205072),
                                          ),
                                        ),
                                        TextSpan(
                                          text: bloodtype ?? " ",
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
                                    height: 5,
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
                                          text: prevdonation ?? " ",
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
                                    height: 5,
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
                                                    'Number of Previous Donation: ',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.normal,
                                                  color: Color(0xFF205072),
                                                ),
                                              ),
                                              TextSpan(
                                                text: prevdonationamt,
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
                                        )
                                      : SizedBox(
                                          height: 0.h,
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    children: [
                                      bloodtype != "A"
                                          ? Container(
                                              width: double.infinity,
                                              child: TextButton(
                                                child: _isLoading
                                                    ? SizedBox(
                                                        height: 15.0,
                                                        width: 15.0,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Colors.white,
                                                          strokeWidth: 2.0,
                                                        ),
                                                      )
                                                    : Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          FaIcon(
                                                            FontAwesomeIcons
                                                                .penToSquare,
                                                            size: 15,
                                                          ),
                                                          SizedBox(width: 5),
                                                          Text(
                                                              'Update Blood Details',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                      fontSize:
                                                                          14.sp,
                                                                      color: Colors
                                                                          .white)),
                                                        ],
                                                      ),
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor:
                                                      Color(0xFF205072),
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                ),
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        Dialog(
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10),
                                                        ),
                                                      ),
                                                      child: IntrinsicHeight(
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width <=
                                                                  768
                                                              ? 0.7.sw
                                                              : 0.65.sw,
                                                          // padding: EdgeInsets.all(10.r),
                                                          decoration: const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10))),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(10
                                                                            .r),
                                                                decoration: BoxDecoration(
                                                                    color:
                                                                        kPrimaryColor,
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                10),
                                                                        topRight:
                                                                            Radius.circular(
                                                                                10),
                                                                        bottomLeft:
                                                                            Radius
                                                                                .zero,
                                                                        bottomRight:
                                                                            Radius.zero)),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Update Blood Details',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15,
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        letterSpacing:
                                                                            0,
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .close,
                                                                          color:
                                                                              kWhiteColor,
                                                                        ))
                                                                  ],
                                                                ),
                                                              ),
                                                              10.verticalSpace,
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10),
                                                                child: Expanded(
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    child: Form(
                                                                      key:
                                                                          _formKey,
                                                                      autovalidateMode:
                                                                          AutovalidateMode
                                                                              .always,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          SizedBox(
                                                                              height: 5),
                                                                          DropdownButtonFormField(
                                                                            //button height
                                                                            decoration:
                                                                                InputDecoration(
                                                                              labelText: 'Blood Group',
                                                                              labelStyle: TextStyle(fontFamily: 'Montserrat', letterSpacing: 0, fontSize: 14),
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
                                                                            icon:
                                                                                const Icon(
                                                                              Icons.arrow_drop_down,
                                                                              color: Colors.black45,
                                                                            ),
                                                                            iconSize:
                                                                                30,

                                                                            items: bloodgrouplist
                                                                                .map((item) => DropdownMenuItem<String>(
                                                                                      value: item,
                                                                                      child: Text(
                                                                                        item,
                                                                                        style: TextStyle(
                                                                                          fontSize: 14.sp,
                                                                                        ),
                                                                                      ),
                                                                                    ))
                                                                                .toList(),
                                                                            validator:
                                                                                (value) {
                                                                              if (value == null) {
                                                                                return 'Please select an option.';
                                                                              }
                                                                            },
                                                                            onChanged:
                                                                                (String? value) {
                                                                              setState(() {
                                                                                selectedBloodType = value;
                                                                              });
                                                                            },
                                                                            onSaved:
                                                                                (value) {
                                                                              selectedBloodType = value.toString();
                                                                            },
                                                                          ),
                                                                          SizedBox(
                                                                              height: 5),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                double.infinity,
                                                                            child:
                                                                                ElevatedButton(
                                                                              style: TextButton.styleFrom(
                                                                                backgroundColor: Color(0xff389e9d),
                                                                                foregroundColor: Colors.white,
                                                                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                              ),
                                                                              onPressed: () async {
                                                                                if (_formKey.currentState!.validate()) {
                                                                                  Navigator.pop(context);
                                                                                  if (await getInternetUsingInternetConnectivity()) {
                                                                                    setState(() {
                                                                                      _isLoading = true;
                                                                                    });
                                                                                    updatUser();
                                                                                    // blooddetailsupdate();
                                                                                  } else {
                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                      SnackBar(
                                                                                        content: Text('You are offline, Kindly turn on Wifi or Mobile Data to continue', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 10.sp)),
                                                                                        backgroundColor: Color(0xFFE02020),
                                                                                        behavior: SnackBarBehavior.fixed,
                                                                                        duration: const Duration(seconds: 10),
                                                                                        // duration: Duration(seconds: 3),
                                                                                      ),
                                                                                    );
                                                                                  }
                                                                                }
                                                                              },
                                                                              child: Text('Update Details', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 13.sp, color: Colors.white)),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          : Container(),
                                      Container(
                                        width: double.infinity,
                                        child: TextButton(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.bloodtype_rounded,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              SizedBox(width: 5),
                                              Text('Schedule Blood Group Test',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 14.sp,
                                                      color: Colors.white)),
                                            ],
                                          ),
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor: Colors.teal,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    scheduletypebody(),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}

// class UpdateProfileScreen extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit (
//         builder: (context) {
//           return MaterialApp(
//
//             title: 'Lifeblood Registration',
//             theme: ThemeData(
//               foregroundColorSwatch: Colors.teal,
//               visualDensity: VisualDensity.adaptivePlatformDensity,
//               fontFamily: GoogleFonts.montserrat().fontFamily,
//             ),
//             debugShowCheckedModeBanner: false,
//             home: UserUpdatePage(title: 'Update Profile'),
//           );
//
//         }
//     );
//   }
// }

// class UserUpdatePage extends StatefulWidget {
//   UserUpdatePage({Key? key, required this.title}) : super(key: key);
//
//   final String? title;
//
//   @override
//
//   _UserUpdatePageState createState() => _UserUpdatePageState();
// }
//
// class _UserUpdatePageState extends State<UserUpdatePage> {
//
//   String? useremail;
//   String? userufname;
//   String? userulname;
//   String? userumname;
//   String? userage;
//   String? usergender;
//   String? userphonenumber;
//   String? useraddress;
//   String? userdistrict;
//   String? userbloodtype;
//   String? userprevdonation;
//
//
//
//   void getProfilePref() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       useremail = prefs.getString('email');
//       userufname = prefs.getString('ufname');
//       userumname = prefs.getString('umname');
//       userulname = prefs.getString('ulname');
//       userage = prefs.getString('age');
//       usergender = prefs.getString('gender');
//       userphonenumber = prefs.getString('phonenumber');
//       useraddress = prefs.getString('address');
//       userdistrict = prefs.getString('district');
//       userbloodtype = prefs.getString('bloodtype');
//       userprevdonation = prefs.getString('prevdonation');
//
//     });
//   }
//
//
//   @override
//   void initState() {
//     super.initState();
//     getProfilePref();
//     _passwordVisible = false;
//     var ageCtrl = userage;
//   }
//
//   final _formKey = GlobalKey<FormState>();
//   bool _validate = false;
//   bool _passwordVisible = false;
//
//
//   String? selectedDistrict = '';
//
//   String? selectedBloodType = '';
//   String? selectedPrevDonation = '';
//   String? selectedGender = '';
//
//
//   final TextEditingController _firstnameCtrl = TextEditingController();
//   final TextEditingController _middlenameCtrl = TextEditingController();
//   final TextEditingController _lastnameCtrl = TextEditingController();
//   final ageCtrl = TextEditingController(text: {age});
//   final TextEditingController _phoneCtrl = TextEditingController();
//   final TextEditingController _emailCtrl = TextEditingController();
//   final TextEditingController _addressCtrl = TextEditingController();
//   final TextEditingController _passwordCtrl = TextEditingController();
//
//
//
//
//
//   Future register() async {
//     var response = await http.post(Uri.parse("http://nsbslifeblood.niche.sl/registeruser.php"), body: {
//       "firstname": _firstnameCtrl.text,
//       "middlename": _middlenameCtrl.text,
//       "lastname": _lastnameCtrl.text,
//       "age": ageCtrl.text,
//       "gender": selectedGender,
//       "phonenumber": _phoneCtrl.text,
//       "email": _emailCtrl.text,
//       "address": _addressCtrl.text,
//       "district": selectedDistrict,
//       "bloodtype": selectedBloodType,
//       "prevdonation": selectedPrevDonation,
//       "password": _passwordCtrl.text,
//     });
//     var data = json.decode(response.body);
//     if (data == "Error") {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Please Try Again, User Already Exists'),
//         backgroundColor: Colors.red,
//         behavior: SnackBarBehavior.fixed,
//         duration: Duration(seconds: 3),
//       ));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Container(
//           height: 10,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text('Update Successful', textAlign:TextAlign.center, style:GoogleFonts.montserrat(fontSize: 14.sp,) ),
//
//             ],
//           ),
//         ),
//         backgroundColor: Colors.teal,
//         behavior: SnackBarBehavior.fixed,
//         duration: Duration(seconds: 5),
//       ));
//       // scheduleAlarm();
//
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ProfilePage(),
//         ),
//       );
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final steps = [
//       CoolStep(
//         title: 'PERSONAL DETAILS',
//         subtitle: 'Please fill some of the Personal Information to get started',
//         content: Form(
//           key: _formKey,
//           autovalidateMode: AutovalidateMode.always,
//           child: Column(
//             children: [
//               TextFormField(
//                 keyboardType: TextInputType.text,
//                 initialValue: ufname,
//                 enabled: false,
//                 readOnly: true,
//                 decoration: InputDecoration(
//                     labelText: 'First Name',
//                     labelStyle: TextStyle(fontSize: 15.sp)
//
//                 ),
//               ),
//               TextFormField(
//                 keyboardType: TextInputType.text,
//                 initialValue: umname,
//                 enabled: false,
//                 readOnly: true,
//                 decoration: InputDecoration(
//                     labelText: 'Middle Name',
//                     labelStyle: TextStyle(fontSize: 15.sp)
//
//                 ),
//               ),
//
//               TextFormField(
//                 keyboardType: TextInputType.text,
//                 initialValue: ulname,
//                 enabled: false,
//                 readOnly: true,
//                 decoration: InputDecoration(
//                     labelText: 'Last Name',
//                     labelStyle: TextStyle(fontSize: 15.sp)
//
//                 ),
//               ),
//
//
//               TextFormField(
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Age is required';
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//                     labelText: 'Age',
//                     labelStyle: TextStyle(fontSize: 15.sp)
//
//                 ),
//
//
//                 controller: _ageCtrl,
//               ),
//               SizedBox(  height: 10),
//
//
//
//
//             ],
//           ),
//         ),
//
//
//         validation: () {
//           if (!_formKey.currentState!.validate()) {
//             return 'Fill form correctly';
//           }
//           return null;
//         },
//       ),
//       CoolStep(
//         title: 'CONTACT DETAILS',
//         subtitle: 'Please fill some of the Contact Information to continue',
//         content:
//         Form(
//           key: _formKey,
//           autovalidateMode: AutovalidateMode.always,
//           child: Column(
//             children: [
//
//               TextFormField(
//                 keyboardType: TextInputType.number,
//                 maxLength: 8,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Phone Number is required';
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//
//                     labelText: 'Phone Number',
//                     labelStyle: TextStyle(fontSize: 15.sp),
//                     prefixText:'+232'
//                 ),
//
//
//                 controller: _phoneCtrl,
//               ),
//
//               _buildTextField(
//                 labelText: 'Email Address',
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Email Address is required';
//                   }
//                   return null;
//                 },
//                 controller: _emailCtrl,
//               ),
//               _buildTextField(
//                 labelText: 'Home Address',
//                 controller: _addressCtrl,
//               ),
//               SizedBox(  height: 15),
//
//
//               FormBuilderRadioGroup(
//
//                 decoration: InputDecoration(border: InputBorder.none, labelText: 'Select District', labelStyle: TextStyle(fontSize: 20.sp)),
//                 name: '$selectedDistrict',
//                 onChanged: (String? value) {
//                   setState(() {
//                     selectedDistrict = value;
//                   });
//                 },
//                 initialValue: selectedDistrict,
//                 orientation: OptionsOrientation.vertical,
//                 validator: FormBuilderValidators.required(
//                   errorText:
//                   'Kindly Select a District',
//                 ),
//                 options: [
//                   'Bo',
//                   'Bombali',
//                   'Bonthe',
//                   'Kailahun',
//                   'Kambia',
//                   'Karene',
//                   'Kenema',
//                   'Koindadugu',
//                   'Kono',
//                   'Moyamba',
//                   'Port Loko',
//                   'Pujehun',
//                   'Tonkolili',
//                   'Western Rural',
//                   'Western Urban'
//                 ]
//                     .map((selectedDistrict) => FormBuilderFieldOption(value: selectedDistrict))
//                     .toList(growable: false),
//               ),
//               // Container(
//               //   child: Column(
//               //     crossAxisAlignment : CrossAxisAlignment.start,
//               //     children: [
//               //       Text('District | Select District'),
//               //       SizedBox(  height: size.height * 0.02,),
//               //       Column(
//               //         children: [
//               //           Row(
//               //             children: <Widget>[
//               //               _buildDistrictSelector(
//               //                 context: context,
//               //                 name: 'Bo',
//               //               ),
//               //               SizedBox(width: 5.0),
//               //               _buildDistrictSelector(
//               //                 context: context,
//               //                 name: 'Bombali',
//               //               ),
//               //             ],
//               //           ),
//               //           SizedBox(  height: size.height * 0.02,),
//               //           Row(
//               //             children: <Widget>[
//               //               _buildDistrictSelector(
//               //                 context: context,
//               //                 name: 'Bonthe',
//               //               ),
//               //               SizedBox(width: 5.0),
//               //               _buildDistrictSelector(
//               //                 context: context,
//               //                 name: 'Falaba',
//               //               ),
//               //             ],
//               //           ),
//               //           SizedBox(  height: size.height * 0.02,),
//               //           Row(
//               //             children: <Widget>[
//               //               _buildDistrictSelector(
//               //                 context: context,
//               //                 name: 'Kailahun',
//               //               ),
//               //               SizedBox(width: 5.0),
//               //               _buildDistrictSelector(
//               //                 context: context,
//               //                 name: 'Kambia',
//               //               ),
//               //             ],
//               //           ),
//               //           SizedBox(  height: size.height * 0.02,),
//               //           Row(
//               //             children: <Widget>[
//               //               _buildDistrictSelector(
//               //                 context: context,
//               //                 name: 'Karene',
//               //               ),
//               //               SizedBox(width: 5.0),
//               //               _buildDistrictSelector(
//               //                 context: context,
//               //                 name: 'Kenema',
//               //               ),
//               //             ],
//               //           ),
//               //           SizedBox(  height: size.height * 0.02,),
//               //           Row(
//               //             children: <Widget>[
//               //               _buildDistrictSelector(
//               //                 context: context,
//               //                 name: 'Koinadugu',
//               //               ),
//               //               SizedBox(width: 5.0),
//               //               _buildDistrictSelector(
//               //                 context: context,
//               //                 name: 'Kono',
//               //               ),
//               //             ],
//               //           ),
//               //           SizedBox(  height: size.height * 0.02,),
//               //           Row(
//               //             children: <Widget>[
//               //               _buildDistrictSelector(
//               //                 context: context,
//               //                 name: 'Moyamba',
//               //               ),
//               //               SizedBox(width: 5.0),
//               //               _buildDistrictSelector(
//               //                 context: context,
//               //                 name: 'PortLoko',
//               //               ),
//               //             ],
//               //           ),
//               //           SizedBox(  height: size.height * 0.02,),
//               //           Row(
//               //             children: <Widget>[
//               //               _buildDistrictSelector(
//               //                 context: context,
//               //                 name: 'Pejuhun',
//               //               ),
//               //               SizedBox(width: 5.0),
//               //               _buildDistrictSelector(
//               //                 context: context,
//               //                 name: 'Tonkolili',
//               //               ),
//               //             ],
//               //           ),
//               //           SizedBox(height: size.height * 0.02,),
//               //           Row(
//               //             children: <Widget>[
//               //               _buildDistrictSelector(
//               //                 context: context,
//               //                 name: 'Western Rural',
//               //               ),
//               //               SizedBox(width: 5.0),
//               //               _buildDistrictSelector(
//               //                 context: context,
//               //                 name: 'Western Urban',
//               //               ),
//               //             ],
//               //           ),
//               //           SizedBox(  height: size.height * 0.03,),
//               //         ],
//               //       ),
//               //     ],
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//         validation: () {
//           if (!_formKey.currentState!.validate()) {
//             return 'Fill form correctly';
//           }
//           return null;
//         },
//       ),
//       CoolStep(
//         title: 'BLOOD DETAILS',
//         subtitle: 'Please fill some of the Blood Information to Complete Registration',
//         content:
//         Form(
//           key: _formKey,
//           autovalidateMode: AutovalidateMode.always,
//           child: Column(
//             children: [
//
//               FormBuilderRadioGroup(
//
//                 orientation: OptionsOrientation.vertical,
//                 name: '$selectedBloodType',
//                 decoration: InputDecoration(border: InputBorder.none, labelText: 'Select Blood Type', labelStyle: TextStyle(fontSize: 20.sp)),
//
//                 onChanged: (String? value) {
//                   setState(() {
//                     selectedBloodType = value;
//                   });
//                 },
//                 initialValue: selectedBloodType,
//
//                 validator: FormBuilderValidators.required(
//                   errorText:
//                   'Kindly Select a Blood Type',
//                 ),
//                 options: [
//                   'A+', 'A-','AB+','AB-','B+','B-','O+','O-','Not Known'
//                 ]
//                     .map((selectedBloodType) => FormBuilderFieldOption(value: selectedBloodType))
//                     .toList(growable: false),
//               ),
//               SizedBox(  height: 10),
//               FormBuilderRadioGroup(
//
//                 orientation: OptionsOrientation.vertical,
//                 name: '$selectedPrevDonation',
//                 decoration: InputDecoration(border: InputBorder.none, labelText: 'Have You Donated Before', labelStyle: TextStyle(fontSize: 20.sp)),
//
//                 onChanged: (String? value) {
//                   setState(() {
//                     selectedPrevDonation = value;
//                   });
//                 },
//                 initialValue: selectedPrevDonation,
//                 validator: FormBuilderValidators.required(
//                   errorText:
//                   'Kindly Select an option',
//                 ),
//                 options: [
//                   'Yes', 'No'
//                 ]
//                     .map((selectedPrevDonation) => FormBuilderFieldOption(value: selectedPrevDonation))
//                     .toList(growable: false),
//               ),
//               SizedBox(  height: 10),
//               TextFormField(
//
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Kindly Enter a Password';
//                   }
//                   return null;
//                 },
//                 obscureText: !_passwordVisible,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   suffixIcon: IconButton(
//                     icon: Icon(
//                       // Based on passwordVisible state choose the icon
//                       _passwordVisible
//                           ? Icons.visibility
//                           : Icons.visibility_off,
//                       color: Colors.teal,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _passwordVisible = !_passwordVisible;
//                       });
//                     },
//                     color: Colors.teal,
//                   ),
//
//                 ),
//
//
//                 controller: _passwordCtrl,
//               ),
//               SizedBox(  height: size.height * 0.03,),
//
//             ],
//           ),
//         ),
//         validation: () {
//           if (!_formKey.currentState!.validate()) {
//             return 'Fill form correctly';
//           }
//           return null;
//         },
//       ),
//
//     ];
//
//     final stepper = CoolStepper(
//       showErrorSnackbar: false,
//       onCompleted: () async{
//         if(await getInternetUsingInternetConnectivity()){
//           register();
//         }
//         else{
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text(
//                 'You are offline, Kindly turn on Wifi or Mobile Data to continue',
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.montserrat(fontSize: 10.sp)),
//             backgroundColor: Color(0xFFE02020),
//             behavior: SnackBarBehavior.fixed,
//             duration: const Duration(seconds: 10),
//             // duration: Duration(seconds: 3),
//           ));
//
//         }
//
//
//
//       },
//       steps: steps,
//       config: CoolStepperConfig(
//         backText: 'PREV',
//       ),
//     );
//
//     return Scaffold(
//       appBar: AppBar(
//           leading: IconButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   new MaterialPageRoute(
//                     builder: (context) => ProfilePage(),
//                   ),
//                 );
//               },
//               icon:Icon(Icons.arrow_back)
//           ),
//           elevation: 0,
//           title: Text(widget.title!)
//       ),
//       body: Container(
//         child: stepper,
//       ),
//     );
//   }
//
//
//
//
//   Widget _buildTextField({
//
//     String? labelText,
//     FormFieldValidator<String>? validator,
//     TextEditingController? controller,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 20.0),
//       child: TextFormField(
//         decoration: InputDecoration(
//           labelText: labelText,
//         ),
//         validator: validator,
//         controller: controller,
//       ),
//     );
//   }
//
//   Widget _buildPrevDonationSelector({
//     BuildContext? context,
//     required String name,
//   }) {
//     final isActive = name == selectedPrevDonation;
//
//     return Expanded(
//
//       child: AnimatedContainer(
//
//         duration: Duration(milliseconds: 200),
//         curve: Curves.easeInOut,
//         decoration: BoxDecoration(
//           color: isActive ? Theme.of(context!).PrimaryColor : null,
//           border: Border.all(
//             width: 0,
//           ),
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         child: RadioListTile(
//           value: name,
//           activeColor: Colors.white,
//           groupValue: selectedPrevDonation,
//           onChanged: (String? v) {
//             setState(() {
//               selectedPrevDonation = v;
//             });
//           },
//           title: Text(
//             name,
//             style: TextStyle(
//               color: isActive ? Colors.white : null,
//               // fontSize: width * 0.035,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBloodTypeSelector({
//     BuildContext? context,
//     required String name,
//   }) {
//     final isActive = name == selectedBloodType;
//
//     return Expanded(
//
//       child: AnimatedContainer(
//
//         duration: Duration(milliseconds: 200),
//         curve: Curves.easeInOut,
//         decoration: BoxDecoration(
//           color: isActive ? Theme.of(context!).PrimaryColor : null,
//           border: Border.all(
//             width: 0,
//           ),
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         child: RadioListTile(
//           value: name,
//           activeColor: Colors.white,
//           groupValue: selectedBloodType,
//           onChanged: (String? v) {
//             setState(() {
//               selectedBloodType = v;
//             });
//           },
//           title: Text(
//             name,
//             style: TextStyle(
//               color: isActive ? Colors.white : null,
//               // fontSize: width * 0.035,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//
//
//
// }
//
//
