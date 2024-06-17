import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lifebloodworld/constants/colors.dart';
import 'package:lifebloodworld/features/Home/views/search.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:lifebloodworld/features/Login/views/login_screen.dart';
import 'package:lifebloodworld/features/Login/views/schedulebloodtest.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:lifebloodworld/models/bloodtestingfacilities.dart';
import 'package:http/http.dart' as http;
import 'package:lifebloodworld/widgets/custom_textfield.dart';

DateTime now = DateTime.now();
String formattedNewDate = DateFormat('d MMM yyyy').format(now);
String formattedNewMonth = DateFormat('LLLL').format(now);
String formattedNewYear = DateFormat('y').format(now);

class EAnalysisScreen extends StatefulWidget {
  EAnalysisScreen(
      {Key? key,
      required this.country,
      required this.gender,
      required this.agecategory,
      required this.weight,
      required this.cold,
      required this.goodhealth,
      required this.eaten,
      required this.hospital,
      required this.disease,
      required this.medication,
      required this.surgical,
      required this.tattoo,
      required this.travel,
      required this.pdonated,
      required this.wdonated,
      required this.pregnant,
      required this.mens})
      : super(key: key);

  String? country;
  String? gender;
  String? agecategory;
  String? weight;
  String? cold;
  String? goodhealth;
  String? eaten;
  String? hospital;
  String? disease;
  String? medication;
  String? surgical;
  String? tattoo;
  String? travel;
  String? pdonated;
  String? wdonated;
  String? pregnant;
  String? mens;

  @override
  State<EAnalysisScreen> createState() => EAnalysisScreenState(
        country: country,
        gender: gender,
        agecategory: agecategory,
        weight: weight,
        cold: cold,
        goodhealth: goodhealth,
        eaten: eaten,
        hospital: hospital,
        disease: disease,
        medication: medication,
        surgical: surgical,
        tattoo: tattoo,
        travel: travel,
        pdonated: pdonated,
        wdonated: wdonated,
        pregnant: pregnant,
        mens: mens,
      );
}

class EAnalysisScreenState extends State<EAnalysisScreen> {
  EAnalysisScreenState(
      {Key? key,
      required this.country,
      required this.gender,
      required this.agecategory,
      required this.weight,
      required this.cold,
      required this.goodhealth,
      required this.eaten,
      required this.hospital,
      required this.disease,
      required this.medication,
      required this.surgical,
      required this.tattoo,
      required this.travel,
      required this.pdonated,
      required this.wdonated,
      required this.pregnant,
      required this.mens});

  String query = '';
  GlobalKey _scaffold = GlobalKey();
  final _formKey = GlobalKey<FormBuilderState>();

  String? country;
  String? gender;
  String? agecategory;
  String? weight;
  String? cold;
  String? goodhealth;
  String? eaten;
  String? hospital;
  String? disease;
  String? medication;
  String? surgical;
  String? tattoo;
  String? travel;
  String? pdonated;
  String? wdonated;
  String? pregnant;
  String? mens;

  bool q1 = true;
  bool q2 = true;
  bool q3 = true;
  bool q4 = true;
  bool q5 = true;
  bool q6 = true;
  bool q7 = true;
  bool q8 = true;
  bool q9 = true;
  bool q10 = true;
  bool q11 = true;
  bool q12 = true;
  bool q13 = true;
  bool q14 = true;
  bool q15 = true;
  bool q16 = true;

  int? selectedYear;
  int? selectedDay;
  int? selectedMonth;
  String? selectedAge = '';

  final TextEditingController monthinput =
      TextEditingController(text: formattedNewMonth.toString());
  final TextEditingController dateinput =
      TextEditingController(text: formattedNewDate.toString());
  final TextEditingController _birthdateinput = TextEditingController();

  final TextEditingController name = TextEditingController();
  final TextEditingController phonenumber = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController yearinput =
      TextEditingController(text: formattedNewYear.toString());

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

      return '$age years';
    }
    return '';
  }

  Future registerinterest() async {
    var response = await http.post(
        Uri.parse("https://community.lifebloodsl.com/potentialdonors.php"),
        body: {
          "name": name.text,
          "birthdate": dobdateinput.text,
          "age": selectedAge,
          "agecategory": agecategory,
          "gender": gender,
          "phonenumber": phonenumber.text,
          "email": email.text,
          "date": dateinput.text,
          "month": monthinput.text,
          "year": yearinput.text,
        });
    var data = json.decode(response.body);
    if (data == "Error") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Please Try Again, Interest Already Exists',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Interest Registered Successfully',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 13.sp,
            )),
        backgroundColor: Colors.teal,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 5),
      ));
      // scheduleAlarm();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFe0e9e4),
        title: Text(
          'Eligibility Analysis',
          overflow: TextOverflow.clip,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 17,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
      backgroundColor: Color(0xFFe0e9e4),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 15, left: 15, top: 0, bottom: 10),
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      ((agecategory != "<18" || agecategory != "65+") &&
                              (weight != "<50kg") &&
                              (cold == "No") &&
                              (goodhealth == "Yes") &&
                              (eaten == "Yes") &&
                              (hospital == "No") &&
                              (disease == "No") &&
                              (medication == "No") &&
                              (surgical == "No") &&
                              (tattoo == "No") &&
                              (travel == "No") &&
                              ((pdonated == "No") ||
                                  (pdonated == "Yes" &&
                                      wdonated != "This Month") ||
                                  (pdonated == "Yes" &&
                                      wdonated != "Last Month") ||
                                  (pdonated == "Yes" &&
                                      wdonated != "Last 3 Month" &&
                                      gender == "Female")) &&
                              ((gender == "Female" && pregnant == "No") ||
                                  (gender == "Male" &&
                                      pregnant.toString().isEmpty)) &&
                              ((gender == "Female" && mens == "No") ||
                                  (gender == "Male" &&
                                      mens.toString().isEmpty)))
                          ? Container(
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
                                    'Overall Analysis',
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.spMax,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: kLifeBloodRed,
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
                                    'Overall Analysis',
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.spMax,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      Expanded(
                        // Use Expanded to allow the SingleChildScrollView to take remaining space
                        child: SingleChildScrollView(
                          // Wrap your content with SingleChildScrollView
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, bottom: 0, left: 15, right: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ((agecategory != "<18" ||
                                                  agecategory != ">65+") &&
                                              (weight != "<50kg") &&
                                              (cold == "No") &&
                                              (goodhealth == "Yes") &&
                                              (eaten == "Yes") &&
                                              (hospital == "No") &&
                                              (disease == "No") &&
                                              (medication == "No") &&
                                              (surgical == "No") &&
                                              (tattoo == "No") &&
                                              (travel == "No") &&
                                              ((pdonated == "No") ||
                                                  (pdonated == "Yes" &&
                                                      wdonated !=
                                                          "This Month") ||
                                                  (pdonated == "Yes" &&
                                                      wdonated !=
                                                          "Last Month") ||
                                                  (pdonated == "Yes" &&
                                                      wdonated !=
                                                          "Last 3 Month" &&
                                                      gender == "Female")) &&
                                              ((gender == "Female" &&
                                                      pregnant == "No") ||
                                                  (gender == "Male" &&
                                                      pregnant
                                                          .toString()
                                                          .isEmpty)) &&
                                              ((gender == "Female" &&
                                                      mens == "No") ||
                                                  (gender == "Male" &&
                                                      mens.toString().isEmpty)))
                                          ? Column(
                                              children: [
                                                Image.asset(
                                                    "assets/images/blood-donation.gif",
                                                    height: 100,
                                                    width: 100),
                                                10.verticalSpace,
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      color: kPrimaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0)),
                                                  child: Text(
                                                    'Eligible',
                                                    style: TextStyle(
                                                        fontSize: 14.spMax,
                                                        color: kWhiteColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                5.verticalSpace,
                                                Text(
                                                    "Congratulations! Based on your response,\nyou're to donate blood.\nYou're a potential lifesaver!\n\nSchedule your blood donation and make a real difference",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        overflow:
                                                            TextOverflow.clip,
                                                        fontSize: 13.spMax,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black)),
                                                10.verticalSpace,
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: TextButton(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            'Schedule Blood Donation',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontSize:
                                                                  13.spMax,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  kPrimaryColor,
                                                            )),
                                                      ],
                                                    ),
                                                    style: TextButton.styleFrom(
                                                      foregroundColor:
                                                          Colors.white,
                                                      backgroundColor:
                                                          Colors.teal.shade50,
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                    ),
                                                    onPressed: () {
                                                      showModalBottomSheet(
                                                          backgroundColor:
                                                              Color(0xFFe0e9e4),
                                                          context: context,
                                                          builder: (context) {
                                                            return StatefulBuilder(
                                                                builder: (context,
                                                                    setState) {
                                                              return SingleChildScrollView(
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets.only(
                                                                      bottom: MediaQuery.of(
                                                                              context)
                                                                          .viewInsets
                                                                          .bottom),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            20.0,
                                                                            20.0,
                                                                            20.0,
                                                                            0.0), // content padding
                                                                    child: Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                                              children: [
                                                                                Text(' Close', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 13.sp, color: Colors.red)),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5.h,
                                                                          ),
                                                                          Text(
                                                                              'Register your Interest',
                                                                              style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                          SizedBox(
                                                                            height:
                                                                                10.h,
                                                                          ),
                                                                          Text(
                                                                              'Fill out the details below and someone \nfrom our team will get in touch.',
                                                                              style: GoogleFonts.montserrat(fontSize: 13.sp, color: Color(0xff406986))),
                                                                          SizedBox(
                                                                            height:
                                                                                10.h,
                                                                          ),
                                                                          FormBuilder(
                                                                            key:
                                                                                _formKey,
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                CustomFormTextField(
                                                                                  name: 'Name',
                                                                                  hinttext: 'Name',
                                                                                  controller: name,
                                                                                ),
                                                                                10.verticalSpace,
                                                                                TextFormField(
                                                                                  validator: (value) {
                                                                                    if (value!.isEmpty) {
                                                                                      return 'Date of Birth is required';
                                                                                    }
                                                                                    return null;
                                                                                  },
                                                                                  style: TextStyle(fontSize: 14, letterSpacing: 0, fontFamily: 'Montserrat'),
                                                                                  controller: dobdateinput, //editing controller of this TextField
                                                                                  decoration: InputDecoration(
                                                                                      border: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(5),
                                                                                      ),
                                                                                      isDense: false,
                                                                                      contentPadding: EdgeInsets.all(10),
                                                                                      labelStyle: TextStyle(fontSize: 14, fontFamily: 'Montserrat', letterSpacing: 0),
                                                                                      // icon: Icon(Icons.calendar_today), //icon of text field
                                                                                      labelText: "Date of Birth" //label text of field
                                                                                      ),

                                                                                  readOnly: true, //set it true, so that user will not able to edit text
                                                                                  onTap: () async {
                                                                                    DateTime? pickedDate = await showDatePicker(
                                                                                        context: context,
                                                                                        initialDate: DateTime.now(),
                                                                                        firstDate: DateTime(1900), //DateTime.now() - not to allow to choose before today.
                                                                                        lastDate: DateTime.now());

                                                                                    if (pickedDate != null) {
                                                                                      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                                                      String formattedDate = DateFormat('d MMM yyyy').format(pickedDate);
                                                                                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                                                                      //you can implement different kind of Date Format here according to your requirement
                                                                                      setState(() {
                                                                                        selectedYear = pickedDate.year;
                                                                                        selectedDay = pickedDate.day;
                                                                                        selectedMonth = pickedDate.month;
                                                                                        dateInput.text = DateFormat('d MMM yyyy').format(pickedDate);
                                                                                        calculateAge();
                                                                                      });
                                                                                      setState(() {
                                                                                        dobdateinput.text = formattedDate; //set output date to TextField value.
                                                                                      });
                                                                                    } else {
                                                                                      print("Date is not selected");
                                                                                    }
                                                                                  },
                                                                                ),
                                                                                10.verticalSpace,
                                                                                CustomFormTextField(
                                                                                  name: 'Phone Number',
                                                                                  hinttext: 'Enter Phone Number',
                                                                                  prefix: '+232',
                                                                                  controller: phonenumber,
                                                                                ),
                                                                                10.verticalSpace,
                                                                                CustomFormTextField(
                                                                                  name: 'Email',
                                                                                  hinttext: 'Enter Email',
                                                                                  controller: phonenumber,
                                                                                ),
                                                                                10.verticalSpace,
                                                                                SizedBox(
                                                                                  width: double.infinity,
                                                                                  child: ElevatedButton(
                                                                                      child: Text('Submit Interest', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 13.sp, color: Colors.white)),
                                                                                      style: TextButton.styleFrom(
                                                                                        foregroundColor: Colors.white,
                                                                                        backgroundColor: Color(0xff389e9d),
                                                                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                      ),
                                                                                      onPressed: () async {
                                                                                        if (_formKey.currentState!.validate()) {
                                                                                          if (await getInternetUsingInternetConnectivity()) {
                                                                                            Navigator.pop(context);
                                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                                              SnackBar(
                                                                                                  backgroundColor: Colors.teal,
                                                                                                  content: SingleChildScrollView(
                                                                                                      child: Container(
                                                                                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 0.0),
                                                                                                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                                        SizedBox(
                                                                                                          height: 15.0,
                                                                                                          width: 15.0,
                                                                                                          child: CircularProgressIndicator(
                                                                                                            color: Colors.white,
                                                                                                            strokeWidth: 2.0,
                                                                                                          ),
                                                                                                        ),
                                                                                                        SizedBox(
                                                                                                          height: 5.h,
                                                                                                        ),
                                                                                                        Text.rich(
                                                                                                          TextSpan(
                                                                                                            style: TextStyle(color: Color(0xff329d9c), fontSize: 15.sp),
                                                                                                            children: [
                                                                                                              TextSpan(
                                                                                                                text: 'Registering your Interest',
                                                                                                                style: GoogleFonts.montserrat(
                                                                                                                  fontSize: 14.sp,
                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                  color: Colors.white,
                                                                                                                ),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                          textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                                          textAlign: TextAlign.left,
                                                                                                        ),
                                                                                                        SizedBox(
                                                                                                          height: 5.h,
                                                                                                        ),
                                                                                                      ]),
                                                                                                    ),
                                                                                                  ))),
                                                                                            );
                                                                                            Future.delayed(Duration(seconds: 3), () async {
                                                                                              registerinterest();
                                                                                            });
                                                                                          }
                                                                                        }
                                                                                      }),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ]),
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                          });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                Image.asset(
                                                    "assets/images/sad.gif",
                                                    height: 100,
                                                    width: 100),
                                                10.verticalSpace,
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      color: kLifeBloodRed,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0)),
                                                  child: Text(
                                                    'Not Eligible',
                                                    style: TextStyle(
                                                        fontSize: 14.spMax,
                                                        color: kWhiteColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                5.verticalSpace,
                                                Text(
                                                    "Thanks for your willingness to help! While your answers indicate you might not be eligible to donate blood at this time, there are still many ways to be a hero.\n\nSpread the word!\nTalk to friends and family about the importance of blood donation.\n\nBe a champion!\nEncourage everyone who\nqualifies to donate.",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        overflow:
                                                            TextOverflow.clip,
                                                        fontSize: 13.spMax,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black)),
                                                10.verticalSpace,
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: TextButton(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            'Support LifeBlood Operations',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontSize:
                                                                  13.spMax,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  kLifeBloodRed,
                                                            )),
                                                      ],
                                                    ),
                                                    style: TextButton.styleFrom(
                                                      foregroundColor:
                                                          Colors.white,
                                                      backgroundColor:
                                                          Colors.red.shade50,
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                    ),
                                                    onPressed: () {
                                                      showModalBottomSheet(
                                                          backgroundColor:
                                                              Color(0xFFe0e9e4),
                                                          context: context,
                                                          builder: (context) {
                                                            return StatefulBuilder(
                                                                builder: (context,
                                                                    setState) {
                                                              return SingleChildScrollView(
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets.only(
                                                                      bottom: MediaQuery.of(
                                                                              context)
                                                                          .viewInsets
                                                                          .bottom),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            20.0,
                                                                            20.0,
                                                                            20.0,
                                                                            0.0), // content padding
                                                                    child: Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                                              children: [
                                                                                Text(' Close', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 13.sp, color: Colors.red)),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5.h,
                                                                          ),
                                                                          Text(
                                                                              'Register your Interest',
                                                                              style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                          SizedBox(
                                                                            height:
                                                                                10.h,
                                                                          ),
                                                                          Text(
                                                                              'Fill out the details below and someone \nfrom our team will get in touch.',
                                                                              style: GoogleFonts.montserrat(fontSize: 13.sp, color: Color(0xff406986))),
                                                                          SizedBox(
                                                                            height:
                                                                                10.h,
                                                                          ),
                                                                          FormBuilder(
                                                                            key:
                                                                                _formKey,
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                CustomFormTextField(
                                                                                  name: 'Name',
                                                                                  hinttext: 'Name',
                                                                                  controller: name,
                                                                                ),
                                                                                10.verticalSpace,
                                                                                TextFormField(
                                                                                  validator: (value) {
                                                                                    if (value!.isEmpty) {
                                                                                      return 'Date of Birth is required';
                                                                                    }
                                                                                    return null;
                                                                                  },
                                                                                  style: TextStyle(fontSize: 14, letterSpacing: 0, fontFamily: 'Montserrat'),
                                                                                  controller: dobdateinput, //editing controller of this TextField
                                                                                  decoration: InputDecoration(
                                                                                      border: OutlineInputBorder(
                                                                                        borderRadius: BorderRadius.circular(5),
                                                                                      ),
                                                                                      isDense: false,
                                                                                      contentPadding: EdgeInsets.all(10),
                                                                                      labelStyle: TextStyle(fontSize: 14, fontFamily: 'Montserrat', letterSpacing: 0),
                                                                                      // icon: Icon(Icons.calendar_today), //icon of text field
                                                                                      labelText: "Date of Birth" //label text of field
                                                                                      ),

                                                                                  readOnly: true, //set it true, so that user will not able to edit text
                                                                                  onTap: () async {
                                                                                    DateTime? pickedDate = await showDatePicker(
                                                                                        context: context,
                                                                                        initialDate: DateTime.now(),
                                                                                        firstDate: DateTime(1900), //DateTime.now() - not to allow to choose before today.
                                                                                        lastDate: DateTime.now());

                                                                                    if (pickedDate != null) {
                                                                                      print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                                                      String formattedDate = DateFormat('d MMM yyyy').format(pickedDate);
                                                                                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                                                                      //you can implement different kind of Date Format here according to your requirement
                                                                                      setState(() {
                                                                                        selectedYear = pickedDate.year;
                                                                                        selectedDay = pickedDate.day;
                                                                                        selectedMonth = pickedDate.month;
                                                                                        dateInput.text = DateFormat('d MMM yyyy').format(pickedDate);
                                                                                        calculateAge();
                                                                                      });
                                                                                      setState(() {
                                                                                        dobdateinput.text = formattedDate; //set output date to TextField value.
                                                                                      });
                                                                                    } else {
                                                                                      print("Date is not selected");
                                                                                    }
                                                                                  },
                                                                                ),
                                                                                10.verticalSpace,
                                                                                CustomFormTextField(
                                                                                  name: 'Phone Number',
                                                                                  hinttext: 'Enter Phone Number',
                                                                                  prefix: '+232',
                                                                                  controller: phonenumber,
                                                                                ),
                                                                                10.verticalSpace,
                                                                                CustomFormTextField(
                                                                                  name: 'Email',
                                                                                  hinttext: 'Enter Email',
                                                                                  controller: phonenumber,
                                                                                ),
                                                                                10.verticalSpace,
                                                                                SizedBox(
                                                                                  width: double.infinity,
                                                                                  child: ElevatedButton(
                                                                                      child: Text('Submit Interest', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 13.sp, color: Colors.white)),
                                                                                      style: TextButton.styleFrom(
                                                                                        foregroundColor: Colors.white,
                                                                                        backgroundColor: Color(0xff389e9d),
                                                                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                      ),
                                                                                      onPressed: () async {
                                                                                        if (_formKey.currentState!.validate()) {
                                                                                          if (await getInternetUsingInternetConnectivity()) {
                                                                                            Navigator.pop(context);
                                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                                              SnackBar(
                                                                                                  backgroundColor: Colors.teal,
                                                                                                  content: SingleChildScrollView(
                                                                                                      child: Container(
                                                                                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 0.0),
                                                                                                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                                        SizedBox(
                                                                                                          height: 15.0,
                                                                                                          width: 15.0,
                                                                                                          child: CircularProgressIndicator(
                                                                                                            color: Colors.white,
                                                                                                            strokeWidth: 2.0,
                                                                                                          ),
                                                                                                        ),
                                                                                                        SizedBox(
                                                                                                          height: 5.h,
                                                                                                        ),
                                                                                                        Text.rich(
                                                                                                          TextSpan(
                                                                                                            style: TextStyle(color: Color(0xff329d9c), fontSize: 15.sp),
                                                                                                            children: [
                                                                                                              TextSpan(
                                                                                                                text: 'Registering your Interest',
                                                                                                                style: GoogleFonts.montserrat(
                                                                                                                  fontSize: 14.sp,
                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                  color: Colors.white,
                                                                                                                ),
                                                                                                              ),
                                                                                                            ],
                                                                                                          ),
                                                                                                          textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                                          textAlign: TextAlign.left,
                                                                                                        ),
                                                                                                        SizedBox(
                                                                                                          height: 5.h,
                                                                                                        ),
                                                                                                      ]),
                                                                                                    ),
                                                                                                  ))),
                                                                                            );
                                                                                            Future.delayed(Duration(seconds: 3), () async {
                                                                                              registerinterest();
                                                                                            });
                                                                                          }
                                                                                        }
                                                                                      }),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ]),
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                          });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    // color: Colors.teal[50],
                                    borderRadius: BorderRadius.only(
                                        // topLeft: Radius.circular(10),
                                        // topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 0, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Text('Intro',
                                      //     textAlign: TextAlign.left,
                                      //     style: GoogleFonts.montserrat(
                                      //         fontSize: 15,
                                      //         fontWeight: FontWeight.bold,
                                      //         color: Colors.teal)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )

                      // 10.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),

            //first question
            Padding(
              padding: const EdgeInsets.only(
                  right: 15, left: 15, top: 0, bottom: 10),
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            q1 = !q1;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.zero,
                                  bottomRight: Radius.zero)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Question 1',
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.spMax,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0,
                                ),
                              ),
                              Icon(
                                q1 ? Icons.expand_less : Icons.expand_more,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      q1
                          ? Expanded(
                              // Use Expanded to allow the SingleChildScrollView to take remaining space
                              child: SingleChildScrollView(
                                // Wrap your content with SingleChildScrollView
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      color: Colors.teal[50],
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            // Text('Intro',
                                            //     textAlign: TextAlign.left,
                                            //     style: GoogleFonts.montserrat(
                                            //         fontSize: 15,
                                            //         fontWeight: FontWeight.bold,
                                            //         color: Colors.teal)),

                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Text('Gender',
                                                        overflow: TextOverflow
                                                            .clip,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize:
                                                                    13.spMax,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .teal))),
                                              ],
                                            ),
                                            10.verticalSpace,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Response',
                                                        textAlign: TextAlign
                                                            .left,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize:
                                                                    13.spMax,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    kPrimaryColor)),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 0,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          color: kIconBcgColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(0)),
                                                      child: Text(
                                                        '$gender',
                                                        style: TextStyle(
                                                            fontSize: 13.spMax,
                                                            color:
                                                                kPrimaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.teal[50],
                                          // color: Colors.teal[50],
                                          borderRadius: BorderRadius.only(
                                              // topLeft: Radius.circular(10),
                                              // topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight:
                                                  Radius.circular(10))),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 0,
                                            bottom: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            // Text('Intro',
                                            //     textAlign: TextAlign.left,
                                            //     style: GoogleFonts.montserrat(
                                            //         fontSize: 15,
                                            //         fontWeight: FontWeight.bold,
                                            //         color: Colors.teal)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                      // 10.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
            //second question
            Padding(
              padding: const EdgeInsets.only(
                  right: 15, left: 15, top: 0, bottom: 10),
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            q2 = !q2;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: agecategory == "<18"
                                  ? kLifeBloodRed
                                  : agecategory == "65+"
                                      ? kLifeBloodRed
                                      : kPrimaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.zero,
                                  bottomRight: Radius.zero)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Question 2',
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.spMax,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0,
                                ),
                              ),
                              Icon(
                                q2 ? Icons.expand_less : Icons.expand_more,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      q2
                          ? Expanded(
                              // Use Expanded to allow the SingleChildScrollView to take remaining space
                              child: SingleChildScrollView(
                                // Wrap your content with SingleChildScrollView
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      color: agecategory == "<18"
                                          ? Colors.red.shade50
                                          : agecategory == "65+"
                                              ? Colors.red.shade50
                                              : Colors.teal.shade50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            // Text('Intro',
                                            //     textAlign: TextAlign.left,
                                            //     style: GoogleFonts.montserrat(
                                            //         fontSize: 15,
                                            //         fontWeight: FontWeight.bold,
                                            //         color: Colors.teal)),

                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Text('Age Category',
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize:
                                                                    13.spMax,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: agecategory ==
                                                                        "<18"
                                                                    ? kLifeBloodRed
                                                                    : agecategory ==
                                                                            "65+"
                                                                        ? kLifeBloodRed
                                                                        : kPrimaryColor))),
                                              ],
                                            ),
                                            10.verticalSpace,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Response',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize:
                                                                    13.spMax,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: agecategory ==
                                                                        "<18"
                                                                    ? kLifeBloodRed
                                                                    : agecategory ==
                                                                            "65+"
                                                                        ? kLifeBloodRed
                                                                        : kPrimaryColor)),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 0,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          color: kIconBcgColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(0)),
                                                      child: Text(
                                                        '$agecategory',
                                                        style: TextStyle(
                                                            fontSize: 13.spMax,
                                                            color: agecategory ==
                                                                    "<18"
                                                                ? kLifeBloodRed
                                                                : agecategory ==
                                                                        "65+"
                                                                    ? kLifeBloodRed
                                                                    : kPrimaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    5.horizontalSpace,
                                                    agecategory == "<18"
                                                        ? Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kLifeBloodRed,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                            child: Text(
                                                              'Not Eligible',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color:
                                                                      kWhiteColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        : agecategory == "65+"
                                                            ? Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            0,
                                                                        horizontal:
                                                                            10),
                                                                decoration: BoxDecoration(
                                                                    color:
                                                                        kLifeBloodRed,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            0)),
                                                                child: Text(
                                                                  'Not Eligible',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color:
                                                                          kWhiteColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              )
                                                            : Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            0,
                                                                        horizontal:
                                                                            10),
                                                                decoration: BoxDecoration(
                                                                    color:
                                                                        kPrimaryColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            0)),
                                                                child: Text(
                                                                  'Eligible',
                                                                  style: TextStyle(
                                                                      fontSize: 13
                                                                          .spMax,
                                                                      color:
                                                                          kWhiteColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
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
                                    agecategory == "<18"
                                        ? Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                color: kWhiteColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Reason',
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "While wanting to help is great, people under 18 typically can't donate blood. This protects their still-developing bodies and ensures informed consent.  Minimum age limits blood volume and iron levels to safeguard donor health. You can still be a hero by promoting blood donation!",
                                                                  style: TextStyle(
                                                                      fontSize: 12.spMax,
                                                                      fontFamily: 'Montserrat',
                                                                      overflow: TextOverflow.clip,
                                                                      fontWeight: FontWeight.normal,
                                                                      color: agecategory == "<18"
                                                                          ? kLifeBloodRed
                                                                          : agecategory == ">64"
                                                                              ? kLifeBloodRed
                                                                              : kPrimaryColor))),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 0),
                                                child: Divider(
                                                  thickness: 0.20,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                color: kWhiteColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Suggestion',
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "While donating blood is an awesome way to help others, you'll need to wait until you turn 18.\nRegister below and we'll contact you to book a donation after your 18th birthday. ",
                                                                  style: TextStyle(
                                                                      fontSize: 12.spMax,
                                                                      fontFamily: 'Montserrat',
                                                                      overflow: TextOverflow.clip,
                                                                      fontWeight: FontWeight.normal,
                                                                      color: agecategory == "<18"
                                                                          ? kLifeBloodRed
                                                                          : agecategory == ">64"
                                                                              ? kLifeBloodRed
                                                                              : kPrimaryColor))),
                                                        ],
                                                      ),
                                                      10.verticalSpace,
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: TextButton(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                  'Register Your Interest',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts
                                                                      .montserrat(
                                                                    fontSize:
                                                                        13.sp,
                                                                    letterSpacing:
                                                                        0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color:
                                                                        kLifeBloodRed,
                                                                  )),
                                                            ],
                                                          ),
                                                          style: TextButton
                                                              .styleFrom(
                                                            foregroundColor:
                                                                Colors.white,
                                                            backgroundColor: agecategory ==
                                                                    "<18"
                                                                ? Colors
                                                                    .red.shade50
                                                                : agecategory ==
                                                                        "65+"
                                                                    ? Colors.red
                                                                        .shade50
                                                                    : Colors
                                                                        .teal
                                                                        .shade50,
                                                            shape: const RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                          ),
                                                          onPressed: () {
                                                            showModalBottomSheet(
                                                                backgroundColor:
                                                                    Color(
                                                                        0xFFe0e9e4),
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return StatefulBuilder(
                                                                      builder:
                                                                          (context,
                                                                              setState) {
                                                                    return SingleChildScrollView(
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsets.fromLTRB(
                                                                              20.0,
                                                                              20.0,
                                                                              20.0,
                                                                              0.0), // content padding
                                                                          child: Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                                                    children: [
                                                                                      Text(' Close', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 13.sp, color: Colors.red)),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 5.h,
                                                                                ),
                                                                                Text('Register your Interest', style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                SizedBox(
                                                                                  height: 10.h,
                                                                                ),
                                                                                Text('Fill out the details below and someone \nfrom our team will get in touch.', style: GoogleFonts.montserrat(fontSize: 13.sp, color: Color(0xff406986))),
                                                                                SizedBox(
                                                                                  height: 10.h,
                                                                                ),
                                                                                FormBuilder(
                                                                                  key: _formKey,
                                                                                  child: Column(
                                                                                    children: [
                                                                                      CustomFormTextField(
                                                                                        name: 'Name',
                                                                                        hinttext: 'Name',
                                                                                        controller: name,
                                                                                      ),
                                                                                      10.verticalSpace,
                                                                                      TextFormField(
                                                                                        validator: (value) {
                                                                                          if (value!.isEmpty) {
                                                                                            return 'Date of Birth is required';
                                                                                          }
                                                                                          return null;
                                                                                        },
                                                                                        style: TextStyle(fontSize: 14, letterSpacing: 0, fontFamily: 'Montserrat'),
                                                                                        controller: dobdateinput, //editing controller of this TextField
                                                                                        decoration: InputDecoration(
                                                                                            border: OutlineInputBorder(
                                                                                              borderRadius: BorderRadius.circular(5),
                                                                                            ),
                                                                                            isDense: false,
                                                                                            contentPadding: EdgeInsets.all(10),
                                                                                            labelStyle: TextStyle(fontSize: 14, fontFamily: 'Montserrat', letterSpacing: 0),
                                                                                            // icon: Icon(Icons.calendar_today), //icon of text field
                                                                                            labelText: "Date of Birth" //label text of field
                                                                                            ),

                                                                                        readOnly: true, //set it true, so that user will not able to edit text
                                                                                        onTap: () async {
                                                                                          DateTime? pickedDate = await showDatePicker(
                                                                                              context: context,
                                                                                              initialDate: DateTime.now(),
                                                                                              firstDate: DateTime(1900), //DateTime.now() - not to allow to choose before today.
                                                                                              lastDate: DateTime.now());

                                                                                          if (pickedDate != null) {
                                                                                            print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                                                            String formattedDate = DateFormat('d MMM yyyy').format(pickedDate);
                                                                                            print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                                                                            //you can implement different kind of Date Format here according to your requirement
                                                                                            setState(() {
                                                                                              selectedYear = pickedDate.year;
                                                                                              selectedDay = pickedDate.day;
                                                                                              selectedMonth = pickedDate.month;
                                                                                              dateInput.text = DateFormat('d MMM yyyy').format(pickedDate);
                                                                                              calculateAge();
                                                                                            });
                                                                                            setState(() {
                                                                                              dobdateinput.text = formattedDate; //set output date to TextField value.
                                                                                            });
                                                                                          } else {
                                                                                            print("Date is not selected");
                                                                                          }
                                                                                        },
                                                                                      ),
                                                                                      10.verticalSpace,
                                                                                      CustomFormTextField(
                                                                                        name: 'Phone Number',
                                                                                        hinttext: 'Enter Phone Number',
                                                                                        prefix: '+232',
                                                                                        controller: phonenumber,
                                                                                      ),
                                                                                      10.verticalSpace,
                                                                                      CustomFormTextField(
                                                                                        name: 'Email',
                                                                                        hinttext: 'Enter Email',
                                                                                        controller: phonenumber,
                                                                                      ),
                                                                                      10.verticalSpace,
                                                                                      SizedBox(
                                                                                        width: double.infinity,
                                                                                        child: ElevatedButton(
                                                                                            child: Text('Submit Interest', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 13.sp, color: Colors.white)),
                                                                                            style: TextButton.styleFrom(
                                                                                              foregroundColor: Colors.white,
                                                                                              backgroundColor: Color(0xff389e9d),
                                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                            ),
                                                                                            onPressed: () async {
                                                                                              if (_formKey.currentState!.validate()) {
                                                                                                if (await getInternetUsingInternetConnectivity()) {
                                                                                                  Navigator.pop(context);
                                                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                                                    SnackBar(
                                                                                                        backgroundColor: Colors.teal,
                                                                                                        content: SingleChildScrollView(
                                                                                                            child: Container(
                                                                                                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 0.0),
                                                                                                            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                                                              SizedBox(
                                                                                                                height: 15.0,
                                                                                                                width: 15.0,
                                                                                                                child: CircularProgressIndicator(
                                                                                                                  color: Colors.white,
                                                                                                                  strokeWidth: 2.0,
                                                                                                                ),
                                                                                                              ),
                                                                                                              SizedBox(
                                                                                                                height: 5.h,
                                                                                                              ),
                                                                                                              Text.rich(
                                                                                                                TextSpan(
                                                                                                                  style: TextStyle(color: Color(0xff329d9c), fontSize: 15.sp),
                                                                                                                  children: [
                                                                                                                    TextSpan(
                                                                                                                      text: 'Registering your Interest',
                                                                                                                      style: GoogleFonts.montserrat(
                                                                                                                        fontSize: 14.sp,
                                                                                                                        fontWeight: FontWeight.normal,
                                                                                                                        color: Colors.white,
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ],
                                                                                                                ),
                                                                                                                textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                                                textAlign: TextAlign.left,
                                                                                                              ),
                                                                                                              SizedBox(
                                                                                                                height: 5.h,
                                                                                                              ),
                                                                                                            ]),
                                                                                                          ),
                                                                                                        ))),
                                                                                                  );
                                                                                                  Future.delayed(Duration(seconds: 3), () async {
                                                                                                    registerinterest();
                                                                                                  });
                                                                                                }
                                                                                              }
                                                                                            }),
                                                                                      ),
                                                                                      SizedBox(height: 20.h),
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              ]),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  });
                                                                });
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : agecategory == "65+"
                                            ? Column(
                                                children: [
                                                  Container(
                                                    width: double.infinity,
                                                    color: kWhiteColor,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              left: 15,
                                                              right: 15),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text('Reason',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: GoogleFonts.montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        // color: Colors.teal[50],
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                // topLeft: Radius.circular(10),
                                                                // topRight: Radius.circular(10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10))),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15,
                                                              right: 15,
                                                              top: 5,
                                                              bottom: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          // Text('Intro',
                                                          //     textAlign: TextAlign.left,
                                                          //     style: GoogleFonts.montserrat(
                                                          //         fontSize: 15,
                                                          //         fontWeight: FontWeight.bold,
                                                          //         color: Colors.teal)),

                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                  child: Text(
                                                                      "As we age, our bodies become less efficient at producing new blood cells. Donating blood can take iron stores and put a slight strain on the body, so ensuring a healthy recovery is importan. You can still be a hero by promoting blood donation!",
                                                                      style: TextStyle(
                                                                          fontSize: 12.spMax,
                                                                          fontFamily: 'Montserrat',
                                                                          overflow: TextOverflow.clip,
                                                                          fontWeight: FontWeight.normal,
                                                                          color: agecategory == "<18"
                                                                              ? kLifeBloodRed
                                                                              : agecategory == "65+"
                                                                                  ? kLifeBloodRed
                                                                                  : kPrimaryColor))),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0, right: 0),
                                                    child: Divider(
                                                      thickness: 0.20,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    color: kWhiteColor,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 0,
                                                              left: 15,
                                                              right: 15),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text('Suggestion',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: GoogleFonts.montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        // color: Colors.teal[50],
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                // topLeft: Radius.circular(10),
                                                                // topRight: Radius.circular(10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10))),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15,
                                                              right: 15,
                                                              top: 5,
                                                              bottom: 15),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          // Text('Intro',
                                                          //     textAlign: TextAlign.left,
                                                          //     style: GoogleFonts.montserrat(
                                                          //         fontSize: 15,
                                                          //         fontWeight: FontWeight.bold,
                                                          //         color: Colors.teal)),

                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                  child: Text(
                                                                      "Talk to friends, family, and colleagues about the importance of blood donation, especially those who might be younger and a good fit for regular donations.",
                                                                      style: TextStyle(
                                                                          fontSize: 12.spMax,
                                                                          fontFamily: 'Montserrat',
                                                                          overflow: TextOverflow.clip,
                                                                          fontWeight: FontWeight.normal,
                                                                          color: agecategory == "<18"
                                                                              ? kLifeBloodRed
                                                                              : agecategory == "65+"
                                                                                  ? kLifeBloodRed
                                                                                  : kPrimaryColor))),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                children: [
                                                  Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        color: Colors.teal[50],
                                                        // color: Colors.teal[50],
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                // topLeft: Radius.circular(10),
                                                                // topRight: Radius.circular(10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10))),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15,
                                                              right: 15,
                                                              top: 0,
                                                              bottom: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          // Text('Intro',
                                                          //     textAlign: TextAlign.left,
                                                          //     style: GoogleFonts.montserrat(
                                                          //         fontSize: 15,
                                                          //         fontWeight: FontWeight.bold,
                                                          //         color: Colors.teal)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(),
                                                ],
                                              ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                      // 10.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
            //third question
            Padding(
              padding: const EdgeInsets.only(
                  right: 15, left: 15, top: 0, bottom: 10),
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            q3 = !q3;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: weight == "<50kg"
                                  ? kLifeBloodRed
                                  : kPrimaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.zero,
                                  bottomRight: Radius.zero)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Question 3',
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.spMax,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0,
                                ),
                              ),
                              Icon(
                                q3 ? Icons.expand_less : Icons.expand_more,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      q3
                          ? Expanded(
                              // Use Expanded to allow the SingleChildScrollView to take remaining space
                              child: SingleChildScrollView(
                                // Wrap your content with SingleChildScrollView
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      color: weight == "<50kg"
                                          ? Colors.red.shade50
                                          : Colors.teal.shade50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            // Text('Intro',
                                            //     textAlign: TextAlign.left,
                                            //     style: GoogleFonts.montserrat(
                                            //         fontSize: 15,
                                            //         fontWeight: FontWeight.bold,
                                            //         color: Colors.teal)),

                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Text('Weight',
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 13.spMax,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: weight ==
                                                                    "<50kg"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor))),
                                              ],
                                            ),
                                            10.verticalSpace,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Response',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 13.spMax,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: weight ==
                                                                    "<50kg"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor)),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 0,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          color: kIconBcgColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(0)),
                                                      child: Text(
                                                        '$weight',
                                                        style: TextStyle(
                                                            fontSize: 13.spMax,
                                                            color: weight ==
                                                                    "<50kg"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    5.horizontalSpace,
                                                    weight == "<50kg"
                                                        ? Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kLifeBloodRed,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                            child: Text(
                                                              'Not Eligible',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color:
                                                                      kWhiteColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        : Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kPrimaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                            child: Text(
                                                              'Eligible',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  color:
                                                                      kWhiteColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
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
                                    weight == "<50kg"
                                        ? Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                color: kWhiteColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Reason',
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "Have a weight less than 50kg. This ensures you have enough blood to donate safely. You can still be a hero by promoting blood donation!",
                                                                  style: TextStyle(
                                                                      fontSize: 12.spMax,
                                                                      fontFamily: 'Montserrat',
                                                                      overflow: TextOverflow.clip,
                                                                      fontWeight: FontWeight.normal,
                                                                      color: agecategory == "<18"
                                                                          ? kLifeBloodRed
                                                                          : agecategory == ">64"
                                                                              ? kLifeBloodRed
                                                                              : kPrimaryColor))),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 0),
                                                child: Divider(
                                                  thickness: 0.20,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                color: kWhiteColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Suggestion',
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "Keep up those healthy habits! By prioritizing your health, you'll be in a better position to donate blood in the future when your weight falls within the acceptable range",
                                                                  style: TextStyle(
                                                                      fontSize: 12.spMax,
                                                                      fontFamily: 'Montserrat',
                                                                      overflow: TextOverflow.clip,
                                                                      fontWeight: FontWeight.normal,
                                                                      color: agecategory == "<18"
                                                                          ? kLifeBloodRed
                                                                          : agecategory == ">64"
                                                                              ? kLifeBloodRed
                                                                              : kPrimaryColor))),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: Colors.teal[50],
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 0,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                      // 10.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
            //fourth question
            Padding(
              padding: const EdgeInsets.only(
                  right: 15, left: 15, top: 0, bottom: 10),
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            q4 = !q4;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color:
                                  cold == "Yes" ? kLifeBloodRed : kPrimaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.zero,
                                  bottomRight: Radius.zero)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Question 4',
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.spMax,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0,
                                ),
                              ),
                              Icon(
                                q4 ? Icons.expand_less : Icons.expand_more,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      q4
                          ? Expanded(
                              // Use Expanded to allow the SingleChildScrollView to take remaining space
                              child: SingleChildScrollView(
                                // Wrap your content with SingleChildScrollView
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      color: cold == "Yes"
                                          ? Colors.red.shade50
                                          : Colors.teal.shade50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            // Text('Intro',
                                            //     textAlign: TextAlign.left,
                                            //     style: GoogleFonts.montserrat(
                                            //         fontSize: 15,
                                            //         fontWeight: FontWeight.bold,
                                            //         color: Colors.teal)),

                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                        'Have you had a fever, cold, or flu in the past week?',
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 13.spMax,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: cold == "Yes"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor))),
                                              ],
                                            ),
                                            10.verticalSpace,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Response',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 13.spMax,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: cold == "Yes"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor)),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 0,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          color: kIconBcgColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(0)),
                                                      child: Text(
                                                        '$cold',
                                                        style: TextStyle(
                                                            fontSize: 13.spMax,
                                                            color: cold == "Yes"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    5.horizontalSpace,
                                                    cold == "Yes"
                                                        ? Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kLifeBloodRed,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                            child: Text(
                                                              'Not Eligible',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color:
                                                                      kWhiteColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        : Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kPrimaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                            child: Text(
                                                              'Eligible',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  color:
                                                                      kWhiteColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
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
                                    cold == "Yes"
                                        ? Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                color: kWhiteColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Reason',
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "Having had a fever, cold, or flu in the past week. You can still be a hero by promoting blood donation!",
                                                                  style: TextStyle(
                                                                      fontSize: 12
                                                                          .spMax,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color: cold ==
                                                                              "Yes"
                                                                          ? kLifeBloodRed
                                                                          : kPrimaryColor))),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 0),
                                                child: Divider(
                                                  thickness: 0.20,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                color: kWhiteColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Suggestion',
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "Wait until you are fully recovered from any minor illnesses like a cold or flu.",
                                                                  style: TextStyle(
                                                                      fontSize: 12
                                                                          .spMax,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color: cold ==
                                                                              "Yes"
                                                                          ? kLifeBloodRed
                                                                          : kPrimaryColor))),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: Colors.teal[50],
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 0,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                      // 10.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
            //firth question
            Padding(
              padding: const EdgeInsets.only(
                  right: 15, left: 15, top: 0, bottom: 10),
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            q5 = !q5;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: goodhealth == "No"
                                  ? kLifeBloodRed
                                  : kPrimaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.zero,
                                  bottomRight: Radius.zero)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Question 5',
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.spMax,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0,
                                ),
                              ),
                              Icon(
                                q5 ? Icons.expand_less : Icons.expand_more,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      q5
                          ? Expanded(
                              // Use Expanded to allow the SingleChildScrollView to take remaining space
                              child: SingleChildScrollView(
                                // Wrap your content with SingleChildScrollView
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      color: goodhealth == "No"
                                          ? Colors.red.shade50
                                          : Colors.teal.shade50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            // Text('Intro',
                                            //     textAlign: TextAlign.left,
                                            //     style: GoogleFonts.montserrat(
                                            //         fontSize: 15,
                                            //         fontWeight: FontWeight.bold,
                                            //         color: Colors.teal)),

                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                        'Are you feeling well and in good health today?',
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 13.spMax,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: goodhealth ==
                                                                    "No"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor))),
                                              ],
                                            ),
                                            10.verticalSpace,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Response',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 13.spMax,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: goodhealth ==
                                                                    "No"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor)),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 0,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          color: kIconBcgColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(0)),
                                                      child: Text(
                                                        '$goodhealth',
                                                        style: TextStyle(
                                                            fontSize: 13.spMax,
                                                            color: goodhealth ==
                                                                    "No"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    5.horizontalSpace,
                                                    goodhealth == "No"
                                                        ? Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kLifeBloodRed,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                            child: Text(
                                                              'Not Eligible',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color:
                                                                      kWhiteColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        : Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kPrimaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                            child: Text(
                                                              'Eligible',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  color:
                                                                      kWhiteColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
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
                                    goodhealth == "No"
                                        ? Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                color: kWhiteColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Reason',
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "Not feeling well or in good health. You can still be a hero by promoting blood donation!",
                                                                  style: TextStyle(
                                                                      fontSize: 12
                                                                          .spMax,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color: goodhealth ==
                                                                              "No"
                                                                          ? kLifeBloodRed
                                                                          : kPrimaryColor))),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 0),
                                                child: Divider(
                                                  thickness: 0.20,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                color: kWhiteColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Suggestion',
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "Ensure you are in good health and have no symptoms of illness.",
                                                                  style: TextStyle(
                                                                      fontSize: 12
                                                                          .spMax,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color: goodhealth ==
                                                                              "No"
                                                                          ? kLifeBloodRed
                                                                          : kPrimaryColor))),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: Colors.teal[50],
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 0,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                      // 10.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
            //sixth question
            Padding(
              padding: const EdgeInsets.only(
                  right: 15, left: 15, top: 0, bottom: 10),
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            q6 = !q6;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color:
                                  eaten == "No" ? kLifeBloodRed : kPrimaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.zero,
                                  bottomRight: Radius.zero)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Question 6',
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.spMax,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0,
                                ),
                              ),
                              Icon(
                                q3 ? Icons.expand_less : Icons.expand_more,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      q6
                          ? Expanded(
                              // Use Expanded to allow the SingleChildScrollView to take remaining space
                              child: SingleChildScrollView(
                                // Wrap your content with SingleChildScrollView
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      color: eaten == "No"
                                          ? Colors.red.shade50
                                          : Colors.teal.shade50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                        'Have you eaten in the last 6 hours?',
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 13.spMax,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: eaten == "No"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor))),
                                              ],
                                            ),
                                            10.verticalSpace,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Response',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 13.spMax,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: eaten == "No"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor)),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 0,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          color: kIconBcgColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(0)),
                                                      child: Text(
                                                        '$eaten',
                                                        style: TextStyle(
                                                            fontSize: 13.spMax,
                                                            color: eaten == "No"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    5.horizontalSpace,
                                                    eaten == "No"
                                                        ? Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kLifeBloodRed,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                            child: Text(
                                                              'Not Eligible',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color:
                                                                      kWhiteColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        : Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kPrimaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                            child: Text(
                                                              'Eligible',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  color:
                                                                      kWhiteColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
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
                                    eaten == "No"
                                        ? Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                color: kWhiteColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Reason',
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "Not having eaten in the last 6 hours. You can still be a hero by promoting blood donation!",
                                                                  style: TextStyle(
                                                                      fontSize: 12
                                                                          .spMax,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color:
                                                                          kLifeBloodRed))),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 0),
                                                child: Divider(
                                                  thickness: 0.20,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                color: kWhiteColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Suggestion',
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "Eat a healthy meal before donating blood.",
                                                                  style: TextStyle(
                                                                      fontSize: 12
                                                                          .spMax,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color:
                                                                          kLifeBloodRed))),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: Colors.teal[50],
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 0,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                      // 10.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
            //seventh question
            Padding(
              padding: const EdgeInsets.only(
                  right: 15, left: 15, top: 0, bottom: 10),
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            q7 = !q7;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: hospital == "Yes"
                                  ? kLifeBloodRed
                                  : kPrimaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.zero,
                                  bottomRight: Radius.zero)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Question 7',
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.spMax,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0,
                                ),
                              ),
                              Icon(
                                q3 ? Icons.expand_less : Icons.expand_more,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      q7
                          ? Expanded(
                              // Use Expanded to allow the SingleChildScrollView to take remaining space
                              child: SingleChildScrollView(
                                // Wrap your content with SingleChildScrollView
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      color: hospital == "Yes"
                                          ? Colors.red.shade50
                                          : Colors.teal.shade50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            // Text('Intro',
                                            //     textAlign: TextAlign.left,
                                            //     style: GoogleFonts.montserrat(
                                            //         fontSize: 15,
                                            //         fontWeight: FontWeight.bold,
                                            //         color: Colors.teal)),

                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                        'Have you recently been hospitalised or receieved blood transfusion ?',
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 13.spMax,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: hospital ==
                                                                    "Yes"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor))),
                                              ],
                                            ),
                                            10.verticalSpace,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Response',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 13.spMax,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: hospital ==
                                                                    "Yes"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor)),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 0,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          color: kIconBcgColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(0)),
                                                      child: Text(
                                                        '$hospital',
                                                        style: TextStyle(
                                                            fontSize: 13.spMax,
                                                            color: hospital ==
                                                                    "Yes"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    5.horizontalSpace,
                                                    hospital == "Yes"
                                                        ? Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kLifeBloodRed,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                            child: Text(
                                                              'Not Eligible',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color:
                                                                      kWhiteColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        : Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kPrimaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                            child: Text(
                                                              'Eligible',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  color:
                                                                      kWhiteColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
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
                                    hospital == "Yes"
                                        ? Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                color: kWhiteColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Reason',
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "Having received a blood transfusion or been hospitalised recently. You can still be a hero by promoting blood donation!",
                                                                  style: TextStyle(
                                                                      fontSize: 12
                                                                          .spMax,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color:
                                                                          kLifeBloodRed))),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 0),
                                                child: Divider(
                                                  thickness: 0.20,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                color: kWhiteColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Suggestion',
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "Follow the recommended deferral period post-transfusion or hospitalisation before attempting to donate blood.\n\nEnsure complete recovery and follow up with your healthcare provider for clearance.",
                                                                  style: TextStyle(
                                                                      fontSize: 12
                                                                          .spMax,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color:
                                                                          kLifeBloodRed))),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: Colors.teal[50],
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 0,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                      // 10.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
//eight question
            Padding(
              padding: const EdgeInsets.only(
                  right: 15, left: 15, top: 0, bottom: 10),
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            q8 = !q8;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: disease == "Yes"
                                  ? kLifeBloodRed
                                  : kPrimaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.zero,
                                  bottomRight: Radius.zero)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Question 8',
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.spMax,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0,
                                ),
                              ),
                              Icon(
                                q8 ? Icons.expand_less : Icons.expand_more,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      q8
                          ? Expanded(
                              // Use Expanded to allow the SingleChildScrollView to take remaining space
                              child: SingleChildScrollView(
                                // Wrap your content with SingleChildScrollView
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      color: disease == "Yes"
                                          ? Colors.red.shade50
                                          : Colors.teal.shade50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                        'Do you have any of the\nfollowing diseases\nLung diseases, kidney diseases, tuberculosis, thyroid disorder, asthma, swollen glands, persistent cough, epilepsy, rheumatic fever, cancer, anaemia, shingles, circulation problems, skin rashes, low/high blood pressure, dizziness, night sweats/fever, excessive epistaxis, sleeping sickness, abdominal diseases, hepatitis/jaundice, brucellosis, prolonged diarrhoea, sexually transmitted diseases, diabetes, sickle cell diseases ?',
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 13.spMax,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: disease ==
                                                                    "Yes"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor))),
                                              ],
                                            ),
                                            10.verticalSpace,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Response',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 13.spMax,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: disease ==
                                                                    "Yes"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor)),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 0,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          color: kIconBcgColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(0)),
                                                      child: Text(
                                                        '$disease',
                                                        style: TextStyle(
                                                            fontSize: 13.spMax,
                                                            color: disease ==
                                                                    "Yes"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    5.horizontalSpace,
                                                    disease == "Yes"
                                                        ? Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kLifeBloodRed,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                            child: Text(
                                                              'Not Eligible',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color:
                                                                      kWhiteColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        : Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kPrimaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                            child: Text(
                                                              'Eligible',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  color:
                                                                      kWhiteColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
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
                                    disease == "Yes"
                                        ? Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                color: kWhiteColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Reason',
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "Having lung diseases, kidney diseases, tuberculosis, thyroid disorder, asthma, swollen glands, persistent cough, epilepsy, rheumatic fever, cancer, anaemia, shingles, circulation problems, skin rashes, low/high blood pressure, dizziness, night sweats/fever, excessive epistaxis, sleeping sickness, abdominal diseases, hepatitis/jaundice, brucellosis, prolonged diarrhoea, sexually transmitted diseases, diabetes, sickle cell diseases. You can still be a hero by promoting blood donation!",
                                                                  style: TextStyle(
                                                                      fontSize: 12
                                                                          .spMax,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color:
                                                                          kLifeBloodRed))),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 0),
                                                child: Divider(
                                                  thickness: 0.20,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                color: kWhiteColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Suggestion',
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "Consult with your healthcare provider to manage and treat any chronic or acute medical conditions.\n\nRegularly monitor your health and follow prescribed treatments to achieve and maintain eligibility.",
                                                                  style: TextStyle(
                                                                      fontSize: 12
                                                                          .spMax,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color:
                                                                          kLifeBloodRed))),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: Colors.teal[50],
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 0,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                      // 10.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
            //ninth question
            Padding(
              padding: const EdgeInsets.only(
                  right: 15, left: 15, top: 0, bottom: 10),
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            q9 = !q9;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: medication == "Yes"
                                  ? kLifeBloodRed
                                  : kPrimaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.zero,
                                  bottomRight: Radius.zero)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Question 9',
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.spMax,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0,
                                ),
                              ),
                              Icon(
                                q9 ? Icons.expand_less : Icons.expand_more,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      q9
                          ? Expanded(
                              // Use Expanded to allow the SingleChildScrollView to take remaining space
                              child: SingleChildScrollView(
                                // Wrap your content with SingleChildScrollView
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      color: medication == "Yes"
                                          ? Colors.red.shade50
                                          : Colors.teal.shade50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            // Text('Intro',
                                            //     textAlign: TextAlign.left,
                                            //     style: GoogleFonts.montserrat(
                                            //         fontSize: 15,
                                            //         fontWeight: FontWeight.bold,
                                            //         color: Colors.teal)),

                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                        'Are you taking or have you recently taken any medication like aspirin, antibiotics, steroids, injections, or recent vaccination?',
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 13.spMax,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: medication ==
                                                                    "Yes"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor))),
                                              ],
                                            ),
                                            10.verticalSpace,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Response',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 13.spMax,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: medication ==
                                                                    "Yes"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor)),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 0,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          color: kIconBcgColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(0)),
                                                      child: Text(
                                                        '$medication',
                                                        style: TextStyle(
                                                            fontSize: 13.spMax,
                                                            color: medication ==
                                                                    "Yes"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    5.horizontalSpace,
                                                    medication == "Yes"
                                                        ? Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kLifeBloodRed,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                            child: Text(
                                                              'Not Eligible',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color:
                                                                      kWhiteColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        : Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kPrimaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                            child: Text(
                                                              'Eligible',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  color:
                                                                      kWhiteColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
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
                                    medication == "Yes"
                                        ? Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                color: kWhiteColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Reason',
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "Taking medications like aspirin, antibiotics, steroids, injections, or recent vaccinations. You can still be a hero by promoting blood donation!",
                                                                  style: TextStyle(
                                                                      fontSize: 12
                                                                          .spMax,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color:
                                                                          kLifeBloodRed))),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 0),
                                                child: Divider(
                                                  thickness: 0.20,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                color: kWhiteColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Suggestion',
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "Disclose all medications to the blood donation centre and follow their guidelines regarding deferral periods after taking certain medications.\n\nConsider timing your blood donation around medication schedules to ensure eligibility.",
                                                                  style: TextStyle(
                                                                      fontSize: 12
                                                                          .spMax,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color:
                                                                          kLifeBloodRed))),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: Colors.teal[50],
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 0,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                      // 10.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
            //tenth question
            Padding(
              padding: const EdgeInsets.only(
                  right: 15, left: 15, top: 0, bottom: 10),
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            q10 = !q10;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: surgical == "Yes"
                                  ? kLifeBloodRed
                                  : kPrimaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.zero,
                                  bottomRight: Radius.zero)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Question 10',
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.spMax,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0,
                                ),
                              ),
                              Icon(
                                q10 ? Icons.expand_less : Icons.expand_more,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      q10
                          ? Expanded(
                              // Use Expanded to allow the SingleChildScrollView to take remaining space
                              child: SingleChildScrollView(
                                // Wrap your content with SingleChildScrollView
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      color: surgical == "Yes"
                                          ? Colors.red.shade50
                                          : Colors.teal.shade50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            // Text('Intro',
                                            //     textAlign: TextAlign.left,
                                            //     style: GoogleFonts.montserrat(
                                            //         fontSize: 15,
                                            //         fontWeight: FontWeight.bold,
                                            //         color: Colors.teal)),

                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                        'Have you had any surgical operation recently?',
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 13.spMax,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: surgical ==
                                                                    "Yes"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor))),
                                              ],
                                            ),
                                            10.verticalSpace,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Response',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 13.spMax,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: surgical ==
                                                                    "Yes"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor)),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 0,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          color: kIconBcgColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(0)),
                                                      child: Text(
                                                        '$surgical',
                                                        style: TextStyle(
                                                            fontSize: 13.spMax,
                                                            color: surgical ==
                                                                    "Yes"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    5.horizontalSpace,
                                                    surgical == "Yes"
                                                        ? Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kLifeBloodRed,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                            child: Text(
                                                              'Not Eligible',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color:
                                                                      kWhiteColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        : Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kPrimaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                            child: Text(
                                                              'Eligible',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  color:
                                                                      kWhiteColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
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
                                    surgical == "Yes"
                                        ? Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                color: kWhiteColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Reason',
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "Having had major or minor operations recently.\n\nDonating blood after surgery is a no-go for two key reasons:\nLower blood volume: Surgery reduces blood, and donating on top of that can be risky.\nImpaired healing: Donating blood right after surgery strains your body and slows recovery.\n\nYou can still be a hero by promoting blood donation!",
                                                                  style: TextStyle(
                                                                      fontSize: 12
                                                                          .spMax,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color:
                                                                          kLifeBloodRed))),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 0),
                                                child: Divider(
                                                  thickness: 0.20,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                color: kWhiteColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Suggestion',
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "Donate blood after full recovery:\n\nMinor surgery: Less than a week after healing.\nMajor surgery: Wait 12 months for complete recovery.\nDental work: Check with doctor (usually 24 hours to 7 days).\n\nAlways consult your doctor for the exact waiting period after your specific surgery. ",
                                                                  style: TextStyle(
                                                                      fontSize: 12
                                                                          .spMax,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color:
                                                                          kLifeBloodRed))),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: Colors.teal[50],
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 0,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                      // 10.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
            //eleven question
            Padding(
              padding: const EdgeInsets.only(
                  right: 15, left: 15, top: 0, bottom: 10),
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            q11 = !q11;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: tattoo == "Yes"
                                  ? kLifeBloodRed
                                  : kPrimaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.zero,
                                  bottomRight: Radius.zero)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Question 11',
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.spMax,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0,
                                ),
                              ),
                              Icon(
                                q11 ? Icons.expand_less : Icons.expand_more,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      q11
                          ? Expanded(
                              // Use Expanded to allow the SingleChildScrollView to take remaining space
                              child: SingleChildScrollView(
                                // Wrap your content with SingleChildScrollView
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      color: tattoo == "Yes"
                                          ? Colors.red.shade50
                                          : Colors.teal.shade50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            // Text('Intro',
                                            //     textAlign: TextAlign.left,
                                            //     style: GoogleFonts.montserrat(
                                            //         fontSize: 15,
                                            //         fontWeight: FontWeight.bold,
                                            //         color: Colors.teal)),

                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                        'Have you had any tattoo or acupuncuture recently (In the last 4 month)?',
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 13.spMax,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: tattoo ==
                                                                    "Yes"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor))),
                                              ],
                                            ),
                                            10.verticalSpace,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Response',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 13.spMax,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: tattoo ==
                                                                    "Yes"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor)),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 0,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          color: kIconBcgColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(0)),
                                                      child: Text(
                                                        '$tattoo',
                                                        style: TextStyle(
                                                            fontSize: 13.spMax,
                                                            color: tattoo ==
                                                                    "Yes"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    5.horizontalSpace,
                                                    tattoo == "Yes"
                                                        ? Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kLifeBloodRed,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                            child: Text(
                                                              'Not Eligible',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color:
                                                                      kWhiteColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        : Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kPrimaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                            child: Text(
                                                              'Eligible',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  color:
                                                                      kWhiteColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
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
                                    tattoo == "Yes"
                                        ? Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                color: kWhiteColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Reason',
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "Having had a tattoo or acupuncture recently. You can still be a hero by promoting blood donation!",
                                                                  style: TextStyle(
                                                                      fontSize: 12
                                                                          .spMax,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color:
                                                                          kLifeBloodRed))),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 0),
                                                child: Divider(
                                                  thickness: 0.20,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                color: kWhiteColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Suggestion',
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "Wait for the deferral period post-tattoo or acupuncture (typically 4-12 months).",
                                                                  style: TextStyle(
                                                                      fontSize: 12
                                                                          .spMax,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color:
                                                                          kLifeBloodRed))),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: Colors.teal[50],
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 0,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                      // 10.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
            //twelveth question
            Padding(
              padding: const EdgeInsets.only(
                  right: 15, left: 15, top: 0, bottom: 10),
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            q12 = !q12;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: travel == "Yes"
                                  ? kLifeBloodRed
                                  : kPrimaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.zero,
                                  bottomRight: Radius.zero)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Question 12',
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.spMax,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0,
                                ),
                              ),
                              Icon(
                                q12 ? Icons.expand_less : Icons.expand_more,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      q12
                          ? Expanded(
                              // Use Expanded to allow the SingleChildScrollView to take remaining space
                              child: SingleChildScrollView(
                                // Wrap your content with SingleChildScrollView
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      color: travel == "Yes"
                                          ? Colors.red.shade50
                                          : Colors.teal.shade50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            // Text('Intro',
                                            //     textAlign: TextAlign.left,
                                            //     style: GoogleFonts.montserrat(
                                            //         fontSize: 15,
                                            //         fontWeight: FontWeight.bold,
                                            //         color: Colors.teal)),

                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                        'Any recent travel to endemic areas with high infectious disease\n(COVID-19, Ebola, Tuberculosis)\nor have you been in close contact with someone who has an infectious disease?',
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 13.spMax,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: travel ==
                                                                    "Yes"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor))),
                                              ],
                                            ),
                                            10.verticalSpace,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Response',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: GoogleFonts.montserrat(
                                                            fontSize: 13.spMax,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: travel ==
                                                                    "Yes"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor)),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 0,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          color: kIconBcgColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(0)),
                                                      child: Text(
                                                        '$travel',
                                                        style: TextStyle(
                                                            fontSize: 13.spMax,
                                                            color: travel ==
                                                                    "Yes"
                                                                ? kLifeBloodRed
                                                                : kPrimaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    5.horizontalSpace,
                                                    travel == "Yes"
                                                        ? Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kLifeBloodRed,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                            child: Text(
                                                              'Not Eligible',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color:
                                                                      kWhiteColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        : Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kPrimaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                            child: Text(
                                                              'Eligible',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  color:
                                                                      kWhiteColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
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
                                    travel == "Yes"
                                        ? Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                color: kWhiteColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Reason',
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "Recent travel to regions with high malaria risk or other infectious diseases. You can still be a hero by promoting blood donation!",
                                                                  style: TextStyle(
                                                                      fontSize: 12
                                                                          .spMax,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color:
                                                                          kLifeBloodRed))),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 0),
                                                child: Divider(
                                                  thickness: 0.20,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                color: kWhiteColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Suggestion',
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "Ensure you have not been exposed to any infectious diseases during travel before donating blood.",
                                                                  style: TextStyle(
                                                                      fontSize: 12
                                                                          .spMax,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color:
                                                                          kLifeBloodRed))),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: Colors.teal[50],
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 0,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                      // 10.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 15, left: 15, top: 0, bottom: 10),
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            q13 = !q13;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: (pdonated == "Yes" &&
                                      wdonated == "This Month")
                                  ? kLifeBloodRed
                                  : (pdonated == "Yes" &&
                                          wdonated == "Last Month")
                                      ? kLifeBloodRed
                                      : (pdonated == "Yes" &&
                                              wdonated == "Last 3 Month" &&
                                              gender == "Female")
                                          ? kLifeBloodRed
                                          : kPrimaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.zero,
                                  bottomRight: Radius.zero)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Question 13',
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.spMax,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0,
                                ),
                              ),
                              Icon(
                                q13 ? Icons.expand_less : Icons.expand_more,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      q13
                          ? Expanded(
                              // Use Expanded to allow the SingleChildScrollView to take remaining space
                              child: SingleChildScrollView(
                                // Wrap your content with SingleChildScrollView
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      color: (pdonated == "Yes" &&
                                              wdonated == "This Month")
                                          ? Colors.red.shade50
                                          : (pdonated == "Yes" &&
                                                  wdonated == "Last Month")
                                              ? Colors.red.shade50
                                              : (pdonated == "Yes" &&
                                                      wdonated ==
                                                          "Last 3 Month" &&
                                                      gender == "Female")
                                                  ? Colors.red.shade50
                                                  : Colors.teal.shade50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            // Text('Intro',
                                            //     textAlign: TextAlign.left,
                                            //     style: GoogleFonts.montserrat(
                                            //         fontSize: 15,
                                            //         fontWeight: FontWeight.bold,
                                            //         color: Colors.teal)),

                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                        'Have you donated blood recently?',
                                                        overflow:
                                                            TextOverflow.clip,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize:
                                                                    13.spMax,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: (pdonated ==
                                                                            "Yes" &&
                                                                        wdonated ==
                                                                            "This Month")
                                                                    ? kLifeBloodRed
                                                                    : (pdonated ==
                                                                                "Yes" &&
                                                                            wdonated ==
                                                                                "Last Month")
                                                                        ? kLifeBloodRed
                                                                        : (pdonated == "Yes" &&
                                                                                wdonated == "Last 3 Month" &&
                                                                                gender == "Female")
                                                                            ? kLifeBloodRed
                                                                            : kPrimaryColor))),
                                              ],
                                            ),
                                            10.verticalSpace,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text('Response',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize:
                                                                    13.spMax,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: (pdonated ==
                                                                            "Yes" &&
                                                                        wdonated ==
                                                                            "This Month")
                                                                    ? kLifeBloodRed
                                                                    : (pdonated ==
                                                                                "Yes" &&
                                                                            wdonated ==
                                                                                "Last Month")
                                                                        ? kLifeBloodRed
                                                                        : (pdonated == "Yes" &&
                                                                                wdonated == "Last 3 Month" &&
                                                                                gender == "Female")
                                                                            ? kLifeBloodRed
                                                                            : kPrimaryColor)),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 0,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          color: kIconBcgColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(0)),
                                                      child: Text(
                                                        '$pdonated' +
                                                            ' ' +
                                                            '$wdonated',
                                                        style: TextStyle(
                                                            fontSize: 13.spMax,
                                                            color: (pdonated ==
                                                                        "Yes" &&
                                                                    wdonated ==
                                                                        "This Month")
                                                                ? kLifeBloodRed
                                                                : (pdonated ==
                                                                            "Yes" &&
                                                                        wdonated ==
                                                                            "Last Month")
                                                                    ? kLifeBloodRed
                                                                    : (pdonated == "Yes" &&
                                                                            wdonated ==
                                                                                "Last 3 Month" &&
                                                                            gender ==
                                                                                "Female")
                                                                        ? kLifeBloodRed
                                                                        : kPrimaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    5.horizontalSpace,
                                                    (pdonated == "Yes" &&
                                                            wdonated ==
                                                                "Last 3 Month" &&
                                                            gender == "Female")
                                                        ? Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kLifeBloodRed,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                            child: Text(
                                                              'Not Eligible',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color:
                                                                      kWhiteColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        : (pdonated == "Yes" &&
                                                                wdonated ==
                                                                    "Last Month")
                                                            ? Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            0,
                                                                        horizontal:
                                                                            10),
                                                                decoration: BoxDecoration(
                                                                    color:
                                                                        kLifeBloodRed,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            0)),
                                                                child: Text(
                                                                  'Not Eligible',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13,
                                                                      color:
                                                                          kWhiteColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              )
                                                            : (pdonated ==
                                                                        "Yes" &&
                                                                    wdonated ==
                                                                        "This Month")
                                                                ? Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            0,
                                                                        horizontal:
                                                                            10),
                                                                    decoration: BoxDecoration(
                                                                        color:
                                                                            kLifeBloodRed,
                                                                        borderRadius:
                                                                            BorderRadius.circular(0)),
                                                                    child: Text(
                                                                      'Not Eligible',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              13,
                                                                          color:
                                                                              kWhiteColor,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  )
                                                                : Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            0,
                                                                        horizontal:
                                                                            10),
                                                                    decoration: BoxDecoration(
                                                                        color:
                                                                            kPrimaryColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(0)),
                                                                    child: Text(
                                                                      'Eligible',
                                                                      style: TextStyle(
                                                                          fontSize: 13
                                                                              .spMax,
                                                                          color:
                                                                              kWhiteColor,
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                                    (pdonated == "Yes" &&
                                            wdonated == "Last 3 Month" &&
                                            gender == "Female")
                                        ? Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                color: kWhiteColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Reason',
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "While wanting to help is great, people under 18 typically can't donate blood. This protects their still-developing bodies and ensures informed consent.  Minimum age limits blood volume and iron levels to safeguard donor health. You can still be a hero by promoting blood donation!",
                                                                  style: TextStyle(
                                                                      fontSize: 12
                                                                          .spMax,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color:
                                                                          kLifeBloodRed))),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 0),
                                                child: Divider(
                                                  thickness: 0.20,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                color: kWhiteColor,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0,
                                                          left: 15,
                                                          right: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text('Suggestion',
                                                          textAlign: TextAlign
                                                              .left,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    // color: Colors.teal[50],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            // topLeft: Radius.circular(10),
                                                            // topRight: Radius.circular(10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 15),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Text('Intro',
                                                      //     textAlign: TextAlign.left,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 15,
                                                      //         fontWeight: FontWeight.bold,
                                                      //         color: Colors.teal)),

                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "While donating blood is an awesome way to help others, you'll need to wait until you turn 18.\nRegister below and we'll contact you to book a donation after your 18th birthday. ",
                                                                  style: TextStyle(
                                                                      fontSize: 12
                                                                          .spMax,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color:
                                                                          kLifeBloodRed))),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : (pdonated == "Yes" &&
                                                wdonated == "This Month")
                                            ? Column(
                                                children: [
                                                  Container(
                                                    width: double.infinity,
                                                    color: kWhiteColor,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              left: 15,
                                                              right: 15),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text('Reason',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: GoogleFonts.montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        // color: Colors.teal[50],
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                // topLeft: Radius.circular(10),
                                                                // topRight: Radius.circular(10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10))),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15,
                                                              right: 15,
                                                              top: 5,
                                                              bottom: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          // Text('Intro',
                                                          //     textAlign: TextAlign.left,
                                                          //     style: GoogleFonts.montserrat(
                                                          //         fontSize: 15,
                                                          //         fontWeight: FontWeight.bold,
                                                          //         color: Colors.teal)),

                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                  child: Text(
                                                                      "While wanting to help is great, people under 18 typically can't donate blood. This protects their still-developing bodies and ensures informed consent.  Minimum age limits blood volume and iron levels to safeguard donor health. You can still be a hero by promoting blood donation!",
                                                                      style: TextStyle(
                                                                          fontSize: 12
                                                                              .spMax,
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          overflow: TextOverflow
                                                                              .clip,
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          color:
                                                                              kLifeBloodRed))),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0, right: 0),
                                                    child: Divider(
                                                      thickness: 0.20,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    color: kWhiteColor,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 0,
                                                              left: 15,
                                                              right: 15),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text('Suggestion',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: GoogleFonts.montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        // color: Colors.teal[50],
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                // topLeft: Radius.circular(10),
                                                                // topRight: Radius.circular(10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        10))),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15,
                                                              right: 15,
                                                              top: 5,
                                                              bottom: 15),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          // Text('Intro',
                                                          //     textAlign: TextAlign.left,
                                                          //     style: GoogleFonts.montserrat(
                                                          //         fontSize: 15,
                                                          //         fontWeight: FontWeight.bold,
                                                          //         color: Colors.teal)),

                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                  child: Text(
                                                                      "While donating blood is an awesome way to help others, you'll need to wait until you turn 18.\nRegister below and we'll contact you to book a donation after your 18th birthday. ",
                                                                      style: TextStyle(
                                                                          fontSize: 12
                                                                              .spMax,
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          overflow: TextOverflow
                                                                              .clip,
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          color:
                                                                              kLifeBloodRed))),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : (pdonated == "Yes" &&
                                                    wdonated == "Last Month")
                                                ? Column(
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        color: kWhiteColor,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 10,
                                                                  left: 15,
                                                                  right: 15),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text('Reason',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize: 13
                                                                          .spMax,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .black)),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                            // color: Colors.teal[50],
                                                            borderRadius: BorderRadius.only(
                                                                // topLeft: Radius.circular(10),
                                                                // topRight: Radius.circular(10),
                                                                bottomLeft: Radius.circular(10),
                                                                bottomRight: Radius.circular(10))),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 15,
                                                                  right: 15,
                                                                  top: 5,
                                                                  bottom: 10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              // Text('Intro',
                                                              //     textAlign: TextAlign.left,
                                                              //     style: GoogleFonts.montserrat(
                                                              //         fontSize: 15,
                                                              //         fontWeight: FontWeight.bold,
                                                              //         color: Colors.teal)),

                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                      child: Text(
                                                                          "While wanting to help is great, people under 18 typically can't donate blood. This protects their still-developing bodies and ensures informed consent.  Minimum age limits blood volume and iron levels to safeguard donor health. You can still be a hero by promoting blood donation!",
                                                                          style: TextStyle(
                                                                              fontSize: 12.spMax,
                                                                              fontFamily: 'Montserrat',
                                                                              overflow: TextOverflow.clip,
                                                                              fontWeight: FontWeight.normal,
                                                                              color: kLifeBloodRed))),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 0,
                                                                right: 0),
                                                        child: Divider(
                                                          thickness: 0.20,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        color: kWhiteColor,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 0,
                                                                  left: 15,
                                                                  right: 15),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text('Suggestion',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize: 13
                                                                          .spMax,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .black)),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                            // color: Colors.teal[50],
                                                            borderRadius: BorderRadius.only(
                                                                // topLeft: Radius.circular(10),
                                                                // topRight: Radius.circular(10),
                                                                bottomLeft: Radius.circular(10),
                                                                bottomRight: Radius.circular(10))),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 15,
                                                                  right: 15,
                                                                  top: 5,
                                                                  bottom: 15),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              // Text('Intro',
                                                              //     textAlign: TextAlign.left,
                                                              //     style: GoogleFonts.montserrat(
                                                              //         fontSize: 15,
                                                              //         fontWeight: FontWeight.bold,
                                                              //         color: Colors.teal)),

                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                      child: Text(
                                                                          "While donating blood is an awesome way to help others, you'll need to wait until you turn 18.\nRegister below and we'll contact you to book a donation after your 18th birthday. ",
                                                                          style: TextStyle(
                                                                              fontSize: 12.spMax,
                                                                              fontFamily: 'Montserrat',
                                                                              overflow: TextOverflow.clip,
                                                                              fontWeight: FontWeight.normal,
                                                                              color: kLifeBloodRed))),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Column(
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                            color: Colors.teal[50],
                                                            // color: Colors.teal[50],
                                                            borderRadius: BorderRadius.only(
                                                                // topLeft: Radius.circular(10),
                                                                // topRight: Radius.circular(10),
                                                                bottomLeft: Radius.circular(10),
                                                                bottomRight: Radius.circular(10))),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 15,
                                                                  right: 15,
                                                                  top: 0,
                                                                  bottom: 10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              // Text('Intro',
                                                              //     textAlign: TextAlign.left,
                                                              //     style: GoogleFonts.montserrat(
                                                              //         fontSize: 15,
                                                              //         fontWeight: FontWeight.bold,
                                                              //         color: Colors.teal)),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(),
                                                    ],
                                                  ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),
                      // 10.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
            gender == "Female"
                ? Padding(
                    padding: const EdgeInsets.only(
                        right: 15, left: 15, top: 0, bottom: 10),
                    child: IntrinsicHeight(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  q14 = !q14;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: pregnant == "Yes"
                                        ? kLifeBloodRed
                                        : kPrimaryColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.zero,
                                        bottomRight: Radius.zero)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Question 14',
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.spMax,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                    Icon(
                                      q14
                                          ? Icons.expand_less
                                          : Icons.expand_more,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            q14
                                ? Expanded(
                                    // Use Expanded to allow the SingleChildScrollView to take remaining space
                                    child: SingleChildScrollView(
                                      // Wrap your content with SingleChildScrollView
                                      child: Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            color: pregnant == "Yes"
                                                ? Colors.red.shade50
                                                : Colors.teal.shade50,
                                            child: Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  // Text('Intro',
                                                  //     textAlign: TextAlign.left,
                                                  //     style: GoogleFonts.montserrat(
                                                  //         fontSize: 15,
                                                  //         fontWeight: FontWeight.bold,
                                                  //         color: Colors.teal)),

                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Text(
                                                              'Are you currently pregnant, breastfeeding or recently given birth in the past six months?',
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              style: GoogleFonts.montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: pregnant ==
                                                                          "Yes"
                                                                      ? kLifeBloodRed
                                                                      : kPrimaryColor))),
                                                    ],
                                                  ),
                                                  10.verticalSpace,
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text('Response',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: GoogleFonts.montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: pregnant ==
                                                                          "Yes"
                                                                      ? kLifeBloodRed
                                                                      : kPrimaryColor)),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kIconBcgColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                            child: Text(
                                                              '$weight',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  color: pregnant ==
                                                                          "Yes"
                                                                      ? kLifeBloodRed
                                                                      : kPrimaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          5.horizontalSpace,
                                                          pregnant == "Yes"
                                                              ? Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              0,
                                                                          horizontal:
                                                                              10),
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          kLifeBloodRed,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              0)),
                                                                  child: Text(
                                                                    'Not Eligible',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        color:
                                                                            kWhiteColor,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                )
                                                              : Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              0,
                                                                          horizontal:
                                                                              10),
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          kPrimaryColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              0)),
                                                                  child: Text(
                                                                    'Eligible',
                                                                    style: TextStyle(
                                                                        fontSize: 13
                                                                            .spMax,
                                                                        color:
                                                                            kWhiteColor,
                                                                        fontWeight:
                                                                            FontWeight.bold),
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
                                          pregnant == "Yes"
                                              ? Column(
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      color: kWhiteColor,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 10,
                                                                left: 15,
                                                                right: 15),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text('Reason',
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: GoogleFonts.montserrat(
                                                                    fontSize: 13
                                                                        .spMax,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          // color: Colors.teal[50],
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  // topLeft: Radius.circular(10),
                                                                  // topRight: Radius.circular(10),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 15,
                                                                right: 15,
                                                                top: 5,
                                                                bottom: 10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            // Text('Intro',
                                                            //     textAlign: TextAlign.left,
                                                            //     style: GoogleFonts.montserrat(
                                                            //         fontSize: 15,
                                                            //         fontWeight: FontWeight.bold,
                                                            //         color: Colors.teal)),

                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                    child: Text(
                                                                        "Being currently pregnant or breastfeeding and having given birth in the past six months.. You can still be a hero by promoting blood donation!",
                                                                        style: TextStyle(
                                                                            fontSize: 12
                                                                                .spMax,
                                                                            fontFamily:
                                                                                'Montserrat',
                                                                            overflow:
                                                                                TextOverflow.clip,
                                                                            fontWeight: FontWeight.normal,
                                                                            color: kLifeBloodRed))),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 0,
                                                              right: 0),
                                                      child: Divider(
                                                        thickness: 0.20,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      color: kWhiteColor,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 0,
                                                                left: 15,
                                                                right: 15),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text('Suggestion',
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: GoogleFonts.montserrat(
                                                                    fontSize: 13
                                                                        .spMax,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          // color: Colors.teal[50],
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  // topLeft: Radius.circular(10),
                                                                  // topRight: Radius.circular(10),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 15,
                                                                right: 15,
                                                                top: 5,
                                                                bottom: 15),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            // Text('Intro',
                                                            //     textAlign: TextAlign.left,
                                                            //     style: GoogleFonts.montserrat(
                                                            //         fontSize: 15,
                                                            //         fontWeight: FontWeight.bold,
                                                            //         color: Colors.teal)),

                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                    child: Text(
                                                                        "Wait until you are no longer pregnant or breastfeeding and have fully recovered from childbirth before donating blood. ",
                                                                        style: TextStyle(
                                                                            fontSize: 12
                                                                                .spMax,
                                                                            fontFamily:
                                                                                'Montserrat',
                                                                            overflow:
                                                                                TextOverflow.clip,
                                                                            fontWeight: FontWeight.normal,
                                                                            color: kLifeBloodRed))),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Column(
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.teal[50],
                                                          // color: Colors.teal[50],
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  // topLeft: Radius.circular(10),
                                                                  // topRight: Radius.circular(10),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 15,
                                                                right: 15,
                                                                top: 0,
                                                                bottom: 10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            // Text('Intro',
                                                            //     textAlign: TextAlign.left,
                                                            //     style: GoogleFonts.montserrat(
                                                            //         fontSize: 15,
                                                            //         fontWeight: FontWeight.bold,
                                                            //         color: Colors.teal)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(),
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            // 10.verticalSpace,
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(),

            gender == "Female"
                ? Padding(
                    padding: const EdgeInsets.only(
                        right: 15, left: 15, top: 0, bottom: 10),
                    child: IntrinsicHeight(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  q15 = !q15;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: mens == "Yes"
                                        ? kLifeBloodRed
                                        : kPrimaryColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.zero,
                                        bottomRight: Radius.zero)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Question 15',
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.spMax,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                    Icon(
                                      q15
                                          ? Icons.expand_less
                                          : Icons.expand_more,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            q15
                                ? Expanded(
                                    // Use Expanded to allow the SingleChildScrollView to take remaining space
                                    child: SingleChildScrollView(
                                      // Wrap your content with SingleChildScrollView
                                      child: Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            color: mens == "Yes"
                                                ? Colors.red.shade50
                                                : Colors.teal.shade50,
                                            child: Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Text(
                                                              'Are you on your menstrual period?',
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              style: GoogleFonts.montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color: mens ==
                                                                          "Yes"
                                                                      ? kLifeBloodRed
                                                                      : kPrimaryColor))),
                                                    ],
                                                  ),
                                                  10.verticalSpace,
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text('Response',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: GoogleFonts.montserrat(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: mens ==
                                                                          "Yes"
                                                                      ? kLifeBloodRed
                                                                      : kPrimaryColor)),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 0,
                                                                    horizontal:
                                                                        10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    kIconBcgColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                            child: Text(
                                                              '$mens',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.spMax,
                                                                  color: mens ==
                                                                          "Yes"
                                                                      ? kLifeBloodRed
                                                                      : kPrimaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          5.horizontalSpace,
                                                          mens == "Yes"
                                                              ? Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              0,
                                                                          horizontal:
                                                                              10),
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          kLifeBloodRed,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              0)),
                                                                  child: Text(
                                                                    'Not Eligible',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        color:
                                                                            kWhiteColor,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                )
                                                              : Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              0,
                                                                          horizontal:
                                                                              10),
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          kPrimaryColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              0)),
                                                                  child: Text(
                                                                    'Eligible',
                                                                    style: TextStyle(
                                                                        fontSize: 13
                                                                            .spMax,
                                                                        color:
                                                                            kWhiteColor,
                                                                        fontWeight:
                                                                            FontWeight.bold),
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
                                          mens == "Yes"
                                              ? Column(
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      color: kWhiteColor,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 10,
                                                                left: 15,
                                                                right: 15),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text('Reason',
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: GoogleFonts.montserrat(
                                                                    fontSize: 13
                                                                        .spMax,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          // color: Colors.teal[50],
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  // topLeft: Radius.circular(10),
                                                                  // topRight: Radius.circular(10),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 15,
                                                                right: 15,
                                                                top: 5,
                                                                bottom: 10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                    child: Text(
                                                                        "Being on your menstrual cycle. You can still be a hero by promoting blood donation!",
                                                                        style: TextStyle(
                                                                            fontSize: 12
                                                                                .spMax,
                                                                            fontFamily:
                                                                                'Montserrat',
                                                                            overflow:
                                                                                TextOverflow.clip,
                                                                            fontWeight: FontWeight.normal,
                                                                            color: kLifeBloodRed))),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 0,
                                                              right: 0),
                                                      child: Divider(
                                                        thickness: 0.20,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      color: kWhiteColor,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 0,
                                                                left: 15,
                                                                right: 15),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text('Suggestion',
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: GoogleFonts.montserrat(
                                                                    fontSize: 13
                                                                        .spMax,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          // color: Colors.teal[50],
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  // topLeft: Radius.circular(10),
                                                                  // topRight: Radius.circular(10),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 15,
                                                                right: 15,
                                                                top: 5,
                                                                bottom: 15),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                    child: Text(
                                                                        "Ensure you are not experiencing any menstrual-related health issues.",
                                                                        style: TextStyle(
                                                                            fontSize: 12
                                                                                .spMax,
                                                                            fontFamily:
                                                                                'Montserrat',
                                                                            overflow:
                                                                                TextOverflow.clip,
                                                                            fontWeight: FontWeight.normal,
                                                                            color: kLifeBloodRed))),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Column(
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Colors.teal[50],
                                                          // color: Colors.teal[50],
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  // topLeft: Radius.circular(10),
                                                                  // topRight: Radius.circular(10),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 15,
                                                                right: 15,
                                                                top: 0,
                                                                bottom: 10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(),
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            // 10.verticalSpace,
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.arrowLeft,
                            size: 15,
                            color: kWhiteColor,
                          ),
                          5.horizontalSpace,
                          Text('Go Home',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: 13.sp,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w400,
                                color: kWhiteColor,
                              )),
                        ],
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: kLifeBloodBlue,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false);
                      },
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.reply,
                            size: 15,
                            color: kPrimaryColor,
                          ),
                          5.horizontalSpace,
                          Text('Share Eligibility Analysis Data',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: 13.sp,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w400,
                                color: kPrimaryColor,
                              )),
                        ],
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.teal.shade100,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => HomePageScreen(
                                      pageIndex: 0,
                                    )),
                            (route) => false);
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('This will help improve our AI model ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12,
                              color: kGreyColor)),
                      Text('Hemoglobin',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: kGreyColor)),
                    ],
                  ),
                  10.verticalSpace,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => RequestDialogContent());
  }
}

class RequestDialogContent extends StatefulWidget {
  RequestDialogContent({
    super.key,
  });

  @override
  State<RequestDialogContent> createState() => _RequestDialogContentState();
}

class _RequestDialogContentState extends State<RequestDialogContent> {
  Timer? debouncer;
  String donationquery = '';

  @override
  final TextEditingController timeInput = TextEditingController();
  final TextEditingController _usernameCtrl = TextEditingController();

  final List<String> trivianameItems = [
    'Account Name',
    'Username',
  ];
  String? selectedrc = '';
  String? selectedrcsolved = '';
  String? selectedscsolved = '';
  String? selectedsc = '';
  String? selectedtrivianame = '';
  String? selectedSampleBrought = '';
  String? _selectedrcRadioGroupValue;
  final _formKey = GlobalKey<FormState>();
  bool _scheduling = false;

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  void _onChanged(dynamic val) => setState(() {
        // usercommunity = val;
        debugPrint(val.toString());
      });

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
        final servicetypeLower = donationschedule.name!.toLowerCase();
        final searchLower = donationquery.toLowerCase();
        return regionLower.contains(searchLower) ||
            facilitynameLower.contains(searchLower) ||
            servicetypeLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width <= 768 ? 0.7.sw : 0.35.sw,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: kLifeBloodBlue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: const Text(
                      'Trivia Questions & Answers',
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        overflow: TextOverflow.fade,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: FutureBuilder<List<BloodTestingFacilities>>(
                    future: getBloodFacilities(donationquery),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: kLifeBloodBlue,
                        ));
                      } else if (!snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(FontAwesomeIcons.faceSadCry),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "No facility found",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 12,
                                      color: Color(0xFFE02020)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 5.r, right: 15.r, left: 15.r),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: TextButton(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.refresh,
                                            color: Colors.teal,
                                          ),
                                          Text('Refresh Page',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  color: Colors.teal)),
                                        ],
                                      ),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        super.widget));
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListView(
                                  children: snapshot.data!
                                      .map((data) => Column(
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Container(
                                                        padding: EdgeInsets.only(
                                                            bottom:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(.0, 5.0,
                                                                  5.0, 5.0),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10.w),
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.r),
                                                              width: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                border: Border.all(
                                                                    color:
                                                                        kLifeBloodBlue),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16),
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                          'Blood Donor Request',
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style: GoogleFonts.montserrat(
                                                                              fontSize: 10,
                                                                              letterSpacing: 0,
                                                                              color: kGreyColor)),
                                                                      SizedBox(
                                                                        height:
                                                                            5.h,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text.rich(
                                                                            TextSpan(
                                                                              style: TextStyle(
                                                                                color: Color(0xFF205072),
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                              children: [
                                                                                TextSpan(
                                                                                  text: data.name!,
                                                                                  style: GoogleFonts.montserrat(
                                                                                    fontSize: 13,
                                                                                    letterSpacing: 0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Color(0xFF205072),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            textHeightBehavior:
                                                                                TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFF205072)),
                                                                            child:
                                                                                Text(
                                                                              data.status!,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.normal,
                                                                                fontFamily: 'Montserrat',
                                                                                letterSpacing: 0,
                                                                                color: kWhiteColor,
                                                                              ),
                                                                              overflow: TextOverflow.clip,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            2.h,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Flexible(
                                                                            child:
                                                                                Expanded(
                                                                              child: Text(
                                                                                data.address!,
                                                                                style: TextStyle(
                                                                                  fontSize: 13,
                                                                                  overflow: TextOverflow.clip,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontFamily: 'Montserrat',
                                                                                  letterSpacing: 0,
                                                                                  color: Color(0xFF205072),
                                                                                ),
                                                                                overflow: TextOverflow.clip,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text.rich(
                                                                        TextSpan(
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Color(0xFF205072),
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                          children: [
                                                                            TextSpan(
                                                                              text: data.district!,
                                                                              style: GoogleFonts.montserrat(
                                                                                fontSize: 13,
                                                                                letterSpacing: 0,
                                                                                fontWeight: FontWeight.normal,
                                                                                color: Color(0xFF205072),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        textHeightBehavior:
                                                                            TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            2.h,
                                                                      ),
                                                                      TextButton(
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            FaIcon(
                                                                              FontAwesomeIcons.whatsapp,
                                                                              size: 20,
                                                                            ),
                                                                            5.horizontalSpace,
                                                                            Text('Volunteer to Donate',
                                                                                textAlign: TextAlign.center,
                                                                                style: GoogleFonts.montserrat(
                                                                                  fontSize: 13,
                                                                                  letterSpacing: 0,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  color: kWhiteColor,
                                                                                )),
                                                                          ],
                                                                        ),
                                                                        style: TextButton
                                                                            .styleFrom(
                                                                          foregroundColor:
                                                                              Colors.white,
                                                                          backgroundColor:
                                                                              kLifeBloodBlue,
                                                                          shape:
                                                                              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                        ),
                                                                        onPressed:
                                                                            () {},
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
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ))
                                      .toList(),
                                ),
                              )
                            ]);
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
