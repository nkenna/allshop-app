import 'package:ems/models/category.dart';
import 'package:ems/providers/authprovider.dart';
import 'package:ems/providers/businessprovider.dart';
import 'package:ems/screens/business/my_business_screen.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:ems/utils/projectcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddBusinessScreen extends StatefulWidget {
  final String? plazaId;
  const AddBusinessScreen({ Key? key, this.plazaId }) : super(key: key);

  @override
  _AddBusinessScreenState createState() => _AddBusinessScreenState();
}

class _AddBusinessScreenState extends State<AddBusinessScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController contactPhoneController = TextEditingController();
  List<Category>? _categories = [];
  Category? _selectedCategory;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    Provider.of<AuthProvider>(context, listen: false).getCategoriesByType("business")
    .then((value) {
      if(value != null){
        _categories = value;
        setState(() {});
      }
      
    });
    
  }

  Widget nameField(){
    return TextField(
          style: const TextStyle(color: Colors.black, fontSize: 12),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          controller: nameController,
          decoration: const InputDecoration(
          hintText: "Enter Business/Store name",
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
          //prefixIcon: Icon(MdiIcons.email, color: Color(0xff333333),)
        ),
        );
      
  }

  Widget detailField(){
    return TextField(
          style: TextStyle(color: Colors.black, fontSize: 12),
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.next,
          controller: detailController,
          minLines: 7,
          maxLines: 10,
          decoration: const InputDecoration(
          hintText: "Enter short Business/Store description",
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
          //prefixIcon: Icon(MdiIcons.email, color: Color(0xff333333),)
        ),
        );
      
  }

  Widget selectState() {
    return SizedBox(
          height: Get.height * 0.062,
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xffbcd3e3), width: 2),
                //borderRadius: BorderRadius.all(Radius.circular(15), )
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<Category>(
                dropdownColor: Colors.white,
                hint: Text("Select Business Category",
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
                value: _selectedCategory,
                icon: Icon(
                  Icons.arrow_drop_down, color: Color(0xff464040), size: 28,),
                elevation: 10,
                style: TextStyle(fontSize: 12, color: Colors.white),
                underline: Container(
                  height: 1,
                  color: Colors.transparent,
                ),
                onChanged: (value) {
                  setState(() {
                    print(value);
                    _selectedCategory = value;
                  });
                },
                isExpanded: true,
                items: _categories!.map((value) {
                  return DropdownMenuItem<Category>(
                    value: value,
                    child: Text("${value.name}".capitalize!,
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
            ),
          )
      );
    
  }

  
  Widget saveBtn(){
    return SizedBox(
      width: Get.width,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xff30b85a))
        ),
        onPressed: () async{
          if(nameController.text.isEmpty){
            ProjectToast.showErrorToast("Business Name is required");
            return;
          }

          if(_selectedCategory == null){
            ProjectToast.showErrorToast("Business category is required");
            return;
          }

          setState(() {
            loading = true;
          });

          final resp = await Provider.of<BusinessProvider>(context, listen: false).addBusinessRequest(
            nameController.text,
            detailController.text,
            widget.plazaId,
            Provider.of<AuthProvider>(context, listen: false).user!.id,
            _selectedCategory!.id,
            addressController.text,
            contactPhoneController.text
          );

           setState(() {
            loading = false;
          });

          if(resp){
            
            Get.offAll(() => MyBusinessScreen());

          }
        },
        child: loading
        ? CircularProgressIndicator.adaptive(backgroundColor: Colors.white,)
        : Text('Save', style: TextStyle(color: Colors.white, fontFamily: 'SofiaProSemiBold'),),
      ),
    );
  }

  Widget addressField(){
    return TextField(
          style: const TextStyle(color: Colors.black, fontSize: 12),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          controller: addressController,
          decoration: const InputDecoration(
          hintText: "Business/Store suite/number",
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
          //prefixIcon: Icon(MdiIcons.email, color: Color(0xff333333),)
        ),
        );
      
  }


  Widget contactPhoneField(){
    return TextField(
          style: const TextStyle(color: Colors.black, fontSize: 12),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          controller: contactPhoneController,
          decoration: const InputDecoration(
          hintText: "Contact Phone Number",
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
          //prefixIcon: Icon(MdiIcons.email, color: Color(0xff333333),)
        ),
        );
      
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: mainColor
          ),
          backgroundColor: Colors.white,
          title: Text('Add Business/Store', style: TextStyle(color: Colors.black),),
        ),
        
        backgroundColor: Colors.white,
        body: Container(
          width: Get.width,
          height: Get.height,
          
          child: SingleChildScrollView(
            child: Column(
              children: [
                
                Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: nameField(),
                ),

                Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: detailField(),
                ),

                Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: addressField(),
                ),

                Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: contactPhoneField(),
                ),

                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: selectState()
                ),

                Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: saveBtn(),
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