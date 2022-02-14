import 'dart:io';

import 'package:ems/models/business.dart';
import 'package:ems/providers/authprovider.dart';
import 'package:ems/providers/businessprovider.dart';
import 'package:ems/screens/business/select_plazas_screen.dart';
import 'package:ems/screens/dashboard/landing_screen.dart';
import 'package:ems/screens/product/add_product_screen.dart';
import 'package:ems/utils/api.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class MyBusinessScreen extends StatefulWidget {
  const MyBusinessScreen({ Key? key }) : super(key: key);

  @override
  _MyBusinessScreenState createState() => _MyBusinessScreenState();
}

class _MyBusinessScreenState extends State<MyBusinessScreen> {
  final ImagePicker _picker = ImagePicker();
  
  @override
  void initState() {
    super.initState();
    initData();
  }

  initData(){
    Provider.of<BusinessProvider>(context, listen: false).getUserBusinesses(
      Provider.of<AuthProvider>(context, listen: false).user!.id
    );
  }

  Widget businessContainer(Business business){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        width: double.infinity,
        height: 110,
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () async{
                    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                    if(image != null){
                       File? croppedFile = await ImageCropper.cropImage(
                        sourcePath: image.path,
                        aspectRatioPresets: [
                          CropAspectRatioPreset.square,
                          CropAspectRatioPreset.ratio3x2,
                          CropAspectRatioPreset.original,
                          CropAspectRatioPreset.ratio4x3,
                          CropAspectRatioPreset.ratio16x9
                        ],
                        androidUiSettings: AndroidUiSettings(
                            toolbarTitle: 'Crop Image',
                            toolbarColor: Colors.deepOrange,
                            toolbarWidgetColor: Colors.white,
                            initAspectRatio: CropAspectRatioPreset.original,
                            lockAspectRatio: false),
                        iosUiSettings: IOSUiSettings(
                          title: 'Crop Image',
                          minimumAspectRatio: 1.0,
                        )
                      );
                  
                    }
                   
                  },
                  child: Container(
                    width: Get.width * 0.3,
                    height: 80,
                    decoration: BoxDecoration(
                      image:  business.image != null
                      ? DecorationImage(
                        image: NetworkImage("${Api.IMAGE_BASE_URL}${business.image!.imageUrl}")                  
                        //fit: BoxFit.cover
                      )
                      : const DecorationImage(
                        image: AssetImage("assets/images/business.png"),
                        //fit: BoxFit.cover
                      )
                    ),
                    child: Icon(Icons.camera)
                    
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            //Get.to(() => ProductScreen());
                          },
                          child: Text("${business.name}".capitalize!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff333333)),)),
                       
                        Row(
                          children: [
                            Icon(Icons.store, color: Color(0xff333333)),
                            Text("${business.plaza!.name}".capitalize!, style: TextStyle(fontSize: 14, color: Color(0xff333333)),),
                          ],
                        ),

                                 
                        
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 10,),
              ],
            ),

            Expanded(
              child: Row(
                children: [
                  Expanded(child: InkWell(
                    onTap: (){
                      Get.to(() => AddProductScreen(businessId: business.id,));
                    },
                    child: Container(
                      color: Color(0xfffa5656),
                      alignment: Alignment.center,
                      child: Text("Add Product", style: TextStyle(fontSize: 12, color: Colors.white))),
                  )),
            
                  Expanded(child: InkWell(
                    onTap: (){
                      ProjectToast.showNormalToast("Feature is coming soon");
                    },
                    child: Container(
                      color: Color(0xff5fe42c),
                      alignment: Alignment.center,
                      child: Text("Promote", style: TextStyle(fontSize: 12, color: Colors.black))),
                  )),

                  
                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Get.to(() => LandingScreen(screen: 3)),
            child: Icon(Icons.arrow_back),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () => Get.to(() => SelectPlazasScreen()),
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xff464040),
        body: Container(
          width: Get.width,
          height: Get.height,
          child: Consumer<BusinessProvider>(
            builder: (context, bProvider, _) {
              return ListView.builder(
                itemCount: bProvider.userStores.length,
                itemBuilder: (context, index) {
                  return businessContainer(bProvider.userStores[index]);
                },
              );
            }
          ),
        ),
      ),
    );
  }
}