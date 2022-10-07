import 'package:ems/providers/authprovider.dart';
import 'package:ems/screens/auth/login_screen.dart';
import 'package:ems/screens/auth/reset_password_screen.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:ems/widgets/onboardingbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class StartForgotPassword extends StatefulWidget {
  const StartForgotPassword({ Key? key }) : super(key: key);

  @override
  _StartForgotPasswordState createState() => _StartForgotPasswordState();
}

class _StartForgotPasswordState extends State<StartForgotPassword> {
  TextEditingController _emailController = TextEditingController();


  bool _isLoading = false;

  
  Widget emailField(){
    return TextField(
      controller: _emailController,
      style: const TextStyle(color: Color(0xff333333), fontSize: 14),
      textInputAction: TextInputAction.done,
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

  Widget nextBtn(){
    return SizedBox(
      height: 50,
      width: 160,
      child: ElevatedButton(
        onPressed: ()async{
          var aProvider = Provider.of<AuthProvider>(context, listen: false);

          if(_emailController.text.isEmpty){
            ProjectToast.showErrorToast("email is required");
          }

          setState(() {
            _isLoading = true;
          });

          final resp = await aProvider.sendResetEmail(_emailController.text);
          setState(() {
            _isLoading = false;
          });

          if(resp){
            Get.to(() => ResetPasswordScreen(email: _emailController.text));
          }
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xff30b85a))
        ),
        child:  _isLoading
            ? CircularProgressIndicator.adaptive(backgroundColor: Colors.white,)
            : Text('Continue', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
      ),
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
                  SizedBox(height: 20,),
                  topContainer(),
                  SizedBox(height: 50,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Get Password Reset Code',
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

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: emailField(),
                  ),
                  SizedBox(height: 50,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        nextBtn(),
                      ],
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