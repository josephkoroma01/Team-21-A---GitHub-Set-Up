import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../main.dart';
import '../../../models/notification_model.dart';

class Notif extends StatelessWidget {
  const Notif({
    super.key,
    required this.newslink,
    required this.newstitle,
    required this.newsdescription,
    required this.newsdate,
    required this.data,
  });

  final String? newslink;
  final String? newstitle;
  final String? newsdescription;
  final String? newsdate;
  final Data? data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        var linkUrl = "$newslink";
        try {
          if (data?.type == "Campaign") {
          } else if (data?.type == "Result") {
            navigatorKey.currentState?.pushNamed('/drives');
          } else if (data?.type == "Blood Donation Request") {}

          launch(linkUrl);
        } catch (e) {
          //To handle error and display error message
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('Could Not Launch Link', style: GoogleFonts.montserrat()),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.fixed,
            duration: Duration(seconds: 4),
          ));
        }
      },
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
          child: Container(
            padding: EdgeInsets.all(10.r),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFebf5f5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "$newstitle",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                            Text("$newsdate",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                    fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("$newsdescription",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                    fontSize: 12, color: Colors.teal)),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  final String userId;
  final String countryid;

  const NotificationPage(
      {super.key, required this.userId, required this.countryid});

  @override
  // ignore: library_private_types_in_public_api
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Future<List<NotificationModel>> notificationsFuture;

  @override
  void initState() {
    super.initState();
    notificationsFuture = getNotifications(widget.countryid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe0e9e4),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(height: 15.h),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Notifications",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF205072)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 500,
              child: FutureBuilder<List<NotificationModel>>(
                future: notificationsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading notifications  '));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No notifications'));
                  } else {
                    var notifications = snapshot.data!;
                    return ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        var notification = notifications[index];
                        DateTime specifiedDateTime =
                            DateTime.parse(notification.createdAt.toString());

                        // Current datetime
                        DateTime currentDateTime = DateTime.now();

                        // Calculate the time difference
                        Duration difference =
                            currentDateTime.difference(specifiedDateTime);

                        // Get the human-readable difference
                        String timeDifference = getTimeDifference(difference);
                        return Notif(
                          newslink: notification.title,
                          newstitle: notification.title,
                          newsdescription: notification.message,
                          newsdate: timeDifference,
                          data: notification.data,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String getTimeDifference(Duration difference) {
  if (difference.inDays > 0) {
    return "${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ";
  } else if (difference.inHours > 0) {
    return "${difference.inHours} hr${difference.inHours == 1 ? '' : 's'} ";
  } else if (difference.inMinutes > 0) {
    return "${difference.inMinutes} min${difference.inMinutes == 1 ? '' : 's'} ";
  } else {
    return "${difference.inSeconds} sec${difference.inSeconds == 1 ? '' : 's'} ";
  }
}
