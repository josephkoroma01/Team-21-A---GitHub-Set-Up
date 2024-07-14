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
import 'package:lifebloodworld/constants/colors.dart';
import 'package:lifebloodworld/features/Community/components/communities.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:intl/intl.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:lifebloodworld/main.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../provider/prefs_provider.dart';

DateTime now = DateTime.now();
String formattedNewDate = DateFormat('d MMM yyyy').format(now);
String formattedNewMonth = DateFormat('LLLL').format(now);
String formattedNewYear = DateFormat('y').format(now);

class CreateActivity extends StatefulWidget {
  const CreateActivity({
    Key? key,
    required this.title,
    required this.donorGroupId,
  }) : super(key: key);

  final String? title;
  final String? donorGroupId;

  @override

  //text editing controller for text field

  _CreateActivityState createState() => _CreateActivityState();
}

class _CreateActivityState extends State<CreateActivity> {
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

  String? uname;
  String? countryId;
  String? country;
  String? userId;
  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // email = prefs.getString('email');
      // name = prefs.getString('name');
      uname = prefs.getString('uname');
      // agecategory = prefs.getString('agecategory');
      // gender = prefs.getString('gender');
      // phonenumber = prefs.getString('phonenumber');
      // address = prefs.getString('address');
      // district = prefs.getString('district');
      countryId = prefs.getString('country_id');
      country = prefs.getString('country');
      // bloodtype = prefs.getString('bloodtype');
      // prevdonation = prefs.getString('prevdonation');
      // prevdonationamt = prefs.getString('prevdonationamt');
      // community = prefs.getString('community');
      // communitydonor = prefs.getString('communitydonor');
      userId = prefs.getString('id');
      // totaldonation = prefs.getString('totaldonation');
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

  final List<String> commcat = ['Blood Donation Community'];
  final List<String> sldistrict = [
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

  final List<String> bndistrict = [
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

  @override
  void initState() {
    _dateinput.text = "";
    getPref(); //set the initial value of text field
    super.initState();
  }

  final TextEditingController _activityName = TextEditingController();
  final TextEditingController _activityDate = TextEditingController();
  final TextEditingController _activityLocation = TextEditingController();
  final TextEditingController _activityPlace = TextEditingController();
  final TextEditingController _activityDescription = TextEditingController();
  bool isActivityLoading = false;

  Future<void> _submitData() async {
    setState(() {
      _scheduling = true;
    });
    String apiUrl =
        'https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/donorgroups/${widget.donorGroupId}/activities';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "title": _activityName.text,
          "description": _activityDescription.text,
          "location": _activityLocation.text,
          "place": _activityPlace.text,
          "activity_date": _activityDate.text,
          "created_by": userId.toString()
        }),
      );
      if (response.statusCode == 201) {
        setState(() {
          _scheduling = false;
        });
        // Successfully created the donor group
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Activity created successfully',
              style: GoogleFonts.montserrat()),
          backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.fixed,
          duration: const Duration(seconds: 4),
        ));
        Future.delayed(const Duration(seconds: 2));
        // scheduleAlarm()
        // refresh page

        Navigator.pop(context);
      } else {
        var data = json.decode(response.body);
        setState(() {
          _scheduling = false;
        });
        // Failed to create the donor group
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data['message'], style: GoogleFonts.montserrat()),
          backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.fixed,
          duration: const Duration(seconds: 80),
        ));
      }
    } catch (e) {
      setState(() {
        _scheduling = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Something went wrong. Please check your internet and try again.',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(fontSize: 11.sp)),
        backgroundColor: const Color(0xFFE02020),
        behavior: SnackBarBehavior.fixed,
        duration: const Duration(seconds: 5),
        // duration: Duration(seconds: 3),
      ));
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Failed to create donor group $e')),
      // );
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => Communities(
                //       title: 'title',
                //     ),
                //   ),
                // );
              },
              icon: const Icon(
                Icons.arrow_back,
                color: kWhiteColor,
              )),
          elevation: 0,
          title: Text(
            'Create Community Activity',
            style: TextStyle(fontSize: 14.sp, color: kWhiteColor),
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
                        Text('Activity Details',
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
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _activityName,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          labelText: 'Activity Name',
                          labelStyle: TextStyle(
                              fontSize: 14,
                              letterSpacing: 0,
                              fontFamily: 'Montserrat'),
                        ),
                        // controller: _emailCtrl,
                      ),
                      10.verticalSpace,
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Date is required';
                          }
                          return null;
                        },
                        controller: _activityDate,
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
                            //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('d MMM yyyy').format(pickedDate);
                            setState(() {
                              _activityDate.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          }
                        },
                      ),
                      10.verticalSpace,
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(
                              fontSize: 14,
                              letterSpacing: 0,
                              fontFamily: 'Montserrat'),
                          labelText: 'Location',
                          //Add isDense true and zero Padding.
                          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                          isDense: false,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          contentPadding: EdgeInsets.all(10),
                        ),
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
                        items: districtCitiesMap['Sierra Leone']
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
                            _activityLocation.text = beninvalue!;
                          });
                        },
                        onSaved: (beninvalue) {},
                      ),
                      10.verticalSpace,
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _activityPlace,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          labelText: 'Activity Place',
                          labelStyle: TextStyle(
                              fontSize: 14,
                              letterSpacing: 0,
                              fontFamily: 'Montserrat'),
                        ),
                        // controller: _emailCtrl,
                      ),
                      10.verticalSpace,
                      TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 4,
                        controller: _activityDescription,
                        decoration: const InputDecoration(
                          alignLabelWithHint: true,
                          isDense: true,
                          border: OutlineInputBorder(),
                          labelText: 'Describe the Activity',
                          labelStyle: TextStyle(
                              fontSize: 14,
                              letterSpacing: 0,
                              fontFamily: 'Montserrat'),
                        ),
                        // controller: _emailCtrl,
                      ),
                      10.verticalSpace,
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                backgroundColor: kPrimaryColor,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10),
                                textStyle: TextStyle(
                                    color: kWhiteColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (await getInternetUsingInternetConnectivity()) {
                                  _submitData();
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
                                ? const SizedBox(
                                    height: 15.0,
                                    width: 15.0,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.0,
                                    ),
                                  )
                                : const Text(
                                    'Create Activity',
                                    style: TextStyle(
                                        color: kWhiteColor,
                                        fontFamily: 'Montserrat'),
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
