import 'package:cool_stepper/cool_stepper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:intl/intl.dart';
import 'package:lifebloodworld/features/Login/views/btschedulebloodtest.dart';
import 'package:lifebloodworld/features/Login/views/schedulebloodtest.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:lifebloodworld/main.dart';
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

class BloodGroup extends StatefulWidget {
  BloodGroup({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String? title;

  @override
  //text editing controller for text field
  _BloodGroupState createState() => _BloodGroupState();
}

class _BloodGroupState extends State<BloodGroup> {
  // Convert AppCountry to Country

  final _formKey = GlobalKey<FormState>();
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
  final TextEditingController dateinput = TextEditingController();
  final TextEditingController yearinput =
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
  @override
  void initState() {
    _dateinput.text = "";
    findfacility();
    findtimeslots();
    getPref(); //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => btblooddonationfacility(),
                    ));
              },
              icon: Icon(
                Icons.arrow_back,
                color: kWhiteColor,
              )),
          elevation: 0,
          title: Text(
            'Schedule Blood Group Test',
            style: TextStyle(fontSize: 14, color: kWhiteColor),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Why Should Know Your Blood Group?',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor)),
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
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(' Close',
                                                          textAlign:
                                                              TextAlign.center,
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
                                                    'Why Should You Donate Blood?',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 15.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                    'Safe blood saves lives. Blood is needed by women with complications during pregnancy and childbirth, children with severe anaemia, often resulting from malaria or malnutrition, accident victims and surgical and cancer patients.\n\nThere is a constant need for a regular supply of blood because it can be stored only for a limited period of time before use. Regular blood donation by a sufficient number of healthy people is needed to ensure that blood will always be available whenever and wherever it is needed.\n\nBlood is the most precious gift that anyone can give to another person – the gift of life. A decision to donate your blood can save a life, or even several if your blood is separated into its components – red cells, platelets and plasma – which can be used individually for patients with specific conditions.',
                                                    textAlign: TextAlign.left,
                                                    style:
                                                        GoogleFonts.montserrat(
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
                                      size: 15.h,
                                      color: Colors.black,
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                            'Every 2 seconds, someone in the Sierra Leone needs blood, and there is no way to get blood other than through donations from volunteers.',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.montserrat(
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color: kBlackColor)),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Personal Information',
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
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
                      CustomFormTextField(
                        name: 'Name',
                        hinttext: 'Name',
                        controller: _occupationCtrl,
                      ),
                      10.verticalSpace,
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Date of Birth is required';
                          }
                          return null;
                        },
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 0,
                            fontFamily: 'Montserrat'),
                        controller:
                            dobdateinput, //editing controller of this TextField
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            isDense: false,
                            contentPadding: EdgeInsets.all(10),
                            labelStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                letterSpacing: 0),
                            // icon: Icon(Icons.calendar_today), //icon of text field
                            labelText: "Date of Birth" //label text of field
                            ),

                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  1900), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime.now());

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('d MMM yyyy').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement
                            setState(() {
                              selectedYear = pickedDate.year;
                              selectedDay = pickedDate.day;
                              selectedMonth = pickedDate.month;
                              dateInput.text =
                                  DateFormat('d MMM yyyy').format(pickedDate);
                              calculateAge();
                            });
                            setState(() {
                              dobdateinput.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ),
                      10.verticalSpace,
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: _buildGenderSelector(
                                      context: context, name: 'Male')),
                              5.horizontalSpace,
                              Expanded(
                                  child: _buildGenderSelector(
                                      context: context, name: 'Female')),
                            ],
                          ),
                        ],
                      ),
                      10.verticalSpace,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contact Information',
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
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
                        initialCountryCode:
                            'SL', // Initial country code for Sierra Leone
                        countries: [
                          Country(
                            name: "Benin",
                            nameTranslations: {
                              "sk": "Benin",
                              "se": "Benin",
                              "pl": "Benin",
                              "no": "Benin",
                              "ja": "ベナン",
                              "it": "Benin",
                              "zh": "贝宁",
                              "nl": "Benin",
                              "de": "Benin",
                              "fr": "Bénin",
                              "es": "Benín",
                              "en": "Benin",
                              "pt_BR": "Benin",
                              "sr-Cyrl": "Бенин",
                              "sr-Latn": "Benin",
                              "zh_TW": "貝南",
                              "tr": "Benin",
                              "ro": "Benin",
                              "ar": "بنين",
                              "fa": "بنين",
                              "yue": "貝寧"
                            },
                            flag: "🇧🇯",
                            code: "BJ",
                            dialCode: "229",
                            minLength: 8,
                            maxLength: 8,
                          ),
                          Country(
                            name: "Sierra Leone",
                            nameTranslations: {
                              "sk": "Sierra Leone",
                              "se": "Sierra Leone",
                              "pl": "Sierra Leone",
                              "no": "Sierra Leone",
                              "ja": "シエラレオネ",
                              "it": "Sierra Leone",
                              "zh": "塞拉利昂",
                              "nl": "Sierra Leone",
                              "de": "Sierra Leone",
                              "fr": "Sierra Leone",
                              "es": "Sierra Leona",
                              "en": "Sierra Leone",
                              "pt_BR": "Serra Leoa",
                              "sr-Cyrl": "Сијера Леоне",
                              "sr-Latn": "Sijera Leone",
                              "zh_TW": "獅子山",
                              "tr": "Sierra Leone",
                              "ro": "Sierra Leone",
                              "ar": "سيراليون",
                              "fa": "سیرالئون",
                              "yue": "塞拉利昂"
                            },
                            flag: "🇸🇱",
                            code: "SL",
                            dialCode: "232",
                            minLength: 8,
                            maxLength: 8,
                          ),
                        ],
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 0,
                            fontFamily: 'Montserrat'),
                        focusNode: focusNode,
                        validator: (value) {
                          if (value == null) {
                            return 'Phone Number is required';
                          }
                          return null;
                        },
                        // controller: _phoneCtrl,
                        decoration: InputDecoration(
                          isDense: true,
                          counterText: '',
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                              fontSize: 14,
                              letterSpacing: 0,
                              fontFamily: 'Montserrat'),
                          errorStyle: TextStyle(
                              fontSize: 12,
                              letterSpacing: 0,
                              fontFamily: 'Montserrat'),
                          helperStyle: TextStyle(
                              fontSize: 12,
                              letterSpacing: 0,
                              fontFamily: 'Montserrat'),
                          hintStyle: TextStyle(
                              fontSize: 12,
                              letterSpacing: 0,
                              fontFamily: 'Montserrat'),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        languageCode: "en",
                        onChanged: (phone) {
                          setState(() {
                            userphonenumber = phone.completeNumber.toString();
                          });
                          print(userphonenumber);
                          // print();
                        },
                        onCountryChanged: (country) {
                          print('Country changed to: ' + country.name);
                        },
                      ),
                      10.verticalSpace,
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              letterSpacing: 0),
                          labelText: 'Marital Status',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          //Add isDense true and zero Padding.
                          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                          isDense: false,
                          contentPadding: EdgeInsets.all(10),
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
                          padding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        items: maritalstatusItems
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select service provider.';
                          }
                        },
                        onChanged: (String? value) {
                          setState(() {
                            selectedMaritalStatus = value;
                          });
                        },
                        onSaved: (value) {
                          selectedMaritalStatus = value.toString();
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomFormTextField(
                        name: 'Email Address (optional)',
                        controller: _occupationCtrl,
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
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
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
                      CustomFormTextField(
                        name: 'Facility',
                        hinttext: 'Facility',
                        enabled: false,
                        fillColor: Colors.grey.shade300,
                        fill: true,
                      ),
                      10.verticalSpace,
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Date is required';
                          }
                          return null;
                        },
                        controller: dateinput,
                        style: TextStyle(
                            fontSize: 14,
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
                              fontSize: 14,
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
                            fontSize: 14,
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
                              fontSize: 14,
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
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                backgroundColor: kPrimaryColor,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                                textStyle: TextStyle(
                                    color: kWhiteColor,
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
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
                                                          color:
                                                              Color(0xff329d9c),
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
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          recognizer:
                                                              TapGestureRecognizer()
                                                                ..onTap = () {
                                                                  // Single tapped.
                                                                },
                                                          text:
                                                              "$ufname $umname $ulname",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.amber,
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
                                                      'A single pint can save 3 lives, and a single gesture can create a million smiles. Give Blood. Save Lives.',
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
                                  Future.delayed(Duration(seconds: 7),
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
                                    'Agree and Schedule',
                                    style: TextStyle(
                                        color: kWhiteColor,
                                        fontSize: 14,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold),
                                  )),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
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
