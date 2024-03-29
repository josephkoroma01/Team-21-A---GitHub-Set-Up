import 'dart:math';

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
import 'package:lifebloodworld/constants/colors.dart';
import 'package:lifebloodworld/features/Home/views/schedulebloodtest.dart';
import 'package:lifebloodworld/features/Labs/views/labstests.dart';
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

class scheduletest extends StatefulWidget {
  scheduletest({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String? title;

  @override

  //text editing controller for text field

  _scheduletestState createState() => _scheduletestState();
}

class _scheduletestState extends State<scheduletest> {
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

  void getPref() async {
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

  final _formKey = GlobalKey<FormState>();
  final TextEditingController monthinput =
      TextEditingController(text: formattedNewMonth.toString());
  final TextEditingController yearinput =
      TextEditingController(text: formattedNewYear.toString());
  final TextEditingController dateinput = TextEditingController();
  final TextEditingController timeinput = TextEditingController();

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
  TextEditingController _firstnameCtrl = TextEditingController();


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
  String bloodtestfor = 'Myself';
  bool _scheduling = false;

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
          "firstname": ufname,
          "middlename": umname,
          "lastname": ulname,
          "agecategory": agecategory,
          "gender": gender,
          "phonenumber": phonenumber,
          "email": email,
          "address": address,
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => labtestbody(),
                  ),
                );
              },
              icon: FaIcon(FontAwesomeIcons.arrowLeft, color: kWhiteColor,)),
          elevation: 0,
          title: Text(
            widget.title!,
            style: TextStyle(fontSize: 14.sp, letterSpacing: 0, color: kWhiteColor, fontFamily: 'Montserrat'),
          )),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
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
  readOnly: true, //set it true, so that the user will not be able to edit text
  onTap: () async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // Next day
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      print(pickedDate);
      final String formattedDate = DateFormat('d MMM yyyy').format(pickedDate);
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
  readOnly: true, //set it true, so that the user will not be able to edit text
  onTap: () async {
    TimeOfDay initialTime = TimeOfDay.now();
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      if (selectedTime.hour < now.hour || (selectedTime.hour == now.hour && selectedTime.minute <= now.minute)) {
        // If selected time is before or equal to the current time
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select a time after the current time'),
          ),
        );
      } else {
        setState(() {
          timeinput.text = selectedTime.format(context);
        });
      }
      if (selectedTime.hour < 9 || selectedTime.hour >= 18) {
        // If selected time is before 9:00 or after 18:00
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select a time between 9:00 and 18:00'),
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
FormBuilderRadioGroup(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Appointment Type',
                          labelStyle: TextStyle(
                              fontSize: 18, fontFamily: 'Montserrat')),
                      name: 'Appointment Type',
                      onChanged: (String? newValue) {
                        setState(() {
                          // selectedSCategory =
                          //     newValue; // Update the state variable
                        });
                      },
                      validator: FormBuilderValidators.required(
                        errorText: 'Kindly Select an option',
                      ),
                      options: ["Doctor's Request", "General Checkup"]
                          .map((option) {
                        return FormBuilderFieldOption(
                          value: option,
                          child: Text(
                            option,
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Montserrat',
                                fontSize: 14),
                          ),
                        );
                      }).toList(growable: false),
                    ),

TextFormField(
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Doctor Name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Doctor Name',
                          labelStyle: TextStyle(
                              fontSize: 14.sp, fontFamily: 'Montserrat'),
                        ),
                        controller: _firstnameCtrl,
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
                                                              "$ufname $umname  $ulname",
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
                                : Text('Schedule Laboratory Test', style: TextStyle(color: Colors.white, fontFamily: 'Montserrat', letterSpacing: 0),)),
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
