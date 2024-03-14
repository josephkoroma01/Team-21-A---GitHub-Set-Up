import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:expandable/expandable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lifebloodworld/features/Home/views/welcome_screen.dart';


class Others extends StatefulWidget {
  const Others({Key? key}) : super(key: key);

  @override
  State<Others> createState() => _OthersState();
}

class _OthersState extends State<Others> {
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
        title: Text('Others',
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
        ],
      ),
    );
  }
}

const faq1 = "To protect your health as a blood donor, there are minimum and maximum weights to donate.\n\nTo donate blood, the minimum weight is 50 kg. We need you to be above a minimum weight because the amount of blood your body contains is related to your weight and height. If our standard donation represents too high a volume, it's not safe for you to donate.\n\nOur donor couches can hold up to 170 kg, depending on their type and age. If you have any questions about maximum weight, please contact us. ";
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
                          "How much should I weigh to donate blood?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq1,
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


const faq2 = "Yes, just not right away. If you spent more than 72 hours in lockup, you’ll need to wait 12 months from the date you leave due to higher rates of hepatitis B and C and HIV in the prison population.";
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
                          "I’ve been in prison. Can I donate?",
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

const faq3 = "Yes, you can. Per- and poly-fluoroalkyl substances, also known as PFASs, are a group of manufactured chemicals that have been used since the 1950s in a range of common household products and specialty applications, including in the manufacture of non-stick cookware, fabric, furniture and carpet stain protection applications, and more.";
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
                          "I’ve been exposed to per- and poly-fluoroalkyl substances (PFASs). Can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq3,
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


const faq4 = "Yes. Menstruating doesn’t affect your ability to donate. Enjoy your relaxing time on the donation couch and a tasty snack afterwards. As someone who menstruates, it’s a good idea to check out our information about iron.";
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
                          "I’m having my period. Can I donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq4,
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

const faq5 = "Lead is a heavy metal which is toxic to our nervous systems. If someone has more than 10 micrograms of lead per deciliter of their blood (μg/dL) it can cause digestive, cardiovascular, kidney, reproductive and nervous system problems. The risks are highest for unborn babies, infants and children.\n\nFortunately, the levels of lead in the general Australian population have fallen over the decades (they’re estimated to be less than 5 ug/dL) and we take certain measures to ensure we’re doing everything we can to protect vulnerable patients from lead exposure.\n\nAm I at risk of having high lead levels and, if so, do I need to be tested?\n\nIf you work in an industry or job with lead exposure, you should be regularly tested by your work and told your blood’s lead levels.\n\nCan I donate blood or plasma if my job exposes me to lead?\n\nIf your lead level is 10 μg/dL or higher, you can’t donate blood — but the good news is that you can donate plasma.\n\nThat’s because lead could be harmful, particularly to unborn babies, infants and children. There is no known safe dose of lead. Higher lead levels in a donation increase the risk of lead-related harm to patients. It’s different with plasma because plasma donations can be pooled in large volumes containing plasma from many donors, so any lead is diluted to a very small amount.\n\nHow do you identify donors who have high lead levels?\n\nTo find these donors, we ask everyone before they donate whether they’ve had any tests or investigations, which they will if they work in an at-risk industry.\n\nI’ve heard that I can reduce my lead levels by donating blood. Is that true?\n\nNo, we wouldn’t expect donating to significantly decrease your lead levels. Only a small fraction of your body’s total lead is stored in your red blood cells and a blood donation is only about 10% of your total blood volume.\n\nIn fact, kidneys can clear out lead from blood quite well, but the process is slower for lead stored in bones. Because most of the lead in your body is actually in your bones, you only lose a small fraction of your overall lead when you donate blood. ";
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
                          "Does lead affect my ability to donate?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq4,
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

const faq6 = "Unfortunately, no. While we love having children around, we don’t offer any kind of childcare in our donor centres. For everyone's safety, children need to be supervised by an adult who isn’t donating.";

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
                          "I don’t want to leave my kids alone while I donate. Can someone watch them for me?",
                          style: GoogleFonts.montserrat(fontSize: 14.sp,fontWeight: FontWeight.bold, color: Color(0xFF205072))
                      )),
                  collapsed: Text(
                    faq4,
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
