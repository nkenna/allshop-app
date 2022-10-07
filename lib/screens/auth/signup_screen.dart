import 'package:ems/providers/authprovider.dart';
import 'package:ems/screens/auth/login_screen.dart';
import 'package:ems/screens/dashboard/landing_screen.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:ems/widgets/onboardingbutton.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({ Key? key }) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  bool _obscure = true;

  bool _isLoading = false;

  Widget firstNameField(){
    return TextField(
      controller: _firstNameController,
      style: const TextStyle(color: Color(0xff333333), fontSize: 14),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        hintText: "First Name",
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
        prefixIcon: Icon(MdiIcons.accountCircle, color: Color(0xff333333),)
      ),
    );
  }

  Widget lastNameField(){
    return TextField(
      controller: _lastNameController,
      style: const TextStyle(color: Color(0xff333333), fontSize: 14),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        hintText: "Last Name",
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
        prefixIcon: Icon(MdiIcons.accountCircle, color: Color(0xff333333),)
      ),
    );
  }


  Widget phoneField(){
    return TextField(
      controller: _phoneController,
      style: const TextStyle(color: Color(0xff333333), fontSize: 14),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        hintText: "Phone Number",
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
        prefixIcon: Icon(MdiIcons.phone, color: Color(0xff333333),)
      ),
    );
  }
  
  Widget emailField(){
    return TextField(
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
    );
  }

  Widget passwordField(){
    return TextField(
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


  Widget signupBtn(){
    return SizedBox(
      height: 50,
      width: 160,
      child: ElevatedButton(
        onPressed: ()async{
          var aProvider = Provider.of<AuthProvider>(context, listen: false);

          if(_emailController.text.isEmpty){
            ProjectToast.showErrorToast("email is required");
          }

          if(!_emailController.text.isEmail){
            ProjectToast.showErrorToast("valid email is required");
          }

          if(_phoneController.text.isEmpty){
            ProjectToast.showErrorToast("valid phone is required");
            return;
          }

          // add country code to phone
          String? phone = aProvider.addCountryCodeToPhone(_phoneController.text);

          if(phone == null){
            ProjectToast.showErrorToast("valid phone is required");
            return;
          }

          setState(() {
            _isLoading = true;
          });

          final resp = await aProvider.signUp(
              _firstNameController.text,
              _lastNameController.text,
              _passwordController.text,
              _emailController.text,
              phone
          );
          setState(() {
            _isLoading = false;
          });

          if(resp){
            Get.offAll(() => LoginScreen());
            //aProvider.loginRequest(_emailController.text, _passwordController.text);
          }
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xff30b85a))
        ),
        child:  _isLoading
            ? CircularProgressIndicator.adaptive(backgroundColor: Colors.white,)
            : Text('Sign Up', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
      ),
    );
  }

  Widget cancelBtn(){
    return SizedBox(
      height: 50,
      width: 160,
      child: ElevatedButton(
        onPressed: (){
          _firstNameController.clear();
          _lastNameController.clear();
          _emailController.clear();
          _phoneController.clear();
          _passwordController.clear();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            elevation: MaterialStateProperty.all(0.0)
        ),
        child: Text('Cancel', style: TextStyle(color: Color(0xff44ce81), fontSize: 14, fontWeight: FontWeight.bold),),
      ),
    );
  }

  Widget authBtnsRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        cancelBtn(),
        Spacer(),
        signupBtn(),
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
                  SizedBox(height: 20,),
                  topContainer(),
                  SizedBox(height: 30,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Create an Account',
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
                        'Please fill the form below',
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
                    child: firstNameField(),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: lastNameField(),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: phoneField(),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: emailField(),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: passwordField(),
                  ),

                  SizedBox(height: 50,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: authBtnsRow(),
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