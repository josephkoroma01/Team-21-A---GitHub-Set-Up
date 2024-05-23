import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lifebloodworld/features/Community/components/donationcampaigns.dart';
import 'package:lifebloodworld/features/Community/components/waitingpage.dart';
import 'package:intl/intl.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';

import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateDonationCampaignsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lifeblood',
      theme: ThemeData(
        primaryColor: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      home: CreateDonationCampaigns(title: 'Create Donation Campaigns'),
    );
  }
}

class CreateDonationCampaigns extends StatefulWidget {
  CreateDonationCampaigns({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String? title;

  @override

  //text editing controller for text field

  _CreateDonationCampaignsState createState() =>
      _CreateDonationCampaignsState();
}

class _CreateDonationCampaignsState extends State<CreateDonationCampaigns> {
  String? email;
  String? ufname;
  String? ulname;
  String? umname;
  String? age;
  String? gender;
  String? phonenumber;
  String? address;
  String? district;
  String? bloodtype;
  String? prevdonation;

  @override
  void initState() {
    super.initState();
    daterange.text = "";
    getPref();
  }

  void _onChanged(dynamic val) => debugPrint(val.toString());

  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      ufname = prefs.getString('ufname');
      umname = prefs.getString('umname');
      ulname = prefs.getString('ulname');
      age = prefs.getString('age');
      gender = prefs.getString('gender');
      phonenumber = prefs.getString('phonenumber');
      address = prefs.getString('address');
      district = prefs.getString('district');
      bloodtype = prefs.getString('bloodtype');
      prevdonation = prefs.getString('prevdonation');
    });
  }

  final _formKey = GlobalKey<FormBuilderState>();
  dynamic _selectedtargeteddistrict;
  dynamic _selectedcomponent;
  dynamic _targetedbloodliters;
  dynamic _budgetrange;
  String dropdownValue = 'Select Facility';
  String bloodtestfor = 'Family';

  final TextEditingController daterange = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _campaignnameCtrl = TextEditingController();
  final TextEditingController _campaigndesCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();
  final TextEditingController _targetedareaCtrl = TextEditingController();
  final TextEditingController refCodeCtrl = TextEditingController(
    text: randomAlphaNumeric(8).toString(),
  );

  void _districtonChanged(dynamic val) => setState(() {
        _selectedtargeteddistrict = val.toString();
        debugPrint(val);
      });
  void _componentonChanged(dynamic val) => setState(() {
        _selectedcomponent = val.toString();
        debugPrint(val);
      });
  void _bloodlitersonChanged(dynamic val) => setState(() {
        _targetedbloodliters = val.toString();
        debugPrint(val);
      });
  void _budgetrangeonChanged(dynamic val) => setState(() {
        _budgetrange = val.toString();
        debugPrint(val);
      });

  Future register() async {
    var response = await http.post(
        Uri.parse("http://lifebloodsl.com/communityapi/donationcampaigns.php"),
        body: {
          "name": _nameCtrl.text,
          "campaignname": _campaignnameCtrl.text,
          "campaigndescription": _campaigndesCtrl.text,
          "phonenumber": _phoneCtrl.text,
          "email": email,
          "campaignemail": _emailCtrl.text,
          "address": _addressCtrl.text,
          "targeteddistrict": _selectedtargeteddistrict,
          "targetedarea": _targetedareaCtrl.text,
          "bloodcomponent": _selectedcomponent,
          "targetedbloodliters": _targetedbloodliters,
          "budgetrange": _budgetrange,
          "daterange": daterange.text,
          "refcode": refCodeCtrl.text,
        });
    var data = json.decode(response.body);
    if (data == "Error") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Please Try Again, Campaign Already Exists, Try Tracking Schedule'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 5),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
          height: 70.h,
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                      'Campaign Created Successfully, You will be contacted shortly !!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(fontSize: 11.sp)),
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
                              'Your reference code to track review process is ',
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
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.copy, size: 13, color: Colors.white),
                          SizedBox(
                            width: 5.h,
                          ),
                          Text('Copy Code',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontSize: 13.sp, color: Colors.white)),
                        ],
                      ),
                      onPressed: () async {
                        await Clipboard.setData(
                            ClipboardData(text: refCodeCtrl.text));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Copied to clipboard'),
                        ));
                      }),
                ],
              )
            ],
          ),
        ),
        backgroundColor: Colors.teal,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 15),
      )); // scheduleAlarm()
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DonationCampaigns(),
        ),
      );
    }
  }

  String? _make, _model;

  //
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

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final steps = [
      CoolStep(
        title: 'STEP ONE',
        subtitle: 'Please fill some of the Personal Information to get started',
        content: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                labelText: 'Name of Campaign Creator / Organisation',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
                controller: _nameCtrl,
              ),
              _buildTextField(
                labelText: 'Name of Campaign',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
                controller: _campaignnameCtrl,
              ),
              TextFormField(
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                minLines: null,
                maxLines: 15,
                maxLength: 200,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Description is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Describe the Campaign',
                  labelStyle: TextStyle(fontSize: 13.sp),
                ),
                controller: _campaigndesCtrl,
              ),
              SizedBox(
                height: size.height * 0.013,
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
        title: 'STEP TWO',
        subtitle: 'Please fill some of the Contact Information to continue',
        content: FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 8,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Phone Number is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'Organisation / Campaign Creator Contact Number',
                    labelStyle: TextStyle(fontSize: 13.sp),
                    prefixText: '+232'),
                controller: _phoneCtrl,
              ),
              _buildTextField(
                labelText: 'Organisation / Campaign Creator Email Address',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email Address is required';
                  }
                  return null;
                },
                controller: _emailCtrl,
              ),
              _buildTextField(
                labelText: 'Organisation / Campaign Creator Address',
                controller: _addressCtrl,
              ),
              SizedBox(
                height: size.height * 0.013,
              ),
              FormBuilderCheckboxGroup<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(labelText: 'Targeted District'),
                name: "selecteddistrict",
                // initialValue: const ['Dart'],
                options: [
                  FormBuilderFieldOption(value: 'Bombali'),
                  FormBuilderFieldOption(
                    value: 'Bonthe',
                  ),
                  FormBuilderFieldOption(
                    value: 'Kailahun',
                  ),
                  FormBuilderFieldOption(
                    value: 'Kambia',
                  ),
                  FormBuilderFieldOption(
                    value: 'Karene',
                  ),
                  FormBuilderFieldOption(
                    value: 'Kenema',
                  ),
                  FormBuilderFieldOption(
                    value: 'Koindadugu',
                  ),
                  FormBuilderFieldOption(
                    value: 'Kono',
                  ),
                  FormBuilderFieldOption(
                    value: 'Moyamba',
                  ),
                  FormBuilderFieldOption(
                    value: 'Port Loko',
                  ),
                  FormBuilderFieldOption(
                    value: 'Pujehun',
                  ),
                  FormBuilderFieldOption(
                    value: 'Tonkolili',
                  ),
                  FormBuilderFieldOption(
                    value: 'Western Rural',
                  ),
                  FormBuilderFieldOption(
                    value: 'Western Urban',
                  ),
                  FormBuilderFieldOption(
                    value: 'Nation Wide',
                  )
                ],
                onChanged: _districtonChanged,
                separator: const VerticalDivider(
                  width: 10,
                  thickness: 5,
                  color: Colors.red,
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.minLength(1),
                  FormBuilderValidators.maxLength(3),
                ]),
              ),
              SizedBox(
                height: 10.h,
              ),
              _buildTextField(
                labelText: 'Targeted Area (e.g. Lumley, Baoma, Biriwa Limba)',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Field is required';
                  }
                  return null;
                },
                controller: _targetedareaCtrl,
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
        title: 'STEP THREE',
        subtitle:
            'Please fill some of the Facility Information to Complete Scheduling',
        content: FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              FormBuilderFilterChip<String>(
                name: 'component',
                onChanged: _componentonChanged,
                selectedColor: Colors.teal,
                checkmarkColor: Colors.white,
                backgroundColor: Colors.black87,
                decoration: InputDecoration(
                  labelText: 'Targeted Blood Components',
                ),
                options: [
                  FormBuilderChipOption(
                      value: 'Plasma',
                      child: Text(
                        'Plasma',
                        style: TextStyle(color: Colors.white),
                      )),
                  FormBuilderChipOption(
                      value: 'Whole Blood',
                      child: Text(
                        'Whole Blood',
                        style: TextStyle(color: Colors.white),
                      )),
                  FormBuilderChipOption(
                      value: 'Platelets',
                      child: Text(
                        'Platelets',
                        style: TextStyle(color: Colors.white),
                      )),
                  FormBuilderChipOption(
                      value: 'All',
                      child: Text(
                        'All',
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
              FormBuilderSlider(
                name: 'targetedbloodliters',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.min(6),
                ]),
                onChanged: _bloodlitersonChanged,
                min: 10.0,
                max: 1000.0,
                initialValue: 100,
                divisions: 1000,
                activeColor: Colors.teal,
                inactiveColor: Colors.tealAccent,
                decoration: InputDecoration(
                  labelText: 'Targeted Blood Liters',
                ),
              ),
              SizedBox(
                height: size.height * 0.013,
              ),
              FormBuilderRangeSlider(
                name: '$_budgetrange',
                onChanged: _budgetrangeonChanged,
                min: 0.0,
                max: 1000.0,
                initialValue: RangeValues(10, 50),
                divisions: 50,
                activeColor: Colors.teal,
                inactiveColor: Colors.tealAccent,
                decoration: const InputDecoration(
                    labelText: "Budget Range (Min and Max in dollars)"),
              ),
              SizedBox(
                height: size.height * 0.013,
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
                      labelStyle: TextStyle(fontSize: 15.sp),
                    ),
                    controller: refCodeCtrl,
                  ),
                ),
              ),
              FormBuilderDateRangePicker(
                name: 'daterange',
                controller: daterange,
                firstDate: DateTime.now(),
                lastDate: DateTime(2030),
                format: DateFormat('d MMM yyyy'),
                decoration: InputDecoration(
                  labelText: 'Campaign Date Range',
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _formKey.currentState!.fields['date_range']
                            ?.didChange(null);
                      }),
                ),
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
      // CoolStep(
      //   title: 'Select your role',
      //   subtitle: 'Choose a role that better defines you',
      //   content: Container(
      //     child: Row(
      //       children: <Widget>[
      //         _buildSelector(
      //           context: context,
      //           name: 'Writer',
      //         ),
      //         SizedBox(width: 5.0),
      //         _buildSelector(
      //           context: context,
      //           name: 'Editor',
      //         ),
      //       ],
      //     ),
      //   ),
      //   validation: () {
      //     return null;
      //   },
      // ),
    ];

    final stepper = CoolStepper(
      showErrorSnackbar: false,
      onCompleted: () async {
        if (await getInternetUsingInternetConnectivity()) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => waitingCampaignPage(
                name: _nameCtrl.text,
                campaignname: _campaignnameCtrl.text,
                campaigndescription: _campaigndesCtrl.text,
                phonenumber: _phoneCtrl.text,
                email: email,
                campaignemail: _emailCtrl.text,
                address: _addressCtrl.text,
                targeteddistrict: _selectedtargeteddistrict,
                targetedarea: _targetedareaCtrl.text,
                bloodcomponent: _selectedcomponent,
                targetedbloodliters: _targetedbloodliters,
                budgetrange: _budgetrange,
                daterange: daterange.text,
                refcode: refCodeCtrl.text,
              ),
            ),
          );
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
      config: CoolStepperConfig(
        backText: 'PREV',
      ),
    );

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DonationCampaigns(),
                  ),
                );
              },
              icon: Icon(Icons.arrow_back)),
          elevation: 0,
          title: Text(
            widget.title!,
            style: TextStyle(fontSize: 14.sp),
          )),
      body: Container(
        child: stepper,
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
            labelText: labelText, labelStyle: TextStyle(fontSize: 13.sp)),
        validator: validator,
        controller: controller,
      ),
    );
  }
}
