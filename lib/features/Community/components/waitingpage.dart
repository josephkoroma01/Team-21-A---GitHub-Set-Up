import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lifebloodworld/features/Community/components/donationcampaigns.dart';
import 'package:lifebloodworld/features/Community/components/donationcampaignsearch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



class waitingCampaignPage extends StatefulWidget {


  waitingCampaignPage({Key? key,
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
    required this.refcode


  }) : super(key: key);

  String? name;
  String? campaignname;
  String? campaigndescription;
  String? phonenumber;
  String? email;
  String? campaignemail;
  String? address;
  String? targeteddistrict;
  String? targetedarea;
  String? bloodcomponent;
  String? targetedbloodliters;
  String? budgetrange;
  String? daterange;
  String? refcode;

  @override
  State<waitingCampaignPage> createState() => waitingCampaignPageState(
      name: name,
      campaignname: campaignname,
      campaigndescription: campaigndescription,
      phonenumber: phonenumber,
      email: email,
      campaignemail: campaignemail,
      address: address,
      targeteddistrict: targeteddistrict,
      targetedarea: targetedarea,
      bloodcomponent: bloodcomponent,
      targetedbloodliters: targetedbloodliters,
      budgetrange: budgetrange,
      daterange: daterange,
      refcode: refcode);
}

class waitingCampaignPageState extends State<waitingCampaignPage> {
  waitingCampaignPageState({Key? key,
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
    required this.refcode});

  String query = '';
  GlobalKey _scaffold = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  String? name;
  String? campaignname;
  String? campaigndescription;
  String? phonenumber;
  String? email;
  String? campaignemail;
  String? address;
  String? targeteddistrict;
  String? targetedarea;
  String? bloodcomponent;
  String? targetedbloodliters;
  String? budgetrange;
  String? daterange;
  String? refcode;



  bool _isloginLoading = true;




  @override
  void initState() {
    super.initState();
    register();
  }


  Future register() async {
    await Future.delayed(Duration(seconds: 2));
    var response = await http.post(Uri.parse("http://lifebloodsl.com/communityapi/donationcampaigns.php"), body: {
      "name": name,
      "campaignname": campaignname,
      "campaigndescription": campaigndescription,
      "phonenumber": phonenumber,
      "email": email,
      "campaignemail": phonenumber,
      "address": address,
      "targeteddistrict": targeteddistrict,
      "targetedarea": targetedarea,
      "bloodcomponent": bloodcomponent,
      "targetedbloodliters": targetedbloodliters,
      "budgetrange": budgetrange,
      "daterange": daterange,
      "refcode": refcode
    });
    var data = json.decode(response.body);
    if (data == "Error") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please Try Again, Schedule Already Exists, Try Tracking Schedule',
            style: GoogleFonts
                .montserrat()),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 4),
      ));
      await Future.delayed(Duration(seconds: 2));
      // scheduleAlarm()
      await Navigator.push(context, MaterialPageRoute(builder: (context)=>DonationCampaigns(),),
      );

    } else {
      showModalBottomSheet(
          backgroundColor: Colors.teal,
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
                    children: [
                      Column(
                        children: [
                          Text('Campaign Created Successfully, \nYou will be contacted shortly !!', textAlign:TextAlign.center, style:GoogleFonts.montserrat(fontSize: 11.sp, color: Colors.white) ),
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
                                  text: 'Your reference code to track \nreview process is ',
                                ),
                                TextSpan(
                                  text:  refcode,
                                  style: GoogleFonts.montserrat(fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,),
                                ),
                              ],
                            ),
                            textHeightBehavior: TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [


                          TextButton(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.copy, size:13, color: Colors.teal),
                                    SizedBox(
                                      width: 5.h,
                                    ),
                                    Text('Copy Code', textAlign: TextAlign.center, style: GoogleFonts.montserrat(fontSize: 13.sp, color: Colors.teal)),
                                  ],
                                ),
                              ),
                              style: TextButton
                                  .styleFrom(
                                primary: Colors.teal,
                                backgroundColor:
                                Colors.white,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius
                                        .all(Radius
                                        .circular(
                                        5))),
                              ),

                              onPressed: () async{
                                await Clipboard.setData(ClipboardData(text: '$refcode'));
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  duration: Duration(seconds: 5),
                                  content: Text('Copied to clipboard',  style: GoogleFonts
                                      .montserrat()),

                                ));
                                // scheduleAlarm()
                                await Navigator.push(context, MaterialPageRoute(builder: (context)=>DonationCampaigns(),),
                                );
                                Navigator.pop(context);
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                    ],
                  ),
                ),
              ),
            );});

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
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Expanded(
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: CircularProgressIndicator(
                          color: Colors.teal,
                        )),
                    SizedBox(
                        height:5
                    ),
                    Text('Creating Campaign..')
                  ],
                )
            ),
          ]),
    );
  }

}