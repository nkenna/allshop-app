import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({ Key? key }) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      alignment: Alignment.center,
      child: Text("This Feature is coming soon", style: TextStyle(color: Colors.white, fontFamily: 'SofiaProMedium', fontSize: 16),),
    );
  }
}