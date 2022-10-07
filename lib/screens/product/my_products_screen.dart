import 'dart:io';

import 'package:ems/models/product.dart';
import 'package:ems/providers/authprovider.dart';
import 'package:ems/providers/productprovider.dart';
import 'package:ems/screens/dashboard/landing_screen.dart';
import 'package:ems/screens/product/edit_product_screen.dart';
import 'package:ems/utils/api.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:ems/utils/projectcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class MyProductsScreen extends StatefulWidget {
  const MyProductsScreen({ Key? key }) : super(key: key);

  @override
  _MyProductsScreenState createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen> {
  final InAppReview _inAppReview = InAppReview.instance;
  final ImagePicker _picker = ImagePicker();
   bool loadingImage = false;
  //var currencyFormat = NumberFormat.currency(locale: "en_US", symbol: "\u{020A6} ");
  Future<List<Product>?>? _futureProducts;

  @override
  void initState() {
    super.initState();
     initData();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
     
      requestForReview();
      

    });
    
  }

  initData(){
    _futureProducts = Provider.of<ProductProvider>(context, listen: false).getUserProducts(
      Provider.of<AuthProvider>(context, listen: false).user!.id
    );
    setState(() {});
  }

  requestForReview() async{
    if(Platform.isAndroid){
      try {
        final isAvailable = await _inAppReview.isAvailable();

        if(isAvailable){
          _inAppReview.requestReview();
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Widget productsContainer(Product product){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: Container(
          width: double.infinity,
          height: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.white
          ),
          child: Column(
            children: [
              Container(
                height: 80,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async{
                        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                            if(image != null){
                               File? croppedFile = await ImageCropper().cropImage(
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
      
                              if(croppedFile != null){
                                // upload to server
                                Map<String, dynamic> data = {};
                                data['userId'] = Provider.of<AuthProvider>(context, listen: false).user!.id;
                                data['productId'] = product.id;
                                setState(() => loadingImage = true);
                                var resp = await Provider.of<ProductProvider>(context, listen: false).editProductImageRequest(
                                  croppedFile,
                                  data, 
                                  Provider.of<AuthProvider>(context, listen: false).user!.id!, 
                                  
                                );
                                setState(() => loadingImage = false);
      
                                if(resp){
                                  initData();
                                }
                              }
                          
                            }
                      },
                      child: Container(
                        width: Get.width * 0.3,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                          image: product.images!.length > 0 && product.images![0] != null
                          ? DecorationImage(
                            image: NetworkImage("${Api.IMAGE_BASE_URL}${product.images![0].imageUrl}"),               
                            fit: BoxFit.cover
                          )
                          : const DecorationImage(
                            image: AssetImage("assets/images/product.png"),
                            fit: BoxFit.cover
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: (){
                                //Get.to(() => ProductScreen());
                              },
                              child: Text("${product.name}".capitalize!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff333333)),)),
                           
                            Row(
                              children: [
                                Icon(Icons.store, color: Color(0xff333333)),
                                Text("${product.business!.name}".capitalize!, style: TextStyle(fontSize: 14, color: Color(0xff333333)),),
                              ],
                            ),
      
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(product.minPrice > 0
                                      ? "from NGN ${product.minPrice}"
                                      : "NGN ${product.maxPrice}", style: TextStyle(fontSize: 12, color: Color(0xff333333)),),
                                //Text("Contact", style: TextStyle(fontSize: 14, color: Color(0xff333333)),),
                                InkWell(
                                  onTap: (){},
                                  child: Icon(MdiIcons.heartOutline, color: Colors.red,),
                                )
                              ],
                            ),
      
                            
                          ],
                        ),
                      ),
                    ),
      
                    SizedBox(width: 10,),
                  ],
                ),
              ),
      
               Expanded(
                 child: Row(
                    children: [
                      Expanded(child: InkWell(
                        onTap: (){
                          Get.to(() => EditProductScreen(userId: Provider.of<AuthProvider>(context, listen: false).user!.id, product: product,));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
                          color: Color(0xfffa5656),
                        ),
                          alignment: Alignment.center,
                          child: Text("Edit Product", style: TextStyle(fontSize: 12, color: Colors.white))),
                      )),
               
                      /*Expanded(child: InkWell(
                        onTap: (){
                         //Get.to(() => AddServiceScreen(businessId: business.id,));
                        },
                        child: Container(
                          color: Colors.blue,
                          alignment: Alignment.center,
                          child: Text("Add Service", style: TextStyle(fontSize: 12, color: Colors.white))),
                      )),*/
                           
                      Expanded(child: InkWell(
                        onTap: (){
                          ProjectToast.showNormalToast("Feature is coming soon");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(8)),
                          color: Color(0xff5fe42c),
                        ),
                          alignment: Alignment.center,
                          child: Text("Promote", style: TextStyle(fontSize: 12, color: Colors.black))),
                      )),
               
                      
                    ],
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
        appBar: AppBar(
          
          iconTheme: IconThemeData(
            color: mainColor
          ),
          title: Text('My Products', style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white,
          
        ),
        backgroundColor: Colors.white,
        body: Container(
          width: Get.width,
          height: Get.height,
          child: Column(
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 400),
                child: loadingImage
                  ? LinearProgressIndicator(valueColor: AlwaysStoppedAnimation(Color(0xff30b85a),),)
                  : SizedBox(height: 0,)),
              Expanded(
                child: FutureBuilder<List<Product>?>(
                  future: _futureProducts,
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                        child: CircularProgressIndicator.adaptive(backgroundColor: Colors.white,),
                      );
                    }
                    else if(snapshot.hasError){
                      return Center(
                        child: Text('Ouchs!!!, error getting data', style: TextStyle(color: Colors.white),),
                      );                
                    }
                    else if(snapshot.hasData){
                      return snapshot.data!.isEmpty
                      ? Center(
                        child: Text('Ouchs!!!, No products yet', style: TextStyle(color: Colors.white),),
                      )
                      : RefreshIndicator(
                        onRefresh: (){
                          initData();
                          return Future.value();
                        },
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return productsContainer(snapshot.data![index]);
                            },
                          ),
                      );
                    }
                    else {
                      return Center(
                        child: Text('Ouchs!!!, error getting data..', style: TextStyle(color: Colors.white),),
                      );
                      
                    }
                    
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}