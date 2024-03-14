import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'donationcampaignsearch.dart';
import 'joindonationcampaigns.dart';

class DonationCampaignDonordata {
  DonationCampaignDonordata(
      {required this.donorcampaignid,
      required this.surname,
      required this.name,
      required this.agecategory,
      required this.gender,
      required this.address,
      required this.donorphonenumber,
      required this.donoremail,
      required this.district,
      required this.maritalstatus,
      required this.occupation,
      required this.nextofkin,
      required this.inextofkin,
      required this.nokcontact,
      required this.pid,
      required this.pidnumber,
      required this.vhbv,
      required this.whenhbv,
      required this.bgroup,
      required this.campaignid,
      required this.campaignname,
      required this.campaigncreator,
      required this.campaigndescription,
      required this.campaigncontact,
      required this.campaignemail,
      required this.facility,
      required this.campaignfacility,
      required this.campaignlocation,
      required this.campaigndistrict,
      required this.campaigndate,
      required this.campaigndatecreated,
      required this.campaignstatus,
      required this.date,
      required this.month,
      required this.year,
      required this.refcode,
      required this.status,
      required this.review,
      required this.rating,
      required this.created_at});

  factory DonationCampaignDonordata.fromJson(Map<String, dynamic> json) {
    return DonationCampaignDonordata(
      donorcampaignid: json['id'].toString(),
      surname: json['surname'].toString(),
      name: json['name'].toString(),
      agecategory: json['agecategory'].toString(),
      gender: json['gender'].toString(),
      address: json['address'].toString(),
      donoremail: json['donoremail'].toString(),
      donorphonenumber: json['donorphonenumber'].toString(),
      district: json['district'].toString(),
      maritalstatus: json['maritalstatus'].toString(),
      occupation: json['occupation'].toString(),
      nextofkin: json['nextofkin'].toString(),
      inextofkin: json['inextofkin'].toString(),
      nokcontact: json['nokcontact'].toString(),
      pid: json['pid'].toString(),
      pidnumber: json['pidnumber'].toString(),
      vhbv: json['vhbv'].toString(),
      whenhbv: json['whenhbv'].toString(),
      bgroup: json['bgroup'].toString(),
      campaignid: json['campaignid'].toString(),
      campaignname: json['campaignname'].toString(),
      campaigncreator: json['campaigncreator'].toString(),
      campaigndescription: json['campaigndescription'].toString(),
      campaigncontact: json['campaigncontact'].toString(),
      campaignemail: json['campaignemail'].toString(),
      facility: json['facility'].toString(),
      campaignfacility: json['campaignfacility'].toString(),
      campaignlocation: json['campaignlocation'].toString(),
      campaigndistrict: json['campaigndistrict'].toString(),
      campaigndate: json['campaigndate'].toString(),
      campaigndatecreated: json['campaigndatecreated'].toString(),
      campaignstatus: json['campaignstatus'].toString(),
      date: json['date'].toString(),
      month: json['month'].toString(),
      year: json['year'].toString(),
      refcode: json['refcode'].toString(),
      status: json['status'].toString(),
      review: json['review'].toString(),
      rating: json['rating'].toString(),
      created_at: json['created_at'].toString(),
    );
  }

  String donorcampaignid;
  String surname;
  String name;
  String agecategory;
  String gender;
  String address;
  String donoremail;
  String donorphonenumber;
  String district;
  String maritalstatus;
  String occupation;
  String nextofkin;
  String inextofkin;
  String nokcontact;
  String pid;
  String pidnumber;
  String vhbv;
  String whenhbv;
  String bgroup;
  String campaignid;
  String campaignname;
  String campaigncreator;
  String campaigndescription;
  String campaigncontact;
  String campaignemail;
  String facility;
  String campaignfacility;
  String campaignlocation;
  String campaigndistrict;
  String campaigndate;
  String campaigndatecreated;
  String campaignstatus;
  String date;
  String month;
  String year;
  String refcode;
  String status;
  String review;
  String rating;
  String created_at;

  Map<String, dynamic> toJson() => {
        'donorcampaignid': donorcampaignid,
        'surname': surname,
        'name': name,
        'agecategory': agecategory,
        'gender': gender,
        'address': address,
        'donoremail': donoremail,
        'donorphonenumber': donorphonenumber,
        'district': district,
        'maritalstatus': maritalstatus,
        'occupation': occupation,
        'nextofkin': nextofkin,
        'inextofkin': inextofkin,
        'nokcontact': nokcontact,
        'pid': pid,
        'pidnumber': pidnumber,
        'vhbv': vhbv,
        'whenhbv': whenhbv,
        'bgroup': bgroup,
        'campaignid': campaignid,
        'campaignname': campaignname,
        'campaigncreator': campaigncreator,
        'campaigndescription': campaigndescription,
        'campaigncontact': campaigncontact,
        'campaignemail': campaignemail,
        'facility': facility,
        'campaignfacility': campaignfacility,
        'campaignlocation': campaignlocation,
        'campaigndistrict': campaigndistrict,
        'campaigndate': campaigndate,
        'campaigndatecreated': campaigndatecreated,
        'campaignstatus': campaignstatus,
        'date': date,
        'month': month,
        'year': year,
        'refcode': refcode,
        'status': status,
        'review': review,
        'rating': rating,
        'created_at': created_at
      };
}

DateTime now = DateTime.now();
String formattedNewDate = DateFormat('d MMM yyyy').format(now);
String formattedNewMonth = DateFormat('LLLL').format(now);
String formattedNewYear = DateFormat('y').format(now);
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

class MyDonationDrive extends StatefulWidget {
  MyDonationDrive({Key? key}) : super(key: key);

  @override
  State<MyDonationDrive> createState() => _MyDonationDriveState();
}

class _MyDonationDriveState extends State<MyDonationDrive> {
  String? address;
  String? agecategory;
  String? bloodtype;
  String? campaigndonation;
  String? checkcampaignid;
  List<DonationCampaignDonordata> joinedcampaign = [];
  final TextEditingController dateinput =
      TextEditingController(text: formattedNewDate.toString());

  Timer? debouncer;
  String? district;
  String? donoremail;
  String? donorphonenumber;
  String? gender;
  final TextEditingController monthinput =
      TextEditingController(text: formattedNewMonth.toString());

  String? prevdonation;
  String query = '';
  String? ufname;
  String? refcode;
  String? ulname;
  String? umname;
  final TextEditingController yearinput =
      TextEditingController(text: formattedNewYear.toString());

  final _formKey = GlobalKey<FormState>();
  bool _iscancelLoading = false;
  GlobalKey _scaffold = GlobalKey();

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  String? selectedRating = '';

  Future sendrating() async {
    if (selectedRating!.isNotEmpty) {
      var response = await http.post(
          Uri.parse("https://community.lifebloodsl.com/donationcampaignrating.php"),
          body: {
            "rating": selectedRating,
            "refcode": refcode,
            "donorphonenumber": donorphonenumber,
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
                Text('Rating Successful Sent',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                    )),
              ],
            ),
          ),
          backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.fixed,
          duration: Duration(seconds: 5),
        ));
        // scheduleAlarm();
        Future.delayed(Duration(seconds: 1), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyDonationDrive(),
            ),
          );
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
    findjoinedCampaigns(query);
    getjoineddrives(query);
  }

  void getPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      donoremail = prefs.getString('email');
      ufname = prefs.getString('ufname');
      umname = prefs.getString('umname');
      ulname = prefs.getString('ulname');
      gender = prefs.getString('gender');
      agecategory = prefs.getString('agecategory');
      donorphonenumber = prefs.getString('phonenumber');
      district = prefs.getString('district');
      address = prefs.getString('address');
      bloodtype = prefs.getString('bloodtype');
      campaigndonation = prefs.getString('campaigndonation');
      checkcampaignid = prefs.getString('checkcampaignid');
    });
  }

  Future cancelreg() async {
    await Future.delayed(Duration(seconds: 0));
    var response = await http.post(
        Uri.parse("https://community.lifebloodsl.com/cancelreg.php"),
        body: {
          "donorphonenumber": donorphonenumber,
          "campaignid": checkcampaignid,
        });
    var data = json.decode(response.body);
    if (data == "Success") {
      setState(() {
        campaigndonation = "No";
        checkcampaignid = "0";
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Campaign Registration\nCancel Successfully',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(fontSize: 12.sp)),
        backgroundColor: Colors.teal,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 3),
      ));
      savecampaigndonation();
      setState(() {
        _iscancelLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Please Try Again',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 3),
      ));
      // scheduleAlarm()
      // await Navigator.push(context, MaterialPageRoute(builder: (context)=>scheduletypebody(),),);
    }
  }

  Future undocancelreg() async {
    await Future.delayed(Duration(seconds: 0));
    var response = await http.post(
        Uri.parse("https://community.lifebloodsl.com/undocancelreg.php"),
        body: {
          "donorphonenumber": donorphonenumber,
          "campaignid": checkcampaignid,
        });
    var data = json.decode(response.body);
    if (data == "Success") {
      setState(() {
        campaigndonation = "Yes";
        checkcampaignid = checkcampaignid;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Campaign Cancellation\nUndo Successfully',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(fontSize: 12.sp)),
        backgroundColor: Colors.teal,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 4),
      ));
      savecampaigndonation();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Please Try Again',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 3),
      ));
      // scheduleAlarm()
      // await Navigator.push(context, MaterialPageRoute(builder: (context)=>scheduletypebody(),),);
    }
  }

  Future<List<DonationCampaignDonordata>> findjoinedCampaigns(
      String query) async {
    var data = {'phonenumber': '+23278621647'};

    var response = await http.post(
        Uri.parse("https://community.lifebloodsl.com/mydddcampaigns.php"),
        body: json.encode(data));
    if (response.statusCode == 200) {
      final List campaign = json.decode(response.body);
      return campaign
          .map((json) => DonationCampaignDonordata.fromJson(json))
          .where((campaign) {
        final campaignnameLower = campaign.campaignname.toLowerCase();
        final campaigncreatorLower = campaign.campaigncreator.toLowerCase();
        final searchLower = query.toLowerCase();

        return campaignnameLower.contains(searchLower) ||
            campaigncreatorLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<DonationCampaignDonordata>> getjoineddrives(String query) async {
    var data = {'donorphonenumber': donorphonenumber};

    var response = await http.post(
        Uri.parse("https://community.lifebloodsl.com/mycampaigns.php"),
        body: json.encode(data));

    if (response.statusCode == 200) {
      final List joinedcampaign = json.decode(response.body);

      return joinedcampaign
          .map((json) => DonationCampaignDonordata.fromJson(json))
          .where((joinedcampaign) {
        final campaignnameLower = joinedcampaign.campaignname.toLowerCase();
        final campaigncreatorLower =
            joinedcampaign.campaigncreator.toLowerCase();
        final searchLower = query.toLowerCase();

        return campaignnameLower.contains(searchLower) ||
            campaigncreatorLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
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

  savecampaigndonation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('campaigndonation', campaigndonation!);
    prefs.setString('checkcampaignid', checkcampaignid!);
  }

  Widget buildDonationSearch() => DonationCampaignSearchWidget(
        text: query,
        hintText: 'Targeted District, Name',
        onChanged: searchcampaings,
      );

  Future searchcampaings(String query) async => debounce(() async {
        final joinedcampaign = await findjoinedCampaigns(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.joinedcampaign = joinedcampaign;
        });
      });

  showSnackBar({BuildContext? context}) {}

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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color(0xFFe0e9e4),
          appBar: AppBar(
              automaticallyImplyLeading: true,
              elevation: 0,
              backgroundColor: Colors.teal,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => HomePageScreen(
                            pageIndex: 2,
                          ),
                        ),
                      )),
              title: Text(
                'Donation Drives Joined',
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
              )),
          body: Column(children: <Widget>[
            buildDonationSearch(),
            Expanded(
              child: FutureBuilder<List<DonationCampaignDonordata>>(
                  future: getjoineddrives(query),
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
                                "No donation drive joined..",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 15.sp,
                                    color: Color(0xFFE02020)),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: TextButton(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Icon(
                                            Icons.refresh,
                                            color: Colors.teal,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text('Refresh',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12.sp,
                                                  color: Colors.teal)),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                        ],
                                      ),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    super.widget));
                                      })),
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
                                                                bottom: MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          .0,
                                                                          5.0,
                                                                          5.0,
                                                                          5.0),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10.w),
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(10
                                                                              .r),
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xFFebf5f5),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                  ),
                                                                  child: Column(
                                                                    children: [
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: [
                                                                                        Text('Campaign Information', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 10.sp, color: Color(0xff389e9d))),
                                                                                        SizedBox(
                                                                                          height: 3.h,
                                                                                        ),
                                                                                        Text('Created on: ' + data.campaigndatecreated, textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 10.sp, color: Colors.grey)),
                                                                                        SizedBox(
                                                                                          height: 5.h,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    TextButton(
                                                                                      child: Text('Campaign ' + data.campaignstatus,
                                                                                          style: GoogleFonts.montserrat(
                                                                                            fontSize: 10.sp,
                                                                                          )),
                                                                                      style: TextButton.styleFrom(
                                                                                        foregroundColor: Colors.white,
                                                                                        backgroundColor: Color(0xFF205072),
                                                                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                      ),
                                                                                      onPressed: () {},
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 5.h,
                                                                                ),
                                                                                Form(
                                                                                    autovalidateMode: AutovalidateMode.always,
                                                                                    child: Column(children: [
                                                                                      TextFormField(
                                                                                        keyboardType: TextInputType.number,
                                                                                        initialValue: data.campaigncreator,
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
                                                                                        height: 5.h,
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
                                                                                          labelText: 'Campaign Description',
                                                                                          labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'),
                                                                                        ),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 5.h,
                                                                                      ),
                                                                                      TextFormField(
                                                                                        keyboardType: TextInputType.number,
                                                                                        initialValue: data.campaigndate,
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
                                                                                      (data.facility == "Yes")
                                                                                          ? TextFormField(
                                                                                              keyboardType: TextInputType.number,
                                                                                              initialValue: data.campaignfacility,
                                                                                              style: TextStyle(fontSize: 12.sp, fontFamily: 'Montserrat'),
                                                                                              enabled: false,
                                                                                              readOnly: true,
                                                                                              validator: (value) {
                                                                                                if (value!.isEmpty) {
                                                                                                  return 'Phone Number is required';
                                                                                                }
                                                                                                return null;
                                                                                              },
                                                                                              decoration: InputDecoration(labelText: 'Facility', hintText: 'Enter New Phone Number', labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                            )
                                                                                          : TextFormField(
                                                                                              keyboardType: TextInputType.number,
                                                                                              initialValue: data.campaignlocation,
                                                                                              style: TextStyle(fontSize: 12.sp, fontFamily: 'Montserrat'),
                                                                                              enabled: false,
                                                                                              readOnly: true,
                                                                                              validator: (value) {
                                                                                                if (value!.isEmpty) {
                                                                                                  return 'Phone Number is required';
                                                                                                }
                                                                                                return null;
                                                                                              },
                                                                                              decoration: InputDecoration(labelText: 'Location', hintText: 'Enter New Phone Number', labelStyle: TextStyle(fontSize: 13.sp, fontFamily: 'Montserrat'), hintStyle: TextStyle(fontSize: 15.sp, fontFamily: 'Montserrat')),
                                                                                            ),
                                                                                    ])),
                                                                                SizedBox(
                                                                                  height: 10.h,
                                                                                ),
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
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                double.infinity,
                                                                            child: (data.status == "Pending")
                                                                                ? Column(
                                                                                    children: [
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          Icon(
                                                                                            Icons.check_box,
                                                                                            color: Colors.green,
                                                                                            size: 15,
                                                                                          ),
                                                                                          Text(' You have registered for this campaign', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.green)),
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 10.h,
                                                                                      ),
                                                                                      TextButton(
                                                                                          child: Row(
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Icon(
                                                                                                Icons.cancel,
                                                                                                size: 14,
                                                                                                color: Colors.white,
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: 5.w,
                                                                                              ),
                                                                                              Text('Cancel', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                              SizedBox(
                                                                                                width: 5.w,
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          style: TextButton.styleFrom(
                                                                                            foregroundColor: Colors.red,
                                                                                            backgroundColor: Color(0xFFE02020),
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
                                                                                                          SizedBox(height: 10.h),
                                                                                                          Text('Are you sure you\nwant to cancel your registration?', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.normal, color: Color(0xff406986))),
                                                                                                          SizedBox(height: 10.h),
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
                                                                                                                  onPressed: () async {
                                                                                                                    Navigator.pop(context);
                                                                                                                    setState(() {
                                                                                                                      _iscancelLoading = true;
                                                                                                                    });

                                                                                                                    cancelreg();
                                                                                                                  }),
                                                                                                              SizedBox(
                                                                                                                width: 5,
                                                                                                              ),
                                                                                                              TextButton(
                                                                                                                  child: Text('No', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
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
                                                                                          }),
                                                                                    ],
                                                                                  )
                                                                                : (data.status == "Cancelled")
                                                                                    ? Column(
                                                                                        children: [
                                                                                          Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Icon(
                                                                                                Icons.check_box,
                                                                                                color: Colors.green,
                                                                                                size: 15,
                                                                                              ),
                                                                                              Text(' You have registered for this campaign', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.green)),
                                                                                            ],
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 10.h,
                                                                                          ),
                                                                                          TextButton(
                                                                                              child: Row(
                                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  Icon(
                                                                                                    Icons.cancel,
                                                                                                    size: 14,
                                                                                                    color: Colors.white,
                                                                                                  ),
                                                                                                  SizedBox(
                                                                                                    width: 5.w,
                                                                                                  ),
                                                                                                  Text('Undo & Donate Now', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                  SizedBox(
                                                                                                    width: 5.w,
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                              style: TextButton.styleFrom(
                                                                                                backgroundColor: Colors.teal,
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
                                                                                                              SizedBox(height: 10.h),
                                                                                                              Text('Are you sure you want to undo \nyour cancellation for this campaign?', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.normal, color: Color(0xff406986))),
                                                                                                              SizedBox(height: 10.h),
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
                                                                                                                      onPressed: () async {
                                                                                                                        Navigator.pop(context);
                                                                                                                        setState(() {
                                                                                                                          _iscancelLoading = true;
                                                                                                                        });

                                                                                                                        undocancelreg();
                                                                                                                      }),
                                                                                                                  SizedBox(
                                                                                                                    width: 5,
                                                                                                                  ),
                                                                                                                  TextButton(
                                                                                                                      child: Text('No', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
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
                                                                                              }),
                                                                                        ],
                                                                                      )
                                                                                    : (data.status == "Donated" && data.review == "Yes")
                                                                                        ? Container(
                                                                                            width: double.infinity,
                                                                                            child: TextButton(
                                                                                              child: Padding(
                                                                                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                                                                                child: Row(
                                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                  children: [
                                                                                                    Text('Your Experience: ', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.teal)),
                                                                                                    (data.rating == "Highly Dissatisfied")
                                                                                                        ? Row(
                                                                                                            children: [
                                                                                                              Image.asset(
                                                                                                                'assets/icons/hdis.png',
                                                                                                                height: 20.h,
                                                                                                                width: 20.w,
                                                                                                              ),
                                                                                                              SizedBox(
                                                                                                                width: 3.w,
                                                                                                              ),
                                                                                                              Text(data.rating, textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.red[300])),
                                                                                                            ],
                                                                                                          )
                                                                                                        : (data.rating == "Dissatisfied")
                                                                                                            ? Row(
                                                                                                                children: [
                                                                                                                  Image.asset(
                                                                                                                    'assets/icons/dis.png',
                                                                                                                    height: 20.h,
                                                                                                                    width: 20.w,
                                                                                                                  ),
                                                                                                                  SizedBox(
                                                                                                                    width: 3.w,
                                                                                                                  ),
                                                                                                                  Text(data.rating, textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.red[300])),
                                                                                                                ],
                                                                                                              )
                                                                                                            : (data.rating == "Neutral")
                                                                                                                ? Row(
                                                                                                                    children: [
                                                                                                                      Image.asset(
                                                                                                                        'assets/icons/neutral.png',
                                                                                                                        height: 20.h,
                                                                                                                        width: 20.w,
                                                                                                                      ),
                                                                                                                      SizedBox(
                                                                                                                        width: 3.w,
                                                                                                                      ),
                                                                                                                      Text(data.rating, textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.amber)),
                                                                                                                    ],
                                                                                                                  )
                                                                                                                : (data.rating == "Satisified")
                                                                                                                    ? Row(
                                                                                                                        children: [
                                                                                                                          Image.asset(
                                                                                                                            'assets/icons/sat.png',
                                                                                                                            height: 20.h,
                                                                                                                            width: 20.w,
                                                                                                                          ),
                                                                                                                          SizedBox(
                                                                                                                            width: 3.w,
                                                                                                                          ),
                                                                                                                          Text(data.rating, textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.green[300])),
                                                                                                                        ],
                                                                                                                      )
                                                                                                                    : Row(
                                                                                                                        children: [
                                                                                                                          Image.asset(
                                                                                                                            'assets/icons/hsat.png',
                                                                                                                            height: 20.h,
                                                                                                                            width: 20.w,
                                                                                                                          ),
                                                                                                                          SizedBox(
                                                                                                                            width: 3.w,
                                                                                                                          ),
                                                                                                                          Text(data.rating, textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.green)),
                                                                                                                        ],
                                                                                                                      ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                              style: TextButton.styleFrom(
                                                                                                foregroundColor: Colors.red,
                                                                                                backgroundColor: Colors.grey[100],
                                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                              ),
                                                                                              onPressed: () {},
                                                                                            ),
                                                                                          )
                                                                                        : Container(
                                                                                            width: double.infinity,
                                                                                            child: TextButton(
                                                                                              child: Row(
                                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [
                                                                                                  Text('Rate Experience', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white)),
                                                                                                ],
                                                                                              ),
                                                                                              style: TextButton.styleFrom(
                                                                                                foregroundColor: Colors.white,
                                                                                                backgroundColor: Colors.teal,
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
                                                                                                            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                                                                                              SizedBox(
                                                                                                                height: 3.h,
                                                                                                              ),
                                                                                                              Text('Rate Experience', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Color(0xff389e9d))),
                                                                                                              SizedBox(
                                                                                                                height: 5.h,
                                                                                                              ),
                                                                                                              Text('Let us know how we can improve.', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 14.sp, fontWeight: FontWeight.normal, color: Color(0xff406986))),
                                                                                                              SizedBox(
                                                                                                                height: 5.h,
                                                                                                              ),
                                                                                                              Container(
                                                                                                                width: double.infinity,
                                                                                                                child: SizedBox(
                                                                                                                  child: Divider(
                                                                                                                    color: Colors.teal,
                                                                                                                    thickness: 1,
                                                                                                                  ),
                                                                                                                  height: 5.h,
                                                                                                                ),
                                                                                                              ),
                                                                                                              SizedBox(
                                                                                                                height: 5.h,
                                                                                                              ),
                                                                                                              Form(
                                                                                                                key: _formKey,
                                                                                                                child: Column(
                                                                                                                  children: [
                                                                                                                    FormBuilderRadioGroup(
                                                                                                                      decoration: InputDecoration(border: InputBorder.none, labelText: 'Rate Your Experience', labelStyle: TextStyle(fontSize: 14.sp, fontFamily: 'Montserrat')),
                                                                                                                      name: '$selectedRating',
                                                                                                                      onChanged: (String? value) {
                                                                                                                        setState(() {
                                                                                                                          selectedRating = value;
                                                                                                                          refcode = data.refcode;
                                                                                                                        });
                                                                                                                      },
                                                                                                                      initialValue: selectedRating,
                                                                                                                      orientation: OptionsOrientation.vertical,
                                                                                                                      validator: FormBuilderValidators.required(
                                                                                                                        errorText: 'Kindly Select an option',
                                                                                                                      ),
                                                                                                                      options: [
                                                                                                                        'Highly Dissatisfied',
                                                                                                                        'Dissatisfied',
                                                                                                                        'Neutral',
                                                                                                                        'Satisified',
                                                                                                                        'Highly Satisfied'
                                                                                                                      ].map((selectedRating) => FormBuilderFieldOption(value: selectedRating)).toList(growable: false),
                                                                                                                    ),
                                                                                                                    SizedBox(
                                                                                                                      width: double.infinity,
                                                                                                                      child: ElevatedButton(
                                                                                                                        style: ButtonStyle(
                                                                                                                          backgroundColor: MaterialStateProperty.all(Colors.teal),
                                                                                                                        ),
                                                                                                                        onPressed: () async {
                                                                                                                          var refcode = data.refcode;
                                                                                                                          if (_formKey.currentState!.validate()) {
                                                                                                                            if (await getInternetUsingInternetConnectivity()) {
                                                                                                                              Navigator.pop(context);
                                                                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                                                                SnackBar(
                                                                                                                                    backgroundColor: Colors.teal,
                                                                                                                                    content: SingleChildScrollView(
                                                                                                                                        child: Container(
                                                                                                                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                                                      child: Padding(
                                                                                                                                        padding: EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 0.0),
                                                                                                                                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                                                                                                                                          Text('Sending rating: $selectedRating',
                                                                                                                                              textAlign: TextAlign.center,
                                                                                                                                              style: GoogleFonts.montserrat(
                                                                                                                                                fontSize: 14.sp,
                                                                                                                                                fontWeight: FontWeight.normal,
                                                                                                                                              ))
                                                                                                                                        ]),
                                                                                                                                      ),
                                                                                                                                    ))),
                                                                                                                              );
                                                                                                                              Future.delayed(Duration(seconds: 0), () async {
                                                                                                                                sendrating();
                                                                                                                              });
                                                                                                                            } else {
                                                                                                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                                                                content: Text('You are offline, Turn On Data or Wifi', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 11.sp)),
                                                                                                                                backgroundColor: Color(0xFFE02020),
                                                                                                                                behavior: SnackBarBehavior.fixed,
                                                                                                                                duration: const Duration(seconds: 5),
                                                                                                                                // duration: Duration(seconds: 3),
                                                                                                                              ));
                                                                                                                            }
                                                                                                                          }
                                                                                                                        },
                                                                                                                        child: const Text(
                                                                                                                          'Rate Experience',
                                                                                                                          style: TextStyle(fontFamily: 'Montserrat'),
                                                                                                                        ),
                                                                                                                      ),
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
                                                                          ),
                                                                          SizedBox(
                                                                              height: 5.h),
                                                                          Text(
                                                                              'Contact Organisers',
                                                                              textAlign: TextAlign.center,
                                                                              style: GoogleFonts.montserrat(fontSize: 11.sp, color: Colors.teal)),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              TextButton(
                                                                                child: Icon(Icons.call),
                                                                                style: TextButton.styleFrom(
                                                                                  foregroundColor: Colors.white,
                                                                                  backgroundColor: Color(0xFF205072),
                                                                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                ),
                                                                                onPressed: () {
                                                                                  launchUrl(Uri(
                                                                                    scheme: 'tel',
                                                                                    path: data.campaigncontact,
                                                                                  ));
                                                                                },
                                                                              ),
                                                                              SizedBox(
                                                                                width: 10.w,
                                                                              ),
                                                                              TextButton(
                                                                                child: Icon(Icons.facebook),
                                                                                //whatsapp logo
                                                                                style: TextButton.styleFrom(
                                                                                  foregroundColor: Colors.white,
                                                                                  backgroundColor: Colors.teal,
                                                                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                                                                ),
                                                                                onPressed: () async {
                                                                                  //To remove the keyboard when button is pressed
                                                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                                                  var whatsappUrl = "whatsapp://send?phone=${data.campaigncontact}" + "&text=${Uri.encodeComponent('I am in interested in your donation campaign.')}";
                                                                                  try {
                                                                                    launchUrl(whatsappUrl as Uri);
                                                                                  } catch (e) {
                                                                                    //To handle error and display error message
                                                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                      content: Text('Could Not Launch WhatsApp', style: GoogleFonts.montserrat()),
                                                                                      backgroundColor: Colors.red,
                                                                                      behavior: SnackBarBehavior.fixed,
                                                                                      duration: Duration(seconds: 4),
                                                                                    ));
                                                                                  }
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
        ));
  }
}
