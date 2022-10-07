import 'package:ems/models/category.dart';
import 'package:ems/providers/authprovider.dart';
import 'package:ems/providers/productprovider.dart';
import 'package:ems/screens/product/my_products_screen.dart';
import 'package:ems/utils/constants.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:ems/utils/projectcolors.dart';
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

  List<SubCategories>? _subCategories;
  SubCategories? _selectedSubCategory;

  bool loading = false;

  //List<TextEditingController> _socialLinkControllers = List.generate(socials.length, (index) => TextEditingController());
  List<TextEditingController> _socialLinkControllers = [];

  List<Widget> _socialContainers = [];

  List<String> _selectedSocialLinks = [];

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
          decoration: const InputDecoration(
            hintText: "Enter Product name",
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
            hintText: "Enter Product description",
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

  Widget minPriceField(){
    return TextField(
          style: TextStyle(color: Colors.black, fontSize: 12),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          textInputAction: TextInputAction.next,
          controller: minPriceController,
          decoration: const InputDecoration(
            hintText: "Enter Product Minimum price",
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

  Widget maxPriceField(){
    return TextField(
          style: TextStyle(color: Colors.black, fontSize: 12),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          textInputAction: TextInputAction.next,
          controller: maxPriceController,
          decoration: const InputDecoration(
            hintText: "Enter Product maximum price",
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

  Widget linkField(){
    return TextField(
          style: TextStyle(color: Colors.black, fontSize: 12),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          controller: linkController,
          decoration: const InputDecoration(
            hintText: "Enter Product link if any",
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
                    if(_selectedCategory!.subCategories != null && _selectedCategory!.subCategories!.isNotEmpty){
                      _subCategories = _selectedCategory!.subCategories;
                    }else{
                      _subCategories = null;
                    }
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

  Widget selectSubCategories() {
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
              child: DropdownButton<SubCategories>(
                dropdownColor: Colors.white,
                hint: Text("Select Subcategory",
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
                value: _selectedSubCategory,
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
                    _selectedSubCategory = value;
                    
                  });
                },
                isExpanded: true,
                items: _subCategories!.map((value) {
                  return DropdownMenuItem<SubCategories>(
                    value: value,
                    child: Text("${value.name} . ${_selectedCategory!.name}".capitalize!,
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
            ),
          )
      );
    
  }

  Widget socialLinkField(TextEditingController controller, int index){
    return TextField(
          style: TextStyle(color: Colors.black, fontSize: 12),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          controller: controller,
          onChanged: (value){
            //_socialLinkControllers[index].text = value;
          },
          decoration: const InputDecoration(
            hintText: "Enter Product link if any",
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

  Widget selectSocialLinkTitle(String linkPlatform, int index) {
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
              child: DropdownButton<String>(
                dropdownColor: Colors.white,
                hint: Text("Select Link Platform",
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
                value: linkPlatform,
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
                    linkPlatform = value!;
                    _selectedSocialLinks[index] = value;
                   
                  });
                },
                isExpanded: true,
                items: socials.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text("${value}".capitalize!,
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

          if(maxPriceController.text.isEmpty){
            ProjectToast.showErrorToast("max. price is required");
            return;
          }

          if(_selectedCategory == null){
            ProjectToast.showErrorToast("product category is required");
            return;
          }

          // build social link data
          List<Map<String, String>> _socialLinks = [];
          for (var i = 0; i < _selectedSocialLinks.length; i++) {
            if(_selectedSocialLinks[i] != null){
              _socialLinks.add(
                {
                  'linkTitle': _selectedSocialLinks[i],
                  'linkUrl': _socialLinkControllers[i].text
                }
              );
            }
          }  

          print(_socialLinks);
            


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
            _selectedSubCategory != null
            ? _selectedSubCategory!.sId
            : _selectedCategory!.id,
            _socialLinks
          );

           setState(() {
            loading = false;
          });

          if(resp){
            Get.off(() => MyProductsScreen());
          }
        },
        child: loading
        ? CircularProgressIndicator.adaptive(backgroundColor: Colors.white,)
        : Text('Save', style: TextStyle(color: Colors.white, fontFamily: 'SofiaProSemiBold'),),
      ),
    );
  }

  Widget socialLinkContainer(String linkPlatform, TextEditingController controller, int index){
    return Column(
      children: [
        selectSocialLinkTitle(linkPlatform, index),
        SizedBox(height: 5,),
        socialLinkField(controller, index),
        TextButton(
          onPressed: (){
            setState(() {
              _socialLinkControllers.removeAt(index);
              _selectedSocialLinks.removeAt(index);
              _socialContainers.removeAt(index);
            });
          }, 
          child: Text("Remove", style: TextStyle(color: Colors.red, fontSize: 12),)
        ),
        Divider(color: Colors.black,),
      ]
    );
  }
  
  Widget socialLinkContainerList(){
    return Column(
      children: List.generate(_socialContainers.length, (i) 
      => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: socialLinkContainer(_selectedSocialLinks[i], _socialLinkControllers[i], i),
      )
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
          title: Text('Add your Product', style: TextStyle(color: Colors.black),),
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
                    child: minPriceField(),
                  ),
          
                  Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: maxPriceField(),
                  ),

                  Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Add Social Links'),
                        TextButton(
                          onPressed: (){
                            print("added");
                            setState(() {
                              _socialLinkControllers.add(TextEditingController());
                              _selectedSocialLinks.add(socials.first);
                              _socialContainers.add(
                                socialLinkContainer(
                                  _selectedSocialLinks.last,
                                  _socialLinkControllers.last,
                                  _selectedSocialLinks.length - 1
                                )
                              );
                            });

                            print(_socialContainers.length);
                          }, 
                          child: Text('Add')
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: socialLinkContainerList(),
                  ),
          
                  /*Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: linkField(),
                  ),*/

                  if(_categories != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: selectCategory(),
                    ),

                  if(_subCategories != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: selectSubCategories(),
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