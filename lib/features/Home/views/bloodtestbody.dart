import 'dart:math';

import 'package:cool_stepper/cool_stepper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lifebloodworld/constants/colors.dart';
import 'package:lifebloodworld/features/Home/views/schedulebloodtest.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/facility.dart';

DateTime now = DateTime.now();
String formattedNewDate = DateFormat('d LLLL yyyy').format(now);
String formattedNewMonth = DateFormat('LLLL').format(now);
String formattedNewYear = DateFormat('y').format(now);

class BloodTestPage extends StatefulWidget {
  BloodTestPage({
    Key? key,
    required this.title,
    required this.facility,
    required this.facilityId,
  }) : super(key: key);

  final String? title;
  final String? facility;
  final String? facilityId;

  @override

  //text editing controller for text field

  _BloodTestPageState createState() => _BloodTestPageState();
}

class _BloodTestPageState extends State<BloodTestPage> {
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

  String query = '';
  List facilityList = [];
  List timeslotList = [];

  @override
  void initState() {
    super.initState();
    dateinput.text = "";
    getPref();
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController monthinput =
      TextEditingController(text: formattedNewMonth.toString());
  final TextEditingController yearinput =
      TextEditingController(text: formattedNewYear.toString());
  final TextEditingController dateinput = TextEditingController();
  final TextEditingController timeinput = TextEditingController();
  final TextEditingController facility = TextEditingController();

  String? selectedFacility = '';
  String? selectedTimeslot = '';

  String dropdownValue = 'Select Facility';
  String bloodtestfor = 'Myself';
  bool _scheduling = false;

  final TextEditingController refCodeCtrl = TextEditingController(
    text: randomAlphaNumeric(8).toString(),
  );
  String? uname;
  String? name;
  String? avartar;
  String? countryId;
  String? country;
  String? userId;
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
      // prevdonationamt = prefs.getString('prevdonationamt');
      // community = prefs.getString('community');
      // communitydonor = prefs.getString('communitydonor');
      userId = prefs.getString('id');
      // totaldonation = prefs.getString('totaldonation');
    });
  }

  Future register() async {
    setState(() {
      _scheduling = false;
    });
    await Future.delayed(Duration(seconds: 0));

    try {
      var response = await http.post(
          Uri.parse(
              "https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/bloodtestschedules"),
          body: {
            "country_id": countryId,
            "facility_id": widget.facilityId,
            "district_id": "0",
            "country": country,
            "user_id": userId,
            "district": district,
            "bloodtestfor": bloodtestfor,
            "name": name,
            "agecategory": agecategory,
            "gender": gender,
            "phone": phonenumber,
            "email": email,
            "schedulerphonenumber": phonenumber,
            "address": address,
            "facility": widget.facility,
            "time":timeinput.text,
            "date": dateinput.text,
            "month": monthinput.text,
            "year": yearinput.text,
            "refcode": refCodeCtrl.text,
            "onSite": "No"
          });

      var data = json.decode(response.body);
      if (response.statusCode != 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Schedule Not Created. \n Please try again ${data}',
              textAlign: TextAlign.center, style: GoogleFonts.montserrat()),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e',
            textAlign: TextAlign.center, style: GoogleFonts.montserrat()),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 10),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: FaIcon(
                FontAwesomeIcons.arrowLeft,
                color: kWhiteColor,
              )),
          elevation: 0,
          title: Text(
            widget.title!,
            style: TextStyle(
                fontSize: 14,
                letterSpacing: 0,
                color: kWhiteColor,
                fontFamily: 'Montserrat'),
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
                        Text('Become a \nPotential Donor',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal)),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Why Know Your Blood Type?',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                    fontSize: 13,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF205072))),
                            SizedBox(
                              width: 5.h,
                            ),
                            GestureDetector(
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
                                                                  fontSize: 13,
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
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 15,
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
                                                    'First, knowing your blood type can let you know if you are at risk for a variety of health conditions (and other random facts) such as these:\n\nType A increases risk of stomach cancer\nType O reduces fertility\nType AB, B, and A all increase risk of heart disease\nType AB, A, and B increases risk of blood clots\nType AB increases risk of dementia and memory loss\nType O has the lowest risk of heart disease and stroke\nMosquitoes like Type O blood\n\nSecond, knowing your blood type and the type of your significant other can prevent certain pregnancy risks. Knowing whether your blood type is positive or negative (also known as it\’s Rh factor) can indicate harmful Rh-incompatibility problems, which is where the mother\’s Rh blood type is different from the baby’s.\n\nKnowing your blood type can save your life in an emergency. If something happens and you are in sudden need of a blood transfusion, having your blood type in your medical file could save precious time.\n\nFinally, one of the most valuable reasons to know your blood type is to help others. Every 2 seconds, someone in the Sierra Loene needs blood, and there is no way to get blood and platelets other than through donations from volunteers.',
                                                    textAlign: TextAlign.left,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 14,
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
                                child: FaIcon(
                                  FontAwesomeIcons.squareArrowUpRight,
                                  size: 20,
                                  color: kLifeBloodBlue,
                                ))
                          ],
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
                              labelStyle: TextStyle(fontSize: 15),
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
                                    fontSize: 11, fontFamily: 'Montserrat'),
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 11), //label text of field
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
                                    fontSize: 11, fontFamily: 'Montserrat'),
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 11), //label text of field
                              ),
                              readOnly:
                                  true, //set it true, so that user will not able to edit text
                            ),
                          ],
                        ),
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
                            fontSize: 14,
                            letterSpacing: 0,
                            fontFamily: 'Montserrat'),
                        readOnly: true,
                        initialValue: widget.facility!,
                        // controller: facility,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          labelText: 'Facility',
                          labelStyle: TextStyle(
                              fontSize: 14,
                              letterSpacing: 0,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
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

                      // DropdownButtonFormField2(
                      //   decoration: InputDecoration(
                      //     //Add isDense true and zero Padding.
                      //     //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                      //     labelText: 'Time Slots',
                      //     //Add isDense true and zero Padding.
                      //     //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                      //     isDense: true,
                      //     contentPadding: EdgeInsets.only(left: 8),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(5),
                      //     ),
                      //     //Add more decoration as you want here
                      //     //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                      //   ),
                      //   isExpanded: true,
                      //   icon: const Icon(
                      //     Icons.arrow_drop_down,
                      //     color: Colors.black45,
                      //   ),
                      //   iconSize: 30,
                      //   buttonHeight: 60,
                      //   buttonPadding: const EdgeInsets.only(left: 0, right: 0),
                      //   dropdownDecoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(5),
                      //   ),
                      //   items: timeslotList.map((timeslots) {
                      //     return DropdownMenuItem(
                      //       child: new Text(timeslots['timeslot']),
                      //       value: timeslots['timeslot'],
                      //     );
                      //   }).toList(),
                      //   validator: (value) {
                      //     if (value == null) {
                      //       return 'Please select a timeslot.';
                      //     }
                      //   },
                      //   onChanged: (dynamic value) {
                      //     setState(() {
                      //       timeslot = value;
                      //     });
                      //   },
                      //   onSaved: (value) {
                      //     timeslot = value.toString();
                      //   },
                      // ),

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
                                  register();
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
                                                          fontSize: 15),
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              'Scheduling for ',
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            fontSize: 14,
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
                                                          text: "$name",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            fontSize: 14,
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
                                                      'Your blood type is more than a letter and a sign. It’s a priceless gift for people in need of life-saving transfusions.',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontSize: 14,
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
                                            fontSize: 11)),
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
                                        color: Colors.white,
                                        fontFamily: 'Montserrat',
                                        letterSpacing: 0),
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
}
