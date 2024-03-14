import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lifebloodworld/features/Community/components/donationcampaigns.dart';
import 'package:lifebloodworld/features/Community/components/donationcampaignsearch.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class Triggerdata {
  int id;
  String name;
  String age;
  String gender;
  String phonenumber;
  String email;
  String district;
  String address;
  String bloodtype;
  String triggerdistrict;
  String triggerfacility;
  String triggeraddress;
  String triggerbloodtype;
  String bloodlitres;
  String date;
  String time;
  String created_at;

  Triggerdata({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.phonenumber,
    required this.email,
    required this.district,
    required this.address,
    required this.bloodtype,
    required this.triggerdistrict,
    required this.triggerfacility,
    required this.triggeraddress,
    required this.triggerbloodtype,
    required this.bloodlitres,
    required this.date,
    required this.time,
    required this.created_at



  });

  factory Triggerdata.fromJson(Map<String, dynamic> json) {
    return Triggerdata(
        id: json['id'],
        name: json['name'],
        age: json['age'].toString(),
        gender: json['gender'],
        phonenumber: json['phonenumber'].toString(),
        email: json['email'],
        district: json['district'],
        address: json['address'],
        bloodtype: json['bloodtype'],
        triggerdistrict: json['triggerdistrict'],
        triggerfacility: json['triggerfacility'],
        triggeraddress: json['triggeraddress'],
        triggerbloodtype: json['triggerbloodtype'],
        bloodlitres: json['bloodlitres'].toString(),
        date: json['date'].toString(),
        time: json['time'].toString(),
        created_at: json['created_at'].toString()

    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'age': age,
    'gender': gender,
    'phonenumber': phonenumber,
    'email': email,
    'district': district,
    'address': address,
    'bloodtype': bloodtype,
    'triggerdistrict': triggerdistrict,
    'triggerfacility': triggerfacility,
    'triggeraddress': triggeraddress,
    'triggerbloodtype': triggerbloodtype,
    'bloodlitres': bloodlitres,
    'date': date,
    'time': time,
    'created_at': created_at
  };
}
class BloodCommunity extends StatefulWidget {
  const BloodCommunity({Key? key}) : super(key: key);

  @override
  State<BloodCommunity> createState() => _BloodCommunityState();
}

class _BloodCommunityState extends State<BloodCommunity> {

  String query = '';
  final _formKey = GlobalKey<FormState>();

  List<Triggerdata> trigger = [];

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

  String? selectedDistrict = '';

  String? selectedBloodType = '';



  final TextEditingController dateinput = TextEditingController();
  final TextEditingController timeinput = TextEditingController();
  final TextEditingController facilityCtrl = TextEditingController();
  final TextEditingController bloodlitresCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  @override
  void initState() {
    super.initState();
    getPref();
    timeinput.text = "";
    dateinput.text = "";
    getTriggers(query);
  }


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
      email = prefs.getString('email');
      district = prefs.getString('district');
      address = prefs.getString('address');
      bloodtype = prefs.getString('bloodtype');
    });
  }

  Future maketrigger() async {
    var response = await http.post(Uri.parse("http://lifebloodsl.com/communityapi/communitytrigger.php"), body: {
      "firstname": ufname,
      "middlename": umname,
      "lastname": ulname,
      "age": age,
      "gender": gender,
      "phonenumber": phonenumber,
      "email": email,
      "district": district,
      "address": address,
      "bloodtype": bloodtype,
      "triggerdistrict": selectedDistrict,
      "triggerfacility": facilityCtrl.text,
      "triggeraddress": _addressCtrl.text,
      "triggerbloodtype": selectedBloodType,
      "bloodlitres": bloodlitresCtrl.text,
      "date": dateinput.text,
      "time": timeinput.text,
    });
    var data = json.decode(response.body);
    if (data == "Error") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please Try Again, Feedback Already Exists'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 3),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
          height: 20.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Trigger Made Successfully', textAlign:TextAlign.center, style:GoogleFonts.montserrat(fontSize: 14.sp,) ),

            ],
          ),
        ),
        backgroundColor: Colors.teal,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 7),
      ));
      // scheduleAlarm();
    }
  }

  Future<List<Triggerdata>> getTriggers(String query) async {
    var response = await http.get(
        Uri.parse("http://lifebloodsl.com/communityapi/findtriggers.php"),
    );

    if (response.statusCode == 200) {
      final List trigger = json.decode(response.body);

      return trigger.map((json) => Triggerdata.fromJson(json)).where((
          trigger) {
        final nameLower = trigger.name.toLowerCase();
        final districtLower = trigger.district.toLowerCase();
        final searchLower = query.toLowerCase();

        return nameLower.contains(searchLower) ||
            districtLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
  Timer? debouncer;


  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }



  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Color(0xFFe0e9e4),
        appBar: AppBar(
            title: Text('Blood Community',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),),
            automaticallyImplyLeading: true,
            elevation: 0,
            backgroundColor: Color(0xFFE02020),
            leading: IconButton(icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )
        ),
        body: SafeArea(
          child: Column(
            children: [
                    buildDonationSearch(),
                    Expanded(
                      child: FutureBuilder<List<Triggerdata>>(
                          future: getTriggers(query),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.teal,
                                  ));
                            } else if (!snapshot.hasData) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/icons/sad.png",
                                        height: 60.h,
                                        width: 60.w,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        "No active triggers found..",
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 15.sp,
                                            color: Color(0xFFE02020)),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          style: TextStyle(
                                            color: Color(0xFF205072),
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'Hi, ',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.normal,
                                                color: Color(0xFF205072),
                                              ),
                                            ),
                                            TextSpan(
                                              text: "$ufname $ulname",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF205072),
                                              ),
                                            ),
                                          ],
                                        ),
                                        textHeightBehavior: TextHeightBehavior(
                                            applyHeightToFirstAscent: false),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        "Do you want to make a trigger? \nIf Yes, Kindly make a trigger",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 13.sp,
                                            color: Color(0xFF205072)),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),

                                    ],
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      ],
                                    ),
                                    Expanded(
                                      child: ListView(
                                        children: snapshot.data!
                                            .map((data) => Column(
                                          children: <Widget>[
                                            Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child:
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
                                                                  .fromLTRB(.0, 5.0,
                                                                  5.0, 5.0),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    10.w),
                                                                child: Container(
                                                                  padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                      10.r),
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    color: (data.email == email) ? Colors.white : Color(
                                                                        0xFFebf5f5),
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        16),
                                                                  ),
                                                                  child: Column(
                                                                    children: [
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                            const EdgeInsets.all(8.0),
                                                                            child:
                                                                            Column(
                                                                              crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                              mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                              children: [
                                                                                Text('Trigger Information',
                                                                                    textAlign: TextAlign.center,
                                                                                    style: GoogleFonts.montserrat(fontSize: 10.sp, color: Color(0xff389e9d))),
                                                                                SizedBox(
                                                                                  height: 5.h,
                                                                                ),

                                                                                Form(
                                                                                  // key: _formKey,
                                                                                    autovalidateMode: AutovalidateMode.always,
                                                                                    child: Column(children: [
                                                                                      (data.email == email) ? SizedBox(width:0) : TextFormField(
                                                                                        keyboardType: TextInputType.number,
                                                                                        initialValue: data.name,
                                                                                        style: TextStyle(fontSize: 12.sp, fontFamily: 'Montserrat'),
                                                                                        enabled: false,
                                                                                        readOnly: true,
                                                                                        validator: (value) {
                                                                                          if (value!.isEmpty) {
                                                                                            return 'Phone Number is required';
                                                                                          }
                                                                                          return null;
                                                                                        },
                                                                                        decoration: InputDecoration(labelText: 'Triggered by', hintText: 'Enter New Phone Number', labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 10.h,
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Text('Where is the Blood Needed?',
                                                                                              textAlign: TextAlign.center,
                                                                                              style: GoogleFonts.montserrat(fontSize: 10.sp, color: Color(0xff389e9d))),
                                                                                        ],
                                                                                      ),
                                                                                      // TextFormField(
                                                                                      //   keyboardType: TextInputType.number,
                                                                                      //   initialValue: data.triggerdistrict,
                                                                                      //   style: TextStyle(fontSize: 12.sp, fontFamily: 'Montserrat'),
                                                                                      //   enabled: false,
                                                                                      //   readOnly: true,
                                                                                      //   validator: (value) {
                                                                                      //     if (value!.isEmpty) {
                                                                                      //       return 'Phone Number is required';
                                                                                      //     }
                                                                                      //     return null;
                                                                                      //   },
                                                                                      //   decoration: InputDecoration(labelText: 'District', hintText: 'Enter New Phone Number', labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                      // ),
                                                                                      TextFormField(
                                                                                        textInputAction: TextInputAction.newline,
                                                                                        keyboardType: TextInputType.multiline,
                                                                                        maxLines: 3,
                                                                                        initialValue: data.district + ' | ' + data.triggerfacility + ' | ' +  data.triggeraddress,
                                                                                        style: TextStyle(fontSize: 12.sp, fontFamily: 'Montserrat'),
                                                                                        enabled: false,
                                                                                        readOnly: true,
                                                                                        validator: (value) {
                                                                                          if (value!.isEmpty) {
                                                                                            return 'Phone Number is required';
                                                                                          }
                                                                                          return null;
                                                                                        },
                                                                                        decoration: InputDecoration(labelText: 'District , Facility/Hospital Details', hintText: 'Enter New Phone Number', labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                      ),
                                                                                      // TextFormField(
                                                                                      //   keyboardType: TextInputType.number,
                                                                                      //   initialValue: data.triggeraddress,
                                                                                      //   style: TextStyle(fontSize: 12.sp, fontFamily: 'Montserrat'),
                                                                                      //   enabled: false,
                                                                                      //   readOnly: true,
                                                                                      //   validator: (value) {
                                                                                      //     if (value!.isEmpty) {
                                                                                      //       return 'Phone Number is required';
                                                                                      //     }
                                                                                      //     return null;
                                                                                      //   },
                                                                                      //   decoration: InputDecoration(labelText: 'Facility/Hospital Address', hintText: 'Enter New Phone Number', labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                      // ),

                                                                                      SizedBox(
                                                                                        height: 10.h,
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Text('What Type of Blood is Needed?',
                                                                                              textAlign: TextAlign.center,
                                                                                              style: GoogleFonts.montserrat(fontSize: 10.sp, color: Color(0xff389e9d))),
                                                                                        ],
                                                                                      ),
                                                                                      TextFormField(
                                                                                        keyboardType: TextInputType.number,
                                                                                        initialValue: data.triggerbloodtype + ' | ' + data.bloodlitres + 'ml',
                                                                                        style: TextStyle(fontSize: 12.sp, fontFamily: 'Montserrat'),
                                                                                        enabled: false,
                                                                                        readOnly: true,
                                                                                        validator: (value) {
                                                                                          if (value!.isEmpty) {
                                                                                            return 'Phone Number is required';
                                                                                          }
                                                                                          return null;
                                                                                        },
                                                                                        decoration: InputDecoration(labelText: 'BloodType & Litres (ml)', hintText: 'Enter New Phone Number', labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 10.h,
                                                                                      ),
                                                                                      Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,

                                                                                        children: [
                                                                                          Text('When is the Blood Needed?',
                                                                                              textAlign: TextAlign.center,
                                                                                              style: GoogleFonts.montserrat(fontSize: 10.sp, color: Color(0xff389e9d))),
                                                                                        ],
                                                                                      ),
                                                                                      TextFormField(
                                                                                        keyboardType: TextInputType.number,
                                                                                        initialValue: data.date + ' | ' + data.time,
                                                                                        style: TextStyle(fontSize: 12.sp, fontFamily: 'Montserrat'),
                                                                                        enabled: false,
                                                                                        readOnly: true,
                                                                                        validator: (value) {
                                                                                          if (value!.isEmpty) {
                                                                                            return 'Phone Number is required';
                                                                                          }
                                                                                          return null;
                                                                                        },
                                                                                        decoration: InputDecoration(labelText: 'Date & Time', hintText: 'Enter New Phone Number', labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                      ),
                                                                                    ])),

                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                          10.h),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                        children: [
                                                                          (data.email == email) ?  Column(
                            children: [
                            Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                            TextButton(
                            child:
                            Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            SizedBox(
                            width: 5.w,
                            ),
                            Icon(Icons.bloodtype),
                            SizedBox(
                            width: 5.w,
                            ),
                            Text('Volunteers', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                            SizedBox(
                            width: 5.w,
                            ),
                            ],
                            ),
                            style:
                            TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Color(0xff389e9d),
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            ),
                            onPressed: () async{
                            if (await getInternetUsingInternetConnectivity()) {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => registeredDonors(triggerid: data.id.toString())));
                            } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                            content: Text(
                            'You are offline, Kindly turn on Wifi or Mobile Data to continue',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                            fontSize: 10.sp)),
                            backgroundColor:
                            Color(0xFFE02020),
                            behavior: SnackBarBehavior.fixed,
                            duration:
                            const Duration(seconds: 5),
                            // duration: Duration(seconds: 3),
                            ));
                            }
                            },
                            ),
                            SizedBox(
                            width:
                            5.w,
                            ),
                              TextButton(
                                child:
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Icon(Icons.stop),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text('Stop', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                  ],
                                ),
                                style:
                                TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Color(0xFFE02020),
                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                ),
                                onPressed:
                                    () async{
                                  String id = data.id.toString();
                                  showModalBottomSheet(
                                    backgroundColor: Color(0xFFebf5f5),
                                    context: context,
                                    builder: (context) {
                                      return SingleChildScrollView(
                                        child: Container(
                                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text.rich(
                                                  TextSpan(
                                                    style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 15.sp,
                                                      color: Color(0xff406986),
                                                      height: 1.3846153846153846,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: 'Hi,',
                                                        style: GoogleFonts.montserrat(
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.bold,
                                                          color: Color(0xff406986),
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: ' $ufname $ulname',
                                                        style: GoogleFonts.montserrat(
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.bold,
                                                          color: Color(0xff389e9d),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                  textAlign: TextAlign.center,
                                                  softWrap: true,
                                                ),
                                                SizedBox(
                                                    height:10.h
                                                ),
                                                Text('Are you sure you\nwant to stop this trigger?', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.normal, color: Color(0xff406986))),


                                                SizedBox(
                                                    height:10.h
                                                ),

                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    TextButton(
                                                        child: Text('Yes', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                        style: TextButton.styleFrom(
                                                          primary: Colors.white,
                                                          backgroundColor: Color(0xff389e9d),
                                                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                        ),
                                                        onPressed: () async{
                                                          if(await getInternetUsingInternetConnectivity()) {
                                                            var response = await http.post(Uri.parse("http://lifebloodsl.com/communityapi/updatetriggerstatus.php"), body: {
                                                              "id": id,
                                                            });
                                                            Navigator.pop(context);
                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                              content: Container(
                                                                height: 30.h,
                                                                child: Column(
                                                                  children: [
                                                                    Column(
                                                                      children: [
                                                                        Text('Your trigger has been stopped successful.', textAlign:TextAlign.center, style:GoogleFonts.montserrat(fontSize: 11.sp) ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              backgroundColor: Colors.teal,
                                                              behavior: SnackBarBehavior.fixed,
                                                              duration: Duration(seconds: 10),));
                                                            await Navigator.push(context, MaterialPageRoute(builder: (context)=>BloodCommunity(),),);
// scheduleAlarm()
                                                          }
                                                          else{
                                                            ScaffoldMessenger
                                                                .of(
                                                                context)
                                                                .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                      'You are offline, Kindly turn on Wifi or Mobile Data to continue',
                                                                      textAlign: TextAlign
                                                                          .center,
                                                                      style: GoogleFonts
                                                                          .montserrat(
                                                                          fontSize: 10
                                                                              .sp)),
                                                                  backgroundColor: Color(
                                                                      0xFFE02020),
                                                                  behavior: SnackBarBehavior
                                                                      .fixed,
                                                                  duration: const Duration(
                                                                      seconds: 10),
                                                                  // duration: Duration(seconds: 3),
                                                                ));
                                                          }
                                                        }
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    TextButton(
                                                        child: Text('Close', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                        style: TextButton.styleFrom(
                                                          primary: Colors.white,
                                                          backgroundColor: Color(0xFFE02020),
                                                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        }),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20.h,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );

                                },
                              ),
                            ],
                            ),],
                            ) :
                                                                          Column(
                                                                            children: [
                                                                              Row(
                                                                                crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                                mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                                children: [
                                                                                  TextButton(
                                                                                    child: Row(
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        SizedBox(
                                                                                          width: 5.w,
                                                                                        ),
                                                                                        Icon(Icons.call),
                                                                                        SizedBox(
                                                                                          width: 5.w,
                                                                                        ),
                                                                                        Text('Call',
                                                                                            textAlign: TextAlign.center,
                                                                                            style: GoogleFonts.montserrat(
                                                                                                fontSize: 12.sp, color: Colors.white)),
                                                                                        SizedBox(
                                                                                          width: 5.w,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    style: TextButton.styleFrom(
                                                                                      primary: Colors.white,
                                                                                      backgroundColor: Color(0xff389e9d),
                                                                                      shape: const RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius.all(
                                                                                              Radius.circular(10))),
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      launchUrl(Uri(
                                                                                        scheme: 'tel',
                                                                                        path: data.phonenumber,
                                                                                      ));
                                                                                    },
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width:
                                                                                    5.w,
                                                                                  ),
                                                                                  TextButton(
                                                                                    child:
                                                                                    Row(
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        SizedBox(
                                                                                          width: 5.w,
                                                                                        ),
                                                                                        Icon(Icons.bloodtype),
                                                                                        SizedBox(
                                                                                          width: 5.w,
                                                                                        ),
                                                                                        Text('Volunteer to Donate', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                        SizedBox(
                                                                                          width: 5.w,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    style:
                                                                                    TextButton.styleFrom(
                                                                                      primary: Colors.white,
                                                                                      backgroundColor: Color(0xff389e9d),
                                                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      showModalBottomSheet(
                                                                                        backgroundColor: Color(0xFFebf5f5),
                                                                                        context: context,
                                                                                        builder: (context) {
                                                                                          return SingleChildScrollView(
                                                                                            child: Container(
                                                                                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                                child: Column(
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Text.rich(
                                                                                                      TextSpan(
                                                                                                        style: TextStyle(
                                                                                                          fontFamily: 'Montserrat',
                                                                                                          fontSize: 15.sp,
                                                                                                          color: Color(0xff406986),
                                                                                                          height: 1.3846153846153846,
                                                                                                        ),
                                                                                                        children: [
                                                                                                          TextSpan(
                                                                                                            text: 'Hi,',
                                                                                                            style: GoogleFonts.montserrat(
                                                                                                              fontSize: 14.sp,
                                                                                                              fontWeight: FontWeight.bold,
                                                                                                              color: Color(0xff406986),
                                                                                                            ),
                                                                                                          ),
                                                                                                          TextSpan(
                                                                                                            text: ' $ufname $ulname',
                                                                                                            style: GoogleFonts.montserrat(
                                                                                                              fontSize: 14.sp,
                                                                                                              fontWeight: FontWeight.bold,
                                                                                                              color: Color(0xff389e9d),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                      textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                                      textAlign: TextAlign.center,
                                                                                                      softWrap: true,
                                                                                                    ),
                                                                                                    Text('\nCan you \ndonate blood?', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 17.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                    SizedBox(
                                                                                                      height: 10.h,
                                                                                                    ),
                                                                                                    Text('Your donation changes lives.\nBut not everyone can donate blood (including plasma), for a few reasons. \nCheck your eligibility to donate now.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                                                                                    SizedBox(
                                                                                                      height: 5.h,
                                                                                                    ),
                                                                                                    Row(
                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                      children: [
                                                                                                        TextButton(
                                                                                                            child: Text('Take Eligibility Quiz', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                            style: TextButton.styleFrom(
                                                                                                              primary: Colors.white,
                                                                                                              backgroundColor: Color(0xff389e9d),
                                                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                            ),
                                                                                                            onPressed: () {
                                                                                                              var volunteeremail = data.email;
                                                                                                              var triggerid = data.id;
                                                                                                              var triggerbloodtype = data.bloodtype;
                                                                                                              var triggerfacility = data.triggerfacility;
                                                                                                              var triggerdistrict = data.triggerdistrict;
                                                                                                              var triggeraddress = data.triggeraddress;
                                                                                                              var time = data.time;
                                                                                                              var name = data.name;
                                                                                                              var date = data.date;
                                                                                                              Navigator.pop(context);
                                                                                                              showModalBottomSheet(
                                                                                                                backgroundColor: Color(0xFFebf5f5),
                                                                                                                context: context,
                                                                                                                builder: (context) {
                                                                                                                  return SingleChildScrollView(
                                                                                                                    child: Container(
                                                                                                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                                      child: Padding(
                                                                                                                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                                                        child: Column(
                                                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                          children: [
                                                                                                                            Text('Blood and Plasma Eligibility Quiz', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                            SizedBox(
                                                                                                                              height: 10.h,
                                                                                                                            ),
                                                                                                                            Image.asset(
                                                                                                                              "assets/icons/-18.png",
                                                                                                                              height: 40.h,
                                                                                                                              width: 40.w,
                                                                                                                            ),
                                                                                                                            SizedBox(
                                                                                                                              height: 5,
                                                                                                                            ),
                                                                                                                            Text('Are you 18-75 years old?', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                                                                                                            SizedBox(
                                                                                                                              height: 5.h,
                                                                                                                            ),
                                                                                                                            Row(
                                                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                              children: [
                                                                                                                                TextButton(
                                                                                                                                    child: Text('Yes', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                    style: TextButton.styleFrom(
                                                                                                                                      primary: Colors.white,
                                                                                                                                      backgroundColor: Color(0xff389e9d),
                                                                                                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                    ),
                                                                                                                                    onPressed: () {
                                                                                                                                      Navigator.pop(context);
                                                                                                                                      showModalBottomSheet(
                                                                                                                                        backgroundColor: Color(0xFFebf5f5),
                                                                                                                                        context: context,
                                                                                                                                        builder: (context) {
                                                                                                                                          return SingleChildScrollView(
                                                                                                                                            child: Container(
                                                                                                                                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                                                              child: Padding(
                                                                                                                                                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                                                                                child: Column(
                                                                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                  children: [
                                                                                                                                                    Text('Blood and Plasma Eligibility Quiz', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                    SizedBox(
                                                                                                                                                      height: 10.h,
                                                                                                                                                    ),
                                                                                                                                                    Image.asset(
                                                                                                                                                      "assets/icons/tattoo.png",
                                                                                                                                                      height: 40.h,
                                                                                                                                                      width: 40.w,
                                                                                                                                                    ),
                                                                                                                                                    SizedBox(
                                                                                                                                                      height: 5,
                                                                                                                                                    ),
                                                                                                                                                    Text('Had a tattoo in the last 4 months?', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                                                                                                                                    SizedBox(
                                                                                                                                                      height: 5.h,
                                                                                                                                                    ),
                                                                                                                                                    Row(
                                                                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                      children: [
                                                                                                                                                        TextButton(
                                                                                                                                                            child: Text('Yes', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                            style: TextButton.styleFrom(
                                                                                                                                                              primary: Colors.white,
                                                                                                                                                              backgroundColor: Color(0xff389e9d),
                                                                                                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                            ),
                                                                                                                                                            onPressed: () {
                                                                                                                                                              Navigator.pop(context);
                                                                                                                                                              showModalBottomSheet(
                                                                                                                                                                backgroundColor: Color(0xFFebf5f5),
                                                                                                                                                                context: context,
                                                                                                                                                                builder: (context) {
                                                                                                                                                                  return SingleChildScrollView(
                                                                                                                                                                    child: Container(
                                                                                                                                                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                                                                                      child: Padding(
                                                                                                                                                                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                                                                                                        child: Column(
                                                                                                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                          children: [
                                                                                                                                                                            Text('Blood and Plasma Eligibility Quiz', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                                            SizedBox(
                                                                                                                                                                              height: 10.h,
                                                                                                                                                                            ),
                                                                                                                                                                            Text.rich(
                                                                                                                                                                              TextSpan(
                                                                                                                                                                                style: TextStyle(
                                                                                                                                                                                  fontFamily: 'Montserrat',
                                                                                                                                                                                  fontSize: 15.sp,
                                                                                                                                                                                  color: Color(0xff406986),
                                                                                                                                                                                  height: 1.3846153846153846,
                                                                                                                                                                                ),
                                                                                                                                                                                children: [
                                                                                                                                                                                  TextSpan(
                                                                                                                                                                                    text: 'Hi,',
                                                                                                                                                                                    style: GoogleFonts.montserrat(
                                                                                                                                                                                      fontSize: 14.sp,
                                                                                                                                                                                      fontWeight: FontWeight.bold,
                                                                                                                                                                                      color: Color(0xff406986),
                                                                                                                                                                                    ),
                                                                                                                                                                                  ),
                                                                                                                                                                                  TextSpan(
                                                                                                                                                                                    text: ' $ufname $ulname',
                                                                                                                                                                                    style: GoogleFonts.montserrat(
                                                                                                                                                                                      fontSize: 14.sp,
                                                                                                                                                                                      fontWeight: FontWeight.bold,
                                                                                                                                                                                      color: Color(0xff389e9d),
                                                                                                                                                                                    ),
                                                                                                                                                                                  ),
                                                                                                                                                                                ],
                                                                                                                                                                              ),
                                                                                                                                                                              textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                                                                                                              textAlign: TextAlign.center,
                                                                                                                                                                              softWrap: true,
                                                                                                                                                                            ),
                                                                                                                                                                            SizedBox(
                                                                                                                                                                              height: 10.h,
                                                                                                                                                                            ),
                                                                                                                                                                            Image.asset(
                                                                                                                                                                              "assets/icons/error.png",
                                                                                                                                                                              height: 40.h,
                                                                                                                                                                              width: 40.w,
                                                                                                                                                                            ),
                                                                                                                                                                            SizedBox(
                                                                                                                                                                              height: 10.h,
                                                                                                                                                                            ),
                                                                                                                                                                            Text('Sorry, you are \nineligible to donate.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                                            SizedBox(
                                                                                                                                                                              height: 10.h,
                                                                                                                                                                            ),
                                                                                                                                                                            Text('You can only donate blood 4 months after you got your tattoo.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                                                                                                                                                            SizedBox(
                                                                                                                                                                              height: 10.h,
                                                                                                                                                                            ),
                                                                                                                                                                            SizedBox(
                                                                                                                                                                              height: 5.h,
                                                                                                                                                                            ),
                                                                                                                                                                            Row(
                                                                                                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                              children: [
                                                                                                                                                                                SizedBox(
                                                                                                                                                                                  width: 5.h,
                                                                                                                                                                                ),
                                                                                                                                                                                TextButton(
                                                                                                                                                                                    child: Text('Close', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                                                    style: TextButton.styleFrom(
                                                                                                                                                                                      primary: Colors.white,
                                                                                                                                                                                      backgroundColor: Color(0xffd12624),
                                                                                                                                                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                                                    ),
                                                                                                                                                                                    onPressed: () {
                                                                                                                                                                                      Navigator.pop(context);
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
                                                                                                                                                            }),
                                                                                                                                                        SizedBox(
                                                                                                                                                          width: 5.h,
                                                                                                                                                        ),
                                                                                                                                                        TextButton(
                                                                                                                                                            child: Text('No', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                            style: TextButton.styleFrom(
                                                                                                                                                              primary: Colors.white,
                                                                                                                                                              backgroundColor: Color(0xffd12624),
                                                                                                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                            ),
                                                                                                                                                            onPressed: () {
                                                                                                                                                              Navigator.pop(context);
                                                                                                                                                              showModalBottomSheet(
                                                                                                                                                                backgroundColor: Color(0xFFebf5f5),
                                                                                                                                                                context: context,
                                                                                                                                                                builder: (context) {
                                                                                                                                                                  return SingleChildScrollView(
                                                                                                                                                                    child: Container(
                                                                                                                                                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                                                                                      child: Padding(
                                                                                                                                                                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                                                                                                        child: Column(
                                                                                                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                          children: [
                                                                                                                                                                            Text('Blood and Plasma Eligibility Quiz', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                                            SizedBox(
                                                                                                                                                                              height: 10.h,
                                                                                                                                                                            ),
                                                                                                                                                                            Image.asset(
                                                                                                                                                                              "assets/icons/mother.png",
                                                                                                                                                                              height: 40.h,
                                                                                                                                                                              width: 40.w,
                                                                                                                                                                            ),
                                                                                                                                                                            SizedBox(
                                                                                                                                                                              height: 5,
                                                                                                                                                                            ),
                                                                                                                                                                            Text('Are you pregnant or \nrecently given birth?', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                                                                                                                                                            SizedBox(
                                                                                                                                                                              height: 5.h,
                                                                                                                                                                            ),
                                                                                                                                                                            Row(
                                                                                                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                              children: [
                                                                                                                                                                                TextButton(
                                                                                                                                                                                    child: Text('Yes', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                                                    style: TextButton.styleFrom(
                                                                                                                                                                                      primary: Colors.white,
                                                                                                                                                                                      backgroundColor: Color(0xff389e9d),
                                                                                                                                                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                                                    ),
                                                                                                                                                                                    onPressed: () {
                                                                                                                                                                                      Navigator.pop(context);
                                                                                                                                                                                      showModalBottomSheet(
                                                                                                                                                                                        backgroundColor: Color(0xFFebf5f5),
                                                                                                                                                                                        context: context,
                                                                                                                                                                                        builder: (context) {
                                                                                                                                                                                          return SingleChildScrollView(
                                                                                                                                                                                            child: Container(
                                                                                                                                                                                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                                                                                                              child: Padding(
                                                                                                                                                                                                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                                                                                                                                child: Column(
                                                                                                                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                  children: [
                                                                                                                                                                                                    Text('Blood and Plasma Eligibility Quiz', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                      height: 10.h,
                                                                                                                                                                                                    ),
                                                                                                                                                                                                    Text.rich(
                                                                                                                                                                                                      TextSpan(
                                                                                                                                                                                                        style: TextStyle(
                                                                                                                                                                                                          fontFamily: 'Montserrat',
                                                                                                                                                                                                          fontSize: 15.sp,
                                                                                                                                                                                                          color: Color(0xff406986),
                                                                                                                                                                                                          height: 1.3846153846153846,
                                                                                                                                                                                                        ),
                                                                                                                                                                                                        children: [
                                                                                                                                                                                                          TextSpan(
                                                                                                                                                                                                            text: 'Hi,',
                                                                                                                                                                                                            style: GoogleFonts.montserrat(
                                                                                                                                                                                                              fontSize: 14.sp,
                                                                                                                                                                                                              fontWeight: FontWeight.bold,
                                                                                                                                                                                                              color: Color(0xff406986),
                                                                                                                                                                                                            ),
                                                                                                                                                                                                          ),
                                                                                                                                                                                                          TextSpan(
                                                                                                                                                                                                            text: ' $ufname $ulname',
                                                                                                                                                                                                            style: GoogleFonts.montserrat(
                                                                                                                                                                                                              fontSize: 14.sp,
                                                                                                                                                                                                              fontWeight: FontWeight.bold,
                                                                                                                                                                                                              color: Color(0xff389e9d),
                                                                                                                                                                                                            ),
                                                                                                                                                                                                          ),
                                                                                                                                                                                                        ],
                                                                                                                                                                                                      ),
                                                                                                                                                                                                      textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                                                                                                                                      textAlign: TextAlign.center,
                                                                                                                                                                                                      softWrap: true,
                                                                                                                                                                                                    ),
                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                      height: 10.h,
                                                                                                                                                                                                    ),
                                                                                                                                                                                                    Image.asset(
                                                                                                                                                                                                      "assets/icons/error.png",
                                                                                                                                                                                                      height: 40.h,
                                                                                                                                                                                                      width: 40.w,
                                                                                                                                                                                                    ),
                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                      height: 10.h,
                                                                                                                                                                                                    ),
                                                                                                                                                                                                    Text('Sorry, you are \nineligible to donate.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                      height: 10.h,
                                                                                                                                                                                                    ),
                                                                                                                                                                                                    Text('The great news is you can donate \nas soon as 9 months after giving birth!', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                      height: 10.h,
                                                                                                                                                                                                    ),
                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                      height: 5.h,
                                                                                                                                                                                                    ),
                                                                                                                                                                                                    Row(
                                                                                                                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                      children: [
                                                                                                                                                                                                        TextButton(
                                                                                                                                                                                                            child: Text('Close', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                                                                            style: TextButton.styleFrom(
                                                                                                                                                                                                              primary: Colors.white,
                                                                                                                                                                                                              backgroundColor: Color(0xffd12624),
                                                                                                                                                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                                                                            ),
                                                                                                                                                                                                            onPressed: () {
                                                                                                                                                                                                              Navigator.pop(context);
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
                                                                                                                                                                                    }),
                                                                                                                                                                                SizedBox(
                                                                                                                                                                                  width: 5.h,
                                                                                                                                                                                ),
                                                                                                                                                                                TextButton(
                                                                                                                                                                                    child: Text('No', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                                                    style: TextButton.styleFrom(
                                                                                                                                                                                      primary: Colors.white,
                                                                                                                                                                                      backgroundColor: Color(0xffd12624),
                                                                                                                                                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                                                    ),
                                                                                                                                                                                    onPressed: () {
                                                                                                                                                                                      Navigator.pop(context);
                                                                                                                                                                                      showModalBottomSheet(
                                                                                                                                                                                        backgroundColor: Color(0xFFebf5f5),
                                                                                                                                                                                        context: context,
                                                                                                                                                                                        builder: (context) {
                                                                                                                                                                                          return SingleChildScrollView(
                                                                                                                                                                                            child: Container(
                                                                                                                                                                                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                                                                                                              child: Padding(
                                                                                                                                                                                                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                                                                                                                                child: Column(
                                                                                                                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                  children: [
                                                                                                                                                                                                    Text('Blood and Plasma Eligibility Quiz', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                      height: 10.h,
                                                                                                                                                                                                    ),
                                                                                                                                                                                                    Image.asset(
                                                                                                                                                                                                      "assets/icons/heart-problem.png",
                                                                                                                                                                                                      height: 40.h,
                                                                                                                                                                                                      width: 40.w,
                                                                                                                                                                                                    ),
                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                      height: 5,
                                                                                                                                                                                                    ),
                                                                                                                                                                                                    Text('Do you heart\ncondition?', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                      height: 5.h,
                                                                                                                                                                                                    ),
                                                                                                                                                                                                    Row(
                                                                                                                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                      children: [
                                                                                                                                                                                                        TextButton(
                                                                                                                                                                                                            child: Text('Yes', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                                                                            style: TextButton.styleFrom(
                                                                                                                                                                                                              primary: Colors.white,
                                                                                                                                                                                                              backgroundColor: Color(0xff389e9d),
                                                                                                                                                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                                                                            ),
                                                                                                                                                                                                            onPressed: () {
                                                                                                                                                                                                              Navigator.pop(context);
                                                                                                                                                                                                              showModalBottomSheet(
                                                                                                                                                                                                                backgroundColor: Color(0xFFebf5f5),
                                                                                                                                                                                                                context: context,
                                                                                                                                                                                                                builder: (context) {
                                                                                                                                                                                                                  return SingleChildScrollView(
                                                                                                                                                                                                                    child: Container(
                                                                                                                                                                                                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                                                                                                                                      child: Padding(
                                                                                                                                                                                                                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                                                                                                                                                        child: Column(
                                                                                                                                                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                                          children: [
                                                                                                                                                                                                                            Text('Blood and Plasma Eligibility Quiz', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                              height: 10.h,
                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                            Text.rich(
                                                                                                                                                                                                                              TextSpan(
                                                                                                                                                                                                                                style: TextStyle(
                                                                                                                                                                                                                                  fontFamily: 'Montserrat',
                                                                                                                                                                                                                                  fontSize: 15.sp,
                                                                                                                                                                                                                                  color: Color(0xff406986),
                                                                                                                                                                                                                                  height: 1.3846153846153846,
                                                                                                                                                                                                                                ),
                                                                                                                                                                                                                                children: [
                                                                                                                                                                                                                                  TextSpan(
                                                                                                                                                                                                                                    text: 'Hi,',
                                                                                                                                                                                                                                    style: GoogleFonts.montserrat(
                                                                                                                                                                                                                                      fontSize: 14.sp,
                                                                                                                                                                                                                                      fontWeight: FontWeight.bold,
                                                                                                                                                                                                                                      color: Color(0xff406986),
                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                  TextSpan(
                                                                                                                                                                                                                                    text: ' $ufname $ulname',
                                                                                                                                                                                                                                    style: GoogleFonts.montserrat(
                                                                                                                                                                                                                                      fontSize: 14.sp,
                                                                                                                                                                                                                                      fontWeight: FontWeight.bold,
                                                                                                                                                                                                                                      color: Color(0xff389e9d),
                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                ],
                                                                                                                                                                                                                              ),
                                                                                                                                                                                                                              textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                                                                                                                                                              textAlign: TextAlign.center,
                                                                                                                                                                                                                              softWrap: true,
                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                              height: 10.h,
                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                            Image.asset(
                                                                                                                                                                                                                              "assets/icons/error.png",
                                                                                                                                                                                                                              height: 40.h,
                                                                                                                                                                                                                              width: 40.w,
                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                              height: 10.h,
                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                            Text('Sorry, you are \nineligible to donate.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                              height: 10.h,
                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                            Text('Depending on your condition, you may be able\nto donate if you’ve had no symptoms for 6 months.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                              height: 10.h,
                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                            Row(
                                                                                                                                                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                                              children: [
                                                                                                                                                                                                                                TextButton(
                                                                                                                                                                                                                                    child: Text('Close', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                                                                                                    style: TextButton.styleFrom(
                                                                                                                                                                                                                                      primary: Colors.white,
                                                                                                                                                                                                                                      backgroundColor: Color(0xffd12624),
                                                                                                                                                                                                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                    onPressed: () {
                                                                                                                                                                                                                                      Navigator.pop(context);
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
                                                                                                                                                                                                            }),
                                                                                                                                                                                                        SizedBox(
                                                                                                                                                                                                          width: 5.h,
                                                                                                                                                                                                        ),
                                                                                                                                                                                                        TextButton(
                                                                                                                                                                                                            child: Text('No', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                                                                            style: TextButton.styleFrom(
                                                                                                                                                                                                              primary: Colors.white,
                                                                                                                                                                                                              backgroundColor: Color(0xffd12624),
                                                                                                                                                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                                                                            ),
                                                                                                                                                                                                            onPressed: () {
                                                                                                                                                                                                              Navigator.pop(context);
                                                                                                                                                                                                              showModalBottomSheet(
                                                                                                                                                                                                                backgroundColor: Color(0xFFebf5f5),
                                                                                                                                                                                                                context: context,
                                                                                                                                                                                                                builder: (context) {
                                                                                                                                                                                                                  return SingleChildScrollView(
                                                                                                                                                                                                                    child: Container(
                                                                                                                                                                                                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                                                                                                                                      child: Padding(
                                                                                                                                                                                                                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                                                                                                                                                        child: Column(
                                                                                                                                                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                                          children: [
                                                                                                                                                                                                                            Text('Blood and Plasma Eligibility Quiz', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                              height: 10.h,
                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                            Image.asset(
                                                                                                                                                                                                                              "assets/icons/anemia.png",
                                                                                                                                                                                                                              height: 40.h,
                                                                                                                                                                                                                              width: 40.w,
                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                              height: 5,
                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                            Text('Are you low on iron?\n\Do you have the following symptoms?\n Extreme fatigue\nWeakness\nFast heartbeat or shortness of breath\nPale skin\nChest pain,', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                              height: 5.h,
                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                            Row(
                                                                                                                                                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                                              children: [
                                                                                                                                                                                                                                TextButton(
                                                                                                                                                                                                                                    child: Text('Yes', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                                                                                                    style: TextButton.styleFrom(
                                                                                                                                                                                                                                      primary: Colors.white,
                                                                                                                                                                                                                                      backgroundColor: Color(0xff389e9d),
                                                                                                                                                                                                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                    onPressed: () {
                                                                                                                                                                                                                                      Navigator.pop(context);
                                                                                                                                                                                                                                      showModalBottomSheet(
                                                                                                                                                                                                                                        backgroundColor: Color(0xFFebf5f5),
                                                                                                                                                                                                                                        context: context,
                                                                                                                                                                                                                                        builder: (context) {
                                                                                                                                                                                                                                          return SingleChildScrollView(
                                                                                                                                                                                                                                            child: Container(
                                                                                                                                                                                                                                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                                                                                                                                                              child: Padding(
                                                                                                                                                                                                                                                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                                                                                                                                                                                child: Column(
                                                                                                                                                                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                                                                  children: [
                                                                                                                                                                                                                                                    Text('Blood and Plasma Eligibility Quiz', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                                                                      height: 10.h,
                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                    Text.rich(
                                                                                                                                                                                                                                                      TextSpan(
                                                                                                                                                                                                                                                        style: TextStyle(
                                                                                                                                                                                                                                                          fontFamily: 'Montserrat',
                                                                                                                                                                                                                                                          fontSize: 15.sp,
                                                                                                                                                                                                                                                          color: Color(0xff406986),
                                                                                                                                                                                                                                                          height: 1.3846153846153846,
                                                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                                                        children: [
                                                                                                                                                                                                                                                          TextSpan(
                                                                                                                                                                                                                                                            text: 'Hi,',
                                                                                                                                                                                                                                                            style: GoogleFonts.montserrat(
                                                                                                                                                                                                                                                              fontSize: 14.sp,
                                                                                                                                                                                                                                                              fontWeight: FontWeight.bold,
                                                                                                                                                                                                                                                              color: Color(0xff406986),
                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                          TextSpan(
                                                                                                                                                                                                                                                            text: ' $ufname $ulname',
                                                                                                                                                                                                                                                            style: GoogleFonts.montserrat(
                                                                                                                                                                                                                                                              fontSize: 14.sp,
                                                                                                                                                                                                                                                              fontWeight: FontWeight.bold,
                                                                                                                                                                                                                                                              color: Color(0xff389e9d),
                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                        ],
                                                                                                                                                                                                                                                      ),
                                                                                                                                                                                                                                                      textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                                                                                                                                                                                      textAlign: TextAlign.center,
                                                                                                                                                                                                                                                      softWrap: true,
                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                                                                      height: 10.h,
                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                    Image.asset(
                                                                                                                                                                                                                                                      "assets/icons/error.png",
                                                                                                                                                                                                                                                      height: 40.h,
                                                                                                                                                                                                                                                      width: 40.w,
                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                                                                      height: 10.h,
                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                    Text('Sorry, you are \nineligible to donate.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                                                                      height: 10.h,
                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                    Text('Add iron-rich foods (nuts, dried fruit, wholemeal pasta and bread, legumes (mixed beans, baked beans, lentils, chickpeas), dark leafy green vegetables (spinach, silver beet, broccoli), oats) to your diet, \ncheck iron levels with your GP and then give us a call.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                                                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                                                                      height: 10.h,
                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                    Row(
                                                                                                                                                                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                                                                      children: [
                                                                                                                                                                                                                                                        TextButton(
                                                                                                                                                                                                                                                            child: Text('Close', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                                                                                                                            style: TextButton.styleFrom(
                                                                                                                                                                                                                                                              primary: Colors.white,
                                                                                                                                                                                                                                                              backgroundColor: Color(0xffd12624),
                                                                                                                                                                                                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                            onPressed: () {
                                                                                                                                                                                                                                                              Navigator.pop(context);
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
                                                                                                                                                                                                                                    }),
                                                                                                                                                                                                                                SizedBox(
                                                                                                                                                                                                                                  width: 5.h,
                                                                                                                                                                                                                                ),
                                                                                                                                                                                                                                TextButton(
                                                                                                                                                                                                                                    child: Text('No', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                                                                                                    style: TextButton.styleFrom(
                                                                                                                                                                                                                                      primary: Colors.white,
                                                                                                                                                                                                                                      backgroundColor: Color(0xffd12624),
                                                                                                                                                                                                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                    onPressed: () {
                                                                                                                                                                                                                                      Navigator.pop(context);
                                                                                                                                                                                                                                      showModalBottomSheet(
                                                                                                                                                                                                                                        backgroundColor: Color(0xFFebf5f5),
                                                                                                                                                                                                                                        context: context,
                                                                                                                                                                                                                                        builder: (context) {
                                                                                                                                                                                                                                          return SingleChildScrollView(
                                                                                                                                                                                                                                            child: Container(
                                                                                                                                                                                                                                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                                                                                                                                                              child: Padding(
                                                                                                                                                                                                                                                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                                                                                                                                                                                child: Column(
                                                                                                                                                                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                                                                  children: [
                                                                                                                                                                                                                                                    Text('Blood and Plasma Eligibility Quiz', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                                                                      height: 10.h,
                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                    Image.asset(
                                                                                                                                                                                                                                                      "assets/icons/sex-addict.png",
                                                                                                                                                                                                                                                      height: 40.h,
                                                                                                                                                                                                                                                      width: 40.w,
                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                                                                      height: 5,
                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                    Text('Have you engaged in\n \u0027at risk\u0027 sexual activity\n in the past 3 months?', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                                                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                                                                      height: 5.h,
                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                    Row(
                                                                                                                                                                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                                                                      children: [
                                                                                                                                                                                                                                                        TextButton(
                                                                                                                                                                                                                                                            child: Text('Yes', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                                                                                                                            style: TextButton.styleFrom(
                                                                                                                                                                                                                                                              primary: Colors.white,
                                                                                                                                                                                                                                                              backgroundColor: Color(0xff389e9d),
                                                                                                                                                                                                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                            onPressed: () {
                                                                                                                                                                                                                                                              Navigator.pop(context);
                                                                                                                                                                                                                                                              showModalBottomSheet(
                                                                                                                                                                                                                                                                backgroundColor: Color(0xFFebf5f5),
                                                                                                                                                                                                                                                                context: context,
                                                                                                                                                                                                                                                                builder: (context) {
                                                                                                                                                                                                                                                                  return SingleChildScrollView(
                                                                                                                                                                                                                                                                    child: Container(
                                                                                                                                                                                                                                                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                                                                                                                                                                                      child: Padding(
                                                                                                                                                                                                                                                                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                                                                                                                                                                                                        child: Column(
                                                                                                                                                                                                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                                                                                          children: [
                                                                                                                                                                                                                                                                            Text('Blood and Plasma Eligibility Quiz', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                                                                              height: 10.h,
                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                            Text.rich(
                                                                                                                                                                                                                                                                              TextSpan(
                                                                                                                                                                                                                                                                                style: TextStyle(
                                                                                                                                                                                                                                                                                  fontFamily: 'Montserrat',
                                                                                                                                                                                                                                                                                  fontSize: 15.sp,
                                                                                                                                                                                                                                                                                  color: Color(0xff406986),
                                                                                                                                                                                                                                                                                  height: 1.3846153846153846,
                                                                                                                                                                                                                                                                                ),
                                                                                                                                                                                                                                                                                children: [
                                                                                                                                                                                                                                                                                  TextSpan(
                                                                                                                                                                                                                                                                                    text: 'Hi,',
                                                                                                                                                                                                                                                                                    style: GoogleFonts.montserrat(
                                                                                                                                                                                                                                                                                      fontSize: 14.sp,
                                                                                                                                                                                                                                                                                      fontWeight: FontWeight.bold,
                                                                                                                                                                                                                                                                                      color: Color(0xff406986),
                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                                                                  TextSpan(
                                                                                                                                                                                                                                                                                    text: ' $ufname $ulname',
                                                                                                                                                                                                                                                                                    style: GoogleFonts.montserrat(
                                                                                                                                                                                                                                                                                      fontSize: 14.sp,
                                                                                                                                                                                                                                                                                      fontWeight: FontWeight.bold,
                                                                                                                                                                                                                                                                                      color: Color(0xff389e9d),
                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                                                                ],
                                                                                                                                                                                                                                                                              ),
                                                                                                                                                                                                                                                                              textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                                                                                                                                                                                                              textAlign: TextAlign.center,
                                                                                                                                                                                                                                                                              softWrap: true,
                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                                                                              height: 10.h,
                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                            Image.asset(
                                                                                                                                                                                                                                                                              "assets/icons/error.png",
                                                                                                                                                                                                                                                                              height: 40.h,
                                                                                                                                                                                                                                                                              width: 40.w,
                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                                                                              height: 10.h,
                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                            Text('Sorry, you are \nineligible to donate.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                                                                              height: 10.h,
                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                            Text('Thanks for your interest, but unfortunately you \ncan\u0027t give blood for the next 3-12 months.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                                                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                                                                              height: 10.h,
                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                            Row(
                                                                                                                                                                                                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                                                                                              children: [
                                                                                                                                                                                                                                                                                TextButton(
                                                                                                                                                                                                                                                                                    child: Text('Close', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                                                                                                                                                    style: TextButton.styleFrom(
                                                                                                                                                                                                                                                                                      primary: Colors.white,
                                                                                                                                                                                                                                                                                      backgroundColor: Color(0xffd12624),
                                                                                                                                                                                                                                                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                    onPressed: () {
                                                                                                                                                                                                                                                                                      Navigator.pop(context);
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
                                                                                                                                                                                                                                                            }),
                                                                                                                                                                                                                                                        SizedBox(
                                                                                                                                                                                                                                                          width: 5.h,
                                                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                                                        TextButton(
                                                                                                                                                                                                                                                            child: Text('No', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                                                                                                                            style: TextButton.styleFrom(
                                                                                                                                                                                                                                                              primary: Colors.white,
                                                                                                                                                                                                                                                              backgroundColor: Color(0xffd12624),
                                                                                                                                                                                                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                            onPressed: () {
                                                                                                                                                                                                                                                              Navigator.pop(context);
                                                                                                                                                                                                                                                              showModalBottomSheet(
                                                                                                                                                                                                                                                                backgroundColor: Color(0xFFebf5f5),
                                                                                                                                                                                                                                                                context: context,
                                                                                                                                                                                                                                                                builder: (context) {
                                                                                                                                                                                                                                                                  return SingleChildScrollView(
                                                                                                                                                                                                                                                                    child: Container(
                                                                                                                                                                                                                                                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                                                                                                                                                                                      child: Padding(
                                                                                                                                                                                                                                                                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                                                                                                                                                                                                        child: Column(
                                                                                                                                                                                                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                                                                                          children: [
                                                                                                                                                                                                                                                                            Text('Blood and Plasma Eligibility Quiz', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                                                                              height: 10.h,
                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                            Image.asset(
                                                                                                                                                                                                                                                                              "assets/icons/syringe.png",
                                                                                                                                                                                                                                                                              height: 40.h,
                                                                                                                                                                                                                                                                              width: 40.w,
                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                                                                              height: 5,
                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                            Text('Have you injected recreational\ndrugs in the past 5 years?', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                                                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                                                                              height: 5.h,
                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                            Row(
                                                                                                                                                                                                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                                                                                              children: [
                                                                                                                                                                                                                                                                                TextButton(
                                                                                                                                                                                                                                                                                    child: Text('Yes', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                                                                                                                                                    style: TextButton.styleFrom(
                                                                                                                                                                                                                                                                                      primary: Colors.white,
                                                                                                                                                                                                                                                                                      backgroundColor: Color(0xff389e9d),
                                                                                                                                                                                                                                                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                    onPressed: () {
                                                                                                                                                                                                                                                                                      Navigator.pop(context);
                                                                                                                                                                                                                                                                                      showModalBottomSheet(
                                                                                                                                                                                                                                                                                        backgroundColor: Color(0xFFebf5f5),
                                                                                                                                                                                                                                                                                        context: context,
                                                                                                                                                                                                                                                                                        builder: (context) {
                                                                                                                                                                                                                                                                                          return SingleChildScrollView(
                                                                                                                                                                                                                                                                                            child: Container(
                                                                                                                                                                                                                                                                                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                                                                                                                                                                                                              child: Padding(
                                                                                                                                                                                                                                                                                                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                                                                                                                                                                                                                                child: Column(
                                                                                                                                                                                                                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                                                                                                                  children: [
                                                                                                                                                                                                                                                                                                    Text('Blood and Plasma Eligibility Quiz', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                                                                                                                      height: 10.h,
                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                    Text.rich(
                                                                                                                                                                                                                                                                                                      TextSpan(
                                                                                                                                                                                                                                                                                                        style: TextStyle(
                                                                                                                                                                                                                                                                                                          fontFamily: 'Montserrat',
                                                                                                                                                                                                                                                                                                          fontSize: 15.sp,
                                                                                                                                                                                                                                                                                                          color: Color(0xff406986),
                                                                                                                                                                                                                                                                                                          height: 1.3846153846153846,
                                                                                                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                                                                                                        children: [
                                                                                                                                                                                                                                                                                                          TextSpan(
                                                                                                                                                                                                                                                                                                            text: 'Hi,',
                                                                                                                                                                                                                                                                                                            style: GoogleFonts.montserrat(
                                                                                                                                                                                                                                                                                                              fontSize: 14.sp,
                                                                                                                                                                                                                                                                                                              fontWeight: FontWeight.bold,
                                                                                                                                                                                                                                                                                                              color: Color(0xff406986),
                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                                                                          TextSpan(
                                                                                                                                                                                                                                                                                                            text: ' $ufname $ulname',
                                                                                                                                                                                                                                                                                                            style: GoogleFonts.montserrat(
                                                                                                                                                                                                                                                                                                              fontSize: 14.sp,
                                                                                                                                                                                                                                                                                                              fontWeight: FontWeight.bold,
                                                                                                                                                                                                                                                                                                              color: Color(0xff389e9d),
                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                                                                        ],
                                                                                                                                                                                                                                                                                                      ),
                                                                                                                                                                                                                                                                                                      textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                                                                                                                                                                                                                                      textAlign: TextAlign.center,
                                                                                                                                                                                                                                                                                                      softWrap: true,
                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                                                                                                                      height: 10.h,
                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                    Image.asset(
                                                                                                                                                                                                                                                                                                      "assets/icons/error.png",
                                                                                                                                                                                                                                                                                                      height: 40.h,
                                                                                                                                                                                                                                                                                                      width: 40.w,
                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                                                                                                                      height: 10.h,
                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                    Text('Sorry, you are \nineligible to donate.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                                                                                                                      height: 10.h,
                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                    Text('Thanks for your interest.\nYou can donate blood 5 years after injecting drugs.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                                                                                                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                                                                                                                      height: 10.h,
                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                    Row(
                                                                                                                                                                                                                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                                                                                                                      children: [
                                                                                                                                                                                                                                                                                                        TextButton(
                                                                                                                                                                                                                                                                                                            child: Text('Close', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                                                                                                                                                                            style: TextButton.styleFrom(
                                                                                                                                                                                                                                                                                                              primary: Colors.white,
                                                                                                                                                                                                                                                                                                              backgroundColor: Color(0xffd12624),
                                                                                                                                                                                                                                                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                            onPressed: () {
                                                                                                                                                                                                                                                                                                              Navigator.pop(context);
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
                                                                                                                                                                                                                                                                                    }),
                                                                                                                                                                                                                                                                                SizedBox(
                                                                                                                                                                                                                                                                                  width: 5.h,
                                                                                                                                                                                                                                                                                ),
                                                                                                                                                                                                                                                                                TextButton(
                                                                                                                                                                                                                                                                                    child: Text('No', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                                                                                                                                                    style: TextButton.styleFrom(
                                                                                                                                                                                                                                                                                      primary: Colors.white,
                                                                                                                                                                                                                                                                                      backgroundColor: Color(0xffd12624),
                                                                                                                                                                                                                                                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                    onPressed: () {
                                                                                                                                                                                                                                                                                      Navigator.pop(context);
                                                                                                                                                                                                                                                                                      showModalBottomSheet(
                                                                                                                                                                                                                                                                                        backgroundColor: Color(0xFFebf5f5),
                                                                                                                                                                                                                                                                                        context: context,
                                                                                                                                                                                                                                                                                        builder: (context) {
                                                                                                                                                                                                                                                                                          return SingleChildScrollView(
                                                                                                                                                                                                                                                                                            child: Container(
                                                                                                                                                                                                                                                                                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                                                                                                                                                                                                              child: Padding(
                                                                                                                                                                                                                                                                                                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                                                                                                                                                                                                                                child: Column(
                                                                                                                                                                                                                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                                                                                                                  children: [
                                                                                                                                                                                                                                                                                                    Text('Blood Consent Form', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                                                                                                                      height: 5.h,
                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                                                                                                                      height: 10.h,
                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                    Image.asset(
                                                                                                                                                                                                                                                                                                      "assets/icons/consent.png",
                                                                                                                                                                                                                                                                                                      height: 40.h,
                                                                                                                                                                                                                                                                                                      width: 40.w,
                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                                                                                                                      height: 10.h,
                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                                                                                                                      height: 10.h,
                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                    Text.rich(
                                                                                                                                                                                                                                                                                                      TextSpan(
                                                                                                                                                                                                                                                                                                        style: TextStyle(
                                                                                                                                                                                                                                                                                                          fontFamily: 'Montserrat',
                                                                                                                                                                                                                                                                                                          fontSize: 15.sp,
                                                                                                                                                                                                                                                                                                          color: Color(0xff406986),
                                                                                                                                                                                                                                                                                                          height: 1.3846153846153846,
                                                                                                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                                                                                                        children: [
                                                                                                                                                                                                                                                                                                          TextSpan(
                                                                                                                                                                                                                                                                                                            text: 'Surname: ',
                                                                                                                                                                                                                                                                                                            style: GoogleFonts.montserrat(
                                                                                                                                                                                                                                                                                                              fontSize: 14.sp,
                                                                                                                                                                                                                                                                                                              fontWeight: FontWeight.bold,
                                                                                                                                                                                                                                                                                                              color: Color(0xff406986),
                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                                                                          TextSpan(
                                                                                                                                                                                                                                                                                                            text: '$ulname',
                                                                                                                                                                                                                                                                                                            style: GoogleFonts.montserrat(
                                                                                                                                                                                                                                                                                                              fontSize: 14.sp,
                                                                                                                                                                                                                                                                                                              fontWeight: FontWeight.bold,
                                                                                                                                                                                                                                                                                                              color: Color(0xff389e9d),
                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                                                                        ],
                                                                                                                                                                                                                                                                                                      ),
                                                                                                                                                                                                                                                                                                      textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                                                                                                                                                                                                                                      textAlign: TextAlign.center,
                                                                                                                                                                                                                                                                                                      softWrap: true,
                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                    SizedBox(width:5.w),
                                                                                                                                                                                                                                                                                                    Text.rich(
                                                                                                                                                                                                                                                                                                      TextSpan(
                                                                                                                                                                                                                                                                                                        style: TextStyle(
                                                                                                                                                                                                                                                                                                          fontFamily: 'Montserrat',
                                                                                                                                                                                                                                                                                                          fontSize: 15.sp,
                                                                                                                                                                                                                                                                                                          color: Color(0xff406986),
                                                                                                                                                                                                                                                                                                          height: 1.3846153846153846,
                                                                                                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                                                                                                        children: [
                                                                                                                                                                                                                                                                                                          TextSpan(
                                                                                                                                                                                                                                                                                                            text: 'Name: ',
                                                                                                                                                                                                                                                                                                            style: GoogleFonts.montserrat(
                                                                                                                                                                                                                                                                                                              fontSize: 14.sp,
                                                                                                                                                                                                                                                                                                              fontWeight: FontWeight.bold,
                                                                                                                                                                                                                                                                                                              color: Color(0xff406986),
                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                                                                          TextSpan(
                                                                                                                                                                                                                                                                                                            text: '$ufname $umname',
                                                                                                                                                                                                                                                                                                            style: GoogleFonts.montserrat(
                                                                                                                                                                                                                                                                                                              fontSize: 14.sp,
                                                                                                                                                                                                                                                                                                              fontWeight: FontWeight.bold,
                                                                                                                                                                                                                                                                                                              color: Color(0xff389e9d),
                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                                                                        ],
                                                                                                                                                                                                                                                                                                      ),
                                                                                                                                                                                                                                                                                                      textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                                                                                                                                                                                                                                      textAlign: TextAlign.center,
                                                                                                                                                                                                                                                                                                      softWrap: true,
                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                    Text.rich(
                                                                                                                                                                                                                                                                                                      TextSpan(
                                                                                                                                                                                                                                                                                                        style: TextStyle(
                                                                                                                                                                                                                                                                                                          fontFamily: 'Montserrat',
                                                                                                                                                                                                                                                                                                          fontSize: 15.sp,
                                                                                                                                                                                                                                                                                                          color: Color(0xff406986),
                                                                                                                                                                                                                                                                                                          height: 1.3846153846153846,
                                                                                                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                                                                                                        children: [
                                                                                                                                                                                                                                                                                                          TextSpan(
                                                                                                                                                                                                                                                                                                            text: 'Age: ',
                                                                                                                                                                                                                                                                                                            style: GoogleFonts.montserrat(
                                                                                                                                                                                                                                                                                                              fontSize: 14.sp,
                                                                                                                                                                                                                                                                                                              fontWeight: FontWeight.bold,
                                                                                                                                                                                                                                                                                                              color: Color(0xff406986),
                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                                                                          TextSpan(
                                                                                                                                                                                                                                                                                                            text: ' $age',
                                                                                                                                                                                                                                                                                                            style: GoogleFonts.montserrat(
                                                                                                                                                                                                                                                                                                              fontSize: 14.sp,
                                                                                                                                                                                                                                                                                                              fontWeight: FontWeight.bold,
                                                                                                                                                                                                                                                                                                              color: Color(0xff389e9d),
                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                                                                        ],
                                                                                                                                                                                                                                                                                                      ),
                                                                                                                                                                                                                                                                                                      textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                                                                                                                                                                                                                                      textAlign: TextAlign.center,
                                                                                                                                                                                                                                                                                                      softWrap: true,
                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                                                                                                                      height: 10.h,
                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                    Text('DECLARE THAT', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 11.sp, fontWeight: FontWeight.normal, color: Color(0xff406986))),
                                                                                                                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                                                                                                                      height: 5.h,
                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                    Text.rich(
                                                                                                                                                                                                                                                                                                      TextSpan(
                                                                                                                                                                                                                                                                                                        style: TextStyle(
                                                                                                                                                                                                                                                                                                          fontFamily: 'Montserrat',
                                                                                                                                                                                                                                                                                                          fontSize: 15.sp,
                                                                                                                                                                                                                                                                                                          color: Color(0xff406986),
                                                                                                                                                                                                                                                                                                          height: 1.3846153846153846,
                                                                                                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                                                                                                        children: [
                                                                                                                                                                                                                                                                                                          TextSpan(
                                                                                                                                                                                                                                                                                                            text: 'have read the information material and understood its meaning;\nhaving answered the questionnaire truthfully, having been informed of the meaning of the questions;\nbe aware that the information provided to me on my health and lifestyle is an essential element for the safety ofthose who will receive the donated blood;\nhave obtained a detailed and understandable explanation of theblood donation procedure\nI voluntarily accept to donate and that in the following 24h will not carryout risky activities.',
                                                                                                                                                                                                                                                                                                            style: GoogleFonts.montserrat(
                                                                                                                                                                                                                                                                                                              fontSize: 14.sp,
                                                                                                                                                                                                                                                                                                              fontWeight: FontWeight.normal,
                                                                                                                                                                                                                                                                                                              color: Color(0xff406986),
                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                                                                        ],
                                                                                                                                                                                                                                                                                                      ),
                                                                                                                                                                                                                                                                                                      textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                                                                                                                                                                                                                                      textAlign: TextAlign.center,
                                                                                                                                                                                                                                                                                                      softWrap: true,
                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                                                                                                                      height: 5.h,
                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                    Text.rich(
                                                                                                                                                                                                                                                                                                      TextSpan(
                                                                                                                                                                                                                                                                                                        style: TextStyle(
                                                                                                                                                                                                                                                                                                          fontFamily: 'Montserrat',
                                                                                                                                                                                                                                                                                                          fontSize: 15.sp,
                                                                                                                                                                                                                                                                                                          color: Color(0xff406986),
                                                                                                                                                                                                                                                                                                          height: 1.3846153846153846,
                                                                                                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                                                                                                        children: [
                                                                                                                                                                                                                                                                                                          TextSpan(
                                                                                                                                                                                                                                                                                                            text: 'I authorize the convervation and use of my blood components or residual biological material derived from the donation for the research purposes',
                                                                                                                                                                                                                                                                                                            style: GoogleFonts.montserrat(
                                                                                                                                                                                                                                                                                                              fontSize: 14.sp,
                                                                                                                                                                                                                                                                                                              fontWeight: FontWeight.normal,
                                                                                                                                                                                                                                                                                                              color: Color(0xff406986),
                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                                                                        ],
                                                                                                                                                                                                                                                                                                      ),
                                                                                                                                                                                                                                                                                                      textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                                                                                                                                                                                                                                      textAlign: TextAlign.center,
                                                                                                                                                                                                                                                                                                      softWrap: true,
                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                                                                                                                      height: 10.h,
                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                    Row(
                                                                                                                                                                                                                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                                                                                                                      children: [
                                                                                                                                                                                                                                                                                                        TextButton(
                                                                                                                                                                                                                                                                                                            child: Text('Accept', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                                                                                                                                                                            style: TextButton.styleFrom(
                                                                                                                                                                                                                                                                                                              primary: Colors.white,
                                                                                                                                                                                                                                                                                                              backgroundColor: Color(0xff389e9d),
                                                                                                                                                                                                                                                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                            onPressed: () {
                                                                                                                                                                                                                                                                                                              Navigator.pop(context);
                                                                                                                                                                                                                                                                                                              showModalBottomSheet(
                                                                                                                                                                                                                                                                                                                backgroundColor: Color(0xFFebf5f5),
                                                                                                                                                                                                                                                                                                                context: context,
                                                                                                                                                                                                                                                                                                                builder: (context) {
                                                                                                                                                                                                                                                                                                                  return SingleChildScrollView(
                                                                                                                                                                                                                                                                                                                    child: Container(
                                                                                                                                                                                                                                                                                                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                                                                                                                                                                                                                                      child: Padding(
                                                                                                                                                                                                                                                                                                                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                                                                                                                                                                                                                                                        child: Column(
                                                                                                                                                                                                                                                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                                                                                                                                          children: [
                                                                                                                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                                                                                                                              height: 10.h,
                                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                                            Text.rich(
                                                                                                                                                                                                                                                                                                                              TextSpan(
                                                                                                                                                                                                                                                                                                                                style: TextStyle(
                                                                                                                                                                                                                                                                                                                                  fontFamily: 'Montserrat',
                                                                                                                                                                                                                                                                                                                                  fontSize: 15.sp,
                                                                                                                                                                                                                                                                                                                                  color: Color(0xff406986),
                                                                                                                                                                                                                                                                                                                                  height: 1.3846153846153846,
                                                                                                                                                                                                                                                                                                                                ),
                                                                                                                                                                                                                                                                                                                                children: [
                                                                                                                                                                                                                                                                                                                                  TextSpan(
                                                                                                                                                                                                                                                                                                                                    text: 'Hi,',
                                                                                                                                                                                                                                                                                                                                    style: GoogleFonts.montserrat(
                                                                                                                                                                                                                                                                                                                                      fontSize: 14.sp,
                                                                                                                                                                                                                                                                                                                                      fontWeight: FontWeight.bold,
                                                                                                                                                                                                                                                                                                                                      color: Color(0xff406986),
                                                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                                                                                                                  TextSpan(
                                                                                                                                                                                                                                                                                                                                    text: ' $ufname $ulname',
                                                                                                                                                                                                                                                                                                                                    style: GoogleFonts.montserrat(
                                                                                                                                                                                                                                                                                                                                      fontSize: 14.sp,
                                                                                                                                                                                                                                                                                                                                      fontWeight: FontWeight.bold,
                                                                                                                                                                                                                                                                                                                                      color: Color(0xff389e9d),
                                                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                                                                                                                ],
                                                                                                                                                                                                                                                                                                                              ),
                                                                                                                                                                                                                                                                                                                              textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                                                                                                                                                                                                                                                              textAlign: TextAlign.center,
                                                                                                                                                                                                                                                                                                                              softWrap: true,
                                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                                                                                                                              height: 10.h,
                                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                                            Image.asset(
                                                                                                                                                                                                                                                                                                                              "assets/icons/fireworks.png",
                                                                                                                                                                                                                                                                                                                              height: 40.h,
                                                                                                                                                                                                                                                                                                                              width: 40.w,
                                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                                                                                                                              height: 10.h,
                                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                                            Text('You are all set to donate in', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.normal, color: Color(0xff406986))),
                                                                                                                                                                                                                                                                                                                            Text(data.triggerfacility, textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                                                                                                                              height: 10.h,
                                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                                            Row(
                                                                                                                                                                                                                                                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                                                                                                                                              children: [
                                                                                                                                                                                                                                                                                                                                TextButton(
                                                                                                                                                                                                                                                                                                                                    child: Text('Volunteer Now', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                                                                                                                                                                                                    style: TextButton.styleFrom(
                                                                                                                                                                                                                                                                                                                                      primary: Colors.white,
                                                                                                                                                                                                                                                                                                                                      backgroundColor: Color(0xff389e9d),
                                                                                                                                                                                                                                                                                                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                                                    onPressed: () async {
                                                                                                                                                                                                                                                                                                                                      if(await getInternetUsingInternetConnectivity()) {
                                                                                                                                                                                                                                                                                                                                        var response = await http
                                                                                                                                                                                                                                                                                                                                            .post(
                                                                                                                                                                                                                                                                                                                                            Uri
                                                                                                                                                                                                                                                                                                                                                .parse(
                                                                                                                                                                                                                                                                                                                                                "http://lifebloodsl.com/communityapi/triggerdonorregistration.php"),
                                                                                                                                                                                                                                                                                                                                            body: {
                                                                                                                                                                                                                                                                                                                                              "name": name,
                                                                                                                                                                                                                                                                                                                                              "lastname": ulname,
                                                                                                                                                                                                                                                                                                                                              "middlename": umname,
                                                                                                                                                                                                                                                                                                                                              "firstname": ufname,
                                                                                                                                                                                                                                                                                                                                              "age": age,
                                                                                                                                                                                                                                                                                                                                              "gender": gender,
                                                                                                                                                                                                                                                                                                                                              "address": address,
                                                                                                                                                                                                                                                                                                                                              "district": district,
                                                                                                                                                                                                                                                                                                                                              "phonenumber": phonenumber,
                                                                                                                                                                                                                                                                                                                                              "donoremail": email,
                                                                                                                                                                                                                                                                                                                                              "email": volunteeremail,
                                                                                                                                                                                                                                                                                                                                              "bloodgroup": bloodtype,
                                                                                                                                                                                                                                                                                                                                              "triggerbloodtype": triggerbloodtype,
                                                                                                                                                                                                                                                                                                                                              "triggerdistrict": triggerdistrict,
                                                                                                                                                                                                                                                                                                                                              "triggerid": triggerid.toString(),
                                                                                                                                                                                                                                                                                                                                              "triggerfacility": triggerfacility,
                                                                                                                                                                                                                                                                                                                                              "triggeraddress": triggeraddress,
                                                                                                                                                                                                                                                                                                                                              "date": date,
                                                                                                                                                                                                                                                                                                                                              "time": time.toString()

                                                                                                                                                                                                                                                                                                                                            });
                                                                                                                                                                                                                                                                                                                                        Navigator.pop(context);
                                                                                                                                                                                                                                                                                                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                                                                                                                                                                                                                                                                          content: Container(
                                                                                                                                                                                                                                                                                                                                            height: 20.h,
                                                                                                                                                                                                                                                                                                                                            child: Column(
                                                                                                                                                                                                                                                                                                                                              children: [
                                                                                                                                                                                                                                                                                                                                                Column(
                                                                                                                                                                                                                                                                                                                                                  children: [
                                                                                                                                                                                                                                                                                                                                                    Text('Volunteered Successfully', textAlign:TextAlign.center, style:GoogleFonts.montserrat(fontSize: 11.sp) ),
                                                                                                                                                                                                                                                                                                                                                  ],
                                                                                                                                                                                                                                                                                                                                                ),
                                                                                                                                                                                                                                                                                                                                              ],
                                                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                                                                                                          backgroundColor: Colors.teal,
                                                                                                                                                                                                                                                                                                                                          behavior: SnackBarBehavior.fixed,
                                                                                                                                                                                                                                                                                                                                          duration: Duration(seconds: 10),));



                                                                                                                                                                                                                                                                                                                                      }
                                                                                                                                                                                                                                                                                                                                      else{
                                                                                                                                                                                                                                                                                                                                        ScaffoldMessenger
                                                                                                                                                                                                                                                                                                                                            .of(
                                                                                                                                                                                                                                                                                                                                            context)
                                                                                                                                                                                                                                                                                                                                            .showSnackBar(
                                                                                                                                                                                                                                                                                                                                            SnackBar(
                                                                                                                                                                                                                                                                                                                                              content: Text(
                                                                                                                                                                                                                                                                                                                                                  'You are offline, Kindly turn on Wifi or Mobile Data to continue',
                                                                                                                                                                                                                                                                                                                                                  textAlign: TextAlign
                                                                                                                                                                                                                                                                                                                                                      .center,
                                                                                                                                                                                                                                                                                                                                                  style: GoogleFonts
                                                                                                                                                                                                                                                                                                                                                      .montserrat(
                                                                                                                                                                                                                                                                                                                                                      fontSize: 10
                                                                                                                                                                                                                                                                                                                                                          .sp)),
                                                                                                                                                                                                                                                                                                                                              backgroundColor: Color(
                                                                                                                                                                                                                                                                                                                                                  0xFFE02020),
                                                                                                                                                                                                                                                                                                                                              behavior: SnackBarBehavior
                                                                                                                                                                                                                                                                                                                                                  .fixed,
                                                                                                                                                                                                                                                                                                                                              duration: const Duration(
                                                                                                                                                                                                                                                                                                                                                  seconds: 10),
                                                                                                                                                                                                                                                                                                                                              // duration: Duration(seconds: 3),
                                                                                                                                                                                                                                                                                                                                            ));
                                                                                                                                                                                                                                                                                                                                      }
                                                                                                                                                                                                                                                                                                                                    }),
                                                                                                                                                                                                                                                                                                                                SizedBox(
                                                                                                                                                                                                                                                                                                                                  width: 5.h,
                                                                                                                                                                                                                                                                                                                                ),
                                                                                                                                                                                                                                                                                                                                TextButton(
                                                                                                                                                                                                                                                                                                                                    child: Text('Close', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                                                                                                                                                                                                    style: TextButton.styleFrom(
                                                                                                                                                                                                                                                                                                                                      primary: Colors.white,
                                                                                                                                                                                                                                                                                                                                      backgroundColor: Color(0xffd12624),
                                                                                                                                                                                                                                                                                                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                                                    onPressed: () {
                                                                                                                                                                                                                                                                                                                                      Navigator.pop(context);
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
                                                                                                                                                                                                                                                                                                            }),
                                                                                                                                                                                                                                                                                                        SizedBox(
                                                                                                                                                                                                                                                                                                          width: 5.h,
                                                                                                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                                                                                                        TextButton(
                                                                                                                                                                                                                                                                                                            child: Text('Reject', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                                                                                                                                                                            style: TextButton.styleFrom(
                                                                                                                                                                                                                                                                                                              primary: Colors.white,
                                                                                                                                                                                                                                                                                                              backgroundColor: Color(0xff406986),
                                                                                                                                                                                                                                                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                            onPressed: () {
                                                                                                                                                                                                                                                                                                              Navigator.pop(context);
                                                                                                                                                                                                                                                                                                              showModalBottomSheet(
                                                                                                                                                                                                                                                                                                                backgroundColor: Color(0xFFebf5f5),
                                                                                                                                                                                                                                                                                                                context: context,
                                                                                                                                                                                                                                                                                                                builder: (context) {
                                                                                                                                                                                                                                                                                                                  return SingleChildScrollView(
                                                                                                                                                                                                                                                                                                                    child: Container(
                                                                                                                                                                                                                                                                                                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                                                                                                                                                                                                                                      child: Padding(
                                                                                                                                                                                                                                                                                                                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                                                                                                                                                                                                                                                        child: Column(
                                                                                                                                                                                                                                                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                                                                                                                                          children: [
                                                                                                                                                                                                                                                                                                                            Text('Blood Consent Form', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                                                                                                                              height: 10.h,
                                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                                            Text.rich(
                                                                                                                                                                                                                                                                                                                              TextSpan(
                                                                                                                                                                                                                                                                                                                                style: TextStyle(
                                                                                                                                                                                                                                                                                                                                  fontFamily: 'Montserrat',
                                                                                                                                                                                                                                                                                                                                  fontSize: 15.sp,
                                                                                                                                                                                                                                                                                                                                  color: Color(0xff406986),
                                                                                                                                                                                                                                                                                                                                  height: 1.3846153846153846,
                                                                                                                                                                                                                                                                                                                                ),
                                                                                                                                                                                                                                                                                                                                children: [
                                                                                                                                                                                                                                                                                                                                  TextSpan(
                                                                                                                                                                                                                                                                                                                                    text: 'Hi,',
                                                                                                                                                                                                                                                                                                                                    style: GoogleFonts.montserrat(
                                                                                                                                                                                                                                                                                                                                      fontSize: 14.sp,
                                                                                                                                                                                                                                                                                                                                      fontWeight: FontWeight.bold,
                                                                                                                                                                                                                                                                                                                                      color: Color(0xff406986),
                                                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                                                                                                                  TextSpan(
                                                                                                                                                                                                                                                                                                                                    text: ' $ufname $ulname',
                                                                                                                                                                                                                                                                                                                                    style: GoogleFonts.montserrat(
                                                                                                                                                                                                                                                                                                                                      fontSize: 14.sp,
                                                                                                                                                                                                                                                                                                                                      fontWeight: FontWeight.bold,
                                                                                                                                                                                                                                                                                                                                      color: Color(0xff389e9d),
                                                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                                                                                                                ],
                                                                                                                                                                                                                                                                                                                              ),
                                                                                                                                                                                                                                                                                                                              textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                                                                                                                                                                                                                                                              textAlign: TextAlign.center,
                                                                                                                                                                                                                                                                                                                              softWrap: true,
                                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                                                                                                                              height: 10.h,
                                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                                            Image.asset(
                                                                                                                                                                                                                                                                                                                              "assets/icons/error.png",
                                                                                                                                                                                                                                                                                                                              height: 40.h,
                                                                                                                                                                                                                                                                                                                              width: 40.w,
                                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                                                                                                                              height: 10.h,
                                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                                            Text('Sorry, you are \ncannot to donate.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                                                                                                                              height: 10.h,
                                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                                            Text('Thanks for your interest.\nYou should accept the Blood Consent Form.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                                                                                                                                                                                                                                                                                                            SizedBox(
                                                                                                                                                                                                                                                                                                                              height: 10.h,
                                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                                            Row(
                                                                                                                                                                                                                                                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                                                                                                                                              children: [
                                                                                                                                                                                                                                                                                                                                TextButton(
                                                                                                                                                                                                                                                                                                                                    child: Text('Close', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                                                                                                                                                                                                    style: TextButton.styleFrom(
                                                                                                                                                                                                                                                                                                                                      primary: Colors.white,
                                                                                                                                                                                                                                                                                                                                      backgroundColor: Color(0xffd12624),
                                                                                                                                                                                                                                                                                                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                                                    onPressed: () {
                                                                                                                                                                                                                                                                                                                                      Navigator.pop(context);
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
                                                                                                                                                                                                                                                                                                            }),
                                                                                                                                                                                                                                                                                                        SizedBox(
                                                                                                                                                                                                                                                                                                          width: 5.h,
                                                                                                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                                                                                                        TextButton(
                                                                                                                                                                                                                                                                                                            child: Text('Close', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                                                                                                                                                                            style: TextButton.styleFrom(
                                                                                                                                                                                                                                                                                                              primary: Colors.white,
                                                                                                                                                                                                                                                                                                              backgroundColor: Color(0xffd12624),
                                                                                                                                                                                                                                                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                            onPressed: () {
                                                                                                                                                                                                                                                                                                              Navigator.pop(context);
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
                                                                                                                                    }),
                                                                                                                                SizedBox(
                                                                                                                                  width: 5.h,
                                                                                                                                ),
                                                                                                                                TextButton(
                                                                                                                                    child: Text('No', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 13.sp, color: Colors.white)),
                                                                                                                                    style: TextButton.styleFrom(
                                                                                                                                      primary: Colors.white,
                                                                                                                                      backgroundColor: Color(0xffd12624),
                                                                                                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                    ),
                                                                                                                                    onPressed: () {
                                                                                                                                      Navigator.pop(context);
                                                                                                                                      showModalBottomSheet(
                                                                                                                                        backgroundColor: Color(0xFFebf5f5),
                                                                                                                                        context: context,
                                                                                                                                        builder: (context) {
                                                                                                                                          return SingleChildScrollView(
                                                                                                                                            child: Container(
                                                                                                                                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                                                              child: Padding(
                                                                                                                                                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                                                                                child: Column(
                                                                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                  children: [
                                                                                                                                                    Text('Blood and Plasma Eligibility Quiz', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                    SizedBox(
                                                                                                                                                      height: 10.h,
                                                                                                                                                    ),
                                                                                                                                                    Text.rich(
                                                                                                                                                      TextSpan(
                                                                                                                                                        style: TextStyle(
                                                                                                                                                          fontFamily: 'Montserrat',
                                                                                                                                                          fontSize: 15.sp,
                                                                                                                                                          color: Color(0xff406986),
                                                                                                                                                          height: 1.3846153846153846,
                                                                                                                                                        ),
                                                                                                                                                        children: [
                                                                                                                                                          TextSpan(
                                                                                                                                                            text: 'Hi,',
                                                                                                                                                            style: GoogleFonts.montserrat(
                                                                                                                                                              fontSize: 14.sp,
                                                                                                                                                              fontWeight: FontWeight.bold,
                                                                                                                                                              color: Color(0xff406986),
                                                                                                                                                            ),
                                                                                                                                                          ),
                                                                                                                                                          TextSpan(
                                                                                                                                                            text: ' $ufname $ulname',
                                                                                                                                                            style: GoogleFonts.montserrat(
                                                                                                                                                              fontSize: 14.sp,
                                                                                                                                                              fontWeight: FontWeight.bold,
                                                                                                                                                              color: Color(0xff389e9d),
                                                                                                                                                            ),
                                                                                                                                                          ),
                                                                                                                                                        ],
                                                                                                                                                      ),
                                                                                                                                                      textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                                                                                                                                      textAlign: TextAlign.center,
                                                                                                                                                      softWrap: true,
                                                                                                                                                    ),
                                                                                                                                                    SizedBox(
                                                                                                                                                      height: 10.h,
                                                                                                                                                    ),
                                                                                                                                                    Image.asset(
                                                                                                                                                      "assets/icons/error.png",
                                                                                                                                                      height: 40.h,
                                                                                                                                                      width: 40.w,
                                                                                                                                                    ),
                                                                                                                                                    SizedBox(
                                                                                                                                                      height: 10.h,
                                                                                                                                                    ),
                                                                                                                                                    Text('Sorry, you are \nineligible to donate.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                    SizedBox(
                                                                                                                                                      height: 10.h,
                                                                                                                                                    ),
                                                                                                                                                    Text('Thanks for your interest, but unfortunately you can\u0027t donate.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                                                                                                                                    SizedBox(
                                                                                                                                                      height: 10.h,
                                                                                                                                                    ),
                                                                                                                                                    SizedBox(
                                                                                                                                                      height: 5.h,
                                                                                                                                                    ),
                                                                                                                                                    Row(
                                                                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                      children: [
                                                                                                                                                        SizedBox(
                                                                                                                                                          width: 5.h,
                                                                                                                                                        ),
                                                                                                                                                        TextButton(
                                                                                                                                                            child: Text('Close', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                            style: TextButton.styleFrom(
                                                                                                                                                              primary: Colors.white,
                                                                                                                                                              backgroundColor: Color(0xffd12624),
                                                                                                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                            ),
                                                                                                                                                            onPressed: () {
                                                                                                                                                              Navigator.pop(context);
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
                                                                                                            }),
                                                                                                        SizedBox(
                                                                                                          width: 5,
                                                                                                        ),
                                                                                                        TextButton(
                                                                                                            child: Text('Close', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                            style: TextButton.styleFrom(
                                                                                                              primary: Colors.white,
                                                                                                              backgroundColor: Color(0xFFE02020),
                                                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                            ),
                                                                                                            onPressed: () {
                                                                                                              Navigator.pop(context);
                                                                                                            }),
                                                                                                      ],
                                                                                                    ),
                                                                                                    SizedBox(
                                                                                                      height: 20.h,
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width:
                                                                                    5.w,
                                                                                  ),
                                                                                ],
                                                                              ),],
                                                                          ),
                                                                        ],
                                                                      ), 
                                                                      
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  )
                                                ])
                                          ],
                                        ))
                                            .toList(),
                                      ),
                                    )
                                  ]);
                            }
                          }),
                    ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: double.infinity,
                  child: TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Make A Trigger', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 13.sp, color: Colors.white)),
                      SizedBox(
                        width:5.w
                      ),
                        Icon(Icons.send, size: 14,)
                      ],
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Color(0xff389e9d),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Color(0xFFebf5f5),
                          context: context,
                          builder: (context) {
                            return SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                    Text('Make A Trigger',
                                        style: GoogleFonts.montserrat(fontSize: 17.sp, fontWeight: FontWeight.bold, color: Color(0xff389e9d))),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Text('Make a Trigger and \ninform the blood community',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.normal, color: Color(0xff406986))),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('Where is the blood needed?',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.normal, color: Color(0xff389e9d))),
                                    ],
                                  ),
                                      Form(
                                      key: _formKey,
                                      autovalidateMode: AutovalidateMode.always,
                                      child: Column(
                                        children: [
                                          FormBuilderRadioGroup(
                                            decoration: InputDecoration(border: InputBorder.none, labelText: 'District', labelStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                            name: '$selectedDistrict',
                                            onChanged: (String? value) {
                                              setState(() {
                                                selectedDistrict = value;
                                              });
                                            },
                                            initialValue: selectedDistrict,
                                            // orientation: OptionsOrientation.vertical,
                                            validator: FormBuilderValidators.required(
                                              errorText:
                                              'Kindly Select a District',
                                            ),
                                            options: [
                                              'Bo',
                                              'Bombali',
                                              'Bonthe',
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
                                            ]
                                                .map((selectedDistrict) => FormBuilderFieldOption(value: selectedDistrict))
                                                .toList(growable: false),
                                          ),
                                          TextFormField(
                                            keyboardType: TextInputType.text,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Phone Number is required';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(

                                                labelText: 'Facility/Hospital',
                                                labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'),
                                            ),


                                            controller: facilityCtrl,
                                          ),
                                          TextFormField(
                                            keyboardType: TextInputType.text,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Phone Number is required';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(

                                              labelText: 'Facility/Hospital Address',
                                              labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'),
                                            ),


                                            controller: _addressCtrl,
                                          ),
                                          SizedBox(height: 10.h,),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text('What bloodtype is needed?',
                                                  textAlign: TextAlign.left,
                                                  style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.normal, color: Color(0xff389e9d))),
                                            ],
                                          ),
                                          FormBuilderRadioGroup(
                                            decoration: InputDecoration(border: InputBorder.none, labelText: 'BloodType', labelStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                            name: '$selectedBloodType',
                                            onChanged: (String? value) {
                                              setState(() {
                                                selectedBloodType = value;
                                              });
                                            },
                                            initialValue: selectedBloodType,
                                            // orientation: OptionsOrientation.vertical,
                                            validator: FormBuilderValidators.required(
                                              errorText:
                                              'Kindly Select a BloodType',
                                            ),
                                            options: [
                                              'A+',
                                              'A-',
                                              'AB+',
                                              'AB-',
                                              'B+',
                                              'B-',
                                              'O+',
                                              'O-'
                                            ]
                                                .map((selectedDistrict) => FormBuilderFieldOption(value: selectedDistrict))
                                                .toList(growable: false),
                                          ),
                                          TextFormField(
                                            keyboardType: TextInputType.number,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Phone Number is required';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(

                                              labelText: 'Litres of Blood Required',
                                              labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'),
                                            ),


                                            controller: bloodlitresCtrl,
                                          ),
                                          SizedBox(height: 10.h,),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text('When is the blood needed?',
                                                  textAlign: TextAlign.left,
                                                  style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.normal, color: Color(0xff389e9d))),
                                            ],
                                          ),
                                          TextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Date is required';
                                              }
                                              return null;
                                            },
                                            controller: dateinput, //editing controller of this TextField
                                            decoration: InputDecoration(
                                              // icon: Icon(Icons.calendar_today), //icon of text field
                                                labelText: "Date",
                                              labelStyle: TextStyle(fontFamily: 'Montserrat'), //label text of field
                                            ),
                                            readOnly: true,  //set it true, so that user will not able to edit text
                                            onTap: () async {
                                              DateTime? pickedDate = await showDatePicker(
                                                  context: context, initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
                                                  lastDate: DateTime(2101)
                                              );

                                              if(pickedDate != null ){
                                                print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                                String formattedDate = DateFormat('d MMM yyyy').format(pickedDate);
                                                print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                                //you can implement different kind of Date Format here according to your requirement

                                                setState(() {
                                                  dateinput.text = formattedDate; //set output date to TextField value.
                                                });
                                              }else{
                                                print("Date is not selected");
                                              }
                                            },
                                          ),
                                          TextField(
                                            controller: timeinput, //editing controller of this TextField
                                            decoration: InputDecoration(
                                                labelText: "Enter Time",
                                              labelStyle: TextStyle(fontFamily: 'Montserrat'), //label text of field//label text of field
                                            ),
                                            readOnly: true,  //set it true, so that user will not able to edit text
                                            onTap: () async {
                                              TimeOfDay? pickedTime =  await showTimePicker(
                                                initialTime: TimeOfDay.now(),
                                                context: context,
                                              );

                                              if(pickedTime != null ){
                                                print(pickedTime.format(context));   //output 10:51 PM
                                                DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                                                //converting to DateTime so that we can further format on different pattern.
                                                print(parsedTime); //output 1970-01-01 22:53:00.000
                                                String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                                                print(formattedTime); //output 14:59:00
                                                //DateFormat() is from intl package, you can format the time on any pattern you need.

                                                setState(() {
                                                  timeinput.text = formattedTime; //set the value of text field.
                                                });
                                              }else{
                                                print("Time is not selected");
                                              }
                                            },
                                          ),
                                          SizedBox(height: 20.h),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              TextButton(
                                                  child: Text('Send Trigger',
                                                      textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 13.sp, color: Colors.white)),
                                                  style: TextButton.styleFrom(
                                                    primary: Colors.white,
                                                    backgroundColor: Color(0xff389e9d),
                                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                  ),
                                                  onPressed: () async{
                                                    if(await getInternetUsingInternetConnectivity()){
                                                      Navigator.pop(context);
                                                      maketrigger();
                                                    }
                                                    else{
                                                      Navigator.pop(context);
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
                                                  }),
                                              SizedBox(width: 10.h),
                                              TextButton(
                                                  child: Text('Close',
                                                      textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 13.sp, color: Colors.white)),
                                                  style: TextButton.styleFrom(
                                                    primary: Colors.white,
                                                    backgroundColor: Color(0xffd12624),
                                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  }),
                                            ],
                                          ),
                                          SizedBox(height: 20.h),
                                        ],
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      );
  }

  Widget buildDonationSearch() => DonationCampaignSearchWidget(
    text: query,
    hintText: 'Search..',
    onChanged: searchcampaigns,
  );

  Future searchcampaigns(String query) async => debounce(() async {
    final campaign = await getTriggers(query);

    if (!mounted) return;

    setState(() {
      this.query = query;
      this.trigger = campaign;
    });
  });
}


class RegisteredDonordata {
  String firstname;
  String middlename;
  String lastname;
  String gender;
  String phonenumber;
  String donoremail;
  String district;
  String address;
  String bloodtype;

  RegisteredDonordata(
      {required this.firstname,
        required this.middlename,
        required this.lastname,
        required this.gender,
        required this.phonenumber,
        required this.donoremail,
        required this.district,
        required this.address,
        required this.bloodtype});

  factory RegisteredDonordata.fromJson(Map<String, dynamic> json) {
    return RegisteredDonordata(
        firstname: json['firstname'],
        middlename: json['middlename'],
        lastname: json['lastname'],
        gender: json['gender'],
        phonenumber: json['phonenumber'].toString(),
        donoremail: json['donoremail'],
        district: json['district'],
        address: json['address'],
        bloodtype: json['bloodtype']);
  }

  Map<String, dynamic> toJson() => {
    'firstname': firstname,
    'middlename': middlename,
    'lastname': lastname,
    'gender': gender,
    'phonenumber': phonenumber,
    'donoremail': donoremail,
    'district': district,
    'address': address,
    'bloodtype': bloodtype,

  };
}


class registeredDonors extends StatefulWidget {
  String? triggerid;

  registeredDonors({Key? key, required this.triggerid}) : super(key: key);

  @override
  State<registeredDonors> createState() => _registeredDonorsState(triggerid:triggerid);
}

class _registeredDonorsState extends State<registeredDonors> {

  String? triggerid;
  _registeredDonorsState({Key? key, required this.triggerid});

  String donorregquery = '';

  List<RegisteredDonordata> donorregistration = [];

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

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  @override
  void initState() {
    super.initState();
    getPref();
    getBloodDonor(donorregquery);
  }

  Future<List<RegisteredDonordata>> getBloodDonor(String donorregquery) async {
    var data = {'email': email,
      'triggerid' : triggerid};

    var response = await http.post(
        Uri.parse("http://lifebloodsl.com/communityapi/findvolunteerdonors.php"),
        body: json.encode(data));

    if (response.statusCode == 200) {
      final List communitydonor = json.decode(response.body);

      return communitydonor
          .map((json) => RegisteredDonordata.fromJson(json))
          .where((communitydonor) {
        final donornameLower = communitydonor.firstname.toLowerCase();
        final districtLower = communitydonor.district.toLowerCase();
        final searchLower = donorregquery.toLowerCase();

        return donornameLower.contains(searchLower) ||
            districtLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }


  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      ufname = prefs.getString('ufname');
      umname = prefs.getString('umname');
      ulname = prefs.getString('ulname');
    });
  }

  Timer? debouncer;


  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }



  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Color(0xFFe0e9e4),
        appBar: AppBar(
            title: Text('Blood Community Volunteers',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14.sp),),
            automaticallyImplyLeading: true,
            elevation: 0,
            backgroundColor: Color(0xFFE02020),
            leading: IconButton(icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )
        ),
        body: Column(
            children: <Widget>[
              buildDonationSearch(),
              Expanded(
                child: FutureBuilder<List<RegisteredDonordata>>(
                    future: getBloodDonor(donorregquery),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                              color: Colors.teal,
                            ));
                      } else if (!snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/icons/sad.png",
                                  height: 60.h,
                                  width: 60.w,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "No volunteer found..",
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 15.sp,
                                      color: Color(0xFFE02020)),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text.rich(
                                  TextSpan(
                                    style: TextStyle(
                                      color: Color(0xFF205072),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Hi, ',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF205072),
                                        ),
                                      ),
                                      TextSpan(
                                        text: '$ufname $umname $ulname',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF205072),
                                        ),
                                      ),
                                    ],
                                  ),
                                  textHeightBehavior: TextHeightBehavior(
                                      applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  'You can find help by finding donors\nWe have a donor community that \nhave joined forces to make blood readily available.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 13.sp,
                                      color: Color(0xFF205072)),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      child: Text('Find Donors',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12.sp, color: Colors.white)),
                                      style: TextButton.styleFrom(
                                        primary: Colors.white,
                                        backgroundColor: Color(0xff389e9d),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      onPressed: () {
                                        // Navigator.push(
                                        //   context,
                                        //   new MaterialPageRoute(
                                        //     builder: (context) => findblooddonors(),
                                        //   ),
                                        // );
                                      },
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        );
                      } else {
                        String space = ' ';
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text.rich(
                                  //   TextSpan(
                                  //     style: TextStyle(
                                  //       color: Color(
                                  //           0xFF205072),
                                  //       fontSize: 15.sp,
                                  //       fontWeight: FontWeight
                                  //           .bold,
                                  //     ),
                                  //     children: [
                                  //       TextSpan(
                                  //         text: 'Total Donations : ',
                                  //         style: GoogleFonts
                                  //             .montserrat(
                                  //             fontSize: 14.sp,
                                  //             fontWeight: FontWeight
                                  //                 .normal,
                                  //             color: Colors.teal),
                                  //       ),
                                  //       TextSpan(
                                  //         text: snapshot.data?.length.toString(),
                                  //         style: GoogleFonts
                                  //             .montserrat(
                                  //           fontSize: 14.sp,
                                  //           fontWeight: FontWeight
                                  //               .bold,
                                  //           color: Colors.teal,),
                                  //       ),
                                  //     ],
                                  //   ),
                                  //   textHeightBehavior: TextHeightBehavior(
                                  //       applyHeightToFirstAscent: false),
                                  //   textAlign: TextAlign.left,
                                  // ),
                                ],
                              ),
                              Expanded(
                                child: ListView(
                                  children: snapshot.data!
                                      .map((data) => Column(
                                    children: <Widget>[
                                      Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child:
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
                                                            .fromLTRB(.0, 5.0,
                                                            5.0, 5.0),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                              10.w),
                                                          child: Container(
                                                            padding:
                                                            EdgeInsets
                                                                .all(
                                                                10.r),
                                                            width: double
                                                                .infinity,
                                                            decoration:
                                                            BoxDecoration(
                                                              color: Color(
                                                                  0xFFebf5f5),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  16),
                                                            ),
                                                            child: Column(

                                                              children: [
                                                                Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment.center,
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment.spaceEvenly,
                                                                      children: [

                                                                        Column(
                                                                          children: [
                                                                            (data.gender == "Male")?
                                                                            Image.asset(
                                                                              'assets/icons/man.png',
                                                                              height:
                                                                              40.h,
                                                                              width: 40.w,
                                                                            ): Image.asset(
                                                                              'assets/icons/woman.png',
                                                                              height:
                                                                              40.h,
                                                                              width: 40.w,
                                                                            ),
                                                                          ],
                                                                        ) ,
                                                                        SizedBox(
                                                                          child: Container(
                                                                            color: Color(0xFFe0e9e4),
                                                                            height: 50.h,
                                                                            width: 1.2.w,
                                                                          ),
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                          CrossAxisAlignment.start,
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment.start,
                                                                          children: [
                                                                            Text('Donor Information',
                                                                                textAlign: TextAlign.center,
                                                                                style: GoogleFonts.montserrat(
                                                                                    fontSize: 10.sp, color: Color(0xff389e9d))),
                                                                            SizedBox(
                                                                              height: 5.h,
                                                                            ),
                                                                            Text(data.firstname + space + data.middlename + space + data.lastname,
                                                                                textAlign: TextAlign.center,
                                                                                style: GoogleFonts.montserrat(
                                                                                    fontSize: 13.sp, fontWeight: FontWeight.bold, color: Color(0xFF205072))),
                                                                            SizedBox(
                                                                              height: 5.h,
                                                                            ),
                                                                            Text(data.district,
                                                                                textAlign: TextAlign.center,
                                                                                style: GoogleFonts.montserrat(
                                                                                    fontSize: 13.sp, fontWeight: FontWeight.bold, color: Color(0xFF205072))),
                                                                            SizedBox(
                                                                              height: 5.h,
                                                                            ),
                                                                            Text(data.bloodtype,
                                                                                textAlign: TextAlign.center,
                                                                                style: GoogleFonts.montserrat(
                                                                                    fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xFFE02020))),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),


                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                    height: 10.h
                                                                ),

                                                                Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment.center,
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.center,
                                                                  children: [
                                                                    Row(
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        TextButton(
                                                                          child: Row(
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              SizedBox(
                                                                                width: 5.w,
                                                                              ),
                                                                              Icon(Icons.call),
                                                                              SizedBox(
                                                                                width: 5.w,
                                                                              ),
                                                                              Text('Call',
                                                                                  textAlign: TextAlign.center,
                                                                                  style: GoogleFonts.montserrat(
                                                                                      fontSize: 12.sp, color: Colors.white)),
                                                                              SizedBox(
                                                                                width: 5.w,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          style: TextButton.styleFrom(
                                                                            primary: Colors.white,
                                                                            backgroundColor: Color(0xff389e9d),
                                                                            shape: const RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.all(
                                                                                    Radius.circular(10))),
                                                                          ),
                                                                          onPressed: () {
                                                                            launchUrl(Uri(
                                                                              scheme: 'tel',
                                                                              path: data.phonenumber,
                                                                            ));
                                                                          },
                                                                        ),
                                                                        SizedBox(
                                                                          width: 5.w,
                                                                        ),
                                                                        TextButton(
                                                                          child: Row(
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              SizedBox(
                                                                                width: 5.w,
                                                                              ),
                                                                              Icon(Icons.message),
                                                                              SizedBox(
                                                                                width: 5.w,
                                                                              ),
                                                                              Text('Message',
                                                                                  textAlign: TextAlign.center,
                                                                                  style: GoogleFonts.montserrat(
                                                                                      fontSize: 12.sp, color: Colors.white)),
                                                                              SizedBox(
                                                                                width: 5.w,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          style: TextButton.styleFrom(
                                                                            primary: Colors.white,
                                                                            backgroundColor: Color(0xff389e9d),
                                                                            shape: const RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.all(
                                                                                    Radius.circular(10))),
                                                                          ),
                                                                          onPressed: () async{
                                                                            String firstname = data.firstname;
                                                                            String middlename = data.middlename;
                                                                            String lastname = data.lastname;

                                                                            launchUrl(Uri(
                                                                              scheme: 'sms',
                                                                              path: data.phonenumber,
                                                                              query: encodeQueryParameters(<String, String>{
                                                                                'body': 'Hi $firstname $middlename $lastname, LifeBlood here.',
                                                                              }),
                                                                            ));
                                                                          },
                                                                        ),
                                                                        SizedBox(
                                                                          width: 5.w,
                                                                        ),
                                                                        TextButton(
                                                                          child: Row(
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              SizedBox(
                                                                                width: 5.w,
                                                                              ),
                                                                              Icon(Icons.email),
                                                                              SizedBox(
                                                                                width: 5.w,
                                                                              ),
                                                                              Text('Email',
                                                                                  textAlign: TextAlign.center,
                                                                                  style: GoogleFonts.montserrat(
                                                                                      fontSize: 12.sp, color: Colors.white)),
                                                                              SizedBox(
                                                                                width: 5.w,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          style: TextButton.styleFrom(
                                                                            primary: Colors.white,
                                                                            backgroundColor: Color(0xff389e9d),
                                                                            shape: const RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.all(
                                                                                    Radius.circular(10))),
                                                                          ),
                                                                          onPressed: () async{
                                                                            String firstname = data.firstname;
                                                                            String middlename = data.middlename;
                                                                            String lastname = data.lastname;

                                                                            launchUrl(Uri(
                                                                              scheme: 'mailto',
                                                                              path: data.donoremail,
                                                                              query: encodeQueryParameters(<String, String>{
                                                                                'subject': 'Hi $firstname LifeBlood here.',
                                                                                'body': 'Hi $firstname $middlename $lastname, LifeBlood here.',
                                                                              }),
                                                                            ));
                                                                          },
                                                                        ),
                                                                      ],
                                                                    ),

                                                                    Row(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment.center,
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment.center,
                                                                      children: [
                                                                        TextButton(
                                                                          child: Row(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                            children: [
                                                                              Icon(Icons.add, color: Color(0xff389e9d), size: 11.h,),
                                                                              SizedBox(
                                                                                width: 3.w,
                                                                              ),
                                                                              Text('More Information',
                                                                                  style: GoogleFonts.montserrat(
                                                                                      fontSize: 11.sp, color: Color(0xff389e9d))),
                                                                            ],
                                                                          ),
                                                                          style: TextButton.styleFrom(
                                                                            primary: Colors.white,
                                                                            backgroundColor: Colors.transparent,
                                                                            shape: const RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.all(
                                                                                    Radius.circular(0))),
                                                                          ),
                                                                          onPressed: () {
                                                                            showModalBottomSheet(
                                                                              backgroundColor: Color(0xFFebf5f5),
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return SingleChildScrollView(
                                                                                  child: Container(
                                                                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                      child: Column(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          Text('More Information', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                          SizedBox(
                                                                                            height: 10.h,
                                                                                          ),

                                                                                          Form(
                                                                                            // key: _formKey,
                                                                                            autovalidateMode: AutovalidateMode.always,
                                                                                            child: Column(
                                                                                              children: [
                                                                                                TextFormField(
                                                                                                  keyboardType: TextInputType.number,
                                                                                                  initialValue: data.phonenumber,
                                                                                                  style: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat'),
                                                                                                  enabled: false,
                                                                                                  readOnly: true,
                                                                                                  validator: (value) {
                                                                                                    if (value!.isEmpty) {
                                                                                                      return 'Phone Number is required';
                                                                                                    }
                                                                                                    return null;
                                                                                                  },
                                                                                                  decoration: InputDecoration(labelText: 'Phone Number', hintText: 'Enter New Phone Number', labelStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                                ),
                                                                                                TextFormField(
                                                                                                  keyboardType: TextInputType.text,
                                                                                                  initialValue: data.donoremail,
                                                                                                  style: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat'),
                                                                                                  enabled: false,
                                                                                                  readOnly: true,
                                                                                                  decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                                ),
                                                                                                (data.address != null)
                                                                                                    ? TextFormField(
                                                                                                  keyboardType: TextInputType.text,
                                                                                                  enabled: false,
                                                                                                  readOnly: true,
                                                                                                  initialValue: data.address,
                                                                                                  style: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat'),
                                                                                                  validator: (value) {
                                                                                                    if (value!.isEmpty) {
                                                                                                      return 'Address is required';
                                                                                                    }
                                                                                                    return null;
                                                                                                  },
                                                                                                  decoration: InputDecoration(labelText: 'Address', hintText: 'Enter New Address', labelStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                                ) : SizedBox(
                                                                                                  height: 0.h,
                                                                                                ),
                                                                                                SizedBox(height: 10.h),
                                                                                                Container(
                                                                                                  child: Column(
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        'District',
                                                                                                        style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp, color: Colors.grey),
                                                                                                      ),
                                                                                                      SizedBox(
                                                                                                        height: 10.h,
                                                                                                      ),
                                                                                                      Column(
                                                                                                        children: [
                                                                                                          Row(children: <Widget>[
                                                                                                            Expanded(
                                                                                                              child: AnimatedContainer(
                                                                                                                duration: Duration(milliseconds: 200),
                                                                                                                curve: Curves.easeInOut,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color:  Colors.teal,
                                                                                                                  border: Border.all(
                                                                                                                    width: 0,
                                                                                                                  ),
                                                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                                                ),
                                                                                                                child: RadioListTile(
                                                                                                                  selected: false,
                                                                                                                  toggleable: false,
                                                                                                                  value: data.district,
                                                                                                                  activeColor: Colors.white,
                                                                                                                  groupValue: data.district,
                                                                                                                  title: Text(
                                                                                                                    data.district,
                                                                                                                    style: TextStyle(
                                                                                                                        color: Colors.white, fontFamily: 'Montserrat'
                                                                                                                      // fontSize: width * 0.035,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  onChanged: (String? v) {},
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ]),
                                                                                                          SizedBox(
                                                                                                            height: 10.h,
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(height: 10.h),
                                                                                              ],
                                                                                            ),
                                                                                          ),


                                                                                          SizedBox(
                                                                                            height: 10.h,
                                                                                          ),
                                                                                          Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              TextButton(
                                                                                                  child: Text('Close', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                  style: TextButton.styleFrom(
                                                                                                    primary: Colors.white,
                                                                                                    backgroundColor: Color(0xffd12624),
                                                                                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                  ),
                                                                                                  onPressed: () {
                                                                                                    Navigator.pop(context);
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
                                                                          },
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            )
                                          ])
                                    ],
                                  ))
                                      .toList(),
                                ),
                              )
                            ]);
                      }
                    }),
              ),
            ]),
      );
  }

  Widget buildDonationSearch() => DonationCampaignSearchWidget(
    text: donorregquery,
    hintText: 'Targeted District, Name',
    onChanged: searchcampaigns,
  );

  Future searchcampaigns(String donorregquery) async => debounce(() async {
    final donorregistration = await getBloodDonor(donorregquery);


    if (!mounted) return;

    setState(() {
      this.donorregquery = donorregquery;
      this.donorregistration = donorregistration;
    });
  });
}

class Fundingdata {
  String firstname;
  String middlename;
  String lastname;
  String gender;
  String phonenumber;
  String donoremail;
  String district;
  String address;
  String amount;
  String paymenttype;
  String status;

  Fundingdata(
      {required this.firstname,
        required this.middlename,
        required this.lastname,
        required this.gender,
        required this.phonenumber,
        required this.donoremail,
        required this.district,
        required this.address,
        required this.amount,
        required this.paymenttype,
        required this.status});

  factory Fundingdata.fromJson(Map<String, dynamic> json) {
    return Fundingdata(
        firstname: json['firstname'],
        middlename: json['middlename'],
        lastname: json['lastname'],
        gender: json['gender'],
        phonenumber: json['phonenumber'].toString(),
        donoremail: json['donoremail'],
        district: json['district'],
        address: json['address'],
        amount: json['amount'].toString(),
        paymenttype: json['paymenttype'],
        status: json['status']
    );
  }

  Map<String, dynamic> toJson() => {
    'firstname': firstname,
    'middlename': middlename,
    'lastname': lastname,
    'gender': gender,
    'phonenumber': phonenumber,
    'donoremail': donoremail,
    'district': district,
    'address': address,
    'amount': amount,
    'paymenttype': paymenttype,
    'status': status

  };
}


class funding extends StatefulWidget {
  String? campaignname;

  funding({Key? key, required this.campaignname}) : super(key: key);

  @override
  State<funding> createState() => _fundingState(campaignname:campaignname);
}

class _fundingState extends State<funding> {

  String? campaignname;
  _fundingState({Key? key, required this.campaignname});

  String fundingquery = '';

  List<Fundingdata> funding = [];

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

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  @override
  void initState() {
    super.initState();
    getPref();
    getFunding(fundingquery);
  }

  Future<List<Fundingdata>> getFunding(String fundingquery) async {
    var data = {'email': email,
      'campaignname' : campaignname};

    var response = await http.post(
        Uri.parse("http://lifebloodsl.com/communityapi/findcampaignfunding.php"),
        body: json.encode(data));

    if (response.statusCode == 200) {
      final List sponsor = json.decode(response.body);

      return sponsor
          .map((json) => Fundingdata.fromJson(json))
          .where((sponsor) {
        final donornameLower = sponsor.firstname.toLowerCase();
        final districtLower = sponsor.district.toLowerCase();
        final searchLower = fundingquery.toLowerCase();

        return donornameLower.contains(searchLower) ||
            districtLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }


  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      ufname = prefs.getString('ufname');
      umname = prefs.getString('umname');
      ulname = prefs.getString('ulname');
    });
  }

  Timer? debouncer;


  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }



  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Color(0xFFe0e9e4),
        appBar: AppBar(
            title: Text('Funding',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),),
            automaticallyImplyLeading: true,
            elevation: 0,
            backgroundColor: Colors.teal,
            leading: IconButton(icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )
        ),
        body: Column(
            children: <Widget>[
              buildDonationSearch(),
              Expanded(
                child: FutureBuilder<List<Fundingdata>>(
                    future: getFunding(fundingquery),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                              color: Colors.teal,
                            ));
                      } else if (!snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/icons/sad.png",
                                  height: 60.h,
                                  width: 60.w,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  "No sponsor found..",
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 15.sp,
                                      color: Color(0xFFE02020)),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text.rich(
                                  TextSpan(
                                    style: TextStyle(
                                      color: Color(0xFF205072),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Hi, ',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF205072),
                                        ),
                                      ),
                                      TextSpan(
                                        text: '$ufname $umname $ulname',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF205072),
                                        ),
                                      ),
                                    ],
                                  ),
                                  textHeightBehavior: TextHeightBehavior(
                                      applyHeightToFirstAscent: false),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  'Your donation changes lives.\nBeing part of a donor community and \njoining forces to make blood readily available.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 13.sp,
                                      color: Color(0xFF205072)),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      child: Text('Register Now',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12.sp, color: Colors.white)),
                                      style: TextButton.styleFrom(
                                        primary: Colors.white,
                                        backgroundColor: Color(0xff389e9d),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                            builder: (context) => HomePageScreen(pageIndex: 2),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        );
                      } else {
                        String space = ' ';
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                ],
                              ),
                              Expanded(
                                child: ListView(
                                  children: snapshot.data!
                                      .map((data) => Column(
                                    children: <Widget>[
                                      Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child:
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
                                                            .fromLTRB(.0, 5.0,
                                                            5.0, 5.0),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                              10.w),
                                                          child: Container(
                                                            padding:
                                                            EdgeInsets
                                                                .all(
                                                                10.r),
                                                            width: double
                                                                .infinity,
                                                            decoration:
                                                            BoxDecoration(
                                                              color: Color(
                                                                  0xFFebf5f5),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  16),
                                                            ),
                                                            child: Column(

                                                              children: [
                                                                Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                                  children: [
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment.center,
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment.spaceEvenly,
                                                                      children: [

                                                                        Column(
                                                                          children: [
                                                                            (data.gender == "Male")?
                                                                            Image.asset(
                                                                              'assets/icons/man.png',
                                                                              height:
                                                                              40.h,
                                                                              width: 40.w,
                                                                            ): Image.asset(
                                                                              'assets/icons/woman.png',
                                                                              height:
                                                                              40.h,
                                                                              width: 40.w,
                                                                            ),
                                                                          ],
                                                                        ) ,
                                                                        SizedBox(
                                                                          child: Container(
                                                                            color: Color(0xFFe0e9e4),
                                                                            height: 50.h,
                                                                            width: 1.2.w,
                                                                          ),
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                          CrossAxisAlignment.start,
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment.start,
                                                                          children: [
                                                                            Text('Sponsor Information',
                                                                                textAlign: TextAlign.center,
                                                                                style: GoogleFonts.montserrat(
                                                                                    fontSize: 10.sp, color: Color(0xff389e9d))),
                                                                            SizedBox(
                                                                              height: 5.h,
                                                                            ),
                                                                            Text(data.firstname + space + data.middlename + space + data.lastname,
                                                                                textAlign: TextAlign.center,
                                                                                style: GoogleFonts.montserrat(
                                                                                    fontSize: 13.sp, fontWeight: FontWeight.bold, color: Color(0xFF205072))),
                                                                            SizedBox(
                                                                              height: 5.h,
                                                                            ),
                                                                            Text(data.district,
                                                                                textAlign: TextAlign.center,
                                                                                style: GoogleFonts.montserrat(
                                                                                    fontSize: 13.sp, fontWeight: FontWeight.bold, color: Color(0xFF205072))),
                                                                            SizedBox(
                                                                              height: 5.h,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),


                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                    height: 10.h
                                                                ),

                                                                Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment.center,
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.center,
                                                                  children: [
                                                                    Row(
                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        TextButton(
                                                                          child: Row(
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              SizedBox(
                                                                                width: 5.w,
                                                                              ),
                                                                              Icon(Icons.call),
                                                                              SizedBox(
                                                                                width: 5.w,
                                                                              ),
                                                                              Text('Call',
                                                                                  textAlign: TextAlign.center,
                                                                                  style: GoogleFonts.montserrat(
                                                                                      fontSize: 12.sp, color: Colors.white)),
                                                                              SizedBox(
                                                                                width: 5.w,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          style: TextButton.styleFrom(
                                                                            primary: Colors.white,
                                                                            backgroundColor: Color(0xff389e9d),
                                                                            shape: const RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.all(
                                                                                    Radius.circular(10))),
                                                                          ),
                                                                          onPressed: () {
                                                                            launchUrl(Uri(
                                                                              scheme: 'tel',
                                                                              path: data.phonenumber,
                                                                            ));
                                                                          },
                                                                        ),
                                                                        SizedBox(
                                                                          width: 5.w,
                                                                        ),
                                                                        TextButton(
                                                                          child: Row(
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              SizedBox(
                                                                                width: 5.w,
                                                                              ),
                                                                              Icon(Icons.message),
                                                                              SizedBox(
                                                                                width: 5.w,
                                                                              ),
                                                                              Text('Message',
                                                                                  textAlign: TextAlign.center,
                                                                                  style: GoogleFonts.montserrat(
                                                                                      fontSize: 12.sp, color: Colors.white)),
                                                                              SizedBox(
                                                                                width: 5.w,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          style: TextButton.styleFrom(
                                                                            primary: Colors.white,
                                                                            backgroundColor: Color(0xff389e9d),
                                                                            shape: const RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.all(
                                                                                    Radius.circular(10))),
                                                                          ),
                                                                          onPressed: () async{
                                                                            String firstname = data.firstname;
                                                                            String middlename = data.middlename;
                                                                            String lastname = data.lastname;

                                                                            launchUrl(Uri(
                                                                              scheme: 'sms',
                                                                              path: data.phonenumber,
                                                                              query: encodeQueryParameters(<String, String>{
                                                                                'body': 'Hi $firstname $middlename $lastname, LifeBlood here.',
                                                                              }),
                                                                            ));
                                                                          },
                                                                        ),
                                                                        SizedBox(
                                                                          width: 5.w,
                                                                        ),
                                                                        TextButton(
                                                                          child: Row(
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              SizedBox(
                                                                                width: 5.w,
                                                                              ),
                                                                              Icon(Icons.email),
                                                                              SizedBox(
                                                                                width: 5.w,
                                                                              ),
                                                                              Text('Email',
                                                                                  textAlign: TextAlign.center,
                                                                                  style: GoogleFonts.montserrat(
                                                                                      fontSize: 12.sp, color: Colors.white)),
                                                                              SizedBox(
                                                                                width: 5.w,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          style: TextButton.styleFrom(
                                                                            primary: Colors.white,
                                                                            backgroundColor: Color(0xff389e9d),
                                                                            shape: const RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.all(
                                                                                    Radius.circular(10))),
                                                                          ),
                                                                          onPressed: () async{
                                                                            String firstname = data.firstname;
                                                                            String middlename = data.middlename;
                                                                            String lastname = data.lastname;

                                                                            launchUrl(Uri(
                                                                              scheme: 'mailto',
                                                                              path: data.donoremail,
                                                                              query: encodeQueryParameters(<String, String>{
                                                                                'subject': 'Hi $firstname LifeBlood here.',
                                                                                'body': 'Hi $firstname $middlename $lastname, LifeBlood here.',
                                                                              }),
                                                                            ));
                                                                          },
                                                                        ),
                                                                      ],
                                                                    ),

                                                                    Row(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment.center,
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment.center,
                                                                      children: [
                                                                        TextButton(
                                                                          child: Row(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                            children: [
                                                                              Icon(Icons.add, color: Color(0xff389e9d), size: 11.h,),
                                                                              SizedBox(
                                                                                width: 3.w,
                                                                              ),
                                                                              Text('More Information',
                                                                                  style: GoogleFonts.montserrat(
                                                                                      fontSize: 11.sp, color: Color(0xff389e9d))),
                                                                            ],
                                                                          ),
                                                                          style: TextButton.styleFrom(
                                                                            primary: Colors.white,
                                                                            backgroundColor: Colors.transparent,
                                                                            shape: const RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.all(
                                                                                    Radius.circular(0))),
                                                                          ),
                                                                          onPressed: () {
                                                                            showModalBottomSheet(
                                                                              backgroundColor: Color(0xFFebf5f5),
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return SingleChildScrollView(
                                                                                  child: Container(
                                                                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), // content padding
                                                                                      child: Column(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          Text('More Information', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                          SizedBox(
                                                                                            height: 10.h,
                                                                                          ),

                                                                                          Form(
                                                                                            // key: _formKey,
                                                                                            autovalidateMode: AutovalidateMode.always,
                                                                                            child: Column(
                                                                                              children: [
                                                                                                TextFormField(
                                                                                                  keyboardType: TextInputType.number,
                                                                                                  initialValue: data.phonenumber,
                                                                                                  style: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat'),
                                                                                                  enabled: false,
                                                                                                  readOnly: true,
                                                                                                  validator: (value) {
                                                                                                    if (value!.isEmpty) {
                                                                                                      return 'Phone Number is required';
                                                                                                    }
                                                                                                    return null;
                                                                                                  },
                                                                                                  decoration: InputDecoration(labelText: 'Phone Number', hintText: 'Enter New Phone Number', labelStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                                ),
                                                                                                TextFormField(
                                                                                                  keyboardType: TextInputType.text,
                                                                                                  initialValue: data.donoremail,
                                                                                                  style: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat'),
                                                                                                  enabled: false,
                                                                                                  readOnly: true,
                                                                                                  decoration: InputDecoration(labelText: 'Email', labelStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                                ),
                                                                                                (data.address != null)
                                                                                                    ? TextFormField(
                                                                                                  keyboardType: TextInputType.text,
                                                                                                  enabled: false,
                                                                                                  readOnly: true,
                                                                                                  initialValue: data.address,
                                                                                                  style: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat'),
                                                                                                  validator: (value) {
                                                                                                    if (value!.isEmpty) {
                                                                                                      return 'Address is required';
                                                                                                    }
                                                                                                    return null;
                                                                                                  },
                                                                                                  decoration: InputDecoration(labelText: 'Address', hintText: 'Enter New Address', labelStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                                ) : SizedBox(
                                                                                                  height: 0.h,
                                                                                                ),
                                                                                                SizedBox(height: 10.h),
                                                                                                Container(
                                                                                                  child: Column(
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        'District',
                                                                                                        style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp, color: Colors.grey),
                                                                                                      ),
                                                                                                      SizedBox(
                                                                                                        height: 10.h,
                                                                                                      ),
                                                                                                      Column(
                                                                                                        children: [
                                                                                                          Row(children: <Widget>[
                                                                                                            Expanded(
                                                                                                              child: AnimatedContainer(
                                                                                                                duration: Duration(milliseconds: 200),
                                                                                                                curve: Curves.easeInOut,
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color:  Colors.teal,
                                                                                                                  border: Border.all(
                                                                                                                    width: 0,
                                                                                                                  ),
                                                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                                                ),
                                                                                                                child: RadioListTile(
                                                                                                                  selected: false,
                                                                                                                  toggleable: false,
                                                                                                                  value: data.district,
                                                                                                                  activeColor: Colors.white,
                                                                                                                  groupValue: data.district,
                                                                                                                  title: Text(
                                                                                                                    data.district,
                                                                                                                    style: TextStyle(
                                                                                                                        color: Colors.white, fontFamily: 'Montserrat'
                                                                                                                      // fontSize: width * 0.035,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  onChanged: (String? v) {},
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ]),
                                                                                                          SizedBox(
                                                                                                            height: 10.h,
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(height: 10.h),
                                                                                              ],
                                                                                            ),
                                                                                          ),


                                                                                          SizedBox(
                                                                                            height: 10.h,
                                                                                          ),
                                                                                          Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              TextButton(
                                                                                                  child: Text('Close', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                  style: TextButton.styleFrom(
                                                                                                    primary: Colors.white,
                                                                                                    backgroundColor: Color(0xffd12624),
                                                                                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                  ),
                                                                                                  onPressed: () {
                                                                                                    Navigator.pop(context);
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
                                                                          },
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            )
                                          ])
                                    ],
                                  ))
                                      .toList(),
                                ),
                              )
                            ]);
                      }
                    }),
              ),
            ]),
      );
  }

  Widget buildDonationSearch() => DonationCampaignSearchWidget(
    text: fundingquery,
    hintText: 'Targeted District, Name',
    onChanged: searchcampaigns,
  );

  Future searchcampaigns(String fundingquery) async => debounce(() async {
    final funding = await getFunding(fundingquery);


    if (!mounted) return;

    setState(() {
      this.fundingquery = fundingquery;
      this.funding = funding;
    });
  });
}

