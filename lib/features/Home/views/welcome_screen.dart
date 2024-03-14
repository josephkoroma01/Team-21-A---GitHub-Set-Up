import 'package:flutter/material.dart';
import 'package:lifebloodworld/features/Home/views/body.dart';



class HomePageScreen extends StatelessWidget {
int pageIndex;

  HomePageScreen({Key? key, required this.pageIndex}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(pageIndex: pageIndex,)
    );
  }
}

