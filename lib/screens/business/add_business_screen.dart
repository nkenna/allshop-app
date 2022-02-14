import 'package:ems/models/category.dart';
import 'package:ems/providers/authprovider.dart';
import 'package:ems/providers/businessprovider.dart';
import 'package:ems/screens/business/my_business_screen.dart';
import 'package:ems/utils/project_toast.dart';
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
          style: TextStyle(color: Colors.black, fontSize: 12),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          controller: nameController,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Enter Business Name',
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

  Widget detailField(){
    return TextField(
          style: TextStyle(color: Colors.black, fontSize: 12),
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.next,
          controller: detailController,
          minLines: 7,
          maxLines: 10,
          decoration: InputDecoration(
            hintText: 'Enter Business details',
            fillColor: Colors.white,
            filled: true,
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

  Widget selectState() {
    return SizedBox(
          height: Get.height * 0.062,
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color(0xff464040), width: 2),
                borderRadius: BorderRadius.all(Radius.circular(15), )
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
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white)
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
          _selectedCategory!.id
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
      : Text('Save', style: TextStyle(color: Color(0xff333333)),),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add New Business/Store"),
        ),
        backgroundColor: const Color(0xff464040),
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