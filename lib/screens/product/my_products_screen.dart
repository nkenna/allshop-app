import 'package:ems/models/product.dart';
import 'package:ems/providers/authprovider.dart';
import 'package:ems/providers/productprovider.dart';
import 'package:ems/screens/dashboard/landing_screen.dart';
import 'package:ems/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class MyProductsScreen extends StatefulWidget {
  const MyProductsScreen({ Key? key }) : super(key: key);

  @override
  _MyProductsScreenState createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen> {
  //var currencyFormat = NumberFormat.currency(locale: "en_US", symbol: "\u{020A6} ");

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData(){
    Provider.of<ProductProvider>(context, listen: false).getUserProducts(
      Provider.of<AuthProvider>(context, listen: false).user!.id
    );
  }

  Widget productsContainer(Product product){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        width: double.infinity,
        height: Get.height * 0.12,
        color: Colors.white,
        child: Row(
          children: [
            InkWell(
              onTap: (){
                //Get.to(() => ProductScreen());
              },
              child: Container(
                width: Get.width * 0.3,
                decoration: BoxDecoration(
                  image: product.images!.length > 0 && product.images![0] != null
                  ? DecorationImage(
                    image: NetworkImage("${Api.IMAGE_BASE_URL}${product.images![0].imageUrl}")                  
                    //fit: BoxFit.cover
                  )
                  : const DecorationImage(
                    image: AssetImage("assets/images/product.png"),
                    //fit: BoxFit.cover
                  )
                ),
                
                
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
                onTap: (){},
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xff464040),
        body: Container(
          width: Get.width,
          height: Get.height,
          child: Consumer<ProductProvider>(
            builder: (context, bProvider, _) {
              return ListView.builder(
                itemCount: bProvider.userProducts.length,
                itemBuilder: (context, index) {
                  return productsContainer(bProvider.userProducts[index]);
                },
              );
            }
          ),
        ),
      ),
    );
  }
}