import 'package:ems/providers/authprovider.dart';
import 'package:ems/screens/auth/login_screen.dart';
import 'package:ems/screens/dashboard/landing_screen.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:ems/widgets/onboardingbutton.dart';
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

  bool _isLoading = false;

  Widget firstNameField(){
    return TextField(
      controller: _firstNameController,
      style: const TextStyle(color: Color(0xff333333), fontSize: 14),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        hintText: "First Name",
        border: InputBorder.none,
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
        border: InputBorder.none,
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
        border: InputBorder.none,
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
      height: Get.height * 0.1,
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
            child: firstNameField(),
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
            child: lastNameField(),
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
            child: phoneField(),
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
      color: const Color(0xffE5E5E5),
      child: Container(
        width: Get.width,
        height: Get.height * 0.8,
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
                  Text("Register", style: TextStyle(fontFamily: 'MonumentRegular', color: Color(0xff333333), fontSize: 20,),),
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
                      btnText: "Signup",
                      onPressed: () async{
                        var aProvider = Provider.of<AuthProvider>(context, listen: false);
                        
                        if(_emailController.text.isEmpty){
                          ProjectToast.showErrorToast("email is required");
                        }
        
                        if(!_emailController.text.isEmail){
                          ProjectToast.showErrorToast("valid email is required");
                        }
        
                        if(_phoneController.text.isEmpty){
                          ProjectToast.showErrorToast("valid phone is required");
                        }
        
                        // add country code to phone
                        String? phone = aProvider.addCountryCodeToPhone(_phoneController.text);
        
                        if(phone == null){
                          ProjectToast.showErrorToast("valid phone is required");
                        }
        
                        setState(() {
                            _isLoading = true;
                        });
        
                        final resp = await aProvider.signUp(
                          _firstNameController.text, 
                          _lastNameController.text, 
                          _passwordController.text, 
                          _emailController.text, 
                          phone!
                        );
                        setState(() {
                            _isLoading = false;
                        });
        
                        if(resp){
                          Get.offAll(() => LoginScreen());
                          //aProvider.loginRequest(_emailController.text, _passwordController.text);
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
          color: const Color(0xff464040),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 20,),
                  topContainer(),
          
                  SizedBox(height: 20,),
                  bottomContainer(),
                ],
              ),
          ),
         
        ),
      ),
    );
  }
}