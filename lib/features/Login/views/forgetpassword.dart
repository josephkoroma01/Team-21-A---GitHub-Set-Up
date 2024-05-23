import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lifebloodworld/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lifebloodworld/features/Login/views/login_screen.dart';
import 'package:pinput/pinput.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ForgetPasswordPage(),
    );
  }
}

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  String? id,
      email,
      password,
      ufname,
      umname,
      ulname,
      agecategory,
      gender,
      phonenumber,
      address,
      nin,
      district,
      bloodtype,
      prevdonation,
      prevdonationamt,
      community,
      communitydonor;

  String? fpassword = '';
  String? otpcode = '';
  String? otpcodesent;
  bool otpready = false;
  final TextEditingController refCodeCtrl = TextEditingController(
    text: randomNumeric(6).toString(),
  );

  final _forgetcheckformKey = GlobalKey<FormState>();
  final _forgetformKey = GlobalKey<FormState>();
  TextEditingController _forgetphonenumberCtrl = TextEditingController();
  TextEditingController _forgetsentphonenumberCtrl = TextEditingController();
  bool _isloginLoading = false;
  TextEditingController _password = TextEditingController();
  bool _passwordVisible = false;
  TextEditingController _phonenumber = TextEditingController();
  TextEditingController _refcodesentCtrl = TextEditingController();
  bool _validate = false;
  FocusNode focusNode = FocusNode();
  Future<bool> getInternetUsingInternetConnectivity() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  @override
  void initState() {
    super.initState();
    // getPref();
    _passwordVisible = false;
  }

  Future forgotpassword() async {
    var data = {
      'phonenumber': '+232' + _forgetphonenumberCtrl.text,
      'refcode': refCodeCtrl.text,
    };
    //Starting Web API Call.
    var response = await http.post(
        Uri.parse("https://community.lifebloodsl.com/forgotpassword.php"),
        body: json.encode(data));
    if (response.statusCode == 200) {
      //Server response into variable
      print(response.body);

      var msg = jsonDecode(response.body);

      //Check Login Status
      if (msg['userStatus'] == true) {
        setState(() {
          otpready = true;
          otpcode = refCodeCtrl.text;
          fpassword = msg['userInformation']["password"];
        }); // Navigate to Home Screen
      } else if (msg['userStatus'] == false) {
        // Navigate to Home Screen
        showModalBottomSheet(
            backgroundColor: Color(0xFFebf5f5),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Close',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFE02020)))
                            ],
                          ),
                        ),
                        Text('Forgotten password?',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                fontSize: 18,
                                letterSpacing: 0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff406986))),
                        SizedBox(
                          height: 3.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Divider(
                            height: 1.h,
                            thickness: 0.5.w,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Image.asset(
                          'assets/icons/error.png',
                          height: 40.h,
                          width: 40.h,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 13,
                              color: Color(0xff406986),
                              height: 1.3846153846153846,
                            ),
                            children: [
                              TextSpan(
                                text: 'Phone Number not found!!!\n',
                              ),
                              TextSpan(
                                text: 'Create An Account',
                                style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff406986),
                                ),
                              ),
                            ],
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Container(
                          width: double.infinity,
                          child: TextButton(
                              child: Text('Create Now',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                      letterSpacing: 0,
                                      fontSize: 14,
                                      color: Colors.white)),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Color(0xff389e9d),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   new MaterialPageRoute(
                                //     builder: (context) => WelcomeScreen(),
                                //   ),
                                // );
                              }),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      }
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
    prefs.setString('communitydonor', communitydonor!);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFe0e9e4),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding:
                  EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Image.asset(
                    'assets/icons/key.png',
                    height: 60.h,
                    width: 60.h,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text('Forgot your password?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontSize: 17,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff406986))),
                  Form(
                    key: _forgetformKey,
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
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 0,
                                ),
                              ),
                              controller: refCodeCtrl,
                            ),
                          ),
                        ),
                        otpready
                            ? SizedBox(
                                height: 10.h,
                              )
                            : Column(
                                children: [
                                  Text(
                                      'We\'ll send a verification to the Phone Number if it matches an existing LifeBlood account.',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 13,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey)),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: kPrimaryLightColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: IntlPhoneField(
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
                                      controller: _forgetphonenumberCtrl,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        isDense: true,
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
                                        border: InputBorder.none,
                                      ),
                                      languageCode: "en",
                                      onChanged: (phone) {
                                        print(phone.completeNumber);
                                      },
                                      onCountryChanged: (country) {
                                        print('Country changed to: ' +
                                            country.name);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 10.h,
                        ),
                        otpready
                            ? Column(
                                children: [
                                  Text(
                                      'A verification has been sent to: +232' +
                                          _forgetphonenumberCtrl.text +
                                          '\n' +
                                          'Kindly enter the six digit code, to verify the number',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 13,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey)),
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
                                ],
                              )
                            : SizedBox(
                                height: 0.h,
                              ),
                        otpready
                            ? Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text('Verify',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              letterSpacing: 0,
                                              fontSize: 14,
                                              color: Colors.white)),
                                    ),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Color(0xff389e9d),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                    ),
                                    onPressed: () async {
                                      if (otpcodesent != null) {
                                        if (otpcode == otpcodesent) {
                                          showModalBottomSheet(
                                              backgroundColor:
                                                  Color(0xFFebf5f5),
                                              context: context,
                                              builder: (context) {
                                                return SingleChildScrollView(
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                                context)
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
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Image.asset(
                                                            'assets/icons/check-mark.png',
                                                            height: 40.h,
                                                            width: 40.h,
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Text.rich(
                                                            TextSpan(
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                fontSize: 13,
                                                                color: Color(
                                                                    0xff406986),
                                                                height:
                                                                    1.3846153846153846,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      'Password Found',
                                                                ),
                                                              ],
                                                            ),
                                                            textHeightBehavior:
                                                                TextHeightBehavior(
                                                                    applyHeightToFirstAscent:
                                                                        false),
                                                            textAlign: TextAlign
                                                                .center,
                                                            softWrap: true,
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Text.rich(
                                                            TextSpan(
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                fontSize: 13,
                                                                color: Color(
                                                                    0xff406986),
                                                                height:
                                                                    1.3846153846153846,
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                    text:
                                                                        fpassword),
                                                              ],
                                                            ),
                                                            textHeightBehavior:
                                                                TextHeightBehavior(
                                                                    applyHeightToFirstAscent:
                                                                        false),
                                                            textAlign: TextAlign
                                                                .center,
                                                            softWrap: true,
                                                          ),
                                                          SizedBox(
                                                            height: 15.h,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                width:
                                                                    size.width *
                                                                        0.8,
                                                                child:
                                                                    TextButton(
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              5),
                                                                          child: Text(
                                                                              'Copy',
                                                                              textAlign: TextAlign.center,
                                                                              style: GoogleFonts.montserrat(fontSize: 14, color: Colors.white)),
                                                                        ),
                                                                        style: TextButton
                                                                            .styleFrom(
                                                                          foregroundColor:
                                                                              Colors.white,
                                                                          backgroundColor:
                                                                              Color(0xff389e9d),
                                                                          shape:
                                                                              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          await Clipboard.setData(
                                                                              ClipboardData(text: '$fpassword'));
                                                                          Navigator.pop(
                                                                              context);
                                                                          // Navigator.push(
                                                                          //     context,
                                                                          //     new MaterialPageRoute(
                                                                          //       builder: (context) => LoginScreen(),
                                                                          //     ));
                                                                          ScaffoldMessenger.of(context)
                                                                              .showSnackBar(SnackBar(
                                                                            duration:
                                                                                Duration(seconds: 3),
                                                                            content: Text('Copied to clipboard',
                                                                                textAlign: TextAlign.center,
                                                                                style: GoogleFonts.montserrat()),
                                                                          ));
                                                                        }),
                                                              )
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
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                'Verification Code do not match.',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.montserrat(
                                                    letterSpacing: 0,
                                                    fontSize: 12)),
                                            backgroundColor: Color(0xFFE02020),
                                            behavior: SnackBarBehavior.fixed,
                                            duration:
                                                const Duration(seconds: 5),
                                            // duration: Duration(seconds: 3),
                                          ));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('Enter 6-Digit code',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(
                                                  letterSpacing: 0,
                                                  fontSize: 12)),
                                          backgroundColor: Color(0xFFE02020),
                                          behavior: SnackBarBehavior.fixed,
                                          duration: const Duration(seconds: 5),
                                          // duration: Duration(seconds: 3),
                                        ));
                                      }
                                    }),
                              )
                            : Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text('Next',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              letterSpacing: 0,
                                              color: Colors.white)),
                                    ),
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Color(0xff389e9d),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                    ),
                                    onPressed: () async {
                                      if (_forgetformKey.currentState!
                                          .validate()) {
                                        if (await getInternetUsingInternetConnectivity()) {
                                          forgotpassword();
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                'You are offline, Kindly turn on Wifi or Mobile Data to continue',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 10,
                                                  letterSpacing: 0,
                                                )),
                                            backgroundColor: Color(0xFFE02020),
                                            behavior: SnackBarBehavior.fixed,
                                            duration:
                                                const Duration(seconds: 10),
                                            // duration: Duration(seconds: 3),
                                          ));
                                        }
                                      }
                                    }),
                              )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 3.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Divider(
                          height: 1.h,
                          thickness: 0.3.w,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ));
                        },
                        child: Text('Back to Login',
                            style: GoogleFonts.montserrat(
                                fontSize: 13,
                                letterSpacing: 0,
                                color: Colors.teal,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
