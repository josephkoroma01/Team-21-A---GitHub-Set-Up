import 'package:flutter/material.dart';
import 'package:lifebloodworld/features/Home/views/body.dart';

class HomePageScreen extends StatelessWidget {
  int pageIndex;
  String? userId;
  String? countryid;
  HomePageScreen({Key? key, required this.pageIndex, this.userId, this.countryid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: HomePage(
      pageIndex: pageIndex,
      userId: userId.toString(),
      countryid:countryid.toString() ,

    ));
  }
}
