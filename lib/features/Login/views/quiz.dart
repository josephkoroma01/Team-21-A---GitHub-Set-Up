import 'dart:math';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifebloodworld/features/Login/views/result_screen.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:lifebloodworld/widgets/custom_button.dart';
import 'package:lifebloodworld/widgets/custom_textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lifebloodworld/constants/colors.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cool_stepper_reloaded/cool_stepper_reloaded.dart';

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
String formattedMonth = DateFormat('M').format(now);
String formattedNewYear = DateFormat('y').format(now);

class MyEQuiz extends StatefulWidget {
  MyEQuiz({
    Key? key,
    required this.country,
    required this.quiz,
  }) : super(key: key);

  String? country;
  String? quiz;

  @override
  State<MyEQuiz> createState() => MyEQuizState(
        country: country,
        quiz: quiz,
      );
}

class MyEQuizState extends State<MyEQuiz> {
  MyEQuizState({
    Key? key,
    required this.country,
    required this.quiz,
  });

  String query = '';
  GlobalKey _scaffold = GlobalKey();
  final _formKey = GlobalKey<FormBuilderState>();

  String? country;
  String? quiz;
  String? farmertype;
  String? firstname;
  String? lastname;
  String? othername;
  String? nin;
  String? gender;
  String? dob;
  String? pob;
  String? orgname;
  String? regtype;
  String? regid;
  String? proof;
  String? address;
  String? phoneno1;
  String? phoneno2;
  String? phoneno3;
  String? fa;
  String? serviceprovider;
  String? accountno;
  String? nacsascheme;
  String? nacsaschemeuid;
  String? nassitpensioner;
  String? nassituid;
  String? tin;
  String? nassiterno;
  String? lgbusineslicense;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final _defaultFileNameController = TextEditingController();
  final _dialogTitleController = TextEditingController();
  final _initialDirectoryController = TextEditingController();
  final _fileExtensionController = TextEditingController();
  String? _fileName;
  String? _saveAsFileName;

  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _lockParentWindow = false;
  bool _userAborted = false;
  bool _multiPick = false;

  List facilityList = [];
  List timeslotList = [];

  @override
  void initState() {
    super.initState();
  }

  // String? _fruid;
  String? _farmertype;

  // String? _gender;
  // String? _dob;
  // String? _pob;
  // String? _orgname;
  // String? _regtype;
  // String? _regid;
  // String? _proof;
  // String? _address;
  // String? _phoneno1;
  // String? _phoneno2;
  // String? _phoneno3;
  // String? _fa;
  // String? _serviceprovider;
  // String? _accountno;
  // String? _nacsascheme;
  // String? _nacsaschemeuid;
  // String? _nassitpensioner;
  // String? _nassituid;
  // String? _tin;
  // String? _nassiterno;
  // String? _lgbusineslicense;
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

  final List<String> districtlist = [
    'Bo',
    'Bombali',
    'Bonthe',
    'Falaba',
    'Kailahun',
    'Kambia',
    'Karene',
    'Kenema',
    'Koindadugu',
    'Kono',
    'Moyamba',
    'Port Loko',
    'Pujehun',
    'Tonkolili',
    'Western Rural',
    'Western Urban'
  ];

  final List<String> reglist = ['Private', 'Public', 'Sole Prop'];

  String? selectedWeight = '';
  String? selectedFeverColdFlu = '';
  String? selectedWellandHealth = '';
  String? selectedEaten = '';
  String? selectedHospital = '';
  String? selecteDisease = '';
  String? selectedMedication = '';
  String? selectedSurgical = '';
  String? selectedTravel = '';
  String? selectedNaCSA = '';
  String? selectedDonated = '';
  String? selectedDonatedLast = '';
  String? selectedPreg = '';
  String? selectedMens = '';
  String? selectedTattoo = '';
  TextEditingController dateInput = TextEditingController();
  TextEditingController _nin = TextEditingController();
  TextEditingController _fruid = TextEditingController();
  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  TextEditingController _othername = TextEditingController();
  TextEditingController _accountno = TextEditingController();
  TextEditingController _phoneno1 = TextEditingController();
  TextEditingController _phoneno2 = TextEditingController();
  TextEditingController _phoneno3 = TextEditingController();
  TextEditingController _tin = TextEditingController();
  TextEditingController _nacsauid = TextEditingController();
  TextEditingController _nassituid = TextEditingController();
  TextEditingController _nassiterno = TextEditingController();
  TextEditingController _lgbusinesslicense = TextEditingController();
  int? selectedYear;
  int? selectedDay;
  int? selectedMonths;
  String? selectedMonth = '';
  final TextEditingController monthinput =
      TextEditingController(text: formattedMonth.toString());
  final TextEditingController yearinput =
      TextEditingController(text: formattedNewYear.toString());
  final TextEditingController dateinput = TextEditingController();
  final TextEditingController sdateinput =
      TextEditingController(text: formattedNewDate.toString());
  final TextEditingController dobdateinput =
      TextEditingController(text: formattedNewDate.toString());

  String dropdownValue = 'Select Facility';
  String bloodtestfor = 'Myself';
  bool _scheduling = false;

  final TextEditingController refCodeCtrl = TextEditingController(
    text: randomAlphaNumeric(8).toString(),
  );

  String? selectedAgeCategory = '';
  String? selectedGender = '';
  String? selectedAge = '';

  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController _orgname = TextEditingController();
  final TextEditingController _regid = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final steps = [
      CoolStep(
        content: Form(
            key: _formKey,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/lifebloodlogo.png",
                    height: 150.h,
                    width: 150.w,
                    // width: size.width * 0.4,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Select Gender',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              overflow: TextOverflow.clip,
                              fontSize: 14.spMax,
                              letterSpacing: 0),
                        ),
                      )
                    ],
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
                ],
              ),
            )),
        validation: () {
          if (selectedGender!.isEmpty) {
            return 'Please Select Age Category';
          }
          return null;
        },
      ),
      CoolStep(
        title: 'QUESTION TWO',
        subtitle: 'AGE',
        content: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/lifebloodlogo.png",
                    height: 150.h,
                    width: 150.w,
                    // width: size.width * 0.4,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Select Age Category',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          overflow: TextOverflow.clip,
                          fontSize: 14.spMax,
                          letterSpacing: 0),
                    ),
                  )
                ],
              ),
              10.verticalSpace,
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: _buildAgeCategorySelector(
                              context: context, name: '<18')),
                      5.horizontalSpace,
                      Expanded(
                          child: _buildAgeCategorySelector(
                              context: context, name: '18-24')),
                    ],
                  ),
                  10.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                          child: _buildAgeCategorySelector(
                              context: context, name: '25-44')),
                      5.horizontalSpace,
                      Expanded(
                          child: _buildAgeCategorySelector(
                              context: context, name: '45-64')),
                    ],
                  ),
                  10.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                          child: _buildAgeCategorySelector(
                              context: context, name: '65+')),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        validation: () {
          if (selectedAgeCategory!.isEmpty) {
            return 'Please Select Age Category';
          }
          return null;
        },
      ),
      CoolStep(
        title: 'QUESTION THREE',
        subtitle: 'AGE',
        content: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/lifebloodlogo.png",
                    height: 150.h,
                    width: 150.w,
                    // width: size.width * 0.4,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Select Weight',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          overflow: TextOverflow.clip,
                          fontSize: 14.spMax,
                          letterSpacing: 0),
                    ),
                  )
                ],
              ),
              10.verticalSpace,
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: _buildWeightSelector(
                              context: context, name: '<50kg')),
                      5.horizontalSpace,
                      Expanded(
                          child: _buildWeightSelector(
                              context: context, name: '>50kg')),
                    ],
                  ),
                  10.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                          child: _buildWeightSelector(
                              context: context, name: "No Idea")),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        validation: () {
          if (selectedWeight!.isEmpty) {
            return 'Please Select Weight';
          }
          return null;
        },
      ),
      CoolStep(
        title: 'QUESTION ONE',
        subtitle: 'AGE',
        content: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/lifebloodlogo.png",
                    height: 150.h,
                    width: 150.w,
                    // width: size.width * 0.4,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      'Have you had a fever, cold,\nor flu in the past week?',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          overflow: TextOverflow.clip,
                          fontSize: 14.spMax,
                          letterSpacing: 0),
                    ),
                  )
                ],
              ),
              10.verticalSpace,
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: _buildFeverColdFluSelector(
                              context: context, name: 'Yes')),
                      5.horizontalSpace,
                      Expanded(
                          child: _buildFeverColdFluSelector(
                              context: context, name: 'No')),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        validation: () {
          if (selectedFeverColdFlu!.isEmpty) {
            return 'Please select an option';
          }
          return null;
        },
      ),
      CoolStep(
        title: 'QUESTION ONE',
        subtitle: 'AGE',
        content: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/lifebloodlogo.png",
                    height: 150.h,
                    width: 150.w,
                    // width: size.width * 0.4,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Are you feeling well\nand in good health today?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          overflow: TextOverflow.clip,
                          fontSize: 14.spMax,
                          letterSpacing: 0),
                    ),
                  )
                ],
              ),
              10.verticalSpace,
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: _buildWellandHealthSelector(
                              context: context, name: 'Yes')),
                      5.horizontalSpace,
                      Expanded(
                          child: _buildWellandHealthSelector(
                              context: context, name: 'No')),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        validation: () {
          if (selectedWellandHealth!.isEmpty) {
            return 'Please select an option';
          }
          return null;
        },
      ),
      CoolStep(
        title: 'QUESTION ONE',
        subtitle: 'AGE',
        content: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/lifebloodlogo.png",
                    height: 150.h,
                    width: 150.w,
                    // width: size.width * 0.4,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Have you eaten in the last 6 hours?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          overflow: TextOverflow.clip,
                          fontSize: 14.spMax,
                          letterSpacing: 0),
                    ),
                  )
                ],
              ),
              10.verticalSpace,
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: _buildEatenSelector(
                              context: context, name: 'Yes')),
                      5.horizontalSpace,
                      Expanded(
                          child: _buildEatenSelector(
                              context: context, name: 'No')),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        validation: () {
          if (selectedEaten!.isEmpty) {
            return 'Please select an option';
          }
          return null;
        },
      ),
      CoolStep(
        title: 'QUESTION ONE',
        subtitle: 'AGE',
        content: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/lifebloodlogo.png",
                    height: 150.h,
                    width: 150.w,
                    // width: size.width * 0.4,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Have you recently been hospitalised or receieved blood transfusion ?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          overflow: TextOverflow.clip,
                          fontSize: 14.spMax,
                          letterSpacing: 0),
                    ),
                  )
                ],
              ),
              10.verticalSpace,
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: _buildHospitalSelector(
                              context: context, name: 'Yes')),
                      5.horizontalSpace,
                      Expanded(
                          child: _buildHospitalSelector(
                              context: context, name: 'No')),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        validation: () {
          if (selectedHospital!.isEmpty) {
            return 'Please select an option';
          }
          return null;
        },
      ),
      CoolStep(
        title: 'QUESTION ONE',
        subtitle: 'AGE',
        content: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/lifebloodlogo.png",
                    height: 150.h,
                    width: 150.w,
                    // width: size.width * 0.4,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              'Do you have any of the following diseases?\n\n',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            overflow: TextOverflow.clip,
                            fontSize: 14.spMax,
                            letterSpacing: 0,
                          ),
                        ),
                        TextSpan(
                          children: [
                            // Column 1 with bullet points
                            TextSpan(
                              text: '  • Lung diseases\n'
                                  '  • Kidney diseases\n'
                                  '  • Tuberculosis\n'
                                  '  • Thyroid disorder\n'
                                  '  • Asthma\n'
                                  '  • Swollen glands\n'
                                  '  • Persistent cough\n'
                                  '  • Epilepsy\n'
                                  '  • Rheumatic fever\n'
                                  '  • Cancer\n'
                                  '  • Anaemia\n'
                                  '  • Shingles\n'
                                  '  • Circulation problems\n'
                                  '  • Low/high blood pressure\n'
                                  '  • Dizziness\n'
                                  '  • Excessive epistaxis (Nose Bleeding)\n'
                                  '  • Sleeping sickness\n'
                                  '  • Abdominal diseases\n'
                                  '  • Hepatitis/jaundice\n'
                                  '  • Brucellosis\n'
                                  '  • Prolonged diarrhoea\n'
                                  '  • Sexually transmitted disease\n'
                                  '  • Diabetes\n'
                                  '  • Sickle cell diseases\n',
                              style: TextStyle(
                                fontSize: 14.spMax,
                              ),
                            ),

                            // Column 2 with bullet points and indentation

                            // Continue with the remaining diseases in columns
                          ],
                          style: TextStyle(
                              // Left-align each column
                              ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              10.verticalSpace,
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: _buildDiseaseSelector(
                              context: context, name: 'Yes')),
                      5.horizontalSpace,
                      Expanded(
                          child: _buildDiseaseSelector(
                              context: context, name: 'No')),
                    ],
                  ),
                ],
              ),
              10.verticalSpace,
            ],
          ),
        ),
        validation: () {
          if (selecteDisease!.isEmpty) {
            return 'Please select an option';
          }
          return null;
        },
      ),
      CoolStep(
        title: 'QUESTION ONE',
        subtitle: 'AGE',
        content: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/lifebloodlogo.png",
                    height: 150.h,
                    width: 150.w,
                    // width: size.width * 0.4,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Are you taking or have you recently taken any medication like aspirin, antibiotics, steroids, injections, or recent vaccination?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          overflow: TextOverflow.clip,
                          fontSize: 14.spMax,
                          letterSpacing: 0),
                    ),
                  )
                ],
              ),
              10.verticalSpace,
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: _buildMedicationSelector(
                              context: context, name: 'Yes')),
                      5.horizontalSpace,
                      Expanded(
                          child: _buildMedicationSelector(
                              context: context, name: 'No')),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        validation: () {
          if (selectedMedication!.isEmpty) {
            return 'Please select an option';
          }
          return null;
        },
      ),
      CoolStep(
        title: 'QUESTION ONE',
        subtitle: 'AGE',
        content: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/lifebloodlogo.png",
                    height: 150.h,
                    width: 150.w,
                    // width: size.width * 0.4,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Have you had any\nsurgical operation recently?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          overflow: TextOverflow.clip,
                          fontSize: 14.spMax,
                          letterSpacing: 0),
                    ),
                  )
                ],
              ),
              10.verticalSpace,
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: _buildSurgicalSelector(
                              context: context, name: 'Yes')),
                      5.horizontalSpace,
                      Expanded(
                          child: _buildSurgicalSelector(
                              context: context, name: 'No')),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        validation: () {
          if (selectedSurgical!.isEmpty) {
            return 'Please select an option';
          }
          return null;
        },
      ),
      CoolStep(
        title: 'QUESTION ONE',
        subtitle: 'AGE',
        content: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/lifebloodlogo.png",
                    height: 150.h,
                    width: 150.w,
                    // width: size.width * 0.4,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Have you had any tattoo\nor acupuncuture recently\n(In the last 4 month)?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          overflow: TextOverflow.clip,
                          fontSize: 14.spMax,
                          letterSpacing: 0),
                    ),
                  )
                ],
              ),
              10.verticalSpace,
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: _buildTattooSelector(
                              context: context, name: 'Yes')),
                      5.horizontalSpace,
                      Expanded(
                          child: _buildTattooSelector(
                              context: context, name: 'No')),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        validation: () {
          if (selectedTattoo!.isEmpty) {
            return 'Please select an option';
          }
          return null;
        },
      ),
      CoolStep(
        title: 'QUESTION ONE',
        subtitle: 'AGE',
        content: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/lifebloodlogo.png",
                    height: 150.h,
                    width: 150.w,
                    // width: size.width * 0.4,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Any recent travel to endemic areas with high infectious disease\n(COVID-19, Ebola, Tuberculosis)\nor have you been in close contact with someone who has an infectious disease?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          overflow: TextOverflow.clip,
                          fontSize: 14.spMax,
                          letterSpacing: 0),
                    ),
                  )
                ],
              ),
              10.verticalSpace,
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: _buildTravelSelector(
                              context: context, name: 'Yes')),
                      5.horizontalSpace,
                      Expanded(
                          child: _buildTravelSelector(
                              context: context, name: 'No')),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        validation: () {
          if (selectedTravel!.isEmpty) {
            return 'Please select an option';
          }
          return null;
        },
      ),
      CoolStep(
        title: 'QUESTION ONE',
        subtitle: 'AGE',
        content: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/lifebloodlogo.png",
                    height: 150.h,
                    width: 150.w,
                    // width: size.width * 0.4,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Have you donated blood recently?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          overflow: TextOverflow.clip,
                          fontSize: 14.spMax,
                          letterSpacing: 0),
                    ),
                  )
                ],
              ),
              10.verticalSpace,
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: _buildDonatedSelector(
                              context: context, name: 'Yes')),
                      5.horizontalSpace,
                      Expanded(
                          child: _buildDonatedSelector(
                              context: context, name: 'No')),
                    ],
                  ),
                ],
              ),
              15.verticalSpace,
              selectedDonated == "Yes"
                  ? Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                'When was the last time\nyou donated blood?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    overflow: TextOverflow.clip,
                                    fontSize: 14.spMax,
                                    letterSpacing: 0),
                              ),
                            )
                          ],
                        ),
                        10.verticalSpace,
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: _buildDonatedLastSelector(
                                        context: context, name: 'This Month')),
                                5.horizontalSpace,
                                Expanded(
                                    child: _buildDonatedLastSelector(
                                        context: context, name: 'Last Month'))
                              ],
                            ),
                            10.verticalSpace,
                            Row(
                              children: [
                                Expanded(
                                    child: _buildDonatedLastSelector(
                                        context: context,
                                        name: 'Last 3 Month')),
                                5.horizontalSpace,
                                Expanded(
                                    child: _buildDonatedLastSelector(
                                        context: context, name: 'Last 4 Month'))
                              ],
                            ),
                            10.verticalSpace,
                            Row(
                              children: [
                                Expanded(
                                    child: _buildDonatedLastSelector(
                                        context: context,
                                        name: 'Last 6 Month')),
                                5.horizontalSpace,
                                Expanded(
                                    child: _buildDonatedLastSelector(
                                        context: context, name: '> 6 Month'))
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  : SizedBox(),
            ],
          ),
        ),
        validation: () {
          if (selectedDonated!.isEmpty) {
            return 'Please select an option';
          } else if (selectedDonated == "Yes" && selectedDonatedLast!.isEmpty) {
            return 'Please select your last donation period';
          }
          return null;
        },
      ),
      CoolStep(
        title: 'QUESTION ONE',
        subtitle: 'AGE',
        content: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/lifebloodlogo.png",
                      height: 150.h,
                      width: 150.w,
                      // width: size.width * 0.4,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(0)),
                  child: Text(
                    'Women-Specific Questions',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                5.verticalSpace,
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(0)),
                  child: Text(
                    'Please Click Finish',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                10.verticalSpace,
                selectedGender == "Female"
                    ? Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  'Are you currently pregnant, breastfeeding or recently given birth in the past six months?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      overflow: TextOverflow.clip,
                                      fontSize: 14.spMax,
                                      letterSpacing: 0),
                                ),
                              )
                            ],
                          ),
                          10.verticalSpace,
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: _buildPregnantSelector(
                                          context: context, name: 'Yes')),
                                  5.horizontalSpace,
                                  Expanded(
                                      child: _buildPregnantSelector(
                                          context: context, name: 'No')),
                                ],
                              ),
                            ],
                          ),
                          15.verticalSpace,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  'Are you on your period (menstrual cycle)?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      overflow: TextOverflow.clip,
                                      fontSize: 14.spMax,
                                      letterSpacing: 0),
                                ),
                              )
                            ],
                          ),
                          10.verticalSpace,
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: _buildMenstrualSelector(
                                          context: context, name: 'Yes')),
                                  5.horizontalSpace,
                                  Expanded(
                                      child: _buildMenstrualSelector(
                                          context: context, name: 'No')),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
        validation: () {
          if (selectedGender == "Female" && selectedMens == null) {
            return 'Fill form correctly';
          }
          return null;
        },
      ),
    ];
    final stepper = CoolStepper(
      isHeaderEnabled: false,

      config: CoolStepperConfig(
          stepColor: Color(0xFFe0e9e4),
          headerColor: Color(0xFFe0e9e4),
          stepText: 'QUESTION',
          nextButton: TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.teal),
                  ); // Define a different border shape for the pressed state
                }
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(color: Colors.teal),
                ); // Define the default border shape
              }),
              backgroundColor:
                  MaterialStateColor.resolveWith((Set<MaterialState> states) {
                return Colors
                    .teal; // Always return white regardless of the button state
              }),
            ),
            child: Text(
              'Next',
              style: TextStyle(fontFamily: 'Montserrat', color: kWhiteColor),
            ),
            onPressed: () {},
          ),
          backButton: TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: kLifeBloodBlue),
                  ); // Define a different border shape for the pressed state
                }
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(color: kLifeBloodBlue),
                ); // Define the default border shape
              }),
              backgroundColor:
                  MaterialStateColor.resolveWith((Set<MaterialState> states) {
                return kLifeBloodBlue; // Always return white regardless of the button state
              }),
            ),
            child: Text(
              'Back',
              style: TextStyle(fontFamily: 'Montserrat', color: kWhiteColor),
            ),
            onPressed: () {},
          ),
          finishButton: TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.green),
                  ); // Define a different border shape for the pressed state
                }
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(color: Colors.green),
                ); // Define the default border shape
              }),
              backgroundColor:
                  MaterialStateColor.resolveWith((Set<MaterialState> states) {
                return Colors
                    .green; // Always return white regardless of the button state
              }),
            ),
            child: Text(
              'Finish',
              style: TextStyle(fontFamily: 'Montserrat', color: kWhiteColor),
            ),
            onPressed: () {},
          ),
          stepOfTextStyle:
              TextStyle(color: kPrimaryColor, fontFamily: 'Montserrat')),

      // contentPadding: EdgeInsets.all(10),
      showErrorSnackbar: true,
      onCompleted: () async {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => EAnalysisScreen(
                      country: country,
                      gender: selectedGender.toString(),
                      agecategory: selectedAgeCategory.toString(),
                      weight: selectedWeight.toString(),
                      cold: selectedFeverColdFlu.toString(),
                      goodhealth: selectedWellandHealth.toString(),
                      eaten: selectedEaten.toString(),
                      hospital: selectedHospital.toString(),
                      disease: selecteDisease.toString(),
                      medication: selectedMedication.toString(),
                      surgical: selectedSurgical.toString(),
                      tattoo: selectedTattoo.toString(),
                      travel: selectedTravel.toString(),
                      pdonated: selectedDonated.toString(),
                      wdonated: selectedDonatedLast.toString(),
                      pregnant: selectedPreg.toString(),
                      mens: selectedMens,
                    )),
            (route) => false);
      },
      steps: steps,
    );

    return Scaffold(
      backgroundColor: Color(0xFFe0e9e4),
      appBar: AppBar(
          backgroundColor: Color(0xFFe0e9e4),
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(
            'Blood Donation Eligibility Survey',
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: 15.spMax,
                fontWeight: FontWeight.bold),
          )),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          child: stepper,
        ),
      ),
    );
  }

  Widget _buildBloodTypeSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == farmertype;

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
          toggleable: false,
          value: name,
          activeColor: Colors.white,
          groupValue: farmertype,
          onChanged: null,
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

  Widget _buildGenderTypeSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == gender;
    final isActiveFilled = name == selectedGender;
    return Expanded(
      child: gender.toString().isNotEmpty
          ? AnimatedContainer(
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
                toggleable: false,
                value: name,
                activeColor: Colors.white,
                groupValue: gender,
                onChanged: null,
                title: Text(
                  name,
                  style: TextStyle(
                    color: isActive ? Colors.white : null,
                    // fontSize: width * 0.035,
                  ),
                ),
              ))
          : AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: isActiveFilled ? Theme.of(context!).primaryColor : null,
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
                    color: isActiveFilled ? Colors.white : null,
                    // fontSize: width * 0.035,
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildAgeCategorySelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedAgeCategory;
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
          groupValue: selectedAgeCategory,
          onChanged: (String? v) {
            setState(() {
              selectedAgeCategory = v;
            });
          },
          title: Column(
            children: [
              Text(
                name,
                style: TextStyle(
                    color: isActive ? Colors.white : null, fontSize: 14.spMax),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeightSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedWeight;
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
          groupValue: selectedWeight,
          onChanged: (String? v) {
            setState(() {
              selectedWeight = v;
            });
          },
          title: Column(
            children: [
              Text(
                name,
                style: TextStyle(
                    color: isActive ? Colors.white : null, fontSize: 14.spMax),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeverColdFluSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedFeverColdFlu;
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
          groupValue: selectedFeverColdFlu,
          onChanged: (String? v) {
            setState(() {
              selectedFeverColdFlu = v;
            });
          },
          title: Column(
            children: [
              Text(
                name,
                style: TextStyle(
                    color: isActive ? Colors.white : null, fontSize: 14.spMax),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWellandHealthSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedWellandHealth;
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
          groupValue: selectedWellandHealth,
          onChanged: (String? v) {
            setState(() {
              selectedWellandHealth = v;
            });
          },
          title: Column(
            children: [
              Text(
                name,
                style: TextStyle(
                    color: isActive ? Colors.white : null, fontSize: 14.spMax),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEatenSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedEaten;
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
          groupValue: selectedEaten,
          onChanged: (String? v) {
            setState(() {
              selectedEaten = v;
            });
          },
          title: Column(
            children: [
              Text(
                name,
                style: TextStyle(
                    color: isActive ? Colors.white : null, fontSize: 14.spMax),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHospitalSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedHospital;
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
          groupValue: selectedHospital,
          onChanged: (String? v) {
            setState(() {
              selectedHospital = v;
            });
          },
          title: Column(
            children: [
              Text(
                name,
                style: TextStyle(
                    color: isActive ? Colors.white : null, fontSize: 14.spMax),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiseaseSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selecteDisease;
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
          groupValue: selecteDisease,
          onChanged: (String? v) {
            setState(() {
              selecteDisease = v;
            });
          },
          title: Column(
            children: [
              Text(
                name,
                style: TextStyle(
                    color: isActive ? Colors.white : null, fontSize: 14.spMax),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMedicationSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedMedication;
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
          groupValue: selectedMedication,
          onChanged: (String? v) {
            setState(() {
              selectedMedication = v;
            });
          },
          title: Text(
            name,
            style: TextStyle(
                color: isActive ? Colors.white : null, fontSize: 14.spMax),
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
                color: isActive ? Colors.white : null, fontSize: 14.spMax),
          ),
        ),
      ),
    );
  }

  Widget _buildSurgicalSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedSurgical;
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
          groupValue: selectedSurgical,
          onChanged: (String? v) {
            setState(() {
              selectedSurgical = v;
            });
          },
          title: Column(
            children: [
              Text(
                name,
                style: TextStyle(
                    color: isActive ? Colors.white : null, fontSize: 14.spMax),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTattooSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedTattoo;
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
          groupValue: selectedTattoo,
          onChanged: (String? v) {
            setState(() {
              selectedTattoo = v;
            });
          },
          title: Column(
            children: [
              Text(
                name,
                style: TextStyle(
                    color: isActive ? Colors.white : null, fontSize: 14.spMax),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTravelSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedTravel;
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
          groupValue: selectedTravel,
          onChanged: (String? v) {
            setState(() {
              selectedTravel = v;
            });
          },
          title: Column(
            children: [
              Text(
                name,
                style: TextStyle(
                    color: isActive ? Colors.white : null, fontSize: 14.spMax),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDonatedSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedDonated;
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
          groupValue: selectedDonated,
          onChanged: (String? v) {
            setState(() {
              selectedDonated = v;
            });
          },
          title: Column(
            children: [
              Text(
                name,
                style: TextStyle(
                    color: isActive ? Colors.white : null, fontSize: 14.spMax),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDonatedLastSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedDonatedLast;
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
          groupValue: selectedDonatedLast,
          onChanged: (String? v) {
            setState(() {
              selectedDonatedLast = v;
            });
          },
          title: Column(
            children: [
              Text(
                name,
                style: TextStyle(
                    color: isActive ? Colors.white : null, fontSize: 14.spMax),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPregnantSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedPreg;
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
          groupValue: selectedPreg,
          onChanged: (String? v) {
            setState(() {
              selectedPreg = v;
            });
          },
          title: Column(
            children: [
              Text(
                name,
                style: TextStyle(
                    color: isActive ? Colors.white : null, fontSize: 14.spMax),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenstrualSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedMens;
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
          groupValue: selectedMens,
          onChanged: (String? v) {
            setState(() {
              selectedMens = v;
            });
          },
          title: Column(
            children: [
              Text(
                name,
                style: TextStyle(
                    color: isActive ? Colors.white : null, fontSize: 14.spMax),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNaCSASelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == nacsascheme;
    final isActiveFilled = name == selectedNaCSA;
    return Expanded(
      child: nacsascheme.toString().isNotEmpty
          ? AnimatedContainer(
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
                toggleable: false,
                value: name,
                activeColor: Colors.white,
                groupValue: nacsascheme,
                onChanged: null,
                title: Text(
                  name,
                  style: TextStyle(
                    color: isActive ? Colors.white : null,
                    // fontSize: width * 0.035,
                  ),
                ),
              ))
          : AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: isActiveFilled ? Theme.of(context!).primaryColor : null,
                border: Border.all(
                  width: 0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: RadioListTile(
                value: name,
                activeColor: Colors.white,
                groupValue: selectedNaCSA,
                onChanged: (String? v) {
                  setState(() {
                    selectedNaCSA = v;
                  });
                },
                title: Text(
                  name,
                  style: TextStyle(
                    color: isActiveFilled ? Colors.white : null,
                    // fontSize: width * 0.035,
                  ),
                ),
              ),
            ),
    );
  }
}
