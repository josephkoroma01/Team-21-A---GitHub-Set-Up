import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:lifebloodworld/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

DateTime now = DateTime.now();
String formattedNewDate = DateFormat('d MMM yyyy').format(now);
String formattedNextDonationDateFormat = DateFormat('yyyy-MM-dd').format(now);
String formattedNewMonth = DateFormat('LLLL').format(now);
String formattedNewYear = DateFormat('y').format(now);

var myid;

class ectriggerScreen extends StatefulWidget {
  ectriggerScreen({Key? key}) : super(key: key);

  @override
  _ectriggerScreenState createState() => _ectriggerScreenState();
}

class _ectriggerScreenState extends State<ectriggerScreen> {
  final List<String> bloodgrouplist = [
    'A+',
    'A-',
    'AB+',
    'AB-',
    'B+',
    'B-',
    'O+',
    'O-',
  ];

  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  String? selectedBloodType = '';
  final TextEditingController _birthdateinput = TextEditingController();

  final TextEditingController bloodlitresCtrl = TextEditingController();
  final TextEditingController dateinput =
      TextEditingController(text: formattedNewDate.toString());
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

  final TextEditingController textEditingController = TextEditingController();
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

  String? selectedCountry;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
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
                    height: 150.h,
                    width: 150.w,
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
                          bottom: 30.h, left: 30.h, right: 30.h),
                      child: Column(
                        children: [
                          10.verticalSpace,
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Make an Emergency Trigger',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: kLifeBloodRed)),
                                Text('Preparing the Blood Banks',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: kLifeBloodRed)),
                                20.verticalSpace,
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: SingleChildScrollView(
                                          child: InkWell(
                                        onTap: () {
                                          // Navigator.push(
                                          //   context,
                                          //   new MaterialPageRoute(
                                          //     builder: (context) => BloodTestPageFam(
                                          //       title: 'Blood Group Test for Myself',
                                          //     ),
                                          //   ),
                                          // );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0.0, 0.0, 0.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w),
                                              child: Container(
                                                padding: EdgeInsets.all(10.r),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    FaIcon(
                                                      FontAwesomeIcons
                                                          .handHoldingDroplet,
                                                      color: kLifeBloodRed,
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text('Blood\nDonor',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 14,
                                                                color:
                                                                    kLifeBloodRed)),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    // Text('Know Your Blood Type',
                                                    //     textAlign: TextAlign.center,
                                                    //     style: GoogleFonts.montserrat(
                                                    //         fontSize: 10,
                                                    //         color: Colors.grey)),
                                                    // SizedBox(
                                                    //   height: 5.h,
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: InkWell(
                                          onTap: () {
                                            // Navigator.push(
                                            //   context,
                                            //   new MaterialPageRoute(
                                            //     builder: (context) => BloodTestPage(
                                            //       title: 'Blood Group Test for Myself',
                                            //       facility: data.name!,
                                            //     ),
                                            //   ),
                                            // );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0.0, 0.0, 0.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5.w),
                                                child: Container(
                                                  padding: EdgeInsets.all(10.r),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      FaIcon(
                                                        FontAwesomeIcons.fire,
                                                        color: kLifeBloodRed,
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Text('Fire\nIncident',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 14,
                                                                  color:
                                                                      kLifeBloodRed)),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      // Text('Know Your Blood Type',
                                                      //     textAlign: TextAlign.center,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 10,
                                                      //         color: Colors.grey)),
                                                      // SizedBox(
                                                      //   height: 5.h,
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                10.verticalSpace,
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: SingleChildScrollView(
                                          child: InkWell(
                                        onTap: () {
                                          // Navigator.push(
                                          //   context,
                                          //   new MaterialPageRoute(
                                          //     builder: (context) => BloodTestPageFam(
                                          //       title: 'Blood Group Test for Myself',
                                          //     ),
                                          //   ),
                                          // );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0.0, 0.0, 0.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w),
                                              child: Container(
                                                padding: EdgeInsets.all(10.r),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    FaIcon(
                                                      FontAwesomeIcons
                                                          .roadCircleExclamation,
                                                      color: kLifeBloodRed,
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text('Road\nAccident',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 14,
                                                                color:
                                                                    kLifeBloodRed)),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    // Text('Know Your Blood Type',
                                                    //     textAlign: TextAlign.center,
                                                    //     style: GoogleFonts.montserrat(
                                                    //         fontSize: 10,
                                                    //         color: Colors.grey)),
                                                    // SizedBox(
                                                    //   height: 5.h,
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                          child: InkWell(
                                        onTap: () {
                                          // Navigator.push(
                                          //   context,
                                          //   new MaterialPageRoute(
                                          //     builder: (context) => BloodTestPageFam(
                                          //       title: 'Blood Group Test for Myself',
                                          //     ),
                                          //   ),
                                          // );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0.0, 0.0, 0.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w),
                                              child: Container(
                                                padding: EdgeInsets.all(10.r),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    FaIcon(
                                                      FontAwesomeIcons
                                                          .handHoldingDroplet,
                                                      color: kLifeBloodRed,
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text('Sickle Cell\nCrisis',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 14,
                                                                color:
                                                                    kLifeBloodRed)),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    // Text('Know Your Blood Type',
                                                    //     textAlign: TextAlign.center,
                                                    //     style: GoogleFonts.montserrat(
                                                    //         fontSize: 10,
                                                    //         color: Colors.grey)),
                                                    // SizedBox(
                                                    //   height: 5.h,
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                    ),
                                  ],
                                ),
                                10.verticalSpace,
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: InkWell(
                                          onTap: () {
                                            // Navigator.push(
                                            //   context,
                                            //   new MaterialPageRoute(
                                            //     builder: (context) => BloodTestPage(
                                            //       title: 'Blood Group Test for Myself',
                                            //       facility: data.name!,
                                            //     ),
                                            //   ),
                                            // );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0.0, 0.0, 0.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5.w),
                                                child: Container(
                                                  padding: EdgeInsets.all(10.r),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      FaIcon(
                                                        FontAwesomeIcons.fire,
                                                        color: kLifeBloodRed,
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Text('Voilent\nIncident',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 14,
                                                                  color:
                                                                      kLifeBloodRed)),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      // Text('Know Your Blood Type',
                                                      //     textAlign: TextAlign.center,
                                                      //     style: GoogleFonts.montserrat(
                                                      //         fontSize: 10,
                                                      //         color: Colors.grey)),
                                                      // SizedBox(
                                                      //   height: 5.h,
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                          child: InkWell(
                                        onTap: () {
                                          // Navigator.push(
                                          //   context,
                                          //   new MaterialPageRoute(
                                          //     builder: (context) => BloodTestPageFam(
                                          //       title: 'Blood Group Test for Myself',
                                          //     ),
                                          //   ),
                                          // );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0.0, 0.0, 0.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w),
                                              child: Container(
                                                padding: EdgeInsets.all(10.r),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    FaIcon(
                                                      FontAwesomeIcons
                                                          .roadCircleExclamation,
                                                      color: kLifeBloodRed,
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text('Chemical Exposure',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 14,
                                                                color:
                                                                    kLifeBloodRed)),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    // Text('Know Your Blood Type',
                                                    //     textAlign: TextAlign.center,
                                                    //     style: GoogleFonts.montserrat(
                                                    //         fontSize: 10,
                                                    //         color: Colors.grey)),
                                                    // SizedBox(
                                                    //   height: 5.h,
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                    ),
                                  ],
                                ),
                                15.verticalSpace,
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Interact with our ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 13,
                                      color: kGreyColor)),
                              Text('WhatsApp Manager',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: kGreyColor)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     TextButton(
              //         child: Text(t.dhaveanaccountsign,
              //             textAlign: TextAlign.center,
              //             style: GoogleFonts.montserrat(
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //                 color: Color(0xFF205072))),
              //         style: TextButton.styleFrom(
              //           foregroundColor: Color(0xFF205072),
              //           backgroundColor: Colors.transparent,
              //           shape: const RoundedRectangleBorder(
              //               borderRadius:
              //                   BorderRadius.all(Radius.circular(10))),
              //         ),
              //         onPressed: () {
              //           Navigator.push(
              //             context,
              //             new MaterialPageRoute(
              //               builder: (context) => RegisterScreen(),
              //             ),
              //           );
              //         }),
              //   ],
              // ),
              //
              // Text(
              //   'Blood Donor Needed!\nContact Donor Support Now',
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: kLifeBloodBlue,
              //       fontSize: 13,
              //       letterSpacing: 0,
              //       fontFamily: 'Montserrat'),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     TextButton(
              //       child: Row(children: [
              //         FaIcon(FontAwesomeIcons.whatsapp),

              //       ]),
              //       style: TextButton.styleFrom(
              //         foregroundColor: Colors.white,
              //         backgroundColor: Color(0xFFaf0d0c),
              //         shape: const CircleBorder(
              //             ),
              //       ),
              //       onPressed: () async {
              //           showModalBottomSheet(
              //               isScrollControlled: true,
              //               backgroundColor: Color(0xFFebf5f5),
              //               context: context,
              //               builder: (context) {
              //                 return SingleChildScrollView(
              //                   child: Container(
              //                     padding: EdgeInsets.only(
              //                         bottom: MediaQuery.of(context)
              //                             .viewInsets
              //                             .bottom),
              //                     child: Padding(
              //                       padding: EdgeInsets.fromLTRB(20.0, 20.0,
              //                           20.0, 0.0), // content padding
              //                       child: Column(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.center,
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.center,
              //                           children: [
              //                             SizedBox(
              //                               height: 10.h,
              //                             ),
              //                             InkWell(
              //                               onTap: () {
              //                                 Navigator.pop(context);
              //                               },
              //                               child: Row(
              //                                 mainAxisAlignment:
              //                                     MainAxisAlignment.end,
              //                                 crossAxisAlignment:
              //                                     CrossAxisAlignment.end,
              //                                 children: [
              //                                   Text(' Close',
              //                                       textAlign: TextAlign.center,
              //                                       style:
              //                                           GoogleFonts.montserrat(
              //                                               fontSize: 13,
              //                                               color: Colors.red)),
              //                                 ],
              //                               ),
              //                             ),
              //                             SizedBox(
              //                               height: 5.h,
              //                             ),
              //                             Text(
              //                                 'Request for \nBlood Community Donor(s)',
              //                                 textAlign: TextAlign.center,
              //                                 style: GoogleFonts.montserrat(
              //                                     fontSize: 15,
              //                                     fontWeight: FontWeight.bold,
              //                                     color: Color(0xff389e9d))),
              //                             SizedBox(
              //                               height: 5.h,
              //                             ),
              //                             Container(
              //                               width: double.infinity,
              //                               child: SizedBox(
              //                                 child: Divider(
              //                                   color: Colors.teal,
              //                                   thickness: 1,
              //                                 ),
              //                                 height: 5.h,
              //                               ),
              //                             ),
              //                             SizedBox(
              //                               height: 5.h,
              //                             ),
              //                             Text('Ask LifeBlood for Help\n',
              //                                 textAlign: TextAlign.center,
              //                                 style: GoogleFonts.montserrat(
              //                                     fontSize: 14,
              //                                     fontWeight: FontWeight.normal,
              //                                     color: Color(0xff406986))),
              //                             Row(
              //                               crossAxisAlignment:
              //                                   CrossAxisAlignment.start,
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment.start,
              //                               children: [
              //                                 Text('Where is the blood needed?',
              //                                     textAlign: TextAlign.left,
              //                                     style: GoogleFonts.montserrat(
              //                                         fontSize: 12,
              //                                         fontWeight:
              //                                             FontWeight.normal,
              //                                         color:
              //                                             Color(0xff389e9d))),
              //                               ],
              //                             ),
              //                             SizedBox(height: 5.h),
              //                             Form(
              //                               key: _formKey,
              //                               child: Column(
              //                                 children: [
              //                                   Row(
              //                                     children: [
              //                                       Icon(
              //                                         Icons.info_outline,
              //                                         size: 17,
              //                                       ),
              //                                       Text(
              //                                           ' Currently, LifeBlood is only available in Freetown.',
              //                                           textAlign:
              //                                               TextAlign.left,
              //                                           style: GoogleFonts
              //                                               .montserrat(
              //                                                   fontSize: 11,
              //                                                   fontWeight:
              //                                                       FontWeight
              //                                                           .normal,
              //                                                   color: Colors
              //                                                       .black)),
              //                                     ],
              //                                   ),
              //                                   SizedBox(
              //                                     height: 10.h,
              //                                   ),

              //                                   SizedBox(
              //                                     height: 10.h,
              //                                   ),
              //                                   Row(
              //                                     crossAxisAlignment:
              //                                         CrossAxisAlignment.start,
              //                                     mainAxisAlignment:
              //                                         MainAxisAlignment.start,
              //                                     children: [
              //                                       Text(
              //                                           'What bloodtype is needed?',
              //                                           textAlign:
              //                                               TextAlign.left,
              //                                           style: GoogleFonts
              //                                               .montserrat(
              //                                                   fontSize: 12,
              //                                                   fontWeight:
              //                                                       FontWeight
              //                                                           .normal,
              //                                                   color: Color(
              //                                                       0xff389e9d))),
              //                                     ],
              //                                   ),
              //                                   SizedBox(height: 5.h),
              //                                   DropdownButtonFormField2(
              //                                     decoration: InputDecoration(
              //                                       labelText: 'Blood Group',
              //                                       labelStyle: TextStyle(
              //                                           fontSize: 13,
              //                                           fontFamily:
              //                                               'Montserrat'),
              //                                       //Add isDense true and zero Padding.
              //                                       //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
              //                                       isDense: true,
              //                                       contentPadding:
              //                                           EdgeInsets.only(
              //                                               left: 5),
              //                                       border: OutlineInputBorder(
              //                                         borderRadius:
              //                                             BorderRadius.circular(
              //                                                 5),
              //                                       ),
              //                                       //Add more decoration as you want here
              //                                       //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
              //                                     ),
              //                                     buttonStyleData: const ButtonStyleData(
              //   padding: EdgeInsets.only(right: 0, left: 0),
              // ),
              // iconStyleData: const IconStyleData(
              //   icon: Icon(
              //     Icons.arrow_drop_down,
              //     color: Colors.black45,
              //   ),
              //   iconSize: 30,
              // ),
              // dropdownStyleData: DropdownStyleData(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(5),
              //   ),
              // ),
              // menuItemStyleData: const MenuItemStyleData(
              //   padding: EdgeInsets.symmetric(horizontal: 16),
              // ),
              //                                     items: bloodgrouplist
              //                                         .map((item) =>
              //                                             DropdownMenuItem<
              //                                                 String>(
              //                                               value: item,
              //                                               child: Text(
              //                                                 item,
              //                                                 style: TextStyle(
              //                                                   fontSize: 14,
              //                                                 ),
              //                                               ),
              //                                             ))
              //                                         .toList(),
              //                                     validator: (value) {
              //                                       if (value == null) {
              //                                         return 'Please select an option.';
              //                                       }
              //                                     },
              //                                     onChanged: (String? value) {
              //                                       setState(() {
              //                                         selectedBloodType = value;
              //                                       });
              //                                     },
              //                                     onSaved: (value) {
              //                                       selectedBloodType =
              //                                           value.toString();
              //                                     },
              //                                   ),
              //                                   SizedBox(height: 5.h),
              //                                   TextFormField(
              //                                     keyboardType:
              //                                         TextInputType.number,
              //                                     validator: (value) {
              //                                       if (value!.isEmpty) {
              //                                         return 'Unit of is required';
              //                                       }
              //                                       return null;
              //                                     },
              //                                     decoration: InputDecoration(
              //                                       border: OutlineInputBorder(
              //                                         borderRadius:
              //                                             BorderRadius.circular(
              //                                                 5),
              //                                       ),
              //                                       labelText:
              //                                           'Units of Blood Required',
              //                                       labelStyle: TextStyle(
              //                                           fontSize: 13,
              //                                           fontFamily:
              //                                               'Montserrat'),
              //                                     ),
              //                                     controller: bloodlitresCtrl,
              //                                   ),
              //                                   SizedBox(
              //                                     height: 10.h,
              //                                   ),
              //                                   Row(
              //                                     crossAxisAlignment:
              //                                         CrossAxisAlignment.start,
              //                                     mainAxisAlignment:
              //                                         MainAxisAlignment.start,
              //                                     children: [
              //                                       Text(
              //                                           'When is the blood needed?',
              //                                           textAlign:
              //                                               TextAlign.left,
              //                                           style: GoogleFonts
              //                                               .montserrat(
              //                                                   fontSize: 12,
              //                                                   fontWeight:
              //                                                       FontWeight
              //                                                           .normal,
              //                                                   color: Color(
              //                                                       0xff389e9d))),
              //                                     ],
              //                                   ),
              //                                   SizedBox(height: 10.h),
              //                                   TextFormField(
              //                                     validator: (value) {
              //                                       if (value!.isEmpty) {
              //                                         return 'Date is required';
              //                                       }
              //                                       return null;
              //                                     },
              //                                     controller:
              //                                         dateinput, //editing controller of this TextField
              //                                     decoration: InputDecoration(
              //                                       border: OutlineInputBorder(
              //                                         borderRadius:
              //                                             BorderRadius.circular(
              //                                                 5),
              //                                       ),
              //                                       // icon: Icon(Icons.calendar_today), //icon of text field
              //                                       labelText: "Date",
              //                                       labelStyle: TextStyle(
              //                                           fontSize: 13,
              //                                           fontFamily:
              //                                               'Montserrat'), //label text of field
              //                                     ),
              //                                     readOnly:
              //                                         true, //set it true, so that user will not able to edit text
              //                                     onTap: () async {
              //                                       DateTime? pickedDate =
              //                                           await showDatePicker(
              //                                               context: context,
              //                                               initialDate:
              //                                                   DateTime.now(),
              //                                               firstDate: DateTime
              //                                                   .now(), //DateTime.now() - not to allow to choose before today.
              //                                               lastDate:
              //                                                   DateTime(2101));

              //                                       if (pickedDate != null) {
              //                                         print(
              //                                             pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
              //                                         String formattedDate =
              //                                             DateFormat(
              //                                                     'd MMM yyyy')
              //                                                 .format(
              //                                                     pickedDate);
              //                                         print(
              //                                             formattedDate); //formatted date output using intl package =>  2021-03-16
              //                                         //you can implement different kind of Date Format here according to your requirement

              //                                         setState(() {
              //                                           dateinput.text =
              //                                               formattedDate; //set output date to TextField value.
              //                                         });
              //                                       } else {
              //                                         print(
              //                                             "Date is not selected");
              //                                       }
              //                                     },
              //                                   ),
              //                                   SizedBox(height: 10.h),
              //                                   SizedBox(
              //                                     width: double.infinity,
              //                                     child: ElevatedButton(
              //                                       style: ButtonStyle(
              //                                         backgroundColor:
              //                                             MaterialStateProperty
              //                                                 .all(Colors.teal),
              //                                       ),
              //                                       onPressed: () async {

              //                                         if (_formKey.currentState!
              //                                             .validate()) {
              //                                          FocusManager.instance.foregroundColorFocus?.unfocus();
              //         var whatsappUrl = "whatsapp://send?phone=${'+23278621647'}" +
              //             "&text=${Uri.encodeComponent('Hi LifeBlood, I need a Blood Donor')}";
              //         try {
              //           launch(whatsappUrl);
              //         } catch (e) {
              //           //To handle error and display error message
              //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //             content: Text('Could Not Launch WhatsApp',
              //                 style: GoogleFonts.montserrat()),
              //             backgroundColor: Colors.red,
              //             behavior: SnackBarBehavior.fixed,
              //             duration: Duration(seconds: 3),
              //           ));
              //         }
              //                                         }
              //                                       },
              //                                       child: const Text(
              //                                         'Request for Community Donor',
              //                                         style: TextStyle(
              //                                             fontFamily:
              //                                                 'Montserrat'),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                   SizedBox(height: 20.h),
              //                                 ],
              //                               ),
              //                             )
              //                           ]),
              //                     ),
              //                   ),
              //                 );
              //               });

              //       },
              //     ),
              //     TextButton(
              //       child: Row(children: [
              //         FaIcon(FontAwesomeIcons.squarePhoneFlip),

              //       ]),
              //       style: TextButton.styleFrom(
              //         foregroundColor: Colors.white,
              //         backgroundColor: Color(0xFFaf0d0c),
              //         shape: const CircleBorder(
              //             ),
              //       ),
              //       onPressed: () async {
              //           showModalBottomSheet(
              //               isScrollControlled: true,
              //               backgroundColor: Color(0xFFebf5f5),
              //               context: context,
              //               builder: (context) {
              //                 return SingleChildScrollView(
              //                   child: Container(
              //                     padding: EdgeInsets.only(
              //                         bottom: MediaQuery.of(context)
              //                             .viewInsets
              //                             .bottom),
              //                     child: Padding(
              //                       padding: EdgeInsets.fromLTRB(20.0, 20.0,
              //                           20.0, 0.0), // content padding
              //                       child: Column(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.center,
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.center,
              //                           children: [
              //                             SizedBox(
              //                               height: 10.h,
              //                             ),
              //                             InkWell(
              //                               onTap: () {
              //                                 Navigator.pop(context);
              //                               },
              //                               child: Row(
              //                                 mainAxisAlignment:
              //                                     MainAxisAlignment.end,
              //                                 crossAxisAlignment:
              //                                     CrossAxisAlignment.end,
              //                                 children: [
              //                                   Text(' Close',
              //                                       textAlign: TextAlign.center,
              //                                       style:
              //                                           GoogleFonts.montserrat(
              //                                               fontSize: 13,
              //                                               color: Colors.red)),
              //                                 ],
              //                               ),
              //                             ),
              //                             SizedBox(
              //                               height: 5.h,
              //                             ),
              //                             Text(
              //                                 'Request for \nBlood Community Donor(s)',
              //                                 textAlign: TextAlign.center,
              //                                 style: GoogleFonts.montserrat(
              //                                     fontSize: 15,
              //                                     fontWeight: FontWeight.bold,
              //                                     color: Color(0xff389e9d))),
              //                             SizedBox(
              //                               height: 5.h,
              //                             ),
              //                             Container(
              //                               width: double.infinity,
              //                               child: SizedBox(
              //                                 child: Divider(
              //                                   color: Colors.teal,
              //                                   thickness: 1,
              //                                 ),
              //                                 height: 5.h,
              //                               ),
              //                             ),
              //                             SizedBox(
              //                               height: 5.h,
              //                             ),
              //                             Text('Ask LifeBlood for Help\n',
              //                                 textAlign: TextAlign.center,
              //                                 style: GoogleFonts.montserrat(
              //                                     fontSize: 14,
              //                                     fontWeight: FontWeight.normal,
              //                                     color: Color(0xff406986))),
              //                             Row(
              //                               crossAxisAlignment:
              //                                   CrossAxisAlignment.start,
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment.start,
              //                               children: [
              //                                 Text('Where is the blood needed?',
              //                                     textAlign: TextAlign.left,
              //                                     style: GoogleFonts.montserrat(
              //                                         fontSize: 12,
              //                                         fontWeight:
              //                                             FontWeight.normal,
              //                                         color:
              //                                             Color(0xff389e9d))),
              //                               ],
              //                             ),
              //                             SizedBox(height: 5.h),
              //                             Form(
              //                               key: _formKey,
              //                               child: Column(
              //                                 children: [
              //                                   Row(
              //                                     children: [
              //                                       Icon(
              //                                         Icons.info_outline,
              //                                         size: 17,
              //                                       ),
              //                                       Text(
              //                                           ' Currently, LifeBlood is only available in Freetown.',
              //                                           textAlign:
              //                                               TextAlign.left,
              //                                           style: GoogleFonts
              //                                               .montserrat(
              //                                                   fontSize: 11,
              //                                                   fontWeight:
              //                                                       FontWeight
              //                                                           .normal,
              //                                                   color: Colors
              //                                                       .black)),
              //                                     ],
              //                                   ),
              //                                   SizedBox(
              //                                     height: 10.h,
              //                                   ),

              //                                   SizedBox(
              //                                     height: 10.h,
              //                                   ),
              //                                   Row(
              //                                     crossAxisAlignment:
              //                                         CrossAxisAlignment.start,
              //                                     mainAxisAlignment:
              //                                         MainAxisAlignment.start,
              //                                     children: [
              //                                       Text(
              //                                           'What bloodtype is needed?',
              //                                           textAlign:
              //                                               TextAlign.left,
              //                                           style: GoogleFonts
              //                                               .montserrat(
              //                                                   fontSize: 12,
              //                                                   fontWeight:
              //                                                       FontWeight
              //                                                           .normal,
              //                                                   color: Color(
              //                                                       0xff389e9d))),
              //                                     ],
              //                                   ),
              //                                   SizedBox(height: 5.h),
              //                                   DropdownButtonFormField2(
              //                                     decoration: InputDecoration(
              //                                       labelText: 'Blood Group',
              //                                       labelStyle: TextStyle(
              //                                           fontSize: 13,
              //                                           fontFamily:
              //                                               'Montserrat'),
              //                                       //Add isDense true and zero Padding.
              //                                       //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
              //                                       isDense: true,
              //                                       contentPadding:
              //                                           EdgeInsets.only(
              //                                               left: 5),
              //                                       border: OutlineInputBorder(
              //                                         borderRadius:
              //                                             BorderRadius.circular(
              //                                                 5),
              //                                       ),
              //                                       //Add more decoration as you want here
              //                                       //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
              //                                     ),
              //                                     buttonStyleData: const ButtonStyleData(
              //   padding: EdgeInsets.only(right: 0, left: 0),
              // ),
              // iconStyleData: const IconStyleData(
              //   icon: Icon(
              //     Icons.arrow_drop_down,
              //     color: Colors.black45,
              //   ),
              //   iconSize: 30,
              // ),
              // dropdownStyleData: DropdownStyleData(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(5),
              //   ),
              // ),
              // menuItemStyleData: const MenuItemStyleData(
              //   padding: EdgeInsets.symmetric(horizontal: 16),
              // ),
              //                                     items: bloodgrouplist
              //                                         .map((item) =>
              //                                             DropdownMenuItem<
              //                                                 String>(
              //                                               value: item,
              //                                               child: Text(
              //                                                 item,
              //                                                 style: TextStyle(
              //                                                   fontSize: 14,
              //                                                 ),
              //                                               ),
              //                                             ))
              //                                         .toList(),
              //                                     validator: (value) {
              //                                       if (value == null) {
              //                                         return 'Please select an option.';
              //                                       }
              //                                     },
              //                                     onChanged: (String? value) {
              //                                       setState(() {
              //                                         selectedBloodType = value;
              //                                       });
              //                                     },
              //                                     onSaved: (value) {
              //                                       selectedBloodType =
              //                                           value.toString();
              //                                     },
              //                                   ),
              //                                   SizedBox(height: 5.h),
              //                                   TextFormField(
              //                                     keyboardType:
              //                                         TextInputType.number,
              //                                     validator: (value) {
              //                                       if (value!.isEmpty) {
              //                                         return 'Unit of is required';
              //                                       }
              //                                       return null;
              //                                     },
              //                                     decoration: InputDecoration(
              //                                       border: OutlineInputBorder(
              //                                         borderRadius:
              //                                             BorderRadius.circular(
              //                                                 5),
              //                                       ),
              //                                       labelText:
              //                                           'Units of Blood Required',
              //                                       labelStyle: TextStyle(
              //                                           fontSize: 13,
              //                                           fontFamily:
              //                                               'Montserrat'),
              //                                     ),
              //                                     controller: bloodlitresCtrl,
              //                                   ),
              //                                   SizedBox(
              //                                     height: 10.h,
              //                                   ),
              //                                   Row(
              //                                     crossAxisAlignment:
              //                                         CrossAxisAlignment.start,
              //                                     mainAxisAlignment:
              //                                         MainAxisAlignment.start,
              //                                     children: [
              //                                       Text(
              //                                           'When is the blood needed?',
              //                                           textAlign:
              //                                               TextAlign.left,
              //                                           style: GoogleFonts
              //                                               .montserrat(
              //                                                   fontSize: 12,
              //                                                   fontWeight:
              //                                                       FontWeight
              //                                                           .normal,
              //                                                   color: Color(
              //                                                       0xff389e9d))),
              //                                     ],
              //                                   ),
              //                                   SizedBox(height: 10.h),
              //                                   TextFormField(
              //                                     validator: (value) {
              //                                       if (value!.isEmpty) {
              //                                         return 'Date is required';
              //                                       }
              //                                       return null;
              //                                     },
              //                                     controller:
              //                                         dateinput, //editing controller of this TextField
              //                                     decoration: InputDecoration(
              //                                       border: OutlineInputBorder(
              //                                         borderRadius:
              //                                             BorderRadius.circular(
              //                                                 5),
              //                                       ),
              //                                       // icon: Icon(Icons.calendar_today), //icon of text field
              //                                       labelText: "Date",
              //                                       labelStyle: TextStyle(
              //                                           fontSize: 13,
              //                                           fontFamily:
              //                                               'Montserrat'), //label text of field
              //                                     ),
              //                                     readOnly:
              //                                         true, //set it true, so that user will not able to edit text
              //                                     onTap: () async {
              //                                       DateTime? pickedDate =
              //                                           await showDatePicker(
              //                                               context: context,
              //                                               initialDate:
              //                                                   DateTime.now(),
              //                                               firstDate: DateTime
              //                                                   .now(), //DateTime.now() - not to allow to choose before today.
              //                                               lastDate:
              //                                                   DateTime(2101));

              //                                       if (pickedDate != null) {
              //                                         print(
              //                                             pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
              //                                         String formattedDate =
              //                                             DateFormat(
              //                                                     'd MMM yyyy')
              //                                                 .format(
              //                                                     pickedDate);
              //                                         print(
              //                                             formattedDate); //formatted date output using intl package =>  2021-03-16
              //                                         //you can implement different kind of Date Format here according to your requirement

              //                                         setState(() {
              //                                           dateinput.text =
              //                                               formattedDate; //set output date to TextField value.
              //                                         });
              //                                       } else {
              //                                         print(
              //                                             "Date is not selected");
              //                                       }
              //                                     },
              //                                   ),
              //                                   SizedBox(height: 10.h),
              //                                   SizedBox(
              //                                     width: double.infinity,
              //                                     child: ElevatedButton(
              //                                       style: ButtonStyle(
              //                                         backgroundColor:
              //                                             MaterialStateProperty
              //                                                 .all(Colors.teal),
              //                                       ),
              //                                       onPressed: () async {

              //                                         if (_formKey.currentState!
              //                                             .validate()) {
              //                                          FocusManager.instance.foregroundColorFocus?.unfocus();
              //         var whatsappUrl = "whatsapp://send?phone=${'+23278621647'}" +
              //             "&text=${Uri.encodeComponent('Hi LifeBlood, I need a Blood Donor')}";
              //         try {
              //           launch(whatsappUrl);
              //         } catch (e) {
              //           //To handle error and display error message
              //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //             content: Text('Could Not Launch WhatsApp',
              //                 style: GoogleFonts.montserrat()),
              //             backgroundColor: Colors.red,
              //             behavior: SnackBarBehavior.fixed,
              //             duration: Duration(seconds: 3),
              //           ));
              //         }
              //                                         }
              //                                       },
              //                                       child: const Text(
              //                                         'Request for Community Donor',
              //                                         style: TextStyle(
              //                                             fontFamily:
              //                                                 'Montserrat'),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                   SizedBox(height: 20.h),
              //                                 ],
              //                               ),
              //                             )
              //                           ]),
              //                     ),
              //                   ),
              //                 );
              //               });

              //       },
              //     ),

              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
