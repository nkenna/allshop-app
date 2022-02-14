import 'package:ems/models/category.dart';
import 'package:ems/providers/authprovider.dart';
import 'package:ems/providers/productprovider.dart';
import 'package:ems/screens/product/my_products_screen.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  String? businessId;
  AddProductScreen({ Key? key, this.businessId }) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  
  TextEditingController nameController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  List<Category>? _categories;
  Category? _selectedCategory;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    Provider.of<AuthProvider>(context, listen: false).getCategoriesByType("product")
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
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Enter Product Name',
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
            fillColor: Colors.white,
            filled: true,
            hintText: 'Enter Product details',
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

  Widget minPriceField(){
    return TextField(
          style: TextStyle(color: Colors.black, fontSize: 12),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          textInputAction: TextInputAction.next,
          controller: minPriceController,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Enter Product Minimum Price',
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

  Widget maxPriceField(){
    return TextField(
          style: TextStyle(color: Colors.black, fontSize: 12),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          textInputAction: TextInputAction.next,
          controller: maxPriceController,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Enter Product Maxmium Price',
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

  Widget linkField(){
    return TextField(
          style: TextStyle(color: Colors.black, fontSize: 12),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          controller: linkController,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: 'Enter Product Url',
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
                hint: Text("Select Product Category",
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
          ProjectToast.showErrorToast("name is required");
          return;
        }

        if(maxPriceController.text.isEmpty){
          ProjectToast.showErrorToast("max. price is required");
          return;
        }

        if(_selectedCategory == null){
          ProjectToast.showErrorToast("product category is required");
          return;
        }        


        setState(() {
          loading = true;
        });

        final resp = await Provider.of<ProductProvider>(context, listen: false).addProduct(
          nameController.text,
          detailController.text,
          minPriceController.text.isEmpty ? 0.0 : double.tryParse(minPriceController.text),
          double.tryParse(maxPriceController.text),
          linkController.text,
          widget.businessId,
          Provider.of<AuthProvider>(context, listen: false).user!.id,
          _selectedCategory!.id
        );

         setState(() {
          loading = false;
        });

        if(resp){
          Get.offAll(() => MyProductsScreen());
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
          title: Text("Add a Product"),
        ),
        backgroundColor: const Color(0xff464040),
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
                    child: minPriceField(),
                  ),
          
                  Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: maxPriceField(),
                  ),
          
                  Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: linkField(),
                  ),

                  Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: selectState(),
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