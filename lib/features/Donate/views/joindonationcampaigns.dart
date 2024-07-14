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
import 'package:intl/intl.dart';
import 'package:lifebloodworld/constants/colors.dart';
import 'package:lifebloodworld/constants/colors.dart';
import 'package:lifebloodworld/features/Donate/views/finddonationdrives.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

DateTime now = DateTime.now();
String formattedNewDate = DateFormat('d MMM yyyy').format(now);
String formattedNewMonth = DateFormat('LLLL').format(now);
String formattedNewYear = DateFormat('y').format(now);

class JoinDrives extends StatefulWidget {
  JoinDrives({
    Key? key,
    required this.campaignname,
    // required this.campaignid,
    // required this.campaigndescription,
    // required this.campaigncontact,
    // required this.campaigndate,
    // required this.campaignaddress,
    // required this.campaignfacility,
    // required this.campaigncreator,
    // required this.campaignemail,
    // required this.campaigndatecreated,
    // required this.facility,
    // required this.campaignlocation,
    // required this.campaigndistrict,
  }) : super(key: key);

  final String? campaignname;
  // final String? campaignid;
  // final String? campaigndescription;
  // final String? campaigncontact;
  // final String? campaigndate;
  // final String? campaignaddress;
  // final String? campaignfacility;
  // final String? campaigncreator;
  // final String? campaignemail;
  // final String? campaigndatecreated;
  // final String? facility;
  // final String? campaignlocation;
  // final String? campaigndistrict;

  @override
  State<JoinDrives> createState() => _JoinDrivesState(
        // campaignid: campaignid,
        campaignname: campaignname,
        // campaignaddress: campaignaddress,
        // campaigndate: campaigndate,
        // campaigndescription: campaigndescription,
        // campaigncontact: campaigncontact,
        // campaignfacility: campaignfacility,
        // campaigncreator: campaigncreator,
        // campaignemail: campaignemail,
        // campaigndatecreated: campaigndatecreated,
        // facility: facility,
        // campaignlocation: campaignlocation,
        // campaigndistrict: campaigndistrict,
      );
}

class _JoinDrivesState extends State<JoinDrives> {
  _JoinDrivesState({
    Key? key,
    required this.campaignname,
    // required this.campaignid,
    // required this.campaigndescription,
    // required this.campaigncontact,
    // required this.campaigndate,
    // required this.campaignaddress,
    // required this.campaignfacility,
    // required this.campaigncreator,
    // required this.campaignemail,
    // required this.campaigndatecreated,
    // required this.facility,
    // required this.campaignlocation,
    // required this.campaigndistrict,
  });

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
  final TextEditingController dateinput =
      TextEditingController(text: formattedNewDate.toString());
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
  String? campaignname;
  String? campaignid;
  String? campaigndescription;
  String? campaigncontact;
  String? campaigndate;
  String? campaignaddress;
  String? campaignfacility;
  String? campaigncreator;
  String? campaignemail;
  String? campaigndatecreated;
  String? facility;
  String? campaignlocation;
  String? campaigndistrict;

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
      userId = prefs.getString('id');
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

  dynamic timeslot;

  final List<String> facilityItems = [
    '34 Military Hospital',
    'Cottage/PCMH',
    'Connaught',
    'Rokupa',
  ];

  String? selectedFacility = '';
  String? selectedTimeslot = '';
  String? campaigndonation;
  String? checkcampaignid;

  savecampaigndonation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('campaigndonation', campaigndonation!);
    prefs.setString('checkcampaignid', checkcampaignid!);
  }

  bool _scheduling = false;

  Future register() async {
    await Future.delayed(Duration(seconds: 0));
    var response = await http.post(
        Uri.parse(
            "https://community.lifebloodsl.com/campaignblooddonorregistration.php"),
        body: {
          "surname": ulname,
          "middlename": umname,
          "firstname": ufname,
          "agecategory": agecategory,
          "gender": gender,
          "address": address,
          "district": district,
          "donorphonenumber": phonenumber,
          "donoremail": email,
          "maritalstatus": selectedMaritalStatus,
          "occupation": _occupationCtrl.text,
          "nextofkin": _nextofkinCtrl.text,
          "informednextofkin": selectedInofkin,
          "nextofkinphonenumber": _nextofkinphoneCtrl.text,
          "personalID": selectedID,
          "IDnumber": _idnumberCtrl.text,
          "HBVvaccination": selectedHBVVaccination,
          "HBVwhendateinput": _HBVwhendateinput.text,
          "bloodgroup": bloodtype,
          "campaignid": campaignid,
          "campaignname": campaignname,
          "campaigncreator": campaigncreator,
          "campaigndescription": campaigndescription,
          "campaigncontact": campaigncontact,
          "campaignemail": campaignemail,
          "facility": facility,
          "campaignfacility": campaignfacility,
          "campaignlocation": campaignlocation,
          "campaigndistrict": campaigndistrict,
          "campaigndate": campaigndate,
          "campaigndatecreated": campaigndatecreated,
          "date": dateinput.text,
          "month": monthinput.text,
          "year": yearinput.text,
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
      
    } else {
      setState(() {
        campaigndonation = "Yes";
        checkcampaignid = campaignid;
      });
      savecampaigndonation();
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
                              style: GoogleFonts.montserrat(
                                fontSize: 12.sp,
                                color: Colors.white,
                                height: 1.3846153846153846,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      'Your reference code for the campaign is ',
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
                                // await Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //        JoinDonationDrive()
                                //   ),
                                // );
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
  final TextEditingController _unexpectedweightlosscomment =
      TextEditingController();
  final TextEditingController _sexualactiviiescomment = TextEditingController();
  final TextEditingController __tattooDate = TextEditingController();
  final TextEditingController _infectiousdiseasecomment =
      TextEditingController();
  final TextEditingController _donottypecomment = TextEditingController();
  final TextEditingController _recentlyhospitalizedcomment =
      TextEditingController();
  final TextEditingController _smokeDate = TextEditingController();
  final TextEditingController _previoustransfusionreceivedcomment =
      TextEditingController();

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
  }

  String? _sexualactiviiestype = "";
  String? _lungdisease = "";
  String? _sexualactivities = "";
  String? _medicationcomment = "";
  String? _operationcomment = "";
  String? _travellingcomment = "";
  String? _smokecomment = "";
  String? _drinkcomment = "";
  String? _sexualactiviies = "";
  String? _smoke = "";
  String? _drink = "";
  String? _medication = "";
  String? _operation = "";
  String? _acupuncture = "";
  String? _tattoo = "";
  String? _infectiousdisease = "";
  String? _kidneydisease = "";
  String? _tuberculosis = "";
  String? _thyroiddisorder = "";
  String? _asthma = "";
  String? _swollengland = "";
  String? _epilepsy = "";
  String? _persistingcough = "";
  String? _rheumaticfever = "";
  String? _cancer = "";
  String? _anaemia = "";
  String? _shingles = "";
  String? _circulationproblems = "";
  String? _bp = "";
  String? _malaria = "";
  String? _skinrashes = "";
  String? _fever = "";
  String? _epitaxis = "";
  String? _dizziness = "";
  String? _sleepingsickness = "";
  String? _abdominal = "";
  String? _jaundice = "";
  String? _ulcer = "";
  String? _brucellosis = "";
  String? _diarrhoea = "";
  String? _std = "";
  String? _diabetes = "";
  String? _sicklecell = "";
  String? _donortype = "";
  String? _previoustransfusionreceived = "";
  String? _recenthospitalization = "";
  String? _unexpectedweightloss = "";
  String? _travelling = "";

  @override
  void initState() {
    _dateinput.text = "";

    getPref(); //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.teal,
          leading: IconButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     new MaterialPageRoute(
                //         builder: (context) => JoinDonationDrive()));
              },
              icon: Icon(Icons.arrow_back)),
          elevation: 0,
          title: Text(
            'Join $campaignname',
            style: GoogleFonts.montserrat(fontSize: 14.sp),
          )),
      body: _donationProcessOne(context, size),
    );
  }

  SingleChildScrollView _donationProcessOne(BuildContext context, Size size) {
    return SingleChildScrollView(
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
                      children: [
                        Text('Join ',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.montserrat(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF205072))),
                        Text('$campaignname',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.montserrat(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal)),
                      ],
                    ),
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
                                        padding: EdgeInsets.fromLTRB(20.0, 20.0,
                                            20.0, 0.0), // content padding
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
                                                              fontSize: 13.sp,
                                                              color:
                                                                  Colors.red)),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Text('Why Should You Donate Blood?',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.teal)),
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
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Color(0xff406986))),
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
                                  style: GoogleFonts.montserrat(
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
                          labelStyle: GoogleFonts.montserrat(fontSize: 15.sp),
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
                        style: GoogleFonts.montserrat(
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
                            hintStyle: GoogleFonts.montserrat(
                              fontSize: 11.sp,
                            ),
                            labelStyle: GoogleFonts.montserrat(
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
                            hintStyle: GoogleFonts.montserrat(
                              fontSize: 11.sp,
                            ),
                            labelStyle: GoogleFonts.montserrat(
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
                            labelStyle: GoogleFonts.montserrat(
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
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
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
                        style: GoogleFonts.montserrat(
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
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Marital Status',
                      labelStyle: GoogleFonts.montserrat(fontSize: 14.sp),
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
                    items: maritalstatusItems
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: GoogleFonts.montserrat(
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
                      labelText: 'Occupation',
                      labelStyle: GoogleFonts.montserrat(fontSize: 14.sp),
                    ),
                    controller: _occupationCtrl,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  DropdownButtonFormField2(
                    decoration: InputDecoration(
                      labelText: 'Personal ID Type',
                      labelStyle: GoogleFonts.montserrat(fontSize: 14.sp),
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
                                style: GoogleFonts.montserrat(
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
                            labelStyle: GoogleFonts.montserrat(fontSize: 14.sp),
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
                        style: GoogleFonts.montserrat(
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
                        Text(
                          'I want my next of Kin to be informed?',
                          style: GoogleFonts.montserrat(),
                        ),
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
                                labelStyle:
                                    GoogleFonts.montserrat(fontSize: 14.sp),
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
                                  labelStyle:
                                      GoogleFonts.montserrat(fontSize: 14.sp),
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
                        'Campaign Information',
                        style: GoogleFonts.montserrat(
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
                                style: GoogleFonts.montserrat(
                                    color: Color(0xff329d9c), fontSize: 15.sp),
                                children: [
                                  TextSpan(
                                    text: 'Campaign created by\n',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14.sp,
                                      height: 1,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF205072),
                                    ),
                                  ),
                                  TextSpan(
                                    text: campaigncreator,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
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
                                style: GoogleFonts.montserrat(
                                    color: Color(0xff329d9c), fontSize: 15.sp),
                                children: [
                                  TextSpan(
                                    text: 'Campaign Name\n',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14.sp,
                                      height: 1,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF205072),
                                    ),
                                  ),
                                  TextSpan(
                                    text: campaignname,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
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
                                style: GoogleFonts.montserrat(
                                    color: Color(0xff329d9c), fontSize: 15.sp),
                                children: [
                                  TextSpan(
                                    text: 'Campaign Description\n',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14.sp,
                                      height: 1,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF205072),
                                    ),
                                  ),
                                  TextSpan(
                                    text: campaigndescription,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
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
                                style: GoogleFonts.montserrat(
                                    color: Color(0xff329d9c), fontSize: 15.sp),
                                children: [
                                  TextSpan(
                                    text: 'Campaign Date\n',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14.sp,
                                      height: 1,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF205072),
                                    ),
                                  ),
                                  TextSpan(
                                    text: campaigndate,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                              textHeightBehavior: TextHeightBehavior(
                                  applyHeightToFirstAscent: false),
                              textAlign: TextAlign.left,
                            ),
                            Text.rich(
                              TextSpan(
                                style: GoogleFonts.montserrat(
                                    color: Color(0xff329d9c), fontSize: 15.sp),
                                children: [
                                  TextSpan(
                                    text: 'Campaign Location\n',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14.sp,
                                      height: 1,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF205072),
                                    ),
                                  ),
                                  TextSpan(
                                    text: campaignlocation,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
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
                            SizedBox(
                              height: 5.h,
                            ),

                            // Text.rich(
                            //   TextSpan(
                            //     style: GoogleFonts.montserrat(
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
                                      style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.teal)),
                                  TextSpan(text: ' '),
                                  TextSpan(
                                      text: "$ufname $umname",
                                      style: GoogleFonts.montserrat(
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
                                                  style: GoogleFonts.montserrat(
                                                      color: Color(0xff329d9c),
                                                      fontSize: 15.sp),
                                                  children: [
                                                    TextSpan(
                                                      text: 'Registering ',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
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
                                                          "$ufname $umname $ulname\n",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.amber,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap = () {
                                                              // Single tapped.
                                                            },
                                                      text: "for $campaignname",
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
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.montserrat(
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
                              Future.delayed(Duration(seconds: 7), () async {
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
                                style: GoogleFonts.montserrat(),
                              )),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ),
        ],
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
            style: GoogleFonts.montserrat(
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
            style: GoogleFonts.montserrat(
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
            style: GoogleFonts.montserrat(
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
            style: GoogleFonts.montserrat(
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
            style: GoogleFonts.montserrat(
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
            style: GoogleFonts.montserrat(
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
            style: GoogleFonts.montserrat(
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
            style: GoogleFonts.montserrat(
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
            style: GoogleFonts.montserrat(
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
            style: GoogleFonts.montserrat(
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
            style: GoogleFonts.montserrat(
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
            style: GoogleFonts.montserrat(
              color: isActive ? Colors.white : null,
              // fontSize: width * 0.035,
            ),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView _donationQuestionnaire() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Questionnaire',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderDropdown(
                  dropdownColor: Colors.white,
                  name: '_donortype',
                  decoration: const InputDecoration(
                    labelText: 'Donor Type',
                    labelStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintText: 'Donor Type',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _donortype = value.toString();
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: 3,
                      child: Text('Select'),
                    ),
                    DropdownMenuItem(
                      child: Text('Regular'),
                      value: "Regular",
                    ),
                    DropdownMenuItem(
                      child: Text('Non Regular'),
                      value: "Non Regular",
                    ),
                    DropdownMenuItem(
                      child: Text('First Time'),
                      value: "Non Regular",
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _donortype == "Regular"
                ? Row(children: [
                    Flexible(
                        child: FormBuilder(
                            child: TextFormField(
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      validator: (Value) {
                        if (Value!.isEmpty) {
                          return 'This Field is Required';
                        }
                        return null;
                      },
                      controller: _donottypecomment,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5),
                          ),
                          labelText: "How was your previous experience?"),
                      onFieldSubmitted: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            _donottypecomment;
                          });
                        }
                      },
                    ))),
                  ])
                : SizedBox(
                    height: 20,
                  ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderDropdown(
                  dropdownColor: Colors.white,
                  name: 'Previous Transfusion Received',
                  decoration: const InputDecoration(
                    labelText: 'Previous Transfusion Received',
                    labelStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintText: 'Previous Transfusion Received',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _previoustransfusionreceived = value.toString();
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text('Select'),
                    ),
                    DropdownMenuItem(
                      child: Text('Yes'),
                      value: "Yes",
                    ),
                    DropdownMenuItem(
                      child: Text('No'),
                      value: "No",
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _previoustransfusionreceived == "Yes"
                ? Row(children: [
                    Flexible(
                        child: FormBuilder(
                            child: TextFormField(
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      validator: (Value) {
                        if (Value!.isEmpty) {
                          return 'This Field is Required';
                        }
                        return null;
                      },
                      controller: _previoustransfusionreceivedcomment,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5),
                          ),
                          labelText: "Reason"),
                      onFieldSubmitted: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            _donottypecomment;
                          });
                        }
                      },
                    ))),
                  ])
                : SizedBox(
                    height: 20,
                  ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderDropdown(
                  dropdownColor: Colors.white,
                  name: 'Recent Hospitalization',
                  decoration: const InputDecoration(
                    labelText: 'Recent Hospitalization',
                    labelStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintText: 'Recent Hospitalization',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _recenthospitalization = value.toString();
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text('Select'),
                    ),
                    DropdownMenuItem(
                      child: Text('Yes'),
                      value: "Yes",
                    ),
                    DropdownMenuItem(
                      child: Text('No'),
                      value: "No",
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _recenthospitalization == "Yes"
                ? Row(children: [
                    Flexible(
                        child: FormBuilder(
                            child: TextFormField(
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      validator: (Value) {
                        if (Value!.isEmpty) {
                          return 'This Field is Required';
                        }
                        return null;
                      },
                      controller: _recentlyhospitalizedcomment,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5),
                          ),
                          labelText: "Reason"),
                      onFieldSubmitted: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            _donottypecomment;
                          });
                        }
                      },
                    ))),
                  ])
                : SizedBox(
                    height: 20,
                  ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderDropdown(
                  dropdownColor: Colors.white,
                  name: 'Unexpected Weight Loss',
                  decoration: const InputDecoration(
                    labelText: 'Unexpected Weight Loss',
                    labelStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintText: 'Unexpected Weight Loss',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _unexpectedweightloss = value.toString();
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text('Select'),
                    ),
                    DropdownMenuItem(
                      child: Text('Yes'),
                      value: "Yes",
                    ),
                    DropdownMenuItem(
                      child: Text('No'),
                      value: "No",
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _unexpectedweightloss == "Yes"
                ? Row(children: [
                    Flexible(
                        child: FormBuilder(
                            child: TextFormField(
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      validator: (Value) {
                        if (Value!.isEmpty) {
                          return 'This Field is Required';
                        }
                        return null;
                      },
                      controller: _unexpectedweightlosscomment,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5),
                          ),
                          labelText: "Reason"),
                      onFieldSubmitted: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            _donottypecomment;
                          });
                        }
                      },
                    ))),
                  ])
                : SizedBox(
                    height: 20,
                  ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Lung Diseases',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Lung Diseases',
                        onChanged: (String? value) {
                          setState(() {
                            _lungdisease = value;
                          });
                        },
                        initialValue: _lungdisease,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(value: 'Yes'),
                      FormBuilderChipOption(value: 'No')
                    ])),
                SizedBox(
                  width: 50,
                ),
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Kidney Diseases',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Kidney Disease',
                        onChanged: (String? value) {
                          setState(() {
                            _kidneydisease = value;
                          });
                        },
                        initialValue: _kidneydisease,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(value: 'Yes'),
                      FormBuilderChipOption(value: 'No')
                    ]))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Tuberculosis',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Tuberculosis',
                        onChanged: (String? value) {
                          setState(() {
                            _tuberculosis = value;
                          });
                        },
                        initialValue: _tuberculosis,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(value: 'Yes'),
                      FormBuilderChipOption(value: 'No')
                    ])),
                SizedBox(
                  width: 50,
                ),
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Thyroid Disorder',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Thyroid Disorder',
                        onChanged: (String? value) {
                          setState(() {
                            _thyroiddisorder = value;
                          });
                        },
                        initialValue: _thyroiddisorder,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(value: 'Yes'),
                      FormBuilderChipOption(value: 'No')
                    ]))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Asthma',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Asthma',
                        onChanged: (String? value) {
                          setState(() {
                            _asthma = value;
                          });
                        },
                        initialValue: _asthma,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(value: 'Yes'),
                      FormBuilderChipOption(value: 'No')
                    ])),
                SizedBox(
                  width: 50,
                ),
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Swollen Gland',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Swollen Gland',
                        onChanged: (String? value) {
                          setState(() {
                            _swollengland = value;
                          });
                        },
                        initialValue: _swollengland,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(value: 'Yes'),
                      FormBuilderChipOption(value: 'No')
                    ]))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Persisting Cough',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Persisting Cough',
                        onChanged: (String? value) {
                          setState(() {
                            _persistingcough = value;
                          });
                        },
                        initialValue: _persistingcough,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(value: 'Yes'),
                      FormBuilderChipOption(value: 'No')
                    ])),
                SizedBox(
                  width: 50,
                ),
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Epilepsy',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Epilepsy',
                        onChanged: (String? value) {
                          setState(() {
                            _epilepsy = value;
                          });
                        },
                        initialValue: _epilepsy,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(value: 'Yes'),
                      FormBuilderChipOption(value: 'No')
                    ]))
              ],
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Rheumatic Fever',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Rheumatic Fever',
                        onChanged: (String? value) {
                          setState(() {
                            _rheumaticfever = value;
                          });
                        },
                        initialValue: _rheumaticfever,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(value: 'Yes'),
                      FormBuilderChipOption(value: 'No')
                    ])),
                SizedBox(
                  width: 50,
                ),
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Cancer',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Cancer',
                        onChanged: (String? value) {
                          setState(() {
                            _cancer = value;
                          });
                        },
                        initialValue: _cancer,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(value: 'Yes'),
                      FormBuilderChipOption(value: 'No')
                    ])),
              ],
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Anaemia',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Anaemia',
                        onChanged: (String? value) {
                          setState(() {
                            _anaemia = value;
                          });
                        },
                        initialValue: _anaemia,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(value: 'Yes'),
                      FormBuilderChipOption(value: 'No')
                    ])),
                SizedBox(
                  width: 50,
                ),
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Shingles',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Shingles',
                        onChanged: (String? value) {
                          setState(() {
                            _shingles = value;
                          });
                        },
                        initialValue: _shingles,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(value: 'Yes'),
                      FormBuilderChipOption(value: 'No')
                    ])),
              ],
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Circulation Problems',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Circulation Problems',
                        onChanged: (String? value) {
                          setState(() {
                            _circulationproblems = value;
                          });
                        },
                        initialValue: _circulationproblems,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(value: 'Yes'),
                      FormBuilderChipOption(value: 'No')
                    ])),
                SizedBox(
                  width: 50,
                ),
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Skin Rashes',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Skin Rashes',
                        onChanged: (String? value) {
                          setState(() {
                            _skinrashes = value;
                          });
                        },
                        initialValue: _skinrashes,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(value: 'Yes'),
                      FormBuilderChipOption(value: 'No')
                    ]))
              ],
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Low/High Blood Pressure',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Low/High Blood Pressure',
                        onChanged: (String? value) {
                          setState(() {
                            _bp = value;
                          });
                        },
                        initialValue: _bp,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(value: 'Yes'),
                      FormBuilderChipOption(value: 'No')
                    ])),
                SizedBox(
                  width: 50,
                ),
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Malaria Past 1 Month',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Malaria Past 1 Month',
                        onChanged: (String? value) {
                          setState(() {
                            _malaria = value;
                          });
                        },
                        initialValue: _malaria,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(value: 'Yes'),
                      FormBuilderChipOption(value: 'No')
                    ]))
              ],
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Dizziness',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Dizziness',
                        onChanged: (String? value) {
                          setState(() {
                            _dizziness = value;
                          });
                        },
                        initialValue: _dizziness,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(value: 'Yes'),
                      FormBuilderChipOption(value: 'No')
                    ])),
                SizedBox(
                  width: 50,
                ),
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Night Sweats/Fever',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Night Sweats/Fever',
                        onChanged: (String? value) {
                          setState(() {
                            _fever = value;
                          });
                        },
                        initialValue: _fever,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(value: 'Yes'),
                      FormBuilderChipOption(value: 'No')
                    ]))
              ],
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Epitaxis (excessive)',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Epitaxis (excessive)',
                        onChanged: (String? value) {
                          setState(() {
                            _epitaxis = value;
                          });
                        },
                        initialValue: _epitaxis,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(value: 'Yes'),
                      FormBuilderChipOption(value: 'No')
                    ])),
                SizedBox(
                  width: 50,
                ),
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Sleeping Sickness',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Sleeping Sickness',
                        onChanged: (String? value) {
                          setState(() {
                            _sleepingsickness = value;
                          });
                        },
                        initialValue: _sleepingsickness,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(
                        value: 'Yes',
                      ),
                      FormBuilderChipOption(value: 'No')
                    ]))
              ],
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Abdominal Diseases',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Abdominal Diseases',
                        onChanged: (String? value) {
                          setState(() {
                            _abdominal = value;
                          });
                        },
                        initialValue: _abdominal,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(value: 'Yes'),
                      FormBuilderChipOption(value: 'No')
                    ])),
                SizedBox(
                  width: 50,
                ),
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Hepatitis/Jaundice',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Hepatitis/Jaundice',
                        onChanged: (String? value) {
                          setState(() {
                            _jaundice = value;
                          });
                        },
                        initialValue: _jaundice,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(
                        value: 'Yes',
                      ),
                      FormBuilderChipOption(value: 'No')
                    ]))
              ],
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Ulcers',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Ulcers',
                        onChanged: (String? value) {
                          setState(() {
                            _ulcer = value;
                          });
                        },
                        initialValue: _ulcer,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(value: 'Yes'),
                      FormBuilderChipOption(value: 'No')
                    ])),
                SizedBox(
                  width: 50,
                ),
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Brucellosis',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Brucellosis',
                        onChanged: (String? value) {
                          setState(() {
                            _brucellosis = value;
                          });
                        },
                        initialValue: _brucellosis,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(
                        value: 'Yes',
                      ),
                      FormBuilderChipOption(value: 'No')
                    ]))
              ],
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Prolonged Diarrhoea',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Prolonged Diarrhoea',
                        onChanged: (String? value) {
                          setState(() {
                            _diarrhoea = value;
                          });
                        },
                        initialValue: _diarrhoea,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(value: 'Yes'),
                      FormBuilderChipOption(value: 'No')
                    ])),
                SizedBox(
                  width: 50,
                ),
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'STD/VD',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'STD/VD',
                        onChanged: (String? value) {
                          setState(() {
                            _std = value;
                          });
                        },
                        initialValue: _std,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(
                        value: 'Yes',
                      ),
                      FormBuilderChipOption(value: 'No')
                    ]))
              ],
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Diabetes',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Diabetes',
                        onChanged: (String? value) {
                          setState(() {
                            _diabetes = value;
                          });
                        },
                        initialValue: _diabetes,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(value: 'Yes'),
                      FormBuilderChipOption(value: 'No')
                    ])),
                SizedBox(
                  width: 50,
                ),
                Flexible(
                    child: FormBuilderRadioGroup(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Sickle Cell Diseases',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: 'Montserrat'
                            )),
                        name: 'Sickle Cell Diseases',
                        onChanged: (String? value) {
                          setState(() {
                            _sicklecell = value;
                          });
                        },
                        initialValue: _sicklecell,
                        validator: FormBuilderValidators.required(
                          errorText: 'Kindly Select an option',
                        ),
                        options: [
                      FormBuilderChipOption(
                        value: 'Yes',
                      ),
                      FormBuilderChipOption(value: 'No')
                    ]))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderDropdown(
                  dropdownColor: Colors.white,
                  name: 'Are you taking or have you taken any Medicine',
                  decoration: const InputDecoration(
                    labelText: 'Are you taking or have you taken any Medicine',
                    labelStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintText: 'Are you taking or have you taken any Medicine',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _medication = value.toString();
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text('Select'),
                    ),
                    DropdownMenuItem(
                      child: Text('Yes'),
                      value: "Yes",
                    ),
                    DropdownMenuItem(
                      child: Text('No'),
                      value: "No",
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _medication == "Yes"
                ? Row(
                    children: [
                      Flexible(
                          child: FormBuilderDropdown(
                        dropdownColor: Colors.white,
                        name: 'Which Medicine',
                        decoration: const InputDecoration(
                          labelText: 'Which Medicine',
                          labelStyle: TextStyle(
                              // fontFamily:
                              //     'Montserrat',
                              fontSize: 14),
                          hintStyle: TextStyle(
                              // fontFamily:
                              //     'Montserrat',
                              fontSize: 14),
                          hintText: 'Which Medicine',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _medicationcomment = value.toString();
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text('Select'),
                          ),
                          DropdownMenuItem(
                            child: Text('Aspirin'),
                            value: "Aspirin",
                          ),
                          DropdownMenuItem(
                            child: Text('Antibiotics'),
                            value: "Antibiotics",
                          ),
                          DropdownMenuItem(
                            child: Text('Steroids'),
                            value: "Steroids",
                          ),
                          DropdownMenuItem(
                            child: Text('Injections'),
                            value: "Injections",
                          ),
                          DropdownMenuItem(
                            child: Text('Vaccinations'),
                            value: "Vaccinations",
                          ),
                        ],
                      )),
                    ],
                  )
                : SizedBox(
                    height: 20,
                  ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderDropdown(
                  dropdownColor: Colors.white,
                  name: 'Have You Had Any Operations',
                  decoration: const InputDecoration(
                    labelText: 'Have You Had Any Operations',
                    labelStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintText: 'Have You Had Any Operations',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _operation = value.toString();
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text('Select'),
                    ),
                    DropdownMenuItem(
                      child: Text('Yes'),
                      value: "Yes",
                    ),
                    DropdownMenuItem(
                      child: Text('No'),
                      value: "No",
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _operation == "Yes"
                ? Row(
                    children: [
                      Flexible(
                          child: FormBuilderDropdown(
                        dropdownColor: Colors.white,
                        name: 'Which Operation',
                        decoration: const InputDecoration(
                          labelText: 'Which Operation',
                          labelStyle: TextStyle(
                              // fontFamily:
                              //     'Montserrat',
                              fontSize: 14),
                          hintStyle: TextStyle(
                              // fontFamily:
                              //     'Montserrat',
                              fontSize: 14),
                          hintText: 'Which Operation',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _operationcomment = value.toString();
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text('Select'),
                          ),
                          DropdownMenuItem(
                            child: Text('Minor'),
                            value: "Minor",
                          ),
                          DropdownMenuItem(
                            child: Text('Major'),
                            value: "Major",
                          ),
                        ],
                      )),
                    ],
                  )
                : SizedBox(
                    height: 20,
                  ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderDropdown(
                  dropdownColor: Colors.white,
                  name: 'Have You Had Any Acupuncture',
                  decoration: const InputDecoration(
                    labelText: 'Have You Had Any Acupuncture',
                    labelStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintText: 'Have You Had Any Acupuncture',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _acupuncture = value.toString();
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text('Select'),
                    ),
                    DropdownMenuItem(
                      child: Text('Yes'),
                      value: "Yes",
                    ),
                    DropdownMenuItem(
                      child: Text('No'),
                      value: "No",
                    ),
                  ],
                )),
                SizedBox(
                  width: 30,
                ),
                Flexible(
                    child: FormBuilderDropdown(
                  dropdownColor: Colors.white,
                  name: '',
                  decoration: const InputDecoration(
                    labelText: 'Have You Had Any Tattoo',
                    labelStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintText: 'Have You Had Any Tattoo',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _tattoo = value.toString();
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text('Select'),
                    ),
                    DropdownMenuItem(
                      child: Text('Yes'),
                      value: "Yes",
                    ),
                    DropdownMenuItem(
                      child: Text('No'),
                      value: "No",
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _tattoo == "Yes"
                ? Row(
                    children: [
                      Flexible(
                          child: FormBuilder(
                              child: TextFormField(
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        validator: (Value) {
                          if (Value!.isEmpty) {
                            return 'This Field is Required';
                          }
                          return null;
                        },
                        controller: __tattooDate,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              // BorderSide(color: Colors.blue, width: 0.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 0.5),
                            ),
                            labelText: "Date",
                            filled: true,
                            prefixIcon: Icon(Icons.calendar_today)),
                        readOnly: true,
                        onTap: () {
                          _selectDate();
                        },
                        onFieldSubmitted: (value) {
                          if (value != Null) {
                            setState(() {
                              _smokeDate.text = value.toString().split(" ")[0];
                            });
                          }
                        },
                      ))),
                    ],
                  )
                : SizedBox(
                    height: 20,
                  ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderDropdown(
                  dropdownColor: Colors.white,
                  name: 'Have you been in contact with any infectious disease',
                  decoration: const InputDecoration(
                    labelText:
                        'Have you been in contact with any infectious disease',
                    labelStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintText:
                        'Have you been in contact with any infectious disease',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _infectiousdisease = value.toString();
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text('Select'),
                    ),
                    DropdownMenuItem(
                      child: Text('Yes'),
                      value: "Yes",
                    ),
                    DropdownMenuItem(
                      child: Text('No'),
                      value: "No",
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _infectiousdisease == "Yes"
                ? Row(children: [
                    Flexible(
                        child: FormBuilder(
                            child: TextFormField(
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      validator: (Value) {
                        if (Value!.isEmpty) {
                          return 'This Field is Required';
                        }
                        return null;
                      },
                      controller: _infectiousdiseasecomment,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5),
                          ),
                          labelText: "Which One?"),
                      onFieldSubmitted: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            _donottypecomment;
                          });
                        }
                      },
                    ))),
                  ])
                : SizedBox(
                    height: 20,
                  ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderDropdown(
                  dropdownColor: Colors.white,
                  name: 'Have You Been Travelling',
                  decoration: const InputDecoration(
                    labelText: 'Have You Been Travelling',
                    labelStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintText: 'Have You Been Travelling',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _travelling = value.toString();
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text('Select'),
                    ),
                    DropdownMenuItem(
                      child: Text('Yes'),
                      value: "Yes",
                    ),
                    DropdownMenuItem(
                      child: Text('No'),
                      value: "No",
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _travelling == "Yes"
                ? Row(
                    children: [
                      Flexible(
                          child: FormBuilderDropdown(
                        dropdownColor: Colors.white,
                        name: 'Which Country',
                        decoration: const InputDecoration(
                          labelText: 'Which Country',
                          labelStyle: TextStyle(
                              // fontFamily:
                              //     'Montserrat',
                              fontSize: 14),
                          hintStyle: TextStyle(
                              // fontFamily:
                              //     'Montserrat',
                              fontSize: 14),
                          hintText: 'Which Country',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _travelling = value.toString();
                          });
                        },
                        onTap: () {
                          // showCountryPicker(
                          //     context: context,
                          //     onSelect: (Country country) {
                          //       ScaffoldMessenger.of(context).showSnackBar(
                          //           SnackBar(content: Text('country.name')));
                          //     });
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text(' '),
                          ),
                        ],
                      )),
                    ],
                  )
                : SizedBox(
                    height: 20,
                  ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderDropdown(
                  dropdownColor: Colors.white,
                  name: 'Do You Smoke',
                  decoration: const InputDecoration(
                    labelText: 'Do You Smoke',
                    labelStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintText: 'Do You Smoke',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _smoke = value.toString();
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text('Select'),
                    ),
                    DropdownMenuItem(
                      child: Text('Yes'),
                      value: "Yes",
                    ),
                    DropdownMenuItem(
                      child: Text('No'),
                      value: "No",
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _smoke == "Yes"
                ? Row(
                    children: [
                      Flexible(
                          child: FormBuilderDropdown(
                        dropdownColor: Colors.white,
                        name: 'Select Category',
                        decoration: const InputDecoration(
                          labelText: 'Select Category',
                          labelStyle: TextStyle(
                              // fontFamily:
                              //     'Montserrat',
                              fontSize: 14),
                          hintStyle: TextStyle(
                              // fontFamily:
                              //     'Montserrat',
                              fontSize: 14),
                          hintText: 'Select Category',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _smokecomment = value.toString();
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text('Select'),
                          ),
                          DropdownMenuItem(
                            child: Text('Light Smoker'),
                            value: "Light Smoker",
                          ),
                          DropdownMenuItem(
                            child: Text('Moderate Smoker'),
                            value: "Moderate Smoker",
                          ),
                          DropdownMenuItem(
                            child: Text('Current Smoker'),
                            value: "Current Smoker",
                          ),
                          DropdownMenuItem(
                            child: Text('Former Smoker'),
                            value: "Former Smoker",
                          ),
                        ],
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                          child: FormBuilder(
                              child: TextFormField(
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        validator: (Value) {
                          if (Value!.isEmpty) {
                            return 'This Field is Required';
                          }
                          return null;
                        },
                        controller: _smokeDate,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              // BorderSide(color: Colors.blue, width: 0.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 0.5),
                            ),
                            labelText: "Date",
                            filled: true,
                            prefixIcon: Icon(Icons.calendar_today)),
                        readOnly: true,
                        onTap: () {
                          _selectDate();
                        },
                        onFieldSubmitted: (value) {
                          if (value != Null) {
                            setState(() {
                              _smokeDate.text = value.toString().split(" ")[0];
                            });
                          }
                        },
                      ))),
                    ],
                  )
                : SizedBox(
                    height: 20,
                  ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderDropdown(
                  dropdownColor: Colors.white,
                  name: 'Do You Drink Alcohol',
                  decoration: const InputDecoration(
                    labelText: 'Do You Drink Alcohol',
                    labelStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintText: 'Do You Drink Alcohol',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _drink = value.toString();
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text('Select'),
                    ),
                    DropdownMenuItem(
                      child: Text('Yes'),
                      value: "Yes",
                    ),
                    DropdownMenuItem(
                      child: Text('No'),
                      value: "No",
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _drink == "Yes"
                ? Row(
                    children: [
                      Flexible(
                          child: FormBuilderDropdown(
                        dropdownColor: Colors.white,
                        name: 'How Many Per Day',
                        decoration: const InputDecoration(
                          labelText: 'How Many Per Day',
                          labelStyle: TextStyle(
                              // fontFamily:
                              //     'Montserrat',
                              fontSize: 14),
                          hintStyle: TextStyle(
                              // fontFamily:
                              //     'Montserrat',
                              fontSize: 14),
                          hintText: 'How Many Per Day',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _drinkcomment = value.toString();
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text('Select'),
                          ),
                          DropdownMenuItem(
                            child: Text('Light'),
                            value: "Light",
                          ),
                          DropdownMenuItem(
                            child: Text('Moderate '),
                            value: "Moderate ",
                          ),
                          DropdownMenuItem(
                            child: Text('Heavy'),
                            value: "Heavy",
                          ),
                          DropdownMenuItem(
                            child: Text('Very Heavy'),
                            value: "Very Heavy",
                          ),
                        ],
                      )),
                    ],
                  )
                : SizedBox(
                    height: 20,
                  ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                    child: FormBuilderDropdown(
                  dropdownColor: Colors.white,
                  name: 'You Had Sexual Activities',
                  decoration: const InputDecoration(
                    labelText: 'You Had Sexual Activities',
                    labelStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintStyle: TextStyle(
                        // fontFamily:
                        //     'Montserrat',
                        fontSize: 14),
                    hintText: 'You Had Sexual Activities',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 0.5),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _sexualactiviies = value.toString();
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      child: Text('Select'),
                    ),
                    DropdownMenuItem(
                      child: Text('Yes'),
                      value: "Yes",
                    ),
                    DropdownMenuItem(
                      child: Text('No'),
                      value: "No",
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _sexualactiviies == "Yes"
                ? Row(
                    children: [
                      Flexible(
                          child: FormBuilderRadioGroup(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: '',
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                    // fontFamily: 'Montserrat'
                                  )),
                              name: 'Sexual Activities',
                              onChanged: (String? value) {
                                setState(() {
                                  _sexualactiviiestype = value;
                                });
                              },
                              initialValue: _sexualactiviiestype,
                              validator: FormBuilderValidators.required(
                                errorText: 'Kindly Select an option',
                              ),
                              options: [
                            FormBuilderChipOption(value: 'Regular Partner'),
                            FormBuilderChipOption(value: 'Occassional Partner')
                          ])),
                      SizedBox(
                        width: 30,
                      ),
                      Flexible(
                          child: FormBuilderDropdown(
                        dropdownColor: Colors.white,
                        name: 'Protected',
                        decoration: const InputDecoration(
                          labelText: 'Protected',
                          labelStyle: TextStyle(
                              // fontFamily:
                              //     'Montserrat',
                              fontSize: 14),
                          hintStyle: TextStyle(
                              // fontFamily:
                              //     'Montserrat',
                              fontSize: 14),
                          hintText: 'Protected',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _sexualactiviiescomment.text = value.toString();
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text('Select'),
                          ),
                          DropdownMenuItem(
                            child: Text('Yes'),
                            value: "Yes",
                          ),
                          DropdownMenuItem(
                            child: Text('No'),
                            value: "No",
                          ),
                        ],
                      )),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  )
                : Divider(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

// class Questionnaire extends StatefulWidget {
//   const Questionnaire({super.key});

//   @override
//   State<Questionnaire> createState() => _QuestionnaireState();
// }

// class _QuestionnaireState extends State<Questionnaire> {


//   // void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
//   //   setState(() {
//   //     if (args.value is PickerDateRange) {
//   //       _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
//   //           // ignore: lines_longer_than_80_chars
//   //           ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
//   //     } else if (args.value is DateTime) {
//   //       _selectedDate = args.value.toString();
//   //     } else if (args.value is List<DateTime>) {
//   //       _dateCount = args.value.length.toString();
//   //     } else {
//   //       _rangeCount = args.value.length.toString();
//   //     }
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _donationQuestionnaire(),
//     );
//   }
// }
