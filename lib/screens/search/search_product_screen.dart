import 'package:ems/models/home_product.dart';
import 'package:ems/providers/homeprovider.dart';
import 'package:ems/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({ Key? key }) : super(key: key);

  @override
  _SearchProductScreenState createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {

   Widget productContainer(HomeProduct product){
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
                    image: NetworkImage("${Api.IMAGE_BASE_URL}${product.images![0].imageUrl}"),              
                    fit: BoxFit.cover
                  )
                  : const DecorationImage(
                    image: AssetImage("assets/images/product.png"),
                    fit: BoxFit.cover
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
                        Text("".capitalize!, style: TextStyle(fontSize: 14, color: Color(0xff333333)),),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("NGN ${product.maxPrice}", style: TextStyle(fontSize: 14, color: Color(0xff333333)),),
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
    return Consumer<HomeProvider>(
      builder: (context, hProvider,_) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: ListView.builder(
            itemCount: hProvider.searchProducts.length,
            shrinkWrap: true,
            itemBuilder: (context, i){
              return productContainer(hProvider.searchProducts[i]);
            },
          ),
        );
      }
    );
  }

}