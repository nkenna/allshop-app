import 'package:flutter/material.dart';
class OnboardingButtons extends StatefulWidget {
  double? height = 50;
  double? width = 100;
  Color? color = Color(0xff333333);
  VoidCallback? onPressed;
  bool? isLoading = false;
  String? btnText;
  
  OnboardingButtons({ Key? key, this.height, this.width, this.color, this.isLoading, this.btnText, this.onPressed }) : super(key: key);

  @override
  _OnboardingButtonsState createState() => _OnboardingButtonsState();
}

class _OnboardingButtonsState extends State<OnboardingButtons> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        child: widget.isLoading!
        ? CircularProgressIndicator.adaptive(backgroundColor: Colors.white,)
        
        : Text(widget.btnText!, style: const TextStyle(color: Colors.white),),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(widget.color),
          shape: MaterialStateProperty.all(const StadiumBorder())
        ),
      ),
    );
  }
}