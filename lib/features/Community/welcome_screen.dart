import 'package:flutter/material.dart';
import 'package:lifebloodworld/features/Community/components/body.dart';


class CommunityPageScreen extends StatelessWidget {
  CommunityPageScreen({super.key, required this.userId});
  String userId;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: community(userId: userId),
    );
  }
}
