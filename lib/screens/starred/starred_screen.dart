import 'package:ems/models/product.dart';
import 'package:ems/models/starred_product.dart';
import 'package:ems/providers/authprovider.dart';
import 'package:ems/providers/productprovider.dart';
import 'package:ems/screens/plaza/product_screen.dart';
import 'package:ems/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class StarredScreen extends StatefulWidget {
  const StarredScreen({ Key? key }) : super(key: key);

  @override
  _StarredScreenState createState() => _StarredScreenState();
}

class _StarredScreenState extends State<StarredScreen> {

  Future<List<StarredProduct>?>? _future;

  @override
  void initState() {
    super.initState();
    _future = Provider.of<ProductProvider>(context, listen: false).getStarredProductsByUser(Provider.of<AuthProvider>(context, listen: false).user!.id);
  }

  Widget productsContainer(StarredProduct sProduct){
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
                Get.to(() => ProductScreen(productId: sProduct.product!.sId,));
              },
              child: Container(
                width: Get.width * 0.3,
                decoration: BoxDecoration(
                  image: sProduct.product!.images!.length > 0 && sProduct.product!.images![0] != null
                  ? DecorationImage(
                    image: NetworkImage("${Api.IMAGE_BASE_URL}${sProduct.product!.images![0].imageUrl}"),              
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
                        Get.to(() => ProductScreen(productId: sProduct.product!.sId,));
                      },
                      child: Text("${sProduct.product!.name}".capitalize!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff333333)),)),
                   
                    Row(
                      children: [
                        Icon(Icons.store, color: Color(0xff333333)),
                        Expanded(child: Text("${sProduct.product!.business!.name}", maxLines: 2, style: TextStyle(fontSize: 14, color: Color(0xff333333)),)),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("NGN ${sProduct.product!.maxPrice}", style: TextStyle(fontSize: 14, color: Color(0xff333333)),),
                        //Text("Contact", style: TextStyle(fontSize: 14, color: Color(0xff333333)),),
                        InkWell(
                          onTap: () async{
                            var resp = await Provider.of<ProductProvider>(context, listen: false).starUnstarProduct(
                              Provider.of<AuthProvider>(context, listen: false).user!.id, 
                              sProduct.product!.sId, 
                              false
                            );

                            if(resp){
                              _future = Provider.of<ProductProvider>(context, listen: false).getStarredProductsByUser(Provider.of<AuthProvider>(context, listen: false).user!.id);
                              setState(() {});
                            }
                          },
                          child: Icon(MdiIcons.closeBox, color: Colors.red,),
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
      child: Container(
        width: Get.width,
        height: Get.height,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 30,),
            Text("Your Starred Products", style: TextStyle(color: Colors.black, fontFamily: 'SofiaProMedium', fontSize: 16),),
            SizedBox(height: 20,),
            Expanded(
              child: FutureBuilder(
                    future: _future,
                    builder: (BuildContext context, AsyncSnapshot<List<StarredProduct>?> snapshot) {

                      if(snapshot.hasData){
                        print(snapshot.data!.length);
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, i){
                            return productsContainer(snapshot.data![i]);
                          },
                        );
                      }else if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator.adaptive(backgroundColor: Colors.white));
                      }
                      
                      else{
                        print(snapshot.data);
                        return Container();
                      }
                    },
                  ),
            ),
          ],
        )
      ),
    );
  }
}