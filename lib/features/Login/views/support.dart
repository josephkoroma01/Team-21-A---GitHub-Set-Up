import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lifebloodworld/constants/colors.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:http/http.dart' as http;
import 'package:random_string/random_string.dart';

DateTime now = DateTime.now();
String formattedNewDate = DateFormat('d MMM yyyy').format(now);
String formattedDate = DateFormat('d').format(now);
String formattedNewMonth = DateFormat('LLLL').format(now);
String formattedNewYear = DateFormat('y').format(now);

class DonationForm extends StatefulWidget {
  @override
  _DonationFormState createState() => _DonationFormState();
}

class _DonationFormState extends State<DonationForm> {
  bool isOneTime = true;
  bool _scheduling = false;
  String? frequency = "";
  String? supportype = "";
  int? selectedAmount;
  final TextEditingController otherAmountController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController monthinput =
      TextEditingController(text: formattedNewMonth.toString());
  final TextEditingController dateinput =
      TextEditingController(text: formattedNewDate.toString());

  final TextEditingController supportdateinput =
      TextEditingController(text: formattedDate.toString());
  final TextEditingController yearinput =
      TextEditingController(text: formattedNewYear.toString());
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController refCodeCtrl = TextEditingController(
    text: randomNumeric(3).toString(),
  );

  final List<String> _options = [
    'Donor Refreshment',
    'Community Engagement',
    'Donor Mobilisation',
    'System Support',
    'Capacity Building',
    'University Ambassadors',
    'Community Champions',
    'LifeBlood School Clubs',
    'LifeBlood Volunteering Staff',
  ];

  // Define a variable to hold the selected option
  String? _selectedOption;

  Future uploadsupport() async {
    try {
      final url = Uri.parse(
          'https://phplaravel-1274936-4609077.cloudwaysapps.com/api/v1/supportlifeblood');
      final response = await http.post(
        url,
        body: jsonEncode({
          "refcode":
              "${refCodeCtrl.text + supportdateinput.text + phonenumberController.text.substring(1, 3)}",
          "supportType": "$_selectedOption",
          "frequency": isOneTime ? "One Time" : "Monthly",
          "amount": selectedAmount != null
              ? selectedAmount
              : otherAmountController.text.isNotEmpty
                  ? int.tryParse(otherAmountController.text)
                  : '',
          "phonenumber": "${'+232' + phonenumberController.text}",
          "status": "Pending",
          "month": "${monthinput.text}",
          "year": "${yearinput.text}",
          "date": "${dateinput.text}"
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 201) {
        setState(() {
          _scheduling = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          showCloseIcon: true,
          closeIconColor: Colors.white,
          backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 5),
          content: Text('Support submitted successfully',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  fontWeight: FontWeight.normal)),
        ));
        await Future.delayed(Duration(seconds: 2), () {
          Navigator.pop(context);
        });
      } else {
        setState(() {
          _scheduling = false;
        });
        // Request failed
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          showCloseIcon: true,
          closeIconColor: Colors.white,
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.fixed,
          duration: Duration(seconds: 60),
          content: Text('Request failed with status: ${response.body}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 13,
              )),
        ));

        print('Request failed with status: ${response}');
      }
    } catch (e) {
      // Handle errors, including slow internet connection
      print('Error occurred: $e');
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
            },
            icon: Icon(
              Icons.arrow_back,
              color: kWhiteColor,
            )),
        title: const Text(
          'LifeBlood Support',
          style: TextStyle(
              letterSpacing: 0, fontFamily: 'Montserrat', color: kWhiteColor),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14.spMax,
                          letterSpacing: 0,
                          overflow: TextOverflow.clip),
                      'LifeBlood is developed as a Digital Public Good. What this means is that Auto Health (SL) Limited is rolling out the system to all health facilities managing blood products free of charge to all the users. The Community Mobile App subscription is also not a paid service, as the overall goal of the system is to help drive and increase voluntary blood donations.\n\n'
                      'As we celebrate the success of various campaigns, it\'s crucial to recognize the paramount role of sustaining this life-saving initiative. Our support is not only an investment in health but a commitment to building a resilient healthcare system. You can boost the LifeBlood initiative by supporting any of the following components:',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              FormBuilder(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Select an option',
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedOption,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedOption = newValue;
                        });
                      },
                      items: _options
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                fontFamily: 'Montserrat', fontSize: 14.spMax),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    Text('Frequency'),
                    Row(
                      children: [
                        ChoiceChip(
                          selectedColor: kPrimaryColor,
                          backgroundColor: kGreyColor,
                          label: Text(
                            'One Time',
                            style: TextStyle(
                                fontFamily: 'Montserrat', fontSize: 14.spMax),
                          ),
                          selected: isOneTime,
                          onSelected: (selected) {
                            setState(() {
                              isOneTime = true;
                            });
                          },
                        ),
                        SizedBox(width: 10),
                        ChoiceChip(
                          selectedColor: kPrimaryColor,
                          backgroundColor: kGreyColor,
                          label: Text(
                            'Monthly',
                            style: TextStyle(
                                fontFamily: 'Montserrat', fontSize: 14.spMax),
                          ),
                          selected: !isOneTime,
                          onSelected: (selected) {
                            setState(() {
                              isOneTime = false;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    const Text('I Want to Give'),
                    Wrap(
                      spacing: 10,
                      children: [
                        _buildAmountButton(50),
                        _buildAmountButton(100),
                        _buildAmountButton(250),
                        _buildAmountButton(500),
                        _buildAmountButton(1000),
                      ],
                    ),
                    10.verticalSpace,
                    _buildOtherAmountField(),
                    10.verticalSpace,
                    _buildOtherNumberField(),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Our support team will be in touch with you regarding the payment.',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14.spMax,
                        overflow: TextOverflow.clip),
                  )),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        backgroundColor: kPrimaryColor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        textStyle: TextStyle(
                            color: kWhiteColor,
                            fontSize: 14,
                            fontFamily: 'Montserrat',
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
                                    padding:
                                        EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 0.0),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
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
                                              'Thank you for your generous contribution. Your support will help save lives and make a significant impact on our blood donation efforts.',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.normal,
                                              ))
                                        ]),
                                  ),
                                ))),
                          );
                          setState(() {
                            _scheduling = true;
                          });
                          Future.delayed(Duration(seconds: 0), () async {
                            uploadsupport();
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'You are offline, Turn On Data or Wifi',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(fontSize: 11.sp)),
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
                            'Submit Support',
                            style: TextStyle(
                                color: kWhiteColor,
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountButton(int amount) {
    return ChoiceChip(
      selectedColor: kPrimaryColor,
      backgroundColor: kGreyColor,
      label: Text(
        'NLe$amount',
        style: TextStyle(fontFamily: 'Montserrat', fontSize: 14.spMax),
      ),
      selected: selectedAmount == amount,
      onSelected: (selected) {
        setState(() {
          selectedAmount = selected ? amount : null;
          otherAmountController.clear();
        });
      },
    );
  }

  Widget _buildOtherAmountField() {
    return Container(
      child: TextField(
        controller: otherAmountController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Other Amount',
          labelStyle: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
        ),
        onChanged: (value) {
          setState(() {
            selectedAmount = null;
          });
        },
      ),
    );
  }

  Widget _buildOtherNumberField() {
    return Container(
      child: TextField(
        controller: phonenumberController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Phone Number',
          labelStyle: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
          prefixText: "+232",
          prefixStyle: TextStyle(fontFamily: 'Montserrat', fontSize: 15),
        ),
      ),
    );
  }

  void _submit() {}
}
