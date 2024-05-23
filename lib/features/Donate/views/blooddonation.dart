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
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:intl/intl.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

DateTime now = DateTime.now();
String formattedNewDate = DateFormat('d MMM yyyy').format(now);
String formattedNewMonth = DateFormat('LLLL').format(now);
String formattedNewYear = DateFormat('y').format(now);

class BloodDonation extends StatefulWidget {
  BloodDonation({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String? title;

  @override

  //text editing controller for text field

  _BloodDonationState createState() => _BloodDonationState();
}

class _BloodDonationState extends State<BloodDonation> {
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
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => HomePageScreen(
                        pageIndex: 2,
                      ),
                    ));
              },
              icon: Icon(Icons.arrow_back)),
          elevation: 0,
          title: Text(
            'Schedule Voluntary Blood Donation',
            style: TextStyle(fontSize: 14.sp),
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
                        Text('Blood Donation \nAppointment Details',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.montserrat(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal)),
                        SizedBox(
                          height: 5.h,
                        ),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Why Should You Donate Blood?',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                    fontSize: 14.sp,
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
                                    Text(
                                      ' More Info',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                      ),
                                    )
                                  ],
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                            'Every 2 seconds, someone in the Sierra Leone needs blood, and there is no way to get blood and platelets other than through donations from volunteers.',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.montserrat(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
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
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Do you have Vaccination for Hepatitis B Virus (HBV)? '),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Row(
                              children: <Widget>[
                                _buildHBVVaccincationSelector(
                                  context: context,
                                  name: 'Yes',
                                ),
                                SizedBox(width: 5.0),
                                _buildHBVVaccincationSelector(
                                  context: context,
                                  name: 'No',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      (selectedHBVVaccination == "Yes")
                          ? TextField(
                              controller:
                                  _HBVwhendateinput, //editing controller of this TextField
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                // icon: Icon(Icons.calendar_today), //icon of text field
                                labelText: "Select Date",
                                labelStyle: TextStyle(
                                    fontSize: 14.sp), //label text of field
                              ),
                              readOnly:
                                  true, //set it true, so that user will not able to edit text
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(
                                        2000), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101));

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  //you can implement different kind of Date Format here according to your requirement

                                  setState(() {
                                    _HBVwhendateinput.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {
                                  print("Date is not selected");
                                }
                              },
                            )
                          : SizedBox(
                              height: 0,
                            ),
                      SizedBox(
                        height: 10.h,
                      ),
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
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          labelText: 'Marital Status',
                          labelStyle: TextStyle(fontSize: 14.sp),
                          //Add isDense true and zero Padding.
                          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                          isDense: true,
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
                        items: maritalstatusItems
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
                        validator: (value) {
                          if (value == null) {
                            return 'Please select gender.';
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
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Occupation (optional)',
                          labelStyle: TextStyle(fontSize: 14.sp),
                        ),
                        controller: _occupationCtrl,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          labelText: 'Personal ID Type',
                          labelStyle: TextStyle(fontSize: 14.sp),
                          //Add isDense true and zero Padding.
                          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                          isDense: true,
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
                        items: idItems
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
                        validator: (value) {
                          if (value == null) {
                            return 'Please select an option.';
                          }
                        },
                        onChanged: (String? value) {
                          setState(() {
                            selectedID = value;
                          });
                        },
                        onSaved: (value) {
                          selectedID = value.toString();
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      (selectedID == "Not Available")
                          ? SizedBox(
                              height: 0.h,
                            )
                          : TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'ID Type Number',
                                labelStyle: TextStyle(fontSize: 14.sp),
                              ),
                              controller: _idnumberCtrl,
                            ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Next of Kin Details',
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
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('I want my next of Kin to be informed?'),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Row(
                              children: <Widget>[
                                _buildInformedNextOfKinSelector(
                                  context: context,
                                  name: 'Yes',
                                ),
                                SizedBox(width: 5.0),
                                _buildInformedNextOfKinSelector(
                                  context: context,
                                  name: 'No',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      (selectedInofkin == "Yes")
                          ? Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Next of Kin Name',
                                    labelStyle: TextStyle(fontSize: 14.sp),
                                  ),
                                  controller: _nextofkinCtrl,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                TextFormField(
                                  maxLength: 8,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Next of Kin Phone Number',
                                      prefixText: '+232'),
                                  controller: _nextofkinphoneCtrl,
                                ),
                              ],
                            )
                          : SizedBox(
                              height: 0,
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
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          //Add isDense true and zero Padding.
                          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                          labelText: 'Facility',
                          labelStyle: TextStyle(fontSize: 14.sp),
                          //Add isDense true and zero Padding.
                          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                          isDense: true,
                          contentPadding: EdgeInsets.only(left: 8),
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
                        items: facilityItems
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
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a facility.';
                          }
                        },
                        onChanged: (dynamic value) {
                          setState(() {
                            selectedFacility = value;
                          });
                        },
                        onSaved: (value) {
                          selectedFacility = value.toString();
                        },
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
                        //editing controller of this TextField
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            labelText: "Select Date" //
                            // label text of field
                            ),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime
                                  .now(), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('d MMM yyyy').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              dateinput.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          //Add isDense true and zero Padding.
                          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                          labelText: 'Time Slots',
                          labelStyle: TextStyle(fontSize: 14.sp),
                          //Add isDense true and zero Padding.
                          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                          isDense: true,
                          contentPadding: EdgeInsets.only(left: 8),
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
                        items: timeslotItems
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
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a timeslot.';
                          }
                        },
                        onChanged: (dynamic value) {
                          setState(() {
                            selectedTimeslot = value;
                          });
                        },
                        onSaved: (value) {
                          selectedTimeslot = value.toString();
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
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
                                Text.rich(
                                  TextSpan(
                                    style: TextStyle(
                                        color: Color(0xff329d9c),
                                        fontSize: 15.sp),
                                    children: [
                                      TextSpan(
                                        text: 'Facility: ',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
                                          height: 1,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF205072),
                                        ),
                                      ),
                                      TextSpan(
                                        text: selectedFacility,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textHeightBehavior: TextHeightBehavior(
                                      applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text.rich(
                                  TextSpan(
                                    style: TextStyle(
                                        color: Color(0xff329d9c),
                                        fontSize: 15.sp),
                                    children: [
                                      TextSpan(
                                        text: 'Date: ',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
                                          height: 1,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF205072),
                                        ),
                                      ),
                                      TextSpan(
                                        text: dateinput.text,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textHeightBehavior: TextHeightBehavior(
                                      applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text.rich(
                                  TextSpan(
                                    style: TextStyle(
                                        color: Color(0xff329d9c),
                                        fontSize: 15.sp),
                                    children: [
                                      TextSpan(
                                        text: 'Time Slot: ',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
                                          height: 1,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF205072),
                                        ),
                                      ),
                                      TextSpan(
                                        text: selectedTimeslot,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textHeightBehavior: TextHeightBehavior(
                                      applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                // Text.rich(
                                //   TextSpan(
                                //     style: TextStyle(
                                //         color: Color(0xff329d9c), fontSize: 15.sp),
                                //     children: [
                                //       TextSpan(
                                //         text: 'Fee: ',
                                //         style: GoogleFonts.montserrat(
                                //           fontSize: 14.sp,
                                //           height: 1,
                                //           fontWeight: FontWeight.bold,
                                //           color: Color(0xFF205072),
                                //         ),
                                //       ),
                                //       (facility =='Cottage/PCMH')?TextSpan(
                                //         text: 'NLE 200',
                                //         style: GoogleFonts.montserrat(
                                //           fontSize: 14.sp,
                                //           fontWeight: FontWeight.bold,
                                //           color: Colors.blue,
                                //         ),
                                //       ):(facility =='Connaught')?TextSpan(
                                //         text: 'NLE 150',
                                //         style: GoogleFonts.montserrat(
                                //           fontSize: 14.sp,
                                //           fontWeight: FontWeight.bold,
                                //           color: Colors.blue,
                                //         ),
                                //       ):(facility =='34 Military Hospital')?TextSpan(
                                //         text: 'NLE 150',
                                //         style: GoogleFonts.montserrat(
                                //           fontSize: 14.sp,
                                //           fontWeight: FontWeight.bold,
                                //           color: Colors.blue,
                                //         ),
                                //       ) :(facility !='34 Military Hospital' ||  facility !='Connaught' || facility !='Cottage/PCMH' )?TextSpan(
                                //         text: 'NLE 150',
                                //         style: GoogleFonts.montserrat(
                                //           fontSize: 14.sp,
                                //           fontWeight: FontWeight.bold,
                                //           color: Colors.blue,
                                //         ),
                                //       ): TextSpan(
                                //         text: '',
                                //         style: GoogleFonts.montserrat(
                                //           fontSize: 14.sp,
                                //           fontWeight: FontWeight.bold,
                                //           color: Colors.blue,
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                //   textHeightBehavior:
                                //       TextHeightBehavior(applyHeightToFirstAscent: false),
                                //   textAlign: TextAlign.left,
                                // ),
                                //  SizedBox(
                                //   height: 5.h,
                                // ),
                                Text.rich(

// overflow: TextOverflow.clip,
                                    TextSpan(
                                        text: 'I ',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey),
                                        children: <InlineSpan>[
                                      TextSpan(
                                          text: "$ulname",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.teal)),
                                      TextSpan(text: ' '),
                                      TextSpan(
                                          text: "$ufname $umname",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.teal)),
                                      TextSpan(
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey),
                                        text:
                                            ', hereby agree voluntary to go through the several investigations on my blood within this Transfusion Center and consent to this. \nI understand that I may be rejected as a blood donor if any of these test (HIV, HBS,HCV, Syphilis) are positive.',
                                      ),
                                    ])),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
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
                                : Text('Agree and Schedule')),
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
