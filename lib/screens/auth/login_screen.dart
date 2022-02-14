import 'dart:io';

import 'package:ems/providers/authprovider.dart';
import 'package:ems/screens/auth/signup_screen.dart';
import 'package:ems/screens/auth/start_forgot_password_screen.dart';
import 'package:ems/screens/dashboard/landing_screen.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:ems/widgets/onboardingbutton.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:device_info_plus/device_info_plus.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _showBtn = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() { 
      setState(() {
        if(_emailController.text.isEmpty || _passwordController.text.isEmpty){
          _showBtn = false;
        }else{
          _showBtn = true;
        }
      });
       print(_showBtn);
    });

    _passwordController.addListener(() { 
      setState(() {
        if(_emailController.text.isEmpty || _passwordController.text.isEmpty){
          _showBtn = false;
        }else{
          _showBtn = true;
        }
      });
      print(_showBtn);
    });
  }
  
  Widget emailField(){
    return TextField(
      controller: _emailController,
      style: const TextStyle(color: Color(0xff333333), fontSize: 14),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        hintText: "Email Address",
        border: InputBorder.none,
        prefixIcon: Icon(MdiIcons.email, color: Color(0xff333333),)
      ),
    );
  }

  Widget passwordField(){
    return TextField(
      controller: _passwordController,
      style: const TextStyle(color: Color(0xff333333), fontSize: 14),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: "Password",
        border: InputBorder.none,
        prefixIcon: Icon(MdiIcons.lock, color: Color(0xff333333),)
      ),
    );
  }

  Widget topContainer(){
    return Container(
      height: Get.height * 0.35,
      alignment: Alignment.center,
      child: Image.asset("assets/images/icon.png", width: Get.width * 0.3,)
    );
  }

  Widget formContainer(){
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: emailField(),
            ),
            // ignore: prefer_const_constructors
        
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Divider(
                height: 3,
                thickness: 3,
              ),
            ),
            // ignore: prefer_const_constructors
          
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: passwordField(),
            ),


        ],
      ),
    );
  }
  

  Widget bottomContainer(){
    return Material(
      elevation: 5,
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      color: Color(0xffE5E5E5),
      child: Container(
        width: Get.width,
        height: Get.height * 0.55,
        alignment: Alignment.bottomCenter,
        decoration: const BoxDecoration(
           borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            color: Color(0xffE5E5E5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ignore: prefer_const_constructors
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Login", style: TextStyle(fontFamily: 'MonumentRegular', color: Color(0xff333333), fontSize: 20,),),
              ],
            ),
            SizedBox(height: 25,),

            Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: formContainer(),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Get.to(() => StartForgotPassword()),
                    child: Text("Forgot Password?"),
                  ),

                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: _showBtn 
                    ? OnboardingButtons(
                        height: 50,
                        width: 150,
                        color: Color(0xff333333),
                        isLoading: _isLoading,
                        btnText: "Login",
                        onPressed: () async{
                          var aProvider = Provider.of<AuthProvider>(context, listen: false);

                          if(!_emailController.text.isEmail){
                            ProjectToast.showErrorToast("valid email is required");
                          }

                          setState(() {
                            _isLoading = true;
                          });

                          final resp = await aProvider.loginRequest(
                            _emailController.text,
                            _passwordController.text
                          );

                          setState(() {
                            _isLoading = false;
                          });

                          if(resp){
                            // Get Device FCM token
                            //String deviceToken = "";
                            aProvider.getUserProfileDetails(aProvider.user!.id!)
                            .then((value) => print("get user details status: ${value}"));

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
                                aProvider.addDeviceToken(token, model, aProvider.user!.id!);
                              }
                            });

                            Get.to(() => LandingScreen());
                          }
                        },
                      )
               
                    : Container(),
                  ),

                  
                ],
              )
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: InkWell(
                onTap: () => Get.to(() => SignupScreen()),
                child: RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account? ',
                     style: TextStyle(color: Color(0xff333333), fontSize: 16),
                    children: [
                      TextSpan(
                        text: 'Create One',
                         style: TextStyle(color: Color(0xffB83232), fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ]
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Container(
          color: const Color(0xff464040),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 25,),
                  topContainer(),
          
                  SizedBox(height: 30,),
                  bottomContainer(),
                ],
              ),
          ),
         
        ),
      ),
    );
  }
}