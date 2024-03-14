import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:expandable/expandable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';


class MedConditionandPro extends StatefulWidget {
  const MedConditionandPro({Key? key}) : super(key: key);

  @override
  State<MedConditionandPro> createState() => _MedConditionandProState();
}

class _MedConditionandProState extends State<MedConditionandPro> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => HomePageScreen(pageIndex: 1,),
                ),
              );
            },
            icon: Icon(Icons.arrow_back)),
        elevation: 0,
        title: Text('Medical Conditions & Procedures',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                fontSize: size.width * 0.045, color: Colors.white)),
      ),
      backgroundColor: Color(0xFFe0e9e4),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
         SizedBox(
           height: 20.h,
         ),
          Card1(),
          Card2(),
          Card3(),
          Card4(),
          Card5(),
          Card6(),
          Card7(),
          Card8(),
          Card9(),
          Card10(),
          Card11(),
          Card12(),



        ],
      ),
    );
  }
}

const faq1 = "Your blood volume goes down a little when you donate. It’s important to be well hydrated so that you can feel well after. \n\nOn the day before your donation, we recommend:\n\n10 glasses of fluid if you are a man\n8 glasses of fluid if you are a woman\n\nIn the three hours before you donate, drink three good-sized glasses of fluid (that’s 750 mL).\n\nIf you’re a new donor and haven’t had enough water, it’s best to reschedule (just give us a call or log in).\n\nIf you’re a regular and you haven’t had enough, you should be fine to donate as long as you’ve had the same amount of fluids you normally would drink on the day before donating.\n\nWater is best, but any non-alcoholic fluid will do the trick.";
class Card1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "Hydration - How much water should I drink?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq1,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq1,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


const faq2 = "Yes, as long as there’s no broken skin or local infection around the wart.";
class Card2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I have wart (human papilloma) virus. Can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq2,
                    softWrap: true,
                    maxLines: 1,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq2,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq3 = "Maybe.It depends on the type of surgery and the recovery period.\n\nUpcoming surgery:\n If you have surgery planned within 84 days (that’s about three months) of your donation, you may need to wait before donating. Please contact us to discuss your eligibility.\n\nRecent surgery: \nHow long you need to wait to give blood after surgery depends on a number of things. These include the medical condition the surgery was for, the type of surgery, and the recovery period. Contact us and we’ll be able to work out when you can donate.\n\nIf you received a blood transfusion during or after your surgery, you’ll have to wait at least 12 months from the transfusion before you donate blood.  ";
class Card3 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I have surgery planned or recently had it. Can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq3,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq3,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


const faq4 = "We’re glad you’re doing better now. Unfortunately, though, to protect your health you’re not able to donate blood. \n\nDon't be disappointed though, because there are other ways you can help. You can spread the word about how blood saves lives on social media";
class Card4 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I've had a stroke, but I'm doing well now. Can I donate blood?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq4,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq4,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq5 = "If your spleen was removed due to trauma or physical injury, you can donate six months after you’ve made a full recovery. If you received a blood transfusion as well, you’ll need to wait 12 months after the transfusion.  \n\nHowever, if your spleen was removed to treat a chronic illness such as immune thrombocytopaenic purpura (ITP) or lymphoma, you won’t be able to donate blood.\n\nDon't be disappointed though, because there are other ways you can help. You can spread the word about how blood saves lives on social media ";
class Card5 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I had my spleen removed. Can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq5,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq5,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq6 = "Yes, but you can only donate either blood or plasma. At the moment, we don’t know how collecting platelets from people with osteoporosis affects their bone density. That’s why, to protect your health, you won’t be able to donate platelets. If you have any questions, please contact us.  ";
class Card6 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I’ve had a bone density scan confirming I have osteoporosis. Can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq6,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq6,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq7 = "Unfortunately, no. As the cause of MS is still unknown, we can’t rule out that it’s caused by a transmissible infection (like a virus) that medical science hasn’t discovered yet.  Don't be disappointed though, because there are other ways you can help. You can spread the word about how blood saves lives on social media";
class Card7 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I have multiple sclerosis (MS). Can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq7,
                    softWrap: true,
                    maxLines: 1,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq7,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq8 = "No. Unfortunately, having SLE may affect your body’s ability to tolerate regular blood donation. It’s also possible that regular blood donations could affect the severity of your SLE.   Don't be disappointed though, because there are other ways you can help. You can spread the word about how blood saves lives on social media";
class Card8 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I have lupus (systemic lupus erythematosus or SLE). Can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq8,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq8,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq9 = "Yes, as long as your doctor has ruled out any serious ongoing liver disease, you can begin donating blood again. If you have any questions, please contact us.";
class Card9 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I’ve been told my ALT (liver function test) was too high for me to donate. If my ALT is back to normal, am I okay to donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq9,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq9,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq10 = "No. Unfortunately, to protect your health, if you have a history of leukaemia or lymphoma you are unable to donate blood. Don't be disappointed though, because there are other ways you can help. You can spread the word about how blood saves lives on social media";
class Card10 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I had leukaemia or lymphoma. Can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq10,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq10,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq11 = "You can donate two weeks after you’ve made a full recovery, but you must stay home while you’re showing any symptoms at all. ";
class Card11 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I’ve had the flu. Can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq11,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq11,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq12 = "Hypoglycaemia means you have low blood sugar. It can occur with the treatment of diabetes. If you have symptoms of hypoglycaemia which aren’t related to diabetes or another serious illness, you can donate as long as you eat a substantial snack two hours before you donate and drink 8 to 10 glass of fluid the day before, then at least three good-sized glasses of water (750ml) in the 3 hours before you donate, and plenty of fluids after.";
class Card12 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I have been told I am hypoglycaemic. Can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq12,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq12,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq13 = "It depends on the type of hepatitis you had.  \n\nHepatitis A and B:\nHepatitis is an inflammation of the liver caused by infection (like the hepatitis A or B viruses) or an unknown cause. You need to wait at least 12 months after you’ve made a full recovery before you donate blood. When you come in, make sure you notify the interviewer so they can request some extra tests on your donation to be safe.\n\nHepatitis C:\nIf you currently have or have ever had hepatitis C, you aren’t able to donate even if you completed successful treatment. \n\nOne of the screening tests for hepatitis C tests for the hepatitis C antibody, which usually remains positive for life. Donations can’t be used if they test positive to any screening test for an infectious disease.\n\nDon't be disappointed though, because there are other ways you can help. You can spread the word about how blood saves lives on social media";
class Card13 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I had hepatitis. Can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq12,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq12,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq14 = "If you've had helicobacter pylori infection (stomach ulcer), you can donate five days after you’ve completed treatment and have no symptoms. However, if you’ve had an endoscopy, you might need to wait a bit longer.";
class Card14 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I’ve had a stomach ulcer before. Am I eligible to donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq12,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq12,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq15 = "Maybe. It depends on the type of heart condition you have (and as long as you meet our other criteria). For the following conditions, please contact us to check.  \n\nAngina: You may be able to donate if you have had no symptoms for at least 6 months. \n\nArrhythmia: There are a lot of different forms of arrhythmia, and different treatments.\n\nHeart disease: If you’ve been diagnosed with ischaemic heart disease or coronary artery disease and have had no symptoms for at least 6 months, you may be able to donate.\n\nHeart attack: You may be able to donate if you've had no symptoms for 6 months after the heart attack, but not if you've had more than one heart attack.\n\nHeart surgery: You’ll need to wait 6 months before you can donate, and only if you have no other symptoms. ";
class Card15 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I have a heart condition. Can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq12,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq12,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq16 = "Depending on the cause of the diarrhoea, you’ll need to wait between one and four weeks after recovering. Check with us about your symptoms and eligibility by contacting us.";
class Card16 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I have diarrhoea. Can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq12,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq12,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq17 = "Yes, as long as you have no complications from your diabetes, such as eye, heart, blood vessel or kidney problems, and your diabetes is well controlled through diet or oral medication. If you need insulin to control your diabetes, contact us to check your eligibility.";
class Card17 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I am diabetic. Can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq12,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq12,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq18 = "Unfortunately, no. Having cystic fibrosis usually results in recurrent chest infections and nutritional problems including anaemia. For your safety, you won’t be able to donate.  Don't be disappointed though, because there are other ways you can help. You can spread the word about how blood saves lives on social media";
class Card18 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I have cystic fibrosis. Can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq12,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq12,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq19 = "We ask that you don’t donate until one week after you’re fully recovered and feeling fit and well. Even if you’re only experiencing mild symptoms, like a runny nose, please stay home to rest and recover.";
class Card19 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I have a cold. Can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq12,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq12,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq20 = "You can donate plasma as soon as you’ve recovered but you’ll need to wait four weeks before you can give blood. You’re recovered when all your spots are completely clean and dry and you’re feeling well. Your plasma can provide valuable antibodies (blood proteins your body makes to fight infections) for people at risk of chicken pox. \n\nIf you’ve been in close contact with someone who has chicken pox while they’re infectious, you’ll need to wait 3 weeks after the contact before you donate. ";
class Card20 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I have chicken pox or have had contact with someone with it. Can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq12,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq12,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


const faq21 = "Yes. In most cases, you can donate if you remain free of cancer five years after completing treatment. This is to protect your own health by ensuring, as far as possible, that the cancer is gone and won’t recur. Five years is the period most often used by doctors to define a cancer as presumed 'cured'.  \n\nFor some cancers (or pre-cancers) of the skin, carcinoma in situ (CIN and CIS) of the cervix, prostatic intraepithelial neoplasia (PIN) of the prostate, or ductal carcinoma in-situ (DCIS) of the breast, you may be eligible to donate as soon as treatment is complete.\n\nHowever, if you have a history of leukaemia, lymphoma and myeloma, which involve the blood production system, you can't donate blood. It’s to protect your health and the health of patients who receive donated blood.  \n\nDon't be disappointed though, because there are other ways you can help. ";
class Card21 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I have had cancer. Can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq12,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq12,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



const faq22 = "Yes. You’ll just need to wait 12 months after you received the transfusion before you donate. If you received only autologous blood (you donated blood before a procedure and were transfused with your own blood), then you can donate sooner. You’ll just need a letter from your doctor. ";
class Card22 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I’ve had a blood transfusion. Can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq12,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq12,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


const faq23 = "Maybe. It can depend on the type of bleeding and blood disorder, and may be based on your individual circumstances. Please contact us to give us more information and learn if you can donate.";
class Card23 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "Can I donate if I have a bleeding or blood disorder, like haemophilia or thalassaemia?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq12,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq12,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const faq24 = "Yes, if you have mild allergies you can donate blood, even when taking antihistamines for treatment. However, there are times when you may not be able to donate.  \n\nYou may not be able to donate if you:\n\nhave an allergy to a substance we use in the blood donation process\nhave a severe allergy, or\nare unwell at the time of donation due to your allergy\n\nIf this is the case, please contact us to see if you’re able to donate. ";
class Card24 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I’ve been told I have anaemia. Can I donate blood?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq12,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq12,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


const faq25 = "Usually, yes, but it depends on how your cerebral palsy affects you. If you’re generally fit, able to move freely on and off a donation couch without assistance, and there’s no difficulty accessing the veins at your elbow, you should be able to donate. Please contact us to talk to us about whether you can donate.";
class Card25 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I have cerebral palsy. Can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq12,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq12,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


const faq26 = "Yes, provided that the rash isn’t inflamed or weeping and doesn’t affect the inner surface of your elbow where we take blood. ";
class Card26 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFebf5f5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: <Widget>[

              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "I have eczema. Am I eligible to donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq12,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              faq12,
                              softWrap: true,
                              style: TextStyle(fontFamily: 'Montserrat', fontSize: 13.sp),
                              overflow: TextOverflow.fade,
                            )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
