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
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../provider/prefs_provider.dart';

DateTime now = DateTime.now();
String formattedNewDate = DateFormat('d MMM yyyy').format(now);
String formattedNewMonth = DateFormat('LLLL').format(now);
String formattedNewYear = DateFormat('y').format(now);

class CreateCommunity extends StatefulWidget {
  CreateCommunity({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String? title;

  @override

  //text editing controller for text field

  _CreateCommunityState createState() => _CreateCommunityState();
}

class _CreateCommunityState extends State<CreateCommunity> {
  final _formKey = GlobalKey<FormState>();

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

  String bloodtestfor = 'Family';
  bool _scheduling = false;

  @override
  void initState() {
    getPref();
    super.initState();
  }

  final TextEditingController _countryIdController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

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

  Future<void> _submitData() async {

    const String apiUrl =
        'https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/donorgroups';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "admin_id": "$userId",
          'country_id': "$countryId",
          'country': "$country",
          'name': _nameController.text,
          'description': _descriptionController.text,
          'location': _locationController.text,
        }),
      );

      if (response.statusCode == 201) {
        setState(() {
          _scheduling = false;
        });
        // Successfully created the donor group
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Donor group created successfully',
              style: GoogleFonts.montserrat()),
          backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.fixed,
          duration: const Duration(seconds: 4),
        ));
        await Future.delayed(const Duration(seconds: 2));
        // scheduleAlarm()
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePageScreen(pageIndex: 2),
          ),
        );
      } else {
        setState(() {
          _scheduling = false;
        });
        // Failed to create the donor group
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Failed to create donor group. Please try again. ${response.body}',
              style: GoogleFonts.montserrat()),
          backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.fixed,
          duration: const Duration(seconds: 80),
        ));
      }
    } catch (e) {
      setState(() {
        _scheduling = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create donor group $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: kWhiteColor,
              )),
          elevation: 0,
          title: Text(
            'Create Community on LifeBlood',
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
                        Text('Community Details',
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
                        controller: _nameController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          labelText: 'Community Name',
                          labelStyle: TextStyle(
                              fontSize: 14,
                              letterSpacing: 0,
                              fontFamily: 'Montserrat'),
                        ),
                        // controller: _emailCtrl,
                      ),
                      10.verticalSpace,
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontSize: 14,
                              letterSpacing: 0,
                              fontFamily: 'Montserrat'),
                          labelText: 'Community Category',
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
                        items: commcat
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
                            _countryController.text = value!;
                          });
                        },
                        onSaved: (value) {},
                      ),
                      10.verticalSpace,
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          labelText: 'Community Description',
                          labelStyle: TextStyle(
                              fontSize: 14,
                              letterSpacing: 0,
                              fontFamily: 'Montserrat'),
                        ),
                        // controller: _emailCtrl,
                      ),
                      10.verticalSpace,
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              fontSize: 14,
                              letterSpacing: 0,
                              fontFamily: 'Montserrat'),
                          labelText: 'Community Location',
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
                            _locationController.text = beninvalue!;
                          });
                        },
                        onSaved: (beninvalue) {},
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
                                    horizontal: 40, vertical: 10),
                                textStyle: TextStyle(
                                    color: kWhiteColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (await getInternetUsingInternetConnectivity()) {
                                  _submitData();
                                  setState(() {
                                    _scheduling = true;
                                  });
                                  Future.delayed(
                                      Duration(seconds: 0), () async {});
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
                                    'Create Community',
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
}
