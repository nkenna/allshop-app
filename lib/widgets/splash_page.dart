import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:ems/models/user.dart';
import 'package:ems/providers/authprovider.dart';
import 'package:ems/screens/auth/login_screen.dart';
import 'package:ems/screens/dashboard/landing_screen.dart';
import 'package:ems/utils/sharedprefs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    navigateToScreen();  
  }


  Future<bool> checkforAuthenication() async{
    bool _isAuthenicated = false;
    var aProvider = Provider.of<AuthProvider>(context, listen: false);
    var tt = await SharedPrefs.instance.retrieveString("token");
    print("get default token: ${tt!.isEmpty}");
    if(tt != null && tt.isNotEmpty){
      _isAuthenicated = true;
      // call user details
      var userString = await SharedPrefs.instance.retrieveUserData();
      if(userString != null && userString.isNotEmpty){
        User user = User.fromJson(jsonDecode(userString));
        if(user != null){
          FirebaseMessaging.instance.getToken()
          .then((token) async{
            DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                              
            if(token != null){
              String? model = "";
              if(Platform.isAndroid){
                AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
                model = androidInfo.model ?? "";
              }
              if(Platform.isIOS){
                IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
                model = iosInfo.utsname.machine ?? "";
              }
              aProvider.addDeviceToken(token, model, user.id!);
            }
          });
          aProvider.getUserProfileDetails(user.id!);
        }
      }
    }else{
      _isAuthenicated = false;
    }

    return _isAuthenicated;
  }

  navigateToScreen(){
    Future.delayed(Duration(seconds: 2), () async{
      bool status = await checkforAuthenication();
      if(status){
        Get.offAll(() => LandingScreen());
      }else{
        Get.offAll(() => LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/icon.png", width: Get.width * 0.4,),
          SizedBox(height: 50,),
          CircularProgressIndicator.adaptive()
        ],
      ),
    );
  }
}