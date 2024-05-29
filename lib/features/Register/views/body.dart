import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:lifebloodworld/constants/colors.dart';
import 'package:lifebloodworld/features/Home/models/donorregistered.dart';
import 'package:lifebloodworld/features/Login/views/login_screen.dart';
import 'package:lifebloodworld/features/Register/views/tour.dart';
import 'package:pinput/pinput.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:url_launcher/url_launcher.dart';

DateTime now = DateTime.now();
String formattedNewDate = DateFormat('d LLLL yyyy').format(now);
String formattedNewMonth = DateFormat('LLLL').format(now);
String formattedNewYear = DateFormat('y').format(now);
dynamic year = DateFormat('y').format(now);

class RegisterPage extends StatefulWidget {
  RegisterPage({
    Key? key,
  }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  final List<String> countrylist = [
    'Sierra Leone',
    'Benin',
  ];

  String? id,
      email,
      password,
      ufname,
      umname,
      ulname,
      agecategory,
      gender,
      nin,
      phonenumber,
      address,
      district,
      bloodtype,
      prevdonation,
      prevdonationamt,
      community,
      date,
      month,
      year;

  final List<String> sldistrictlist = [
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

  final List<String> lbdistrictlist = [
    'Bomi',
    'Bong',
    'Gbarpolu',
    'Grand',
    'Bassa',
    'Grand Gedeh',
    'Grand Kru',
    'Lofa',
    'Margibi',
    'Maryland',
    'Montserrado',
    'Nimba',
    'Rivercess',
    'River Gee'
        'Sinoe'
  ];

  final List<String> cmdistrictlist = [
    'Adamawa Region',
    'Centre Region',
    'East Region',
    'Far North Region',
    'Littoral Region',
    'North Region',
    'North West Region',
    'West Region',
    'South Region',
    'South West Region'
  ];

  final List<String> bndistrictlist = [
    'Alibori',
    'Atakora',
    'Atlantique',
    'Borgou',
    'Collines',
    'Donga',
    'Kouffo',
    'Littoral Region',
    'Mono',
    'Ouémé',
    'Plateau',
    'Zou'
  ];

  final List<String> gdistrictlist = [
    'Banjul',
    'Western',
    'North Bank',
    'Lower River',
    'Central River',
    'Upper River'
  ];

  final List<String> countrygrouplist = [
    'Sierra Leone',
    'Afghanistan',
    'Albania',
    'Algeria',
    'Andorra',
    'Angola',
    'Antigua and Barbuda',
    'Argentina',
    'Armenia',
    'Australia',
    'Austria',
    'Azerbaijan',
    'Bahamas',
    'Bahrain',
    'Bangladesh',
    'Barbados',
    'Belarus',
    'Belgium',
    'Belize',
    'Benin',
    'Bhutan',
    'Bolivia',
    'Bosnia and Herzegovina',
    'Botswana',
    'Brazil',
    'Brunei',
    'Bulgaria',
    'Burkina Faso',
    'Burundi',
    'Cabo Verde',
    'Cambodia',
    'Cameroon',
    'Canada',
    'Central African Republic',
    'Chad',
    'Chile',
    'China',
    'Colombia',
    'Comoros',
    'Congo',
    'Costa Rica',
    'Croatia',
    'Cuba',
    'Cyprus',
    'Czech Republic',
    'Denmark',
    'Djibouti',
    'Dominica',
    'Dominican Republic',
    'East Timor (Timor-Leste)',
    'Ecuador',
    'Egypt',
    'El Salvador',
    'Equatorial Guinea',
    'Eritrea',
    'Estonia',
    'Eswatini',
    'Ethiopia',
    'Fiji',
    'Finland',
    'France',
    'Gabon',
    'Gambia',
    'Georgia',
    'Germany',
    'Ghana',
    'Greece',
    'Grenada',
    'Guatemala',
    'Guinea',
    'Guinea-Bissau',
    'Guyana',
    'Haiti',
    'Honduras',
    'Hungary',
    'Iceland',
    'India',
    'Indonesia',
    'Iran',
    'Iraq',
    'Ireland',
    'Israel',
    'Italy',
    'Jamaica',
    'Japan',
    'Jordan',
    'Kazakhstan',
    'Kenya',
    'Kiribati',
    'Korea, North',
    'Korea, South',
    'Kosovo',
    'Kuwait',
    'Kyrgyzstan',
    'Laos',
    'Latvia',
    'Lebanon',
    'Lesotho',
    'Liberia',
    'Libya',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Madagascar',
    'Malawi',
    'Malaysia',
    'Maldives',
    'Mali',
    'Malta',
    'Marshall Islands',
    'Mauritania',
    'Mauritius',
    'Mexico',
    'Micronesia',
    'Moldova',
    'Monaco',
    'Mongolia',
    'Montenegro',
    'Morocco',
    'Mozambique',
    'Myanmar (Burma)',
    'Namibia',
    'Nauru',
    'Nepal',
    'Netherlands',
    'New Zealand',
    'Nicaragua',
    'Niger',
    'Nigeria',
    'North Macedonia',
    'Norway',
    'Oman',
    'Pakistan',
    'Palau',
    'Palestine',
    'Panama',
    'Papua New Guinea',
    'Paraguay',
    'Peru',
    'Philippines',
    'Poland',
    'Portugal',
    'Qatar',
    'Romania',
    'Russia',
    'Rwanda',
    'Saint Kitts and Nevis',
    'Saint Lucia',
    'Saint Vincent and the Grenadines',
    'Samoa',
    'San Marino',
    'Sao Tome and Principe',
    'Saudi Arabia',
    'Senegal',
    'Serbia',
    'Seychelles',
    'Singapore',
    'Slovakia',
    'Slovenia',
    'Solomon Islands',
    'Somalia',
    'South Africa',
    'South Sudan',
    'Spain',
    'Sri Lanka',
    'Sudan',
    'Suriname',
    'Sweden',
    'Switzerland',
    'Syria',
    'Taiwan',
    'Tajikistan',
    'Tanzania',
    'Thailand',
    'Togo',
    'Tonga',
    'Trinidad and Tobago',
    'Tunisia',
    'Turkey',
    'Turkmenistan',
    'Tuvalu',
    'Uganda',
    'Ukraine',
    'United Arab Emirates',
    'United Kingdom',
    'United States',
    'Uruguay',
    'Uzbekistan',
    'Vanuatu',
    'Vatican City',
    'Venezuela',
    'Vietnam',
    'Yemen',
    'Zambia',
    'Zimbabwe',
  ];

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

  String? selectedBloodType = '';
  String? selectedAgeCategory = '';
  String? selectedAge = '';
  String? selectedDistrict = '';
  String? selectedDepartment = '';
  String? selectedCountry;
  String? selectedGender = '';
  String? selectedMiddleName = '';
  String? selectedPrevDonation = '';
  String? selectedValue;
  final date2 = DateTime.now();
  TextEditingController dateInput = TextEditingController();
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
  final TextEditingController _addressCtrl = TextEditingController();
  final TextEditingController _ageCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _donoridCtrl = TextEditingController();
  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _firstnameCtrl = TextEditingController();
  final TextEditingController _fullnameCtrl = TextEditingController();
  final TextEditingController _agecategoryinput = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _lastnameCtrl = TextEditingController();
  final TextEditingController _middlenameCtrl = TextEditingController();
  final TextEditingController _ninCtrl = TextEditingController();
  final TextEditingController _passwordConfirmCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  bool _passwordVisible = false;
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _prevdonationamtCtrl = TextEditingController();
  bool _validate = false;
  bool otpready = false;
  bool otploading = false;
  String? otpcode = '';
  String? otpcodesent;
  String? fpassword = '';
  String? userphonenumber;
  String? usercommunity;
  final TextEditingController refCodeCtrl = TextEditingController(
    text: randomNumeric(6).toString(),
  );

  Future<bool> getInternetUsingInternetConnectivity() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  void _onChanged(dynamic val) => setState(() {
        usercommunity = val;
        debugPrint(val.toString());
      });
  @override
  void initState() {
    super.initState();
    // getPref();
    _passwordVisible = false;
  }

  FocusNode focusNode = FocusNode();

  Future<void> sendotp() async {
    try {
      final url = Uri.parse(
          'http://api.famcaresl.com/communityapp/index.php?route=otp');
      final response = await http.post(
        url,
        body: jsonEncode({
          'phonenumber': '$userphonenumber', // Additional data
          'refcode': refCodeCtrl.text, // Additional data
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        setState(() {
          otploading = false;
        });
        // Request was successful
        print('Response: ${response.body}');
        var msg = jsonDecode(response.body);
        if (msg['userStatus'] == false) {
          setState(() {
            otpready = true;
            otpcode = refCodeCtrl.text;
          }); // Navigate to Home Screen
        } else if (msg['userStatus'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Phone Number Already Exist, \nTry Another Phone Number',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 12)),
            backgroundColor: Color(0xFFE02020),
            behavior: SnackBarBehavior.fixed,
            duration: const Duration(seconds: 3),
            // duration: Duration(seconds: 3),
          ));
        }
      } else {
        // Request failed
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle errors, including slow internet connection
      print('Error occurred: $e');
    }
  }

  savePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email!);
    prefs.setString('password', password!);
    prefs.setString('ufname', ufname!);
    prefs.setString('umname', umname!);
    prefs.setString('ulname', ulname!);
    prefs.setString('agecategory', agecategory!);
    prefs.setString('gender', gender!);
    prefs.setString('phonenumber', phonenumber!);
    prefs.setString('address', address!);
    prefs.setString('nin', nin!);
    prefs.setString('district', district!);
    prefs.setString('bloodtype', bloodtype!);
    prefs.setString('prevdonation', prevdonation!);
    prefs.setString('prevdonationamt', prevdonationamt!);
    prefs.setString('community', community!);
  }

  Future register() async {
    try {
      final url = Uri.parse(
          'http://api.famcaresl.com/communityapp/index.php?route=register');
      final response = await http.post(
        url,
        body: jsonEncode({
          "name": _fullnameCtrl.text,
          "dob": dobdateinput.text,
          "age": '$selectedAge',
          "agecategory": selectedAgeCategory,
          "gender": selectedGender,
          "avatar": selectedAvatar,
          "phonenumber": '$userphonenumber',
          "email": _emailCtrl.text,
          "address": _addressCtrl.text,
          "country": selectedCountry,
          "section": selectedDistrict,
          "bloodtype": selectedBloodType,
          "prevdonation": selectedPrevDonation,
          "donorid": _donoridCtrl.text,
          "prevdonationamt": _prevdonationamtCtrl.text,
          "community": 'true',
          "username": _usernameCtrl.text,
          "trivia": 'No',
          "password": _passwordCtrl.text,
          "date": dateinput.text,
          "month": monthinput.text,
          "year": yearinput.text, // Additional data
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 409) {
        // Request was successful
        var data = json.decode(response.body);
        if (data == "User already exists") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('User Already Exist, \nTry Different Phone Number.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                )),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.fixed,
            duration: Duration(seconds: 5),
          ));
        }
      }
      if (response.statusCode == 201) {
        var data = json.decode(response.body);
        if (data == "Success") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.teal,
            behavior: SnackBarBehavior.fixed,
            duration: Duration(seconds: 3),
            content: Text('Registration Successful',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  fontWeight: FontWeight.bold
                )),
          ));
          Future.delayed(Duration(seconds: 3));
          {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => tour()),
                (route) => false);
          }
          ;
        }
      } else {
        // Request failed
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.grey,
          behavior: SnackBarBehavior.fixed,
          duration: Duration(seconds: 3),
          content: Text('Request failed with status:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 13,
              )),
        ));
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle errors, including slow internet connection
      print('Error occurred: $e');
    }

    // scheduleAlarm();
  }


Future<List<DonorRegisterData>> findDonor(String query) async {
    var data = {'rbtc_id': '1', 'tfs_id': '2', 'status': 'Pending'};

    var response = await http.post(
      Uri.parse(
          "https://labtech.lifebloodsl.com/labtechapi/findregisterdonor.php"),
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      final List<dynamic> donorRegisterJson = json.decode(response.body);

      return donorRegisterJson
          .map((json) => DonorRegisterData.fromJson(json))
          .where((donor) {
        final donorNameLower = donor.name.toLowerCase();
        final donorPhoneNumberLower = donor.phonenumber.toLowerCase();
        final donorAgeCategoryLower = donor.agecategory.toLowerCase();
        final donorAddressLower = donor.address.toLowerCase();
        final donorEmailAddressLower = donor.email.toLowerCase();
        final donorBloodTypeLower = donor.bloodtype.toLowerCase();
        final donorGenderLower = donor.gender.toLowerCase();
        final searchLower = query.toLowerCase();

        return donorNameLower.contains(searchLower) ||
            donorAgeCategoryLower.contains(searchLower) ||
            donorAddressLower.contains(searchLower) ||
            donorEmailAddressLower.contains(searchLower) ||
            donorGenderLower.contains(searchLower) ||
            donorPhoneNumberLower.contains(searchLower) ||
            donorBloodTypeLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception('Failed to load donors');
    }
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
              fontFamily: 'Montserrat',
              color: isActive ? Colors.white : null,
              // fontSize: width * 0.035,
            ),
          ),
        ),
      ),
    );
  }

  Map<String, List<String>> districtCitiesMap = {
    'Sierra Leone': [
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
    ],
    'Benin': [
      'Alibori',
      'Atakora',
      'Atlantique',
      'Borgou',
      'Collines',
      'Donga',
      'Kouffo',
      'Littoral Region',
      'Mono',
      'Ouémé',
      'Plateau',
      'Zou'
    ],
  };

  // void scheduleAlarm() async{
  //   var tz;
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       'LifeBlood',
  //       'Thank You For Regisering, You Have Saved A Life',
  //       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
  //       const NotificationDetails(
  //           android: AndroidNotificationDetails(
  //             'alarm_notify',
  //             'alarm_notify',
  //             channelDescription: 'Channel For Registeration',
  //             icon: 'lifeblood',
  //             sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
  //             largeIcon: DrawableResourceAndroidBitmap('lifeblood'),),
  //       iOS: IOSNotificationDetails(
  //   sound: 'a_long_cold_sting.wav',
  //   presentAlert: true,
  //   presentBadge: true,
  //   presentSound: true),),
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //       UILocalNotificationDateInterpretation.absoluteTime);
  // }

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
  String selectedAvatar = 'assets/images/lady1.png';

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFe0e9e4),
      appBar: AppBar(
          backgroundColor: Colors.teal,
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          elevation: 0,
          title: Text(
            t.signupandsavelives,
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                letterSpacing: 0,
                color: Colors.white),
            textAlign: TextAlign.left,
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  otpready
                      ? SizedBox(
                          height: 0.h,
                        )
                      : Column(
                          children: [
                            SizedBox(
                              child: Container(
                                width: double.infinity,
                                color: kPrimaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xff329d9c),
                                                  fontSize: 15),
                                              children: [
                                                TextSpan(
                                                  text: t.makeadifferencetoday,
                                                  style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 25,
                                                    height: 1,
                                                    fontWeight: FontWeight.bold,
                                                    color: kWhiteColor,
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
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      // Row(
                                      //   children: [
                                      //     Expanded(
                                      //       child: Text(
                                      //         'Empowering Blood Services & Communities',
                                      //         style: TextStyle(
                                      //             fontFamily: 'Montserrat',
                                      //             fontSize: 14,
                                      //             overflow: TextOverflow.clip,
                                      //             letterSpacing: 0,
                                      //             color: kWhiteColor,
                                      //             fontWeight:
                                      //                 FontWeight.normal),
                                      //         textAlign: TextAlign.left,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 5,
                            ),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Text(
                            //         'Account Benefits: Create an account to easily schedule future appointments, manage existing appointments, see your blood type, view results of your mini-physical, and track donation history.',
                            //         style: TextStyle(
                            //             fontFamily: 'Montserrat',
                            //             fontSize: 14,
                            //             letterSpacing: 0,
                            //             overflow: TextOverflow.clip,
                            //             fontWeight: FontWeight.normal,
                            //             color: kLifeBloodRed),
                            //         textAlign: TextAlign.left,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Personal Information',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 14,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.bold),
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
                                          labelStyle: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Montserrat'),
                                        ),
                                        controller: refCodeCtrl,
                                      ),
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
                                    decoration: InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(),
                                      labelText: 'Full Name',
                                      labelStyle: TextStyle(
                                          fontSize: 14,
                                          letterSpacing: 0,
                                          fontFamily: 'Montserrat'),
                                    ),
                                    controller: _fullnameCtrl,
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        isDense: false,
                                        contentPadding: EdgeInsets.all(10),
                                        labelStyle: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0),
                                        // icon: Icon(Icons.calendar_today), //icon of text field
                                        labelText:
                                            "Date of Birth" //label text of field
                                        ),

                                    readOnly:
                                        true, //set it true, so that user will not able to edit text
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(
                                                  1900), //DateTime.now() - not to allow to choose before today.
                                              lastDate: DateTime.now());

                                      if (pickedDate != null) {
                                        print(
                                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                        String formattedDate =
                                            DateFormat('d MMM yyyy')
                                                .format(pickedDate);
                                        print(
                                            formattedDate); //formatted date output using intl package =>  2021-03-16
                                        //you can implement different kind of Date Format here according to your requirement
                                        setState(() {
                                          selectedYear = pickedDate.year;
                                          selectedDay = pickedDate.day;
                                          selectedMonth = pickedDate.month;
                                          dateInput.text =
                                              DateFormat('d MMM yyyy')
                                                  .format(pickedDate);
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
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              child: _buildGenderSelector(
                                                  context: context,
                                                  name: 'Male')),
                                          5.horizontalSpace,
                                          Expanded(
                                              child: _buildGenderSelector(
                                                  context: context,
                                                  name: 'Female')),
                                        ],
                                      ),
                                    ],
                                  ),
                                  selectedGender!.isNotEmpty
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            Text(
                                              'Avatar',
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 14,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left,
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              'Select how you want your avatar to look',
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 13,
                                                  letterSpacing: 0,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
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
                                            selectedGender == "Female"
                                                ? Column(
                                                    children: [
                                                      Center(
                                                        child: Container(
                                                          width:
                                                              70, // Adjust the width as needed
                                                          height:
                                                              70, // Adjust the height as needed
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                              color: Colors
                                                                  .teal, // Change the color as needed
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          child: CircleAvatar(
                                                            backgroundImage:
                                                                AssetImage(
                                                                    selectedAvatar),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),

                                                      // Create a scrollable list of avatars
                                                      Container(
                                                        height: 90,
                                                        child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount:
                                                              8, // Change this to the number of avatars you have for both 'lady' and 'men'
                                                          itemBuilder:
                                                              (context, index) {
                                                            String avatarPath;

                                                            avatarPath =
                                                                'assets/images/lady${index}.png';

                                                            return GestureDetector(
                                                              onTap: () {
                                                                // Update the selectedAvatar when an avatar is clicked
                                                                setState(() {
                                                                  selectedAvatar =
                                                                      avatarPath;
                                                                });
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(8),
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      70, // Adjust the width as needed
                                                                  height:
                                                                      40, // Adjust the height as needed
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: selectedAvatar ==
                                                                              avatarPath
                                                                          ? Colors
                                                                              .teal
                                                                              .shade200
                                                                          : Colors
                                                                              .transparent,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .teal
                                                                            .shade100,
                                                                    backgroundImage:
                                                                        AssetImage(
                                                                            avatarPath),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Column(
                                                    children: [
                                                      Center(
                                                        child: Container(
                                                          width:
                                                              70, // Adjust the width as needed
                                                          height:
                                                              70, // Adjust the height as needed
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            border: Border.all(
                                                              color: Colors
                                                                  .teal, // Change the color as needed
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          child: CircleAvatar(
                                                            backgroundImage:
                                                                AssetImage(
                                                                    selectedAvatar),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),

                                                      // Create a scrollable list of avatars
                                                      Container(
                                                        height: 90,
                                                        child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount:
                                                              8, // Change this to the number of avatars you have for both 'lady' and 'men'
                                                          itemBuilder:
                                                              (context, index) {
                                                            String avatarPath;

                                                            avatarPath =
                                                                'assets/images/man${index}.png';

                                                            return GestureDetector(
                                                              onTap: () {
                                                                // Update the selectedAvatar when an avatar is clicked
                                                                setState(() {
                                                                  selectedAvatar =
                                                                      avatarPath;
                                                                });
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(8),
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      70, // Adjust the width as needed
                                                                  height:
                                                                      40, // Adjust the height as needed
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: selectedAvatar ==
                                                                              avatarPath
                                                                          ? Colors
                                                                              .teal
                                                                              .shade200
                                                                          : Colors
                                                                              .transparent,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .teal
                                                                            .shade100,
                                                                    backgroundImage:
                                                                        AssetImage(
                                                                            avatarPath),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                          ],
                                        )
                                      : SizedBox(),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Contact Information',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 14,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.bold),
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
                                    decoration: InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(),
                                      labelText: 'Email Address (optional)',
                                      labelStyle: TextStyle(
                                          fontSize: 14,
                                          letterSpacing: 0,
                                          fontFamily: 'Montserrat'),
                                    ),
                                    controller: _emailCtrl,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Home Address is required';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(),
                                      labelText: 'Home Address',
                                      labelStyle: TextStyle(
                                          fontSize: 14,
                                          letterSpacing: 0,
                                          fontFamily: 'Montserrat'),
                                    ),
                                    controller: _addressCtrl,
                                  ),
                                  10.verticalSpace,
                                  DropdownButtonFormField2(
                                    value: selectedCountry,
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                          fontSize: 14,
                                          letterSpacing: 0,
                                          fontFamily: 'Montserrat'),
                                      labelText: 'Residing Country',
                                      //Add isDense true and zero Padding.
                                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                      isDense: false,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                      // border: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.circular(5),
                                      // ),
                                      //Add more decoration as you want here
                                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                    ),
                                    buttonStyleData: const ButtonStyleData(
                                      padding:
                                          EdgeInsets.only(right: 0, left: 0),
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
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                    ),
                                    items: districtCitiesMap.keys
                                        .map((String district) {
                                      return DropdownMenuItem<String>(
                                        value: district,
                                        child: Text(district),
                                      );
                                    }).toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select an option.';
                                      }
                                    },
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedCountry = value;

                                        // Reset selected city when district changes
                                        selectedDistrict = null;
                                      });
                                    },
                                    onSaved: (value) {
                                      selectedCountry = value.toString();
                                    },
                                  ),
                                  Column(
                                    children: [
                                      10.verticalSpace,
                                      DropdownButtonFormField2(
                                        value: selectedDistrict,
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              fontSize: 14,
                                              letterSpacing: 0,
                                              fontFamily: 'Montserrat'),
                                          labelText: 'Residing District',
                                          //Add isDense true and zero Padding.
                                          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                          isDense: false,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          contentPadding: EdgeInsets.all(10),
                                          // border: OutlineInputBorder(
                                          //   borderRadius: BorderRadius.circular(5),
                                          // ),
                                          //Add more decoration as you want here
                                          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                        ),
                                        buttonStyleData: const ButtonStyleData(
                                          padding: EdgeInsets.only(
                                              right: 0, left: 0),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                        ),
                                        items: selectedCountry == null
                                            ? null
                                            : districtCitiesMap[selectedCountry]
                                                ?.map((String city) {
                                                return DropdownMenuItem<String>(
                                                  value: city,
                                                  child: Text(city),
                                                );
                                              }).toList(),
                                        validator: (beininvalue) {
                                          if (beininvalue == null) {
                                            return 'Please select an option.';
                                          }
                                        },
                                        onChanged: (String? beninvalue) {
                                          setState(() {
                                            selectedDistrict = beninvalue;
                                          });
                                        },
                                        onSaved: (beninvalue) {
                                          selectedDistrict =
                                              beninvalue.toString();
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Blood Information',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 14,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.bold),
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
                                    height: 15.h,
                                  ),
                                  DropdownButtonFormField2(
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                          fontSize: 14,
                                          letterSpacing: 0,
                                          fontFamily: 'Montserrat'),
                                      labelText: 'Blood Group',
                                      //Add isDense true and zero Padding.
                                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                      isDense: false,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      contentPadding: EdgeInsets.all(10),
                                      // border: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.circular(5),
                                      // ),
                                      //Add more decoration as you want here
                                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                    ),
                                    buttonStyleData: const ButtonStyleData(
                                      padding:
                                          EdgeInsets.only(right: 0, left: 0),
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
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                    ),
                                    items: bloodgrouplist
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
                                        return 'Please select an option.';
                                      }
                                    },
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedBloodType = value;
                                      });
                                    },
                                    onSaved: (value) {
                                      selectedBloodType = value.toString();
                                    },
                                  ),
                                  10.verticalSpace,
                                  Row(
                                    children: [
                                      Text(
                                        'Have you donated blood before?',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 14,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.normal),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                  10.verticalSpace,
                                  Column(
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: _buildNassitSelector(
                                                      context: context,
                                                      name: 'Yes')),
                                              5.horizontalSpace,
                                              Expanded(
                                                  child: _buildNassitSelector(
                                                      context: context,
                                                      name: 'No')),
                                            ],
                                          ),
                                        ],
                                      ),
                                      (selectedPrevDonation == "Yes")
                                          ? Column(
                                              children: [
                                                10.verticalSpace,
                                                TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: 'How Many Times',
                                                    labelStyle: TextStyle(
                                                        fontSize: 14,
                                                        letterSpacing: 0,
                                                        fontFamily:
                                                            'Montserrat'),
                                                  ),
                                                  controller:
                                                      _prevdonationamtCtrl,
                                                ),
                                                10.verticalSpace,
                                                TextFormField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText:
                                                        'Donor ID (optional)',
                                                    labelStyle: TextStyle(
                                                        fontSize: 14,
                                                        letterSpacing: 0,
                                                        fontFamily:
                                                            'Montserrat'),
                                                  ),
                                                  controller: _donoridCtrl,
                                                ),
                                              ],
                                            )
                                          : SizedBox(
                                              height: 0,
                                            ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Login Information',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 14,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.bold),
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
                                        userphonenumber =
                                            phone.completeNumber.toString();
                                      });
                                      print(userphonenumber);
                                      // print();
                                    },
                                    onCountryChanged: (country) {
                                      print('Country changed to: ' +
                                          country.name);
                                    },
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(),
                                      labelText: 'Username',
                                      labelStyle: TextStyle(
                                          fontSize: 14,
                                          letterSpacing: 0,
                                          fontFamily: 'Montserrat'),
                                    ),
                                    controller: _usernameCtrl,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Kindly Enter a Password';
                                      }
                                      if (value.length < 8) {
                                        return 'Must be more than 8 charater';
                                      }
                                      return null;
                                    },
                                    obscureText: !_passwordVisible,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(),
                                      labelStyle: TextStyle(
                                          fontSize: 14,
                                          letterSpacing: 0,
                                          fontFamily: 'Montserrat'),
                                      labelText: 'Create Password',
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          // Based on passwordVisible state choose the icon
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.teal,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                        color: Colors.teal,
                                      ),
                                    ),
                                    controller: _passwordCtrl,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Kindly Confirm Password';
                                      }
                                      if (_passwordCtrl.text !=
                                          _passwordConfirmCtrl.text) {
                                        return 'Password Do not Match';
                                      }
                                      return null;
                                    },
                                    obscureText: !_passwordVisible,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(),
                                      labelText: 'Confirm Password',
                                      labelStyle: TextStyle(
                                          fontSize: 14,
                                          letterSpacing: 0,
                                          fontFamily: 'Montserrat'),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          // Based on passwordVisible state choose the icon
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.teal,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible =
                                                !_passwordVisible;
                                          });
                                        },
                                        color: Colors.teal,
                                      ),
                                    ),
                                    controller: _passwordConfirmCtrl,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  FormBuilderCheckbox(
                                    name: 'accept_terms',
                                    initialValue: false,
                                    onChanged: _onChanged,
                                    title: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                'I have read and agree to the ',
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 14,
                                                letterSpacing: 0,
                                                color: Colors.black),
                                          ),
                                          TextSpan(
                                            text: 'Terms of Reference',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14,
                                              fontFamily: 'Montserrat',
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                showModalBottomSheet(
                                                  backgroundColor:
                                                      Color(0xFFe0e9e4),
                                                  context: context,
                                                  builder: (context) {
                                                    return SingleChildScrollView(
                                                      child: Container(
                                                        padding: EdgeInsets.only(
                                                            bottom:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  20.0,
                                                                  20.0,
                                                                  20.0,
                                                                  0.0), // content padding
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  'Terms of Reference',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .teal)),
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                              Text(
                                                                  'Last updated: 2022-06-14 1. \n\nIntroduction Welcome to AutoHealth (“Company”, “we”, “our”, “us”)! \n\nThese Terms of Service (“Terms”, “Terms of Service”) govern your use of our application LifeBlood (together or individually “Service”) operated by AutoHealth. \n\nOur Privacy Policy also governs your use of our Service and explains how we collect, safeguard and disclose information that results from your use of our web pages. \n\nYour agreement with us includes these Terms and our Privacy Policy (“Agreements”). You acknowledge that you have read and understood Agreements, and agree to be bound of them. \n\nIf you do not agree with (or cannot comply with) Agreements, then you may not use the Service, but please let us know by emailing at support@lifebloodsl.com so we can try to find a solution. \n\nThese Terms apply to all visitors, users and others who wish to access or use Service. \n\n2. Communications\n\n By using our Service, you agree to subscribe to newsletters, marketing or promotional materials and other information we may send. However, you may opt out of receiving any, or all, of these communications from us by following the unsubscribe link or by emailing at support@lifebloodsl.com.\n\n 3. Contests\n\n Sweepstakes and Promotions Any contests, sweepstakes or other promotions (collectively, “Promotions”) made available through Service may be governed by rules that are separate from these Terms of Service. If you participate in any Promotions, please review the applicable rules as well as our Privacy Policy. \n\nIf the rules for a Promotion conflict with these Terms of Service, Promotion rules will apply. \n\n4. Content\n\nContent found on or through this Service are the property of AutoHealth or used with permission. You may not distribute, modify, transmit, reuse, download, repost, copy, or use said Content, whether in whole or in part, for commercial purposes or for personal gain, without express advance written permission from us. \n\n5. Prohibited\n\n Uses You may use Service only for lawful purposes and in accordance with Terms. You agree not to use Service: \n\n0.1. In any way that violates any applicable national or international law or regulation. \n0.2. For the purpose of exploiting, harming, or attempting to exploit or harm minors in any way by exposing them to inappropriate content or otherwise. \n0.3. To transmit, or procure the sending of, any advertising or promotional material, including any “junk mail”, “chain letter,” “spam,” or any other similar solicitation. \n0.4. To impersonate or attempt to impersonate Company, a Company employee, another user, or any other person or entity. \n0.5. In any way that infringes upon the rights of others, or in any way is illegal, threatening, fraudulent, or harmful, or in connection with any unlawful, illegal, fraudulent, or harmful purpose or activity. \n0.6. To engage in any other conduct that restricts or inhibits anyone’s use or enjoyment of Service, or which, as determined by us, may harm or offend Company or users of Service or expose them to liability. \nAdditionally, you agree not to: \n\n0.1. Use Service in any manner that could disable, overburden, damage, or impair Service or interfere with any other party’s use of Service, including their ability to engage in real time activities through Service. \n\n0.2. Use any robot, spider, or other automatic device, process, or means to access Service for any purpose, including monitoring or copying any of the material on Service. \n\n0.3. Use any manual process to monitor or copy any of the material on Service or for any other unauthorized purpose without our prior written consent. \n\n0.4. Use any device, software, or routine that interferes with the proper working of Service. \n\n0.5. Introduce any viruses, trojan horses, worms, logic bombs, or other material which is malicious or technologically harmful. \n\n0.6. Attempt to gain unauthorized access to, interfere with, damage, or disrupt any parts of Service, the server on which Service is stored, or any server, computer, or database connected to Service. \n\n0.7. Attack Service via a denial-of-service attack or a distributed denial-of-service attack. \n\n0.8. Take any action that may damage or falsify Company rating. \n\n0.9. Otherwise attempt to interfere with the proper working of Service. \n\n6. Analytics \nWe may use third-party Service Providers to monitor and analyze the use of our Service. \n\n7. No Use \nBy Minors Service is intended only for access and use by individuals at least eighteen (18) years old. \n\nBy accessing or using Service, you warrant and represent that you are at least eighteen (18) years of age and with the full authority, right, and capacity to enter into this agreement and abide by all of the terms and conditions of Terms. If you are not at least eighteen (18) years old, you are prohibited from both the access and usage of Service. \n\n8.\n\nAccounts When you create an account with us, you guarantee that you are above the age of 18, and that the information you provide us is accurate, complete, and current at all times. Inaccurate, incomplete, or obsolete information may result in the immediate termination of your account on Service. You are responsible for maintaining the confidentiality of your account and password, including but not limited to the restriction of access to your computer and/or account. \n\nYou agree to accept responsibility for any and all activities or actions that occur under your account and/or password, whether your password is with our Service or a third-party service. \n\nYou must notify us immediately upon becoming aware of any breach of security or unauthorized use of your account. \n\nYou may not use as a username the name of another person or entity or that is not lawfully available for use, a name or trademark that is subject to any rights of another person or entity other than you, without appropriate authorization. \n\nYou may not use as a username any name that is offensive, vulgar or obscene. We reserve the right to refuse service, terminate accounts, remove or edit content, or cancel orders in our sole discretion. 9. Intellectual Property Service and its original content (excluding Content provided by users), features and functionality are and will remain the exclusive property of AutoHealth and its licensors. \n\nService is protected by copyright, trademark, and other laws of and foreign countries. Our trademarks may not be used in connection with any product or service without the prior written consent of AutoHealth\n\n. 10. Copyright Policy\n We respect the intellectual property rights of others. It is our policy to respond to any claim that Content posted on Service infringes on the copyright or other intellectual property rights (“Infringement”) of any person or entity. If you are a copyright owner, or authorized on behalf of one, and you believe that the copyrighted work has been copied in a way that constitutes copyright infringement, please submit your claim via email to support@lifebloodsl.com, with the subject line: “Copyright Infringement” and include in your claim a detailed description of the alleged Infringement as detailed below, under “DMCA Notice and Procedure for Copyright Infringement Claims” You may be held accountable for damages (including costs and attorneys’ fees) for misrepresentation or bad-faith claims on the infringement of any Content found on and/or through Service on your copyright. \n\n11. DMCA Notice and Procedure for Copyright Infringement Claims\n\n You may submit a notification pursuant to the Digital Millennium Copyright Act (DMCA) by providing our Copyright Agent with the following information in writing (see 17 U.S.C 512(c)(3) for further detail): \n\n0.1. an electronic or physical signature of the person authorized to act on behalf of the owner of the copyright’s interest; \n0.2. a description of the copyrighted work that you claim has been infringed, including the URL (i.e., web page address) of the location where the copyrighted work exists or a copy of the copyrighted work; \n0.3. identification of the URL or other specific location on Service where the material that you claim is infringing is located; \n0.4. your address, telephone number, and email address; \n0.5. a statement by you that you have a good faith belief that the disputed use is not authorized by the copyright owner, its agent, or the law; \n0.6. a statement by you, made under penalty of perjury, that the above information in your notice is accurate and that you are the copyright owner or authorized to act on the copyright owner’s behalf. \n\nYou can contact our Copyright Agent via email at support@lifebloodsl.com. \n\n12. \nError Reporting and Feedback You may provide us either directly at support@lifebloodsl.com or via third party sites and tools with information and feedback concerning errors, suggestions for improvements, ideas, problems, complaints, and other matters related to our Service (“Feedback”). You acknowledge and agree that: \n\n(i) you shall not retain, acquire or assert any intellectual property right or other right, title or interest in or to the Feedback; \n(ii) Company may have development ideas similar to the Feedback; \n(iii) Feedback does not contain confidential information or proprietary information from you or any third party; and \n(iv) Company is not under any obligation of confidentiality with respect to the Feedback. In the event the transfer of the ownership to the Feedback is not possible due to applicable mandatory laws, you grant Company and its affiliates an exclusive, transferable, irrevocable, free-of-charge, sub-licensable, unlimited and perpetual right to use (including copy, modify, create derivative works, publish, distribute and commercialize) Feedback in any manner and for any purpose. \n\n13. Links To Other Web Sites \n\nOur Service may contain links to third party web sites or services that are not owned or controlled by AutoHealth. \n\nAutoHealth has no control over, and assumes no responsibility for the content, privacy policies, or practices of any third party web sites or services. We do not warrant the offerings of any of these entities/individuals or their websites. For example, the outlined Terms of Use have been created using PolicyMaker.io, a free web application for generating high-quality legal documents. \n\nPolicyMaker’s Terms and Conditions generator is an easy-to-use free tool for creating an excellent standard Terms of Service template for a website, blog, e-commerce store or app. \n\nYOU ACKNOWLEDGE AND AGREE THAT COMPANY SHALL NOT BE RESPONSIBLE OR LIABLE, DIRECTLY OR INDIRECTLY, FOR ANY DAMAGE OR LOSS CAUSED OR ALLEGED TO BE CAUSED BY OR IN CONNECTION WITH USE OF OR RELIANCE ON ANY SUCH CONTENT, GOODS OR SERVICES AVAILABLE ON OR THROUGH ANY SUCH THIRD PARTY WEB SITES OR SERVICES. \n\nWE STRONGLY ADVISE YOU TO READ THE TERMS OF SERVICE AND PRIVACY POLICIES OF ANY THIRD PARTY WEB SITES OR SERVICES THAT YOU VISIT.\n\n 14. Disclaimer Of Warranty \n\nTHESE SERVICES ARE PROVIDED BY COMPANY ON AN “AS IS” AND “AS AVAILABLE” BASIS. COMPANY MAKES NO REPRESENTATIONS OR WARRANTIES OF ANY KIND, EXPRESS OR IMPLIED, AS TO THE OPERATION OF THEIR SERVICES, OR THE INFORMATION, CONTENT OR MATERIALS INCLUDED THEREIN. YOU EXPRESSLY AGREE THAT YOUR USE OF THESE SERVICES, THEIR CONTENT, AND ANY SERVICES OR ITEMS OBTAINED FROM US IS AT YOUR SOLE RISK. NEITHER COMPANY NOR ANY PERSON ASSOCIATED WITH COMPANY MAKES ANY WARRANTY OR REPRESENTATION WITH RESPECT TO THE COMPLETENESS, SECURITY, RELIABILITY, QUALITY, ACCURACY, OR AVAILABILITY OF THE SERVICES. WITHOUT LIMITING THE FOREGOING, NEITHER COMPANY NOR ANYONE ASSOCIATED WITH COMPANY REPRESENTS OR WARRANTS THAT THE SERVICES, THEIR CONTENT, OR ANY SERVICES OR ITEMS OBTAINED THROUGH THE SERVICES WILL BE ACCURATE, RELIABLE, ERROR-FREE, OR UNINTERRUPTED, THAT DEFECTS WILL BE CORRECTED, THAT THE SERVICES OR THE SERVER THAT MAKES IT AVAILABLE ARE FREE OF VIRUSES OR OTHER HARMFUL COMPONENTS OR THAT THE SERVICES OR ANY SERVICES OR ITEMS OBTAINED THROUGH THE SERVICES WILL OTHERWISE MEET YOUR NEEDS OR EXPECTATIONS. COMPANY HEREBY DISCLAIMS ALL WARRANTIES OF ANY KIND, WHETHER EXPRESS OR IMPLIED, STATUTORY, OR OTHERWISE, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT, AND FITNESS FOR PARTICULAR PURPOSE. THE FOREGOING DOES NOT AFFECT ANY WARRANTIES WHICH CANNOT BE EXCLUDED OR LIMITED UNDER APPLICABLE LAW. 15. Limitation Of Liability EXCEPT AS PROHIBITED BY LAW, YOU WILL HOLD US AND OUR OFFICERS, DIRECTORS, EMPLOYEES, AND AGENTS HARMLESS FOR ANY INDIRECT, PUNITIVE, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGE, HOWEVER IT ARISES (INCLUDING ATTORNEYS’ FEES AND ALL RELATED COSTS AND EXPENSES OF LITIGATION AND ARBITRATION, OR AT TRIAL OR ON APPEAL, IF ANY, WHETHER OR NOT LITIGATION OR ARBITRATION IS INSTITUTED), WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE, OR OTHER TORTIOUS ACTION, OR ARISING OUT OF OR IN CONNECTION WITH THIS AGREEMENT, INCLUDING WITHOUT LIMITATION ANY CLAIM FOR PERSONAL INJURY OR PROPERTY DAMAGE, ARISING FROM THIS AGREEMENT AND ANY VIOLATION BY YOU OF ANY FEDERAL, STATE, OR LOCAL LAWS, STATUTES, RULES, OR REGULATIONS, EVEN IF COMPANY HAS BEEN PREVIOUSLY ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. EXCEPT AS PROHIBITED BY LAW, IF THERE IS LIABILITY FOUND ON THE PART OF COMPANY, IT WILL BE LIMITED TO THE AMOUNT PAID FOR THE PRODUCTS AND/OR SERVICES, AND UNDER NO CIRCUMSTANCES WILL THERE BE CONSEQUENTIAL OR PUNITIVE DAMAGES. SOME STATES DO NOT ALLOW THE EXCLUSION OR LIMITATION OF PUNITIVE, INCIDENTAL OR CONSEQUENTIAL DAMAGES, SO THE PRIOR LIMITATION OR EXCLUSION MAY NOT APPLY TO YOU. \n\n16. Termination \n\nWe may terminate or suspend your account and bar access to Service immediately, without prior notice or liability, under our sole discretion, for any reason whatsoever and without limitation, including but not limited to a breach of Terms. If you wish to terminate your account, you may simply discontinue using Service. All provisions of Terms which by their nature should survive termination shall survive termination, including, without limitation, ownership provisions, warranty disclaimers, indemnity and limitations of liability. 17. Governing Law These Terms shall be governed and construed in accordance with the laws of Sierra Leone, which governing law applies to agreement without regard to its conflict of law provisions. Our failure to enforce any right or provision of these Terms will not be considered a waiver of those rights. If any provision of these Terms is held to be invalid or unenforceable by a court, the remaining provisions of these Terms will remain in effect. These Terms constitute the entire agreement between us regarding our Service and supersede and replace any prior agreements we might have had between us regarding Service.\n\n 18. Changes\n\n To Service We reserve the right to withdraw or amend our Service, and any service or material we provide via Service, in our sole discretion without notice. We will not be liable if for any reason all or any part of Service is unavailable at any time or for any period. From time to time, we may restrict access to some parts of Service, or the entire Service, to users, including registered users. \n\n19. Amendments\n\n To Terms We may amend Terms at any time by posting the amended terms on this site. It is your responsibility to review these Terms periodically. Your continued use of the Platform following the posting of revised Terms means that you accept and agree to the changes. You are expected to check this page frequently so you are aware of any changes, as they are binding on you. By continuing to access or use our Service after any revisions become effective, you agree to be bound by the revised terms. If you do not agree to the new terms, you are no longer authorized to use Service. \n\n20. Waiver And Severability \n\nNo waiver by Company of any term or condition set forth in Terms shall be deemed a further or continuing waiver of such term or condition or a waiver of any other term or condition, and any failure of Company to assert a right or provision under Terms shall not constitute a waiver of such right or provision. If any provision of Terms is held by a court or other tribunal of competent jurisdiction to be invalid, illegal or unenforceable for any reason, such provision shall be eliminated or limited to the minimum extent such that the remaining provisions of Terms will continue in full force and effect. \n\n21. Acknowledgement\n\n BY USING SERVICE OR OTHER SERVICES PROVIDED BY US, YOU ACKNOWLEDGE THAT YOU HAVE READ THESE TERMS OF SERVICE AND AGREE TO BE BOUND BY THEM. \n\n22. \n\nContact Us Please send your feedback, comments, requests for technical support by email: support@lifebloodsl.com.',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color: Color(
                                                                          0xff406986))),
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SizedBox(
                                                                    width: 5.h,
                                                                  ),
                                                                  TextButton(
                                                                      child: Text(
                                                                          'Close',
                                                                          textAlign: TextAlign
                                                                              .right,
                                                                          style: GoogleFonts.montserrat(
                                                                              fontSize:
                                                                                  12,
                                                                              color: Colors
                                                                                  .white)),
                                                                      style: TextButton
                                                                          .styleFrom(
                                                                        foregroundColor:
                                                                            Colors.white,
                                                                        backgroundColor:
                                                                            Color(0xffd12624),
                                                                        shape: const RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(10))),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      }),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                                // Single tapped.
                                              },
                                          ),
                                          TextSpan(
                                            text: ' , ',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                showModalBottomSheet(
                                                  backgroundColor:
                                                      Color(0xFFe0e9e4),
                                                  context: context,
                                                  builder: (context) {
                                                    return SingleChildScrollView(
                                                      child: Container(
                                                        padding: EdgeInsets.only(
                                                            bottom:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  20.0,
                                                                  20.0,
                                                                  20.0,
                                                                  0.0), // content padding
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  'Privacy Policy',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .teal)),
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                              Text(
                                                                  '\nEffective date: 2022-05-05\n\nUpdated on: 2022-06-14\n\nThis Privacy Policy explains the policies of LifeBlood on the collection and use of the information we collect when you access https://lifeblood.sl (the “Service”). \n\nThis Privacy Policy describes your privacy rights and how you are protected under privacy laws. \n\nBy using our Service, you are consenting to the collection and use of your information in accordance with this Privacy Policy. Please do not access or use our Service if you do not consent to the collection and use of your information as outlined in this Privacy Policy. This Privacy Policy has been created with the help of CookieScript Privacy Policy Generator. LifeBlood is authorized to modify this Privacy Policy at any time. This may occur without prior notice. LifeBlood will post the revised Privacy Policy on the https://lifebloodsl.com website \n\nCOLLECTION AND USE OF YOUR PERSONAL\n\n \n\nINFORMATION INFORMATION WE COLLECT\n When using our Service, you will be prompted to provide us with personal information used to contact or identify you. https://lifebloodsl.com collects the following information: \n\n* Usage Data \n* Name \n* Email \n* Mobile Number \n* Date of Birth \n* Work Address \n* Home Address Usage Data includes the following: \n* Internet Protocol (IP) address of computers accessing the site \n* Web page requests \n* Referring web pages \n* Browser used to access site \n* Time and date of access \n\nHOW WE COLLECT INFORMATION\n https://lifebloodsl.com collects and receives information from you in the following manner: \n\n* When you fill a registration form or otherwise submit your personal information. Your information will be stored for up to 365 days after it is no longer required to provide you the services. Your information may be retained for longer periods for reporting or record- keeping in accordance with applicable laws. Information which does not identify you personally may be stored indefinitely. \n\nHOW WE USE YOUR INFORMATION\n https://lifebloodsl.com may use your information for the following purposes: \n* Providing and maintaining our Service, as well as monitoring the usage of our Service. \n* For other purposes. LifeBlood will use your information for data analysis to identify usage trends or determine the effective of our marketing campaigns when reasonable. We will use your information to evaluate and improve our Service, products, services, and marketing efforts. \n* Managing your account. Your Personal Data can enable access to multiple functions of our Service that are available to registered users. \n* For the performance of a contract. Your Personal Data will assist with the development, undertaking, and compliance of a purchase contract for products or services you have purchased through our Service. \n* To contact you. LifeBlood will contact you by email, phone, SMS, or another form of electronic communication related to the functions, products, services, or security updates when necessary or reasonable. \n* To update you with news, general information, special offers, new services, and events. \n* Administration information. Your Personal Data will be used as part of the operation of our website Administration practices. \n* User to user comments. Your information, such as your screen name, personal image, or email address, will be in public view when posting user to user comments. \n\nHOW WE SHARE YOUR INFORMATION \nLifeBlood will share your information, when applicable, in the following situations: * With your consent. LifeBlood will share your information for any purpose with your explicit consent. * Sharing with other users. Information you provide may be viewed by other users of our Service. By interacting with other users or registering through a third-party service, such as a social media service, your contacts on the third-party service may see your information and a description of your activity.\n\nTHIRD-PARTY SHARING\n\nAny third party we share your information with must disclose the purpose for which they intend to use your information. They must retain your information only for the duration disclosed when requesting or receiving said information. The third-party service provider must not further collect, sell, or use your personal information except as necessary to perform the specified purpose. \n\nYour information may be shared to a third-party for reasons including: \n* Analytics information. \nYour information might be shared with online analytics tools in order to track and analyse website traffic. If you choose to provide such information during registration or otherwise, you are giving LifeBlood permission to use, share, and store that information in a manner consistent with this Privacy Policy. Your information may be disclosed for additional reasons, including: \n* Complying with applicable laws, regulations, or court orders. \n* Responding to claims that your use of our Service violates third-party rights. \n* Enforcing agreements you make with us, including this Privacy Policy. \n\nCOOKIES \nCookies are small text files that are placed on your computer by websites that you visit. Websites use cookies to help users navigate efficiently and perform certain functions. Cookies that are required for the website to operate properly are allowed to be set without your permission. All other cookies need to be approved before they can be set in the browser. \n\n* Strictly necessary cookies.\nStrictly necessary cookies allow core website functionality such as user login and account management. The website cannot be used properly without strictly necessary cookies. \n* Performance cookies. \nPerformance cookies are used to see how visitors use the website, eg. analytics cookies. Those cookies cannot be used to directly identify a certain visitor. \n\nSECURITY\nYour information’s security is important to us. https://lifebloodsl.com utilizes a range of security measures to prevent the misuse, loss, or alteration of the information you have given us. However, because we cannot guarantee the security of the information you provide us, you must access our service at your own risk. \n\nLifeBlood is not responsible for the performance of websites operated by third parties or your interactions with them. When you leave this website, we recommend you review the privacy practices of other websites you interact with and determine the adequacy of those practices. \n\nCONTACT US For any questions, please contact us through the following methods: Name: LifeBlood Address: 8 Regent Road, Hill Cut Email: LifeBlood14@gmail.com Website: https://lifebloodsl.com Phone: +23278621647',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      color: Color(
                                                                          0xff406986))),
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SizedBox(
                                                                    width: 5.h,
                                                                  ),
                                                                  TextButton(
                                                                      child: Text(
                                                                          'Close',
                                                                          textAlign: TextAlign
                                                                              .right,
                                                                          style: GoogleFonts.montserrat(
                                                                              fontSize:
                                                                                  12,
                                                                              color: Colors
                                                                                  .white)),
                                                                      style: TextButton
                                                                          .styleFrom(
                                                                        foregroundColor:
                                                                            Colors.white,
                                                                        backgroundColor:
                                                                            Color(0xffd12624),
                                                                        shape: const RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(10))),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      }),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ); // Single tapped.
                                              },
                                            text: 'Privacy Policy.',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    validator: FormBuilderValidators.equal(
                                      true,
                                      errorText:
                                          'You must accept terms and conditions to continue',
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                  otpready
                      ? Padding(
                          padding: const EdgeInsets.all(15),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Image.asset(
                                  'assets/icons/verified.png',
                                  height: 80.h,
                                  width: 80.w,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                    'A verification has been sent to:\n' +
                                        '$userphonenumber' +
                                        '\n' +
                                        'Kindly enter code.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal,
                                        color: kBlackColor)),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Pinput(
                                  length: 6,
                                  showCursor: true,
                                  defaultPinTheme: PinTheme(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.teal.shade200,
                                      ),
                                    ),
                                    textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  onCompleted: (value) {
                                    setState(() {
                                      otpcodesent = value;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      child: Row(
                                        children: [
                                          Text('Change Number',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.teal)),
                                        ],
                                      ),
                                      onTap: () {
                                        setState(() {
                                          otpready = false;
                                        }); // Navigate t
                                      },
                                    ),
                                    InkWell(
                                        child: Row(
                                          children: [
                                            Text('Resend Code ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.teal)),
                                            Icon(
                                              Icons.refresh,
                                              size: 15,
                                              color: Colors.teal,
                                            ),
                                          ],
                                        ),
                                        onTap: () async {
                                          if (await getInternetUsingInternetConnectivity()) {
                                            sendotp();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  'You are offline, Kindly turn on Wifi or Mobile Data to continue',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 10)),
                                              backgroundColor:
                                                  Color(0xFFE02020),
                                              behavior: SnackBarBehavior.fixed,
                                              duration:
                                                  const Duration(seconds: 10),
                                              // duration: Duration(seconds: 3),
                                            ));
                                          }
                                        }),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 0.h,
                        ),
                  otpready
                      ? Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          if (await getInternetUsingInternetConnectivity()) {
                                            if (otpcodesent != null) {
                                              if (otpcode == otpcodesent) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                      backgroundColor:
                                                          Colors.teal,
                                                      content:
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
                                                              .fromLTRB(
                                                                  3.0,
                                                                  3.0,
                                                                  3.0,
                                                                  0.0),
                                                          child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SizedBox(
                                                                  height: 15.0,
                                                                  width: 15.0,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: Colors
                                                                        .white,
                                                                    strokeWidth:
                                                                        2.0,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5.h,
                                                                ),
                                                                Text.rich(
                                                                  TextSpan(
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Montserrat',
                                                                        color: Color(
                                                                            0xff329d9c),
                                                                        fontSize:
                                                                            15),
                                                                    children: [
                                                                      TextSpan(
                                                                        text:
                                                                            'Registering ',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          fontWeight:
                                                                              FontWeight.normal,
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
                                                                        text: _fullnameCtrl
                                                                            .text,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontFamily:
                                                                              'Montserrat',
                                                                          fontWeight:
                                                                              FontWeight.bold,
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
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                ),
                                                                SizedBox(
                                                                  height: 5.h,
                                                                ),
                                                                Container(
                                                                  width: double
                                                                      .infinity,
                                                                  child:
                                                                      SizedBox(
                                                                    child:
                                                                        Divider(
                                                                      color: Colors
                                                                          .white,
                                                                      thickness:
                                                                          1,
                                                                    ),
                                                                    height: 5.h,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5.h,
                                                                ),
                                                                Text(
                                                                    'A single pint can save 3 lives, and a single gesture can create a million smiles.',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontFamily:
                                                                          'Montserrat',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ))
                                                              ]),
                                                        ),
                                                      ))),
                                                );
                                                Future.delayed(
                                                    Duration(seconds: 1),
                                                    () async {
                                                  register();
                                                });
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Verification Code do not match.',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontSize: 12)),
                                                  backgroundColor:
                                                      Color(0xFFE02020),
                                                  behavior:
                                                      SnackBarBehavior.fixed,
                                                  duration: const Duration(
                                                      seconds: 3),
                                                  // duration: Duration(seconds: 3),
                                                ));
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Enter 6-Digit code',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 12)),
                                                backgroundColor:
                                                    Color(0xFFE02020),
                                                behavior:
                                                    SnackBarBehavior.fixed,
                                                duration:
                                                    const Duration(seconds: 3),
                                                // duration: Duration(seconds: 3),
                                              ));
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  'You are offline, Kindly turn on Wifi or Mobile Data to continue',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 10)),
                                              backgroundColor:
                                                  Color(0xFFE02020),
                                              behavior: SnackBarBehavior.fixed,
                                              duration:
                                                  const Duration(seconds: 3),
                                              // duration: Duration(seconds: 3),
                                            ));
                                          }
                                        }
                                      },
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: kPrimaryColor,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                      ),
                                      child: Text('Verify and Sign Up',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 14,
                                              letterSpacing: 0,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Divider(
                                    thickness: 0.2,
                                    color: Colors.grey,
                                  ),
                                  30.verticalSpace,
                                  Text(
                                    'Did not receive code\nContact Systems Support',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 13,
                                        letterSpacing: 0,
                                        fontFamily: 'Montserrat'),
                                  ),
                                  5.verticalSpace,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        child: Row(children: [
                                          FaIcon(
                                            FontAwesomeIcons.phoneFlip,
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 5.h,
                                          ),
                                          Text('Phone Call',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  color: Colors.white)),
                                        ]),
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: kPrimaryColor,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        onPressed: () async {
                                          //To remove the keyboard when button is pressed
                                         launchUrl(Uri(
                                            scheme: 'tel',
                                            path: '+232 79 230776',
                                          ));
                                        },
                                      ),
                                      10.horizontalSpace,
                                      TextButton(
                                        child: Row(children: [
                                          FaIcon(FontAwesomeIcons.whatsapp),
                                          SizedBox(
                                            width: 5.h,
                                          ),
                                          Text('WhatsApp',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  color: Colors.white)),
                                        ]),
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: kPrimaryColor,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        ),
                                        onPressed: () async {
                                          //To remove the keyboard when button is pressed
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          var whatsappUrl =
                                              "whatsapp://send?phone=${'+23278621647'}" +
                                                  "&text=${Uri.encodeComponent('Hi LifeBlood, I did not recieve my code')}";
                                          try {
                                            launch(whatsappUrl);
                                          } catch (e) {
                                            //To handle error and display error message
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Could Not Launch WhatsApp',
                                                  style:
                                                      GoogleFonts.montserrat()),
                                              backgroundColor: Colors.red,
                                              behavior: SnackBarBehavior.fixed,
                                              duration: Duration(seconds: 3),
                                            ));
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            width: double.infinity,
                            child: ElevatedButton(
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: otploading
                                      ? SizedBox(
                                          height: 15.0,
                                          width: 15.0,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2.0,
                                          ),
                                        )
                                      : Text('Agree and Continue',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 14,
                                              letterSpacing: 0,
                                              color: Colors.white)),
                                ),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: kPrimaryColor,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (await getInternetUsingInternetConnectivity()) {
                                      setState(() {
                                        otploading = true;
                                      });
                                      Future.delayed(Duration(seconds: 2), () {
                                        sendotp();
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            'You are offline, Kindly turn on Wifi or Mobile Data to continue',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 10,
                                                letterSpacing: 0)),
                                        backgroundColor: Color(0xFFE02020),
                                        behavior: SnackBarBehavior.fixed,
                                        duration: const Duration(seconds: 10),
                                        // duration: Duration(seconds: 3),
                                      ));
                                    }
                                  }
                                }),
                          ),
                        ),
                  otpready
                      ? SizedBox(
                          height: 0.h,
                        )
                      : Center(
                          child: InkWell(
                            child: Text('Have an account? Log in',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF205072))),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ],
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
            style: TextStyle(color: isActive ? Colors.white : null, fontSize: 14
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
    final isActive = name == selectedPrevDonation;
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
          groupValue: selectedPrevDonation,
          onChanged: (String? v) {
            setState(() {
              selectedPrevDonation = v;
            });
          },
          title: Text(
            name,
            style: TextStyle(color: isActive ? Colors.white : null, fontSize: 14
                // fontSize: width * 0.035,
                ),
          ),
        ),
      ),
    );
  }
}
