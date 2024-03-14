import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifebloodworld/features/Community/components/donationcampaigns.dart';
import 'package:lifebloodworld/features/Community/components/donationcampaignsearch.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class DonationCampaigndata {
  int id;
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

  DonationCampaigndata({
    required this.id,
    required this.name,
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
    required this.created_at



  });

  factory DonationCampaigndata.fromJson(Map<String, dynamic> json) {
    return DonationCampaigndata(
        id: json['id'],
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
        created_at: json['created_at'].toString()

    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
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
class myDonationCampaigns extends StatefulWidget {
  const myDonationCampaigns({Key? key}) : super(key: key);

  @override
  State<myDonationCampaigns> createState() => _myDonationCampaignsState();
}

class _myDonationCampaignsState extends State<myDonationCampaigns> {

  String query = '';

  List<DonationCampaigndata> campaign = [];

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
    getMyCampaigns(query);
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


  Future<List<DonationCampaigndata>> getMyCampaigns(String query) async {
    var data = {'email': email};

    var response = await http.post(
        Uri.parse("http://nsbslifeblood.niche.sl/mycampaigns.php"),
        body: json.encode(data));

    if (response.statusCode == 200) {
      final List campaign = json.decode(response.body);

      return campaign.map((json) => DonationCampaigndata.fromJson(json)).where((
          campaign) {
        final campaignnameLower = campaign.campaignname.toLowerCase();
        final targeteddistrictLower = campaign.campaigndescription.toLowerCase();
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
            title: Text('Find Donation Campaigns',
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
                child: FutureBuilder<List<DonationCampaigndata>>(
                    future: getMyCampaigns(query),
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
                                  "No donation campaigns created..",
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
                                                                                  initialValue: data.targeteddistrict,
                                                                                  style: TextStyle(fontSize: 12.sp, fontFamily: 'Montserrat'),
                                                                                  enabled: false,
                                                                                  readOnly: true,
                                                                                  validator: (value) {
                                                                                    if (value!.isEmpty) {
                                                                                      return 'Phone Number is required';
                                                                                    }
                                                                                    return null;
                                                                                  },
                                                                                  decoration: InputDecoration(labelText: 'Targeted District', hintText: 'Enter New Phone Number', labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                ),
                                                                                TextFormField(
                                                                                  keyboardType: TextInputType.number,
                                                                                  initialValue: data.targetedarea,
                                                                                  style: TextStyle(fontSize: 12.sp, fontFamily: 'Montserrat'),
                                                                                  enabled: false,
                                                                                  readOnly: true,
                                                                                  validator: (value) {
                                                                                    if (value!.isEmpty) {
                                                                                      return 'Phone Number is required';
                                                                                    }
                                                                                    return null;
                                                                                  },
                                                                                  decoration: InputDecoration(labelText: 'Targeted Area', hintText: 'Enter New Phone Number', labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                ),
                                                                              ])),
                                                                          SizedBox(
                                                                            height: 10.h,
                                                                          ),
                                                                          Text('Status',
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
                                                                                  initialValue: data.status,
                                                                                  style: TextStyle(fontSize: 12.sp, fontFamily: 'Montserrat'),
                                                                                  enabled: false,
                                                                                  readOnly: true,
                                                                                  validator: (value) {
                                                                                    if (value!.isEmpty) {
                                                                                      return 'Phone Number is required';
                                                                                    }
                                                                                    return null;
                                                                                  },
                                                                                  decoration: InputDecoration(labelText: 'Status', hintText: 'Enter New Phone Number', labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
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
                                                                    (data.status == "Pending") ? SizedBox(width:0.w) : Column(
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
                                                                                  Text('Registered Donors', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
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
                                                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => registeredDonors(campaignname: data.campaignname)));
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
                                                                                  Icon(Icons.money),
                                                                                  SizedBox(
                                                                                    width: 5.w,
                                                                                  ),
                                                                                  Text('Funds', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
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
                                                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => funding(campaignname: data.campaignname)));

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
                                                                          ],
                                                                        ),
                                                                        (data.status == "Closed") ? SizedBox(width:0.w) : Row(
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
                                                                                  Icon(Icons.share),
                                                                                  SizedBox(
                                                                                    width: 5.w,
                                                                                  ),
                                                                                  Text('Share', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
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
                                                                                              Text('\nShare Your \nCampaign', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 17.sp, fontWeight: FontWeight.bold, color: Color(0xff406986))),
                                                                                              SizedBox(
                                                                                                height: 10.h,
                                                                                              ),
                                                                                              Text('Get more people involved\nand reach your target goals faster.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                                                                              SizedBox(
                                                                                                height: 5.h,
                                                                                              ),
                                                                                              Text('\nFollow these steps to share your campaign:', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986), fontWeight: FontWeight.bold)),
                                                                                              SizedBox(
                                                                                                height: 5.h,
                                                                                              ),
                                                                                              Row(
                                                                                                children: [
                                                                                                  Text('1. Copy the campaign link ', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                                                                                  TextButton(
                                                                                                    child: Row(
                                                                                                      children: [
                                                                                                        Icon(Icons.copy, size:13, color: Color(0xff389e9d),),
                                                                                                        SizedBox(
                                                                                                          width: 5.h,
                                                                                                        ),
                                                                                                        Text('Copy', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 13.sp, color: Color(0xff389e9d))),
                                                                                                      ],
                                                                                                    ),
                                                                                                    onPressed: () async{
                                                                                                      await Clipboard.setData(ClipboardData(text: "http://nsbslifeblood.niche.sl/campaigns.php?value="+data.id.toString()));
                                                                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                                        content: Text('Copied to clipboard'),
                                                                                                      ));
                                                                                                    }),
                                                                                                ],
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: 2.h,
                                                                                              ),
                                                                                              Row(
                                                                                                children: [
                                                                                                  Text('2. Share the link to ', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Color(0xff406986))),
                                                                                                  SizedBox(
                                                                                                    width: 2.h,
                                                                                                  ),Icon(FontAwesomeIcons.facebook, color: Color(0xff4267B2),),
                                                                                                  SizedBox(
                                                                                                    width: 2.h,
                                                                                                  ),Icon(FontAwesomeIcons.whatsapp, color: Color(0xff25D366)),
                                                                                                  SizedBox(
                                                                                                    width: 2.h,
                                                                                                  ),Icon(FontAwesomeIcons.instagram, color: Color(0xffF77737)),
                                                                                                  SizedBox(
                                                                                                    width: 2.h,
                                                                                                  ),Icon(FontAwesomeIcons.twitter, color: Color(0xff1DA1F2)),
                                                                                                ],
                                                                                              ),

                                                                                              SizedBox(
                                                                                                height:10.h
                                                                                              ),

                                                                                              Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
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
                                                                                                  Text('Are you sure you\nwant to stop this campaign?', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.normal, color: Color(0xff406986))),


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
    var response = await http.post(Uri.parse("http://nsbslifeblood.niche.sl/updatecampaignstatus.php"), body: {
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
    Text('Your campaign has been stopped successful.', textAlign:TextAlign.center, style:GoogleFonts.montserrat(fontSize: 11.sp) ),
    ],
    ),
    ],
    ),
    ),
    backgroundColor: Colors.teal,
    behavior: SnackBarBehavior.fixed,
    duration: Duration(seconds: 15),));
    await Navigator.push(context, MaterialPageRoute(builder: (context)=>myDonationCampaigns(),),);
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
                                                                            SizedBox(
                                                                              width:
                                                                              5.w,
                                                                            ),
                                                                          ],
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
                                                                            primary: Colors.white,
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
                                                                                                TextFormField(
                                                                                                  keyboardType: TextInputType.text,
                                                                                                  enabled: false,
                                                                                                  readOnly: true,
                                                                                                  initialValue: data.refcode,
                                                                                                  style: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'),
                                                                                                  validator: (value) {
                                                                                                    if (value!.isEmpty) {
                                                                                                      return 'Address is required';
                                                                                                    }
                                                                                                    return null;
                                                                                                  },
                                                                                                  decoration: InputDecoration(labelText: 'Reference Code', hintText: 'Enter New Address', labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                                ),
                                                                                                SizedBox(height: 3.h),
                                                                                                TextButton(
                                                                                                    child: Row(
                                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                                      children: [
                                                                                                        Icon(Icons.copy, size:13, color: Colors.teal),
                                                                                                        SizedBox(
                                                                                                          width: 5.h,
                                                                                                        ),
                                                                                                        Text('Copy Code', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 13.sp, color: Colors.teal)),
                                                                                                      ],
                                                                                                    ),
                                                                                                    onPressed: () async{
                                                                                                      await Clipboard.setData(ClipboardData(text: data.refcode));
                                                                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                                        content: Text('Copied to clipboard'),
                                                                                                      ));
                                                                                                    }),
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
  text: query,
  hintText: 'Targeted District, Name',
  onChanged: searchcampaigns,
);

Future searchcampaigns(String query) async => debounce(() async {
  final campaign = await getMyCampaigns(query);

  if (!mounted) return;

  setState(() {
    this.query = query;
    this.campaign = campaign;
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
  String? campaignname;

  registeredDonors({Key? key, required this.campaignname}) : super(key: key);

  @override
  State<registeredDonors> createState() => _registeredDonorsState(campaignname:campaignname);
}

class _registeredDonorsState extends State<registeredDonors> {

  String? campaignname;
  _registeredDonorsState({Key? key, required this.campaignname});

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
    'campaignname' : campaignname};

    var response = await http.post(
        Uri.parse("http://nsbslifeblood.niche.sl/findregisteredcampaigndonors.php"),
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
            title: Text('Registered Donors',
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
                                  "No donor found..",
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
        Uri.parse("http://nsbslifeblood.niche.sl/findcampaignfunding.php"),
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

