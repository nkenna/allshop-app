import 'package:ems/providers/authprovider.dart';
import 'package:ems/screens/auth/login_screen.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:ems/widgets/onboardingbutton.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  String? email;
  ResetPasswordScreen({ Key? key, this.email }) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _codeController = TextEditingController();


  bool _isLoading = false;

  Widget codeField(){
    return TextField(
      controller: _codeController,
      style: const TextStyle(color: Color(0xff333333), fontSize: 14),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        hintText: "Enter Reset Code",
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
        prefixIcon: Icon(MdiIcons.xml, color: Color(0xff333333),)
      ),
    );
  }

 
  Widget passwordField(){
    return TextField(
      controller: _newPasswordController,
      style: const TextStyle(color: Color(0xff333333), fontSize: 14),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: "Enter New Password",
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
        prefixIcon: Icon(MdiIcons.lock, color: Color(0xff333333),)
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

  Widget submitBtn(){
    return SizedBox(
      height: 50,
      width: 160,
      child: ElevatedButton(
        onPressed: ()async{
          var aProvider = Provider.of<AuthProvider>(context, listen: false);

          if(_newPasswordController.text.isEmpty){
            ProjectToast.showErrorToast("password is required");
          }

          setState(() {
            _isLoading = true;
          });

          final resp = await aProvider.resetPassword(
              _codeController.text,
              _newPasswordController.text
          );
          setState(() {
            _isLoading = false;
          });

          if(resp){
            Get.to(() => LoginScreen());
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
              child: codeField(),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Divider(
                height: 3,
                thickness: 3,
              ),
            ),
          
          
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
      color: const Color(0xffE5E5E5),
      child: Container(
        width: Get.width,
        height: Get.height * 0.75,
        alignment: Alignment.bottomCenter,
        decoration: const BoxDecoration(
           borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            color: Color(0xffE5E5E5),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ignore: prefer_const_constructors
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Reset Password", style: TextStyle(fontFamily: 'MonumentRegular', color: Color(0xff333333), fontSize: 20,),),
                ],
              ),
              SizedBox(height: 30,),
        
              Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: formContainer(),
              ),
        
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                   
        
                    OnboardingButtons(
                      height: 50,
                      width: 150,
                      color: Color(0xff333333),
                      isLoading: _isLoading,
                      btnText: "Submit",
                      onPressed: () async{
                        var aProvider = Provider.of<AuthProvider>(context, listen: false);
                        
                        if(_newPasswordController.text.isEmpty){
                          ProjectToast.showErrorToast("password is required");
                        }

                        setState(() {
                            _isLoading = true;
                        });
        
                        final resp = await aProvider.resetPassword(
                          _codeController.text,
                          _newPasswordController.text
                        );
                        setState(() {
                            _isLoading = false;
                        });
        
                        if(resp){
                          Get.to(() => LoginScreen());
                        }                     
                      },
                    )
                  ],
                )
              ),
        
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: InkWell(
                  onTap: () => Get.to(() => LoginScreen()),
                  child: RichText(
                    text: TextSpan(
                      text: 'Have an account? ',
                       style: TextStyle(color: Color(0xff333333), fontSize: 16),
                      children: [
                        TextSpan(
                          text: 'Login',
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
                        'Reset Password',
                        style: TextStyle(
                            color: Color(0xff30b85a),
                            fontSize: 24,
                            fontFamily: 'SofiaProMedium',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: codeField(),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: passwordField(),
                  ),
                  SizedBox(height: 50,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        submitBtn(),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: RichText(
                      text: TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(fontSize: 14, color: Color(0xff4f4f4f), fontFamily: 'SofiaProMedium'),
                          children: [
                            TextSpan(
                                text: 'Sign In',
                                style: TextStyle(decoration: TextDecoration.underline, fontSize: 14, color: Color(0xff4f4f4f), fontFamily: 'SofiaProSemiBold'),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(() => LoginScreen());
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