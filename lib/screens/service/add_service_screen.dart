import 'package:ems/providers/authprovider.dart';
import 'package:ems/providers/serviceprovider.dart';
import 'package:ems/screens/service/my_services_screen.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:ems/utils/projectcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../models/category.dart';

class AddServiceScreen extends StatefulWidget {
  final String? businessId;
  const AddServiceScreen({ Key? key, this.businessId }) : super(key: key);

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  List<Category>? _categories = [];
  Category? _selectedCategory;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    Provider.of<AuthProvider>(context, listen: false).getCategoriesByType("service")
    .then((value) {
      if(value != null){
        _categories = value;
        setState(() {});
      }
      
    });
    
  }

  @override
  void dispose() {
    nameController.dispose();
    detailController.dispose();
    super.dispose();
  }
  
  
  Widget nameField(){
    return TextField(
          style: TextStyle(color: Colors.black, fontSize: 12),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          controller: nameController,
          decoration: const InputDecoration(
            hintText: "Enter Service name",
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
            hintText: 'Enter Service description. Remember to add some finance details of your service',
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


  Widget selectCategory() {
    return SizedBox(
          height: Get.height * 0.062,
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xffbcd3e3), width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<Category>(
                dropdownColor: Colors.white,
                hint: Text("Select Service Category",
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
                value: _selectedCategory,
                icon: Icon(
                  Icons.arrow_drop_down, color: Color(0xff464040), size: 32,),
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
            ProjectToast.showErrorToast("name is required");
            return;
          }

          if(detailController.text.isEmpty){
            ProjectToast.showErrorToast("service description is required");
            return;
          }


        

          if(_selectedCategory == null){
            ProjectToast.showErrorToast("product category is required");
            return;
          }        


          setState(() {
            loading = true;
          });

          final resp = await Provider.of<ServiceProvider>(context, listen: false).addService(
            nameController.text,
            detailController.text,
            widget.businessId,
            Provider.of<AuthProvider>(context, listen: false).user!.id,
            _selectedCategory!.id
          );

           setState(() {
            loading = false;
          });

          if(resp){
            Get.off(() => MyServicesScreen());
          }
          
        },
         child: loading
        ? CircularProgressIndicator.adaptive(backgroundColor: Colors.white,)
        : Text('Save', style: TextStyle(color: Colors.white, fontFamily: 'SofiaProSemiBold'),),
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
          title: Text('Add a Service', style: TextStyle(color: Colors.black),),
        ),
        
        backgroundColor: Colors.white,
        body: Container(
           width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
            //borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Scrollbar(
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
                    child: selectCategory(),
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
      ),
    );
  }
}