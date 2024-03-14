import 'dart:math';

import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';
import 'package:lifebloodworld/features/Welcome/onboarding.dart';
import 'package:lifebloodworld/main.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SupportLifeBloodScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lifeblood',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      home:
      SupportLifeBlood(title: 'Create Donation Campaigns'),
    );
  }
}

class SupportLifeBlood extends StatefulWidget {
  SupportLifeBlood({Key? key, required this.title,}) : super(key: key);

  final String? title;

  @override

  //text editing controller for text field



  _SupportLifeBloodState createState() => _SupportLifeBloodState();
}

class _SupportLifeBloodState extends State<SupportLifeBlood> {
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
    dateinput.text = "";
    getPref();
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
      address = prefs.getString('address');
      district = prefs.getString('district');
      bloodtype = prefs.getString('bloodtype');
      prevdonation = prefs.getString('prevdonation');

    });
  }


  final _formKey = GlobalKey<FormState>();

  String dropdownValue = 'Select Support Type';



  final TextEditingController dateinput = TextEditingController();
  final TextEditingController refCodeCtrl = TextEditingController(text:randomAlphaNumeric(8).toString(),);
  final TextEditingController _amountCtrl = TextEditingController();



  Future register() async {
    var response = await http.post(Uri.parse("http://nsbslifeblood.niche.sl/supportlifeblood.php"), body: {
      "firstname": ufname,
      "middlename": umname,
      "lastname": ulname,
      "age": age,
      "gender": gender,
      "phonenumber": phonenumber,
      "email": email,
      "address": address,
      "district": district,
      "supporttype": dropdownValue,
      "amount": _amountCtrl.text,

    });
    var data = json.decode(response.body);
    if (data == "Error") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please Try Again, Schedule Already Exists, Try Tracking Schedule'),
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
                  Text('Schedule Successful, You will be contacted shortly !!', textAlign:TextAlign.center, style:GoogleFonts.montserrat(fontSize: 11.sp) ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.teal,
        behavior: SnackBarBehavior.fixed,
        duration: Duration(seconds: 15),));
      // scheduleAlarm()
      await Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePageScreen(pageIndex: 3),),);
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final steps = [
      CoolStep(
        title: 'SUPPORT DETAILS',
        subtitle: 'Please fill some of the Support Information to get started',
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              Visibility(
                visible : false,
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

              DropdownButton<String>(
                isExpanded: true,
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,

                underline: Container(
                  height: 1,
                  color: Colors.grey,

                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['Select Support Type', 'Blood Banks', 'LifeBlood Team',]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(  height: size.height * 0.013,),
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

                    labelText: 'Amount (\$)',
                    labelStyle: TextStyle(fontSize: 15.sp),
                ),


                controller: _amountCtrl,
              ),

              SizedBox(  height: size.height * 0.013,),

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

    ];

    final stepper = CoolStepper(
      showErrorSnackbar: false,
      onCompleted: () async{
        if(await getInternetUsingInternetConnectivity()){


          register();
        }
        else{
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
                  new MaterialPageRoute(
                    builder: (context) => HomePageScreen(pageIndex: 3),
                  ),
                );
              },
              icon:Icon(Icons.arrow_back)
          ),
          elevation: 0,
          title: Text(widget.title!, style: TextStyle(fontSize: 13.sp),)
      ),
      body: Container(
        child: stepper,
      ),
    );
  }





}


