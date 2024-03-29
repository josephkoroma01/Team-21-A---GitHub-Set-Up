import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lifebloodworld/constants/colors.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:lifebloodworld/features/Login/views/forgetpassword.dart';
import 'package:lifebloodworld/features/Register/views/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context)!;
    final Locale locale = Localizations.localeOf(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   elevation: 0,
      //   backgroundColor: Colors.teal,
      //   title: Text(t.login,
      //       style: GoogleFonts.montserrat(
      //           fontSize: size.width * 0.05,
      //           fontWeight: FontWeight.bold,
      //           color: Colors.white)),
      // ),
      body: const LoginPage(),
    );
  }
}

var myid;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  @override
  void initState() {
    super.initState();
    setState(() {
      myid = id;
    });
    // getPref();
    _passwordVisible = false;
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController _phonenumber = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _validate = false;
  bool _passwordVisible = false;
  bool _isloginLoading = false;

  Future<bool> getInternetUsingInternetConnectivity() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  FocusNode focusNode = FocusNode();

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
    // prefs.setString('ethnicity', ethnicity!);
    prefs.setString('bloodtype', bloodtype!);
    prefs.setString('prevdonation', prevdonation!);
    prefs.setString('prevdonationamt', prevdonationamt!);
    prefs.setString('community', community!);
    prefs.setString('communitydonor', communitydonor!);
    prefs.setString('id', myid);
  }

  Future userLogin() async {
    if (_phonenumber.text.isNotEmpty && _password.text.isNotEmpty) {
      // Getting username and password from Controller
      var data = {'phonenumber': _phonenumber.text, 'password': _password.text};

      await Future.delayed(Duration(seconds: 2));
      //Starting Web API Call.
      var response = await http.post(
          Uri.parse("https://community.lifebloodsl.com/login.php"),
          body: json.encode(data));

      if (response.statusCode == 200) {
        //Server response into variable
        print(response.body);

        var msg = jsonDecode(response.body);

        //Check Login Status
        if (msg['loginStatus'] == true) {
          setState(() {
            email = msg['userInfo']["email"];
            ufname = msg['userInfo']["firstname"];
            umname = msg['userInfo']["middlename"];
            ulname = msg['userInfo']["lastname"];
            agecategory = msg['userInfo']["agecategory"];
            gender = msg['userInfo']["gender"];
            phonenumber = msg['userInfo']["phonenumber"];
            email = msg['userInfo']["email"];
            address = msg['userInfo']["address"];
            nin = msg['userInfo']["nin"];
            district = msg['userInfo']["district"];
            bloodtype = msg['userInfo']["bloodtype"];
            prevdonation = msg['userInfo']["prevdonation"];
            prevdonationamt = msg['userInfo']["prevdonationamt"];
            community = msg['userInfo']["community"];
            communitydonor = msg['userInfo']["communitydonor"];
            password = msg['userInfo']["password"];
            id = msg['userInfo']["id"];
          });
          savePref();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => HomePageScreen(
                        pageIndex: 0,
                      )),
              (route) => false);
          // Navigate to Home Screen
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Phone Number and Password is not correct, Please Try Again',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(fontSize: 10)),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.fixed,
            duration: Duration(seconds: 3),
          ));
          setState(() {
            _isloginLoading = false;
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error Connecting to Server',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(fontSize: 10)),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.fixed,
          duration: Duration(seconds: 3),
        ));
        setState(() {
          _isloginLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Enter Phone Number or Password',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(fontSize: 11)),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 5),
      ));
      setState(() {
        _isloginLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var t = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Color(0xFFe0e9e4),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/lifebloodlogo.png",
                    height: 200.h,
                    width: 200.w,
                    // width: size.width * 0.4,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10.h, bottom: 5.h, left: 30.h, right: 30.h),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
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
                              controller: _phonenumber,
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
                                print('Country changed to: ' + country.name);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                              color: kPrimaryLightColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: _password,
                              obscureText: !_passwordVisible,
                              cursorColor: Colors.teal,
                              decoration: InputDecoration(
                                isDense: true,
                                errorStyle: TextStyle(
                                    fontFamily: 'Montserrat', letterSpacing: 0),
                                focusColor: Colors.teal,
                                labelText: t.enterpassword,
                                labelStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    letterSpacing: 0),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: const Color(0xFF205072),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                  color: const Color(0xFF205072),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                child: Text(t.forgotpassword,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal)),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.teal,
                                  backgroundColor: Colors.transparent,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (context) =>
                                          ForgetPasswordScreen(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: _isloginLoading
                                  ? SizedBox(
                                      height: 15.0,
                                      width: 15.0,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.0,
                                      ),
                                    )
                                  : Text(
                                      t.login,
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontSize: 13,
                                          letterSpacing: 2,
                                          fontWeight: FontWeight.bold),
                                    ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  if (await getInternetUsingInternetConnectivity()) {
                                    setState(() {
                                      _isloginLoading = true;
                                    });
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomePageScreen(
                                                  pageIndex: 0,
                                                )),
                                        (route) => false);
                                    userLogin();
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Row(
                                        children: [
                                          Icon(Icons.wifi_off_sharp, color: kWhiteColor,),
                                          5.horizontalSpace,
                                          Text(
                                              'You are currently offline',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12, color: kWhiteColor)),
                                        ],
                                      ),
                                      backgroundColor: kGreyColor,
                                      behavior: SnackBarBehavior.fixed,
                                      duration: const Duration(seconds: 10),
                                      // duration: Duration(seconds: 3),
                                    ));
                                  }
                                } else {
                                  _validate;
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  backgroundColor: Colors.teal,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 20),
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      child: Text(t.dhaveanaccountsign,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF205072))),
                      style: TextButton.styleFrom(
                        foregroundColor: Color(0xFF205072),
                        backgroundColor: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      }),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left:30, right: 30),
                child: Divider(
                  thickness: 0.20,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Blood Donor Needed!',
                style: TextStyle(
                    fontSize: 12,
                    letterSpacing: 0,
                    fontFamily: 'Montserrat'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    child: Row(children: [
                      FaIcon(FontAwesomeIcons.whatsapp),
                      SizedBox(
                        width: 5.h,
                      ),
                      Text('Send a WhatsApp Message Now!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontSize: 12, color: Colors.white)),
                    ]),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFFaf0d0c),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onPressed: () async {
                      //To remove the keyboard when button is pressed
                      FocusManager.instance.primaryFocus?.unfocus();
                      var whatsappUrl = "whatsapp://send?phone=${'+23278621647'}" +
                          "&text=${Uri.encodeComponent('Hi LifeBlood, I need a Blood Donor')}";
                      try {
                        launch(whatsappUrl);
                      } catch (e) {
                        //To handle error and display error message
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Could Not Launch WhatsApp',
                              style: GoogleFonts.montserrat()),
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
          ),
        ),
      ),
    );
  }
}
