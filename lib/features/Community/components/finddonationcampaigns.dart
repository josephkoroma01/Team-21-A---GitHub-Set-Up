import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifebloodworld/features/Community/components/donationcampaigns.dart';
import 'package:lifebloodworld/features/Community/components/donationcampaignsearch.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DonationCampaigndata {
  String name;
  String campaignname;
  String campaigndescription;
  String phonenumber;
  String email;
  String campaignemail;
  String address;
  String targeteddistrict;
  String targetedarea;
  String bloodcomponent;
  String targetedbloodliters;
  String budgetrange;
  String daterange;
  String refcode;
  String status;
  String created_at;

  DonationCampaigndata(
      {required this.name,
      required this.campaignname,
      required this.campaigndescription,
      required this.phonenumber,
      required this.email,
      required this.campaignemail,
      required this.address,
      required this.targeteddistrict,
      required this.targetedarea,
      required this.bloodcomponent,
      required this.targetedbloodliters,
      required this.budgetrange,
      required this.daterange,
      required this.refcode,
      required this.status,
      required this.created_at});

  factory DonationCampaigndata.fromJson(Map<String, dynamic> json) {
    return DonationCampaigndata(
        name: json['name'],
        campaignname: json['campaignname'],
        campaigndescription: json['campaigndescription'],
        phonenumber: json['phonenumber'].toString(),
        email: json['email'],
        campaignemail: json['campaignemail'],
        address: json['address'],
        targeteddistrict: json['targeteddistrict'],
        targetedarea: json['targetedarea'],
        bloodcomponent: json['bloodcomponent'],
        targetedbloodliters: json['targetedbloodliters'].toString(),
        budgetrange: json['budgetrange'].toString(),
        daterange: json['daterange'].toString(),
        refcode: json['refcode'].toString(),
        status: json['status'],
        created_at: json['created_at']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'campaignname': campaignname,
        'campaigndescription': campaigndescription,
        'phonenumber': phonenumber,
        'email': email,
        'campaignemail': campaignemail,
        'address': address,
        'targeteddistrict': targeteddistrict,
        'targetedarea': targetedarea,
        'bloodcomponent': bloodcomponent,
        'targetedbloodliters': targetedbloodliters,
        'budgetrange': budgetrange,
        'daterange': daterange,
        'refcode': refcode,
        'status': status,
        'created_at': created_at
      };
}

class findDonationCampaigns extends StatefulWidget {
  const findDonationCampaigns({Key? key}) : super(key: key);

  @override
  State<findDonationCampaigns> createState() => _findDonationCampaignsState();
}

class _findDonationCampaignsState extends State<findDonationCampaigns> {
  String query = '';
  GlobalKey _scaffold = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  List<DonationCampaigndata> campaign = [];

  String? donoremail;
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
    getPref();
    findCampaigns(query);
  }

  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      donoremail = prefs.getString('email');
      ufname = prefs.getString('ufname');
      umname = prefs.getString('umname');
      ulname = prefs.getString('ulname');
      gender = prefs.getString('gender');
      age = prefs.getString('age');
      phonenumber = prefs.getString('phonenumber');
      district = prefs.getString('district');
      address = prefs.getString('address');
      bloodtype = prefs.getString('bloodtype');
    });
  }

  Future<List<DonationCampaigndata>> findCampaigns(String query) async {
    var response = await http.get(
        Uri.parse("http://lifebloodsl.com/communityapi/findcampaigns.php"));

    if (response.statusCode == 200) {
      final List campaign = json.decode(response.body);

      return campaign
          .map((json) => DonationCampaigndata.fromJson(json))
          .where((campaign) {
        final campaignnameLower = campaign.campaignname.toLowerCase();
        final targeteddistrictLower = campaign.targeteddistrict.toLowerCase();
        final searchLower = query.toLowerCase();

        return campaignnameLower.contains(searchLower) ||
            targeteddistrictLower.contains(searchLower);
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

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  // if (response.statusCode == 200) {
  //
  //   print(response.statusCode);
  //
  //   final items = json.decode(response.body).cast<Map<String, dynamic>>();
  //   List<BloodTestSchAppdata> bloodtestschList = items.map<BloodTestSchAppdata>((json) {
  //     return BloodTestSchAppdata.fromJson(json);
  //   }).toList();
  //   return bloodtestschList;
  // }
  // else {
  //   print(response.statusCode.toString());
  //   throw Exception('Failed load data with status code ${response.statusCode}');
  // }

  // }catch(e){
  //   print (e);
  //   throw e;}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      backgroundColor: Color(0xFFe0e9e4),
      appBar: AppBar(
          title: Text(
            'Find Donation Campaigns',
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
          ),
          automaticallyImplyLeading: true,
          elevation: 0,
          backgroundColor: Colors.teal,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: Column(children: <Widget>[
        buildDonationSearch(),
        Expanded(
          child: FutureBuilder<List<DonationCampaigndata>>(
              future: findCampaigns(query),
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
                            "No active donation campaigns found..",
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
                            "Do you want to create a donation campaign? \nIf Yes, Kindly create a donation campaign",
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
                                child: Text('Create Campaign Now',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12.sp, color: Colors.white)),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Color(0xff389e9d),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (context) => DonationCampaigns(),
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
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [],
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
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Text('Campaign Information',
                                                                                textAlign: TextAlign.center,
                                                                                style: GoogleFonts.montserrat(fontSize: 10.sp, color: Color(0xff389e9d))),
                                                                            SizedBox(
                                                                              height: 5.h,
                                                                            ),
                                                                            Form(
                                                                                // key: _formKey,
                                                                                autovalidateMode: AutovalidateMode.always,
                                                                                child: Column(children: [
                                                                                  TextFormField(
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
                                                                                    decoration: InputDecoration(labelText: 'Campaign Creator', hintText: 'Enter New Phone Number', labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                  ),
                                                                                  TextFormField(
                                                                                    keyboardType: TextInputType.number,
                                                                                    initialValue: data.campaignname,
                                                                                    style: TextStyle(fontSize: 12.sp, fontFamily: 'Montserrat'),
                                                                                    enabled: false,
                                                                                    readOnly: true,
                                                                                    validator: (value) {
                                                                                      if (value!.isEmpty) {
                                                                                        return 'Phone Number is required';
                                                                                      }
                                                                                      return null;
                                                                                    },
                                                                                    decoration: InputDecoration(labelText: 'Campaign Name', hintText: 'Enter New Phone Number', labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 15.h,
                                                                                  ),
                                                                                  TextFormField(
                                                                                    keyboardType: TextInputType.number,
                                                                                    initialValue: data.daterange,
                                                                                    style: TextStyle(fontSize: 12.sp, fontFamily: 'Montserrat'),
                                                                                    enabled: false,
                                                                                    readOnly: true,
                                                                                    validator: (value) {
                                                                                      if (value!.isEmpty) {
                                                                                        return 'Phone Number is required';
                                                                                      }
                                                                                      return null;
                                                                                    },
                                                                                    decoration: InputDecoration(labelText: 'Date', hintText: 'Enter New Phone Number', labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                  ),
                                                                                ])),
                                                                            SizedBox(
                                                                              height: 10.h,
                                                                            ),
                                                                            Divider(
                                                                              height: 1.h,
                                                                              thickness: 0.4.w,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10.h,
                                                                            ),
                                                                            Text('Targets',
                                                                                textAlign: TextAlign.center,
                                                                                style: GoogleFonts.montserrat(fontSize: 10.sp, color: Color(0xff389e9d))),
                                                                            SizedBox(
                                                                              height: 5.h,
                                                                            ),
                                                                            Form(
                                                                                // key: _formKey,
                                                                                autovalidateMode: AutovalidateMode.always,
                                                                                child: Column(children: [
                                                                                  TextFormField(
                                                                                    keyboardType: TextInputType.number,
                                                                                    initialValue: data.targetedbloodliters,
                                                                                    style: TextStyle(fontSize: 12.sp, fontFamily: 'Montserrat'),
                                                                                    enabled: false,
                                                                                    readOnly: true,
                                                                                    validator: (value) {
                                                                                      if (value!.isEmpty) {
                                                                                        return 'Phone Number is required';
                                                                                      }
                                                                                      return null;
                                                                                    },
                                                                                    decoration: InputDecoration(labelText: 'Blood Litres', hintText: 'Enter New Phone Number', labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                  ),
                                                                                  TextFormField(
                                                                                    keyboardType: TextInputType.number,
                                                                                    initialValue: data.targeteddistrict + ' | ' + data.targetedarea,
                                                                                    style: TextStyle(fontSize: 12.sp, fontFamily: 'Montserrat'),
                                                                                    enabled: false,
                                                                                    readOnly: true,
                                                                                    validator: (value) {
                                                                                      if (value!.isEmpty) {
                                                                                        return 'Phone Number is required';
                                                                                      }
                                                                                      return null;
                                                                                    },
                                                                                    decoration: InputDecoration(labelText: 'Targeted District & Area', hintText: 'Enter New Phone Number', labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
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
                                                                                Text('Donate', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                SizedBox(
                                                                                  width: 5.w,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            style:
                                                                                TextButton.styleFrom(
                                                                              foregroundColor: Colors.white,
                                                                              backgroundColor: Color(0xff389e9d),
                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                            ),
                                                                            onPressed:
                                                                                () {
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
                                                                                            Text('Your donation changes lives.\nBut not everyone can donate blood (including plasma), for a few reasons. \nCheck your eligibility to donate today.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                                                                            SizedBox(
                                                                                              height: 5.h,
                                                                                            ),
                                                                                            Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              children: [
                                                                                                TextButton(
                                                                                                    child: Text('Take Eligibility Quiz', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                    style: TextButton.styleFrom(
                                                                                                      foregroundColor: Colors.white,
                                                                                                      backgroundColor: Color(0xff389e9d),
                                                                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                    ),
                                                                                                    onPressed: () {
                                                                                                      var email = data.email;
                                                                                                      var campaignname = data.campaignname;
                                                                                                      var campaignemail = data.campaignemail;
                                                                                                      var name = data.name;
                                                                                                      var date = data.daterange;
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
                                                                                                                              foregroundColor: Colors.white,
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
                                                                                                                                                      foregroundColor: Colors.white,
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
                                                                                                                                                                              foregroundColor: Colors.white,
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
                                                                                                                                                      foregroundColor: Colors.white,
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
                                                                                                                                                                              foregroundColor: Colors.white,
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
                                                                                                                                                                                                      foregroundColor: Colors.white,
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
                                                                                                                                                                              foregroundColor: Colors.white,
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
                                                                                                                                                                                                      foregroundColor: Colors.white,
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
                                                                                                                                                                                                                              foregroundColor: Colors.white,
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
                                                                                                                                                                                                      foregroundColor: Colors.white,
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
                                                                                                                                                                                                                              foregroundColor: Colors.white,
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
                                                                                                                                                                                                                                                      foregroundColor: Colors.white,
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
                                                                                                                                                                                                                              foregroundColor: Colors.white,
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
                                                                                                                                                                                                                                                      foregroundColor: Colors.white,
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
                                                                                                                                                                                                                                                                              foregroundColor: Colors.white,
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
                                                                                                                                                                                                                                                      foregroundColor: Colors.white,
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
                                                                                                                                                                                                                                                                              foregroundColor: Colors.white,
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
                                                                                                                                                                                                                                                                                                      foregroundColor: Colors.white,
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
                                                                                                                                                                                                                                                                              foregroundColor: Colors.white,
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
                                                                                                                                                                                                                                                                                            SizedBox(width: 5.w),
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
                                                                                                                                                                                                                                                                                                      foregroundColor: Colors.white,
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
                                                                                                                                                                                                                                                                                                                    Text(data.campaignname, textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                                                                                                                                                                                                                                                    SizedBox(
                                                                                                                                                                                                                                                                                                                      height: 10.h,
                                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                                    Row(
                                                                                                                                                                                                                                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                                                                                                                                                                                                                      children: [
                                                                                                                                                                                                                                                                                                                        TextButton(
                                                                                                                                                                                                                                                                                                                            child: Text('Register Now', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                                                                                                                                                                                                                                            style: TextButton.styleFrom(
                                                                                                                                                                                                                                                                                                                              foregroundColor: Colors.white,
                                                                                                                                                                                                                                                                                                                              backgroundColor: Color(0xff389e9d),
                                                                                                                                                                                                                                                                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                                                                                                            onPressed: () async {
                                                                                                                                                                                                                                                                                                                              if (await getInternetUsingInternetConnectivity()) {
                                                                                                                                                                                                                                                                                                                                var response = await http.post(Uri.parse("http://lifebloodsl.com/communityapi/campaignblooddonorregistration.php"), body: {
                                                                                                                                                                                                                                                                                                                                  "lastname": ulname,
                                                                                                                                                                                                                                                                                                                                  "middlename": umname,
                                                                                                                                                                                                                                                                                                                                  "firstname": ufname,
                                                                                                                                                                                                                                                                                                                                  "age": age,
                                                                                                                                                                                                                                                                                                                                  "gender": gender,
                                                                                                                                                                                                                                                                                                                                  "address": address,
                                                                                                                                                                                                                                                                                                                                  "district": district,
                                                                                                                                                                                                                                                                                                                                  "phonenumber": phonenumber,
                                                                                                                                                                                                                                                                                                                                  "donoremail": donoremail,
                                                                                                                                                                                                                                                                                                                                  "email": email,
                                                                                                                                                                                                                                                                                                                                  "campaignemail": campaignemail,
                                                                                                                                                                                                                                                                                                                                  "bloodgroup": bloodtype,
                                                                                                                                                                                                                                                                                                                                  "campaignname": campaignname,
                                                                                                                                                                                                                                                                                                                                  "name": name,
                                                                                                                                                                                                                                                                                                                                  "date": date,
                                                                                                                                                                                                                                                                                                                                });
                                                                                                                                                                                                                                                                                                                                Navigator.pop(context);
                                                                                                                                                                                                                                                                                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                                                                                                                                                                                                                                                                  content: Container(
                                                                                                                                                                                                                                                                                                                                    height: 25.h,
                                                                                                                                                                                                                                                                                                                                    child: Column(
                                                                                                                                                                                                                                                                                                                                      children: [
                                                                                                                                                                                                                                                                                                                                        Column(
                                                                                                                                                                                                                                                                                                                                          children: [
                                                                                                                                                                                                                                                                                                                                            Text('Registration Successful', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 11.sp)),
                                                                                                                                                                                                                                                                                                                                          ],
                                                                                                                                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                                                                                                                                      ],
                                                                                                                                                                                                                                                                                                                                    ),
                                                                                                                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                                                                                                                  backgroundColor: Colors.teal,
                                                                                                                                                                                                                                                                                                                                  behavior: SnackBarBehavior.fixed,
                                                                                                                                                                                                                                                                                                                                  duration: Duration(seconds: 15),
                                                                                                                                                                                                                                                                                                                                ));
                                                                                                                                                                                                                                                                                                                              } else {
                                                                                                                                                                                                                                                                                                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                                                                                                                                                                                                                                                                  content: Text('You are offline, Kindly turn on Wifi or Mobile Data to continue', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 10.sp)),
                                                                                                                                                                                                                                                                                                                                  backgroundColor: Color(0xFFE02020),
                                                                                                                                                                                                                                                                                                                                  behavior: SnackBarBehavior.fixed,
                                                                                                                                                                                                                                                                                                                                  duration: const Duration(seconds: 10),
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
                                                                                                                                                                                                                                                                                                                              foregroundColor: Colors.white,
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
                                                                                                                                                                                                                                                                                                      foregroundColor: Colors.white,
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
                                                                                                                                                                                                                                                                                                                              foregroundColor: Colors.white,
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
                                                                                                                                                                                                                                                                                                      foregroundColor: Colors.white,
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
                                                                                                                              foregroundColor: Colors.white,
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
                                                                                                                                                      foregroundColor: Colors.white,
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
                                                                                                      foregroundColor: Colors.white,
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
                                                                          TextButton(
                                                                            child:
                                                                                Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: 5.w,
                                                                                ),
                                                                                Icon(Icons.money),
                                                                                SizedBox(
                                                                                  width: 5.w,
                                                                                ),
                                                                                Text('Fund', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                SizedBox(
                                                                                  width: 5.w,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            style:
                                                                                TextButton.styleFrom(
                                                                              foregroundColor: Colors.white,
                                                                              backgroundColor: Color(0xff389e9d),
                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              String selectedpayment = '';
                                                                              var email = data.email;
                                                                              var campaignemail = data.campaignemail;
                                                                              var campaignname = data.campaignname;
                                                                              var name = data.name;
                                                                              var date = data.daterange;
                                                                              final TextEditingController amountCtrl = TextEditingController();

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
                                                                                            Text('We appreciate you for this decision. \nThanks in advance.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Color(0xff389e9d))),
                                                                                            SizedBox(
                                                                                              height: 10.h,
                                                                                            ),
                                                                                            Form(
                                                                                              key: _formKey,
                                                                                              autovalidateMode: AutovalidateMode.always,
                                                                                              child: Column(
                                                                                                children: [
                                                                                                  TextFormField(
                                                                                                    keyboardType: TextInputType.text,
                                                                                                    enabled: false,
                                                                                                    readOnly: true,
                                                                                                    initialValue: data.budgetrange,
                                                                                                    style: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'),
                                                                                                    validator: (value) {
                                                                                                      if (value!.isEmpty) {
                                                                                                        return 'Address is required';
                                                                                                      }
                                                                                                      return null;
                                                                                                    },
                                                                                                    decoration: InputDecoration(labelText: 'Budget Range', hintText: 'Enter New Address', labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                                  ),
                                                                                                  TextFormField(
                                                                                                    keyboardType: TextInputType.number,
                                                                                                    style: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'),
                                                                                                    validator: (value) {
                                                                                                      if (value!.isEmpty) {
                                                                                                        return 'Amount is required';
                                                                                                      }
                                                                                                      return null;
                                                                                                    },
                                                                                                    controller: amountCtrl,
                                                                                                    decoration: InputDecoration(labelText: 'Amount', hintText: 'Enter Amount', labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                                  ),
                                                                                                  SizedBox(height: 8.h),
                                                                                                  FormBuilderRadioGroup(
                                                                                                    orientation: OptionsOrientation.vertical,
                                                                                                    name: selectedpayment,
                                                                                                    decoration: InputDecoration(border: InputBorder.none, labelText: 'Payment Information', labelStyle: TextStyle(fontSize: 14.sp, fontFamily: 'Montserrat')),
                                                                                                    onChanged: (String? value) {
                                                                                                      setState(() {
                                                                                                        selectedpayment = value!;
                                                                                                      });
                                                                                                    },
                                                                                                    validator: FormBuilderValidators.required(
                                                                                                      errorText: 'Kindly Select a Blood Type',
                                                                                                    ),
                                                                                                    options: [
                                                                                                      'Bank',
                                                                                                      'Orange Money',
                                                                                                      'Afrimoney'
                                                                                                    ].map((selectedpayment) => FormBuilderFieldOption(value: selectedpayment)).toList(growable: false),
                                                                                                  ),
                                                                                                  SizedBox(height: 10.h),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                            Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                              children: [
                                                                                                TextButton(
                                                                                                    child: Text('Submit Fund', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                    style: TextButton.styleFrom(
                                                                                                      foregroundColor: Colors.white,
                                                                                                      backgroundColor: Color(0xff389e9d),
                                                                                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                                    ),
                                                                                                    onPressed: () async {
                                                                                                      Navigator.pop(context);
                                                                                                      if (await getInternetUsingInternetConnectivity()) {
                                                                                                        var response = await http.post(Uri.parse("http://nsbslifebloodsl.com/communityapi/campaignbloodfunding.php"), body: {
                                                                                                          "lastname": ulname,
                                                                                                          "middlename": umname,
                                                                                                          "firstname": ufname,
                                                                                                          "age": age,
                                                                                                          "gender": gender,
                                                                                                          "address": address,
                                                                                                          "district": district,
                                                                                                          "phonenumber": phonenumber,
                                                                                                          "donoremail": donoremail,
                                                                                                          "email": email,
                                                                                                          "campaignemail": campaignemail,
                                                                                                          "bloodgroup": bloodtype,
                                                                                                          "campaignname": campaignname,
                                                                                                          "name": name,
                                                                                                          "date": date,
                                                                                                          "amount": amountCtrl.text,
                                                                                                          "paymenttype": selectedpayment,
                                                                                                        });
                                                                                                        Navigator.pop(context);
                                                                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                                          content: Container(
                                                                                                            height: 25.h,
                                                                                                            child: Column(
                                                                                                              children: [
                                                                                                                Column(
                                                                                                                  children: [
                                                                                                                    Text('Funding Successful, You will be contacted shortly!!', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 11.sp)),
                                                                                                                  ],
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                          backgroundColor: Colors.teal,
                                                                                                          behavior: SnackBarBehavior.fixed,
                                                                                                          duration: Duration(seconds: 15),
                                                                                                        ));
                                                                                                      } else {
                                                                                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                                          content: Text('You are offline, Kindly turn on Wifi or Mobile Data to continue', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 10.sp)),
                                                                                                          backgroundColor: Color(0xFFE02020),
                                                                                                          behavior: SnackBarBehavior.fixed,
                                                                                                          duration: const Duration(seconds: 10),
                                                                                                          // duration: Duration(seconds: 3),
                                                                                                        ));
                                                                                                      }
                                                                                                    }),
                                                                                                SizedBox(width: 5.w),
                                                                                                TextButton(
                                                                                                    child: Text('Close', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                    style: TextButton.styleFrom(
                                                                                                      foregroundColor: Colors.white,
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
                                                                          SizedBox(
                                                                            width:
                                                                                5.w,
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
                                                                            child:
                                                                                Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.add,
                                                                                  color: Color(0xff389e9d),
                                                                                  size: 11.h,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 3.w,
                                                                                ),
                                                                                Text('More Information', style: GoogleFonts.montserrat(fontSize: 11.sp, color: Color(0xff389e9d))),
                                                                              ],
                                                                            ),
                                                                            style:
                                                                                TextButton.styleFrom(
                                                                              foregroundColor: Colors.white,
                                                                              backgroundColor: Colors.transparent,
                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
                                                                            ),
                                                                            onPressed:
                                                                                () {
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
                                                                                            Text('More Information', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 13.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                            SizedBox(
                                                                                              height: 10.h,
                                                                                            ),
                                                                                            Form(
                                                                                              // key: _formKey,
                                                                                              autovalidateMode: AutovalidateMode.always,
                                                                                              child: Column(
                                                                                                children: [
                                                                                                  SizedBox(
                                                                                                    height: 10.h,
                                                                                                  ),
                                                                                                  TextFormField(
                                                                                                    maxLengthEnforcement: MaxLengthEnforcement.none,
                                                                                                    textInputAction: TextInputAction.newline,
                                                                                                    keyboardType: TextInputType.multiline,
                                                                                                    minLines: null,
                                                                                                    enabled: false,
                                                                                                    readOnly: true,
                                                                                                    style: TextStyle(fontSize: 12.sp, fontFamily: 'Montserrat'),
                                                                                                    maxLines: null,
                                                                                                    initialValue: data.campaigndescription,
                                                                                                    decoration: InputDecoration(
                                                                                                      border: OutlineInputBorder(),
                                                                                                      labelText: 'Campaign Description',
                                                                                                      labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'),
                                                                                                    ),
                                                                                                  ),
                                                                                                  TextFormField(
                                                                                                    keyboardType: TextInputType.number,
                                                                                                    initialValue: data.phonenumber,
                                                                                                    style: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'),
                                                                                                    enabled: false,
                                                                                                    readOnly: true,
                                                                                                    validator: (value) {
                                                                                                      if (value!.isEmpty) {
                                                                                                        return 'Phone Number is required';
                                                                                                      }
                                                                                                      return null;
                                                                                                    },
                                                                                                    decoration: InputDecoration(labelText: 'Phone Number', hintText: 'Enter New Phone Number', labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                                  ),
                                                                                                  TextFormField(
                                                                                                    keyboardType: TextInputType.text,
                                                                                                    initialValue: data.campaignemail,
                                                                                                    style: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'),
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
                                                                                                          style: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'),
                                                                                                          validator: (value) {
                                                                                                            if (value!.isEmpty) {
                                                                                                              return 'Address is required';
                                                                                                            }
                                                                                                            return null;
                                                                                                          },
                                                                                                          decoration: InputDecoration(labelText: 'Address', hintText: 'Enter New Address', labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                                        )
                                                                                                      : SizedBox(
                                                                                                          height: 0.h,
                                                                                                        ),
                                                                                                  TextFormField(
                                                                                                    keyboardType: TextInputType.text,
                                                                                                    enabled: false,
                                                                                                    readOnly: true,
                                                                                                    initialValue: data.bloodcomponent,
                                                                                                    style: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'),
                                                                                                    validator: (value) {
                                                                                                      if (value!.isEmpty) {
                                                                                                        return 'Address is required';
                                                                                                      }
                                                                                                      return null;
                                                                                                    },
                                                                                                    decoration: InputDecoration(labelText: 'Targeted Blood Components', hintText: 'Enter New Address', labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                                  ),
                                                                                                  TextFormField(
                                                                                                    keyboardType: TextInputType.text,
                                                                                                    enabled: false,
                                                                                                    readOnly: true,
                                                                                                    initialValue: data.budgetrange,
                                                                                                    style: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'),
                                                                                                    validator: (value) {
                                                                                                      if (value!.isEmpty) {
                                                                                                        return 'Address is required';
                                                                                                      }
                                                                                                      return null;
                                                                                                    },
                                                                                                    decoration: InputDecoration(labelText: 'Budget Range', hintText: 'Enter New Address', labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                                  ),
                                                                                                  SizedBox(height: 10.h),
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
                                                                                                      foregroundColor: Colors.white,
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
        text: query,
        hintText: 'Targeted District, Name',
        onChanged: searchcampaings,
      );

  Future searchcampaings(String query) async => debounce(() async {
        final campaign = await findCampaigns(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.campaign = campaign;
        });
      });

  showSnackBar({BuildContext? context}) {}
}
