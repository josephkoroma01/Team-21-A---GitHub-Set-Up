import 'dart:math';

import 'package:cool_stepper/cool_stepper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifebloodworld/features/Donate/views/mresult_screen.dart';
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

class MMyEQuiz extends StatefulWidget {
  MMyEQuiz({
    Key? key,
    required this.country,
    required this.quiz,
  }) : super(key: key);

  String? country;
  String? quiz;

  @override
  State<MMyEQuiz> createState() => MMyEQuizState(
        country: country,
        quiz: quiz,
      );
}

class MMyEQuizState extends State<MMyEQuiz> {
  MMyEQuizState({
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
    _fileExtensionController
        .addListener(() => _extension = _fileExtensionController.text);
    dateinput.text = "";
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

  String? selectedFacility = '';
  String? selectedTimeslot = '';
  String? selectedFarmerType = '';
  String? selectedRegType = '';
  String? selectedGender = '';
  String? selectedPOB = '';
  String? selectedAddress = '';
  String? selectedSP = '';
  String? selectedFA = '';
  String? selectedNaCSA = '';
  String? response = '';
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
  int? selectedMonth;
  final TextEditingController monthinput =
      TextEditingController(text: formattedNewMonth.toString());
  final TextEditingController yearinput =
      TextEditingController(text: formattedNewYear.toString());
  final TextEditingController dateinput =
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
  String? selectedAge = '';

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

  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController _orgname = TextEditingController();
  final TextEditingController _regid = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final steps = [
      CoolStep(
        title: 'QUESTION ONE',
        subtitle: 'AGE',
        isHeaderEnabled: false,
        content: FormBuilder(
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
                children: [
                  Text(
                    'Are you 18-60 years old?',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        letterSpacing: 0),
                  )
                ],
              ),
              10.verticalSpace,
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: _buildNassitSelector(
                              context: context, name: 'Yes')),
                      5.horizontalSpace,
                      Expanded(
                          child: _buildNassitSelector(
                              context: context, name: 'No')),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        validation: () {
          if (!_formKey.currentState!.validate()) {
            return 'Fill form correctly';
          }
          return null;
        },
      ),
      CoolStep(
        title: 'QUESTION ONE',
        subtitle: 'AGE',
        isHeaderEnabled: false,
        content: FormBuilder(
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
                children: [
                  Expanded(
                    child: Text(
                      'Have you had a tattoo in the last 4 months?',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          overflow: TextOverflow.clip,
                          fontSize: 14,
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
                          child: _buildNassitSelector(
                              context: context, name: 'Yes')),
                      5.horizontalSpace,
                      Expanded(
                          child: _buildNassitSelector(
                              context: context, name: 'No')),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        validation: () {
          if (!_formKey.currentState!.validate()) {
            return 'Fill form correctly';
          }
          return null;
        },
      ),
      CoolStep(
        title: 'QUESTION ONE',
        subtitle: 'AGE',
        isHeaderEnabled: false,
        content: FormBuilder(
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
                children: [
                  Expanded(
                    child: Text(
                      'Are you pregnant or recently given birth?',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          overflow: TextOverflow.clip,
                          fontSize: 14,
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
                          child: _buildNassitSelector(
                              context: context, name: 'Yes')),
                      5.horizontalSpace,
                      Expanded(
                          child: _buildNassitSelector(
                              context: context, name: 'No')),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        validation: () {
          if (!_formKey.currentState!.validate()) {
            return 'Fill form correctly';
          }
          return null;
        },
      )
    
    ];
    final stepper = CoolStepper(
      config: CoolStepperConfig(
        stepText: 'QUESTION',
      ),

      // contentPadding: EdgeInsets.all(10),
      showErrorSnackbar: false,
      onCompleted: () async {
        if (await getInternetUsingInternetConnectivity()) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MAnalysisScreen()),
              (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'You are offline, Kindly turn on Wifi or Mobile Data to continue',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(fontSize: 10.sp)),
            backgroundColor: Color(0xFFE02020),
            behavior: SnackBarBehavior.fixed,
            duration: const Duration(seconds: 10),
            // duration: Duration(seconds: 3),
          ));
        }
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
            'Eligibility Quiz',
            style: TextStyle(color: kPrimaryColor, fontSize: 18),
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

  Widget _buildFASelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == fa;
    final isActiveFilled = name == selectedFA;
    return Expanded(
      child: fa.toString().isNotEmpty
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
                groupValue: fa,
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
                groupValue: selectedFA,
                onChanged: (String? v) {
                  setState(() {
                    selectedFA = v;
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

  Widget _buildNassitSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == response;
    ;
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
          groupValue: response,
          onChanged: (String? v) {
            setState(() {
              response = v;
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
