import 'package:ems/models/product.dart';
import 'package:ems/providers/authprovider.dart';
import 'package:ems/providers/productprovider.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MakeOfferModal extends StatefulWidget {
  final Product? product;
  const MakeOfferModal({ Key? key, this.product }) : super(key: key);

  @override
  _MakeOfferModalState createState() => _MakeOfferModalState();
}

class _MakeOfferModalState extends State<MakeOfferModal> {
  TextEditingController detailController = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    detailController.dispose();
    super.dispose();
  }

  Widget detailField(){
    return TextField(
          style: TextStyle(color: Colors.black, fontSize: 12),
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.next,
          controller: detailController,
          minLines: 7,
          maxLines: 10,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Enter your message here',
            hintStyle: TextStyle(color: Color(0xff464040), fontSize: 14, fontWeight: FontWeight.w400),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(
                width: 1, color: Color(0xff464040)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide(
                  width: 1, color: Color(0xff464040)),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                borderSide: BorderSide(
                  width: 1, color: Color(0xff464040)),
                ),
          ),
        );
      
  }

  Widget saveBtn(){
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xff333333))
      ),
      onPressed: () async{
      if(detailController.text.isEmpty){
          ProjectToast.showErrorToast("message content is required");
          return;
        }
      
        setState(() {
          loading = true;
        });

        final resp = await Provider.of<ProductProvider>(context, listen: false).makeOfferMessage(
          widget.product!.id, 
          Provider.of<AuthProvider>(context, listen: false).user!.id, 
          detailController.text
        );
      

         setState(() {
          loading = false;
        });

        if(resp){
          Get.back();
        }
      },
      child: loading
      ? CircularProgressIndicator.adaptive(backgroundColor: Colors.white,)
      : Text('Send', style: TextStyle(color: Colors.white),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        child: Container(
          width: 300,
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Make an Offer", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),),
              Text("${widget.product!.name} - NGN${widget.product!.maxPrice}"),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: detailField(),
              ),

              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                 child: Align(
                  alignment: Alignment.bottomCenter,
                  child: saveBtn(),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}