import 'dart:io';

import 'package:ems/providers/authprovider.dart';
import 'package:ems/screens/auth/signup_screen.dart';
import 'package:ems/screens/auth/start_forgot_password_screen.dart';
import 'package:ems/screens/dashboard/landing_screen.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:ems/widgets/onboardingbutton.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  bool _obscure = true;

  bool _googleLoading = false;

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
    return Card(
      child: TextField(
        controller: _emailController,
        style: const TextStyle(color: Color(0xff333333), fontSize: 14),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          hintText: "Email Address",
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xfff0efeb), width: 2 ),
          //borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffbcd3e3), width: 2 ),
          //borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xfff0efeb), width: 2 ),
          //borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          prefixIcon: Icon(MdiIcons.email, color: Color(0xff333333),)
        ),
      ),
    );
  }

  Widget passwordField(){
    return Card(
      child: TextField(
        controller: _passwordController,
        style: TextStyle(color: Color(0xff333333), fontSize: 14),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        obscureText: _obscure,
        decoration: InputDecoration(
          hintText: "Password",
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xfff0efeb), width: 2 ),
            //borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffbcd3e3), width: 2 ),
            //borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xfff0efeb), width: 2 ),
            //borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          prefixIcon: Icon(MdiIcons.lock, color: Color(0xff333333),),
          suffixIcon: InkWell(
                onTap: (){
                  setState(() =>_obscure = !_obscure);
                },
                child: Icon(_obscure ? Icons.visibility : Icons.visibility_off_rounded, color: Colors.black,),
              ),
        )
      ),
    );
  }

  Widget topContainer(){
    return Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Image.asset("assets/images/icon.png", width: 70),
        )
    );
  }

  Widget loginBtn(){
    return SizedBox(
      height: 50,
      width: 160,
      child: ElevatedButton(
        onPressed: ()async{
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
                print(token);
                aProvider.addDeviceToken(token, model, aProvider.user!.id!);
              }
            });

            Get.to(() => LandingScreen());
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xff30b85a))
        ),
        child:  _isLoading
        ? CircularProgressIndicator.adaptive(backgroundColor: Colors.white,)
        : Text('Login Now', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
      ),
    );
  }

   Widget googleBtn(){
    return SizedBox(
      height: 50,
      width: Get.width,
      child: TextButton(
        onPressed: ()async{
         var aProvider =
                            Provider.of<AuthProvider>(context, listen: false);
                        setState(() => _googleLoading = true);
                        var resp = await aProvider.signInWithGoogle(context);
                        setState(() => _googleLoading = false);
                        if (resp) {
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
                              print(token);
                              aProvider.addDeviceToken(token, model, aProvider.user!.id!);
                            }
                          });

                          Get.to(() => LandingScreen());
                        }
        },
       /* style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xff30b85a))
        ),*/
        child:  _googleLoading
        ? CircularProgressIndicator.adaptive()
        : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.google, color: Color(0xff30b85a),),
            SizedBox(width: 5,),
            Text('Continue with Google', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }

  Widget forgotBtn(){
    return SizedBox(
      height: 50,
      width: 160,
      child: ElevatedButton(
        onPressed: (){
          Get.to(() => StartForgotPassword());
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            elevation: MaterialStateProperty.all(0.0)
        ),
        child: Text('Forgot Password', style: TextStyle(color: Color(0xff44ce81), fontSize: 14, fontWeight: FontWeight.bold),),
      ),
    );
  }

  Widget authBtnsRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        forgotBtn(),
        Spacer(),
        loginBtn(),
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 50,),
                  topContainer(),
                  SizedBox(height: 50,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Welcome Back',
                        style: TextStyle(
                            color: Color(0xff30b85a),
                            fontSize: 24,
                            fontFamily: 'SofiaProMedium',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Sign in to continue',
                        style: TextStyle(
                            color: Color(0xff979797),
                            fontSize: 14,
                            //fontFamily: 'SofiaProMedium',
                            //fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
          
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: emailField(),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: passwordField(),
                  ),

                  SizedBox(height: 30,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: authBtnsRow(),
                  ),

                  SizedBox(height: 10,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: googleBtn(),
                  ),

                  SizedBox(height: 30,),


                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: RichText(
                      text: TextSpan(
                        text: 'Dont\'t have an account yet? ',
                        style: TextStyle(fontSize: 14, color: Color(0xff4f4f4f), fontFamily: 'SofiaProMedium'),
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(decoration: TextDecoration.underline, fontSize: 14, color: Color(0xff4f4f4f), fontFamily: 'SofiaProSemiBold'),
                              recognizer: new TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(() => SignupScreen());
                              }
                          )
                        ]
                      ),
                    ),
                  ),
                ],
              ),
          ),
         
        ),
      ),
    );
  }
}