import 'package:ems/models/home_product.dart';
import 'package:ems/models/product.dart';
import 'package:ems/providers/authprovider.dart';
import 'package:ems/providers/homeprovider.dart';
import 'package:ems/providers/productprovider.dart';
import 'package:ems/screens/plaza/product_screen.dart';
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

   Widget productContainer(Product product){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 5,
        child: Container(
          width: double.infinity,
          height: 120,
          color: Colors.white,
          child: Row(
            children: [
              InkWell(
                onTap: (){
                  Get.to(() => ProductScreen(productId: product.id));
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
                          Get.to(() => ProductScreen(productId: product.id));
                        },
                        child: Text("${product.name}".capitalize!, maxLines: 3, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff333333)),)),
                     
                      Row(
                        children: [
                          Icon(Icons.store, color: Color(0xff30b85a)),
                          SizedBox(width: 5,),
                          Expanded(child: Text("${product.business!.name ?? ''}".capitalize!, maxLines: 1, style: TextStyle(fontSize: 14, color: Color(0xff333333)),)),
                        ],
                      ),
      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                         // Text("NGN ${product.maxPrice ?? 0.0}", style: TextStyle(fontSize: 14, color: Color(0xff333333)),),
                          //Text("Contact", style: TextStyle(fontSize: 14, color: Color(0xff333333)),),
                          InkWell(
                            onTap: () async{
                              var resp = await Provider.of<ProductProvider>(context, listen: false).starUnstarProduct(
                                  Provider.of<AuthProvider>(context, listen: false).user!.id,
                                  product.id,
                                  product.starred == true ? false : true
                              );
      
                              if(resp){
                                //_future = Provider.of<ProductProvider>(context, listen: false).getStarredProductsByUser(Provider.of<AuthProvider>(context, listen: false).user!.id);
                                //setState(() {});
                              }
                            },
                            child: Icon(product.starred == true ? MdiIcons.heart : MdiIcons.heartOutline, color: Colors.red,),
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
      ),
    );
  }
  

   @override
  Widget build(BuildContext context) {
    print("len::::: ${Provider.of<HomeProvider>(context, listen: false).searchProducts.length}");
    return Consumer<HomeProvider>(
      builder: (context, hProvider,_) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: hProvider.searchProducts.isEmpty
          ? Center(
            child: Text('No Products found'),
          )
          : ListView.builder(
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