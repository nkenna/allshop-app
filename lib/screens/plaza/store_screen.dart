import 'package:ems/models/business.dart' as bs;
import 'package:ems/models/product.dart';
import 'package:ems/providers/authprovider.dart';
import 'package:ems/providers/plazaprovider.dart';
import 'package:ems/providers/productprovider.dart';
import 'package:ems/providers/storeprovider.dart';
import 'package:ems/screens/plaza/product_screen.dart';
import 'package:ems/utils/api.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class StoreScreen extends StatefulWidget {
  final bs.Business? storeData;
  const StoreScreen({ Key? key, this.storeData }) : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    Provider.of<StoreProvider>(context, listen: false).getStoreProducts(widget.storeData!.id, 1);
    //Provider.of<StoreProvider>(context, listen: false).getStoreProducts(widget.storeData!.id, 1);
  }

  Widget topBox(){
    return Material(
      type: MaterialType.card,
      elevation: 20,
      child: Container(
        width: double.infinity,
        height: Get.height * 0.07,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: InkWell(
                onTap: () => Get.back(),
                child: Icon(MdiIcons.arrowLeft, color: Color(0xff333333),),
              ),
            ),
            SizedBox(width: 30,),
            Expanded(
              child: TextField(
                  style: const TextStyle(color: Color(0xff333333), fontSize: 14),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Search for something",
                    border: InputBorder.none,
                  ),
                ),
            ),
            SizedBox(width: 30,),

             Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {},
                child: Icon(MdiIcons.star, color: Color(0xffE5E5E5),),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget infoContainer(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        width: double.infinity,
        height: Get.height * 0.12,
        //color: Colors.blue,
        child: Row(
          children: [
            Container(
              width: Get.width * 0.3,
              height: double.infinity,
              decoration: BoxDecoration(
                //color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                image: widget.storeData!.image != null
                      ? DecorationImage(
                        image: NetworkImage("${Api.IMAGE_BASE_URL}${widget.storeData!.image!.imageUrl}"),                 
                        fit: BoxFit.cover
                      )
                      : const DecorationImage(
                        image: AssetImage("assets/images/business.png"),
                        fit: BoxFit.cover
                      )
              ),
              
              
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text("${
                      widget.storeData != null
                      ? widget.storeData!.name != null
                        ? widget.storeData!.name
                        : ""
                      : "" 
                    }", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),),
                   

                   SizedBox(
                     width: 120,
                     child: ElevatedButton(
                       style: ButtonStyle(
                         backgroundColor: MaterialStateProperty.all(Color(0xff30b85a))
                       ),
                       onPressed: (){
                        ProjectToast.showNormalToast("feature is coming soon");
                       },
                       child: Text("View on Map", style: TextStyle(color: Colors.white),),
                     ),
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

  
  
 
  Widget newProductContainer(Product product){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: (){
          Get.to(() => ProductScreen(productId: product.id,));
        },
        child: Container(
          width: Get.width,
          height: 250,
          decoration: BoxDecoration(
            //color: Colors.green,
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.orange,
                    image:  product.images!.length > 0 && product.images![0] != null
                        ? DecorationImage(
                        image: NetworkImage("${Api.IMAGE_BASE_URL}${product.images![0].imageUrl}"),
                        fit: BoxFit.cover
                    )
                        : const DecorationImage(
                      image: AssetImage("assets/images/product.png"),
                        fit: BoxFit.cover
                    ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${product.category!.name}', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, fontFamily: 'SofiaProSemiBold', color: Color(0xff333656)),),
                    Text('${product.name}', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, fontFamily: 'SofiaProSemiBold', color: Color(0xff333656)),),
                    SizedBox(height: 10,),
                    Text('${product.detail}', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, fontFamily: 'SofiaProSemiBold', color: Color(0xff333656)),),
                    if(product.minPrice > 0)
                      Text('from NGN ${product.minPrice }', style: TextStyle(fontSize: 14, color: Colors.black)),
                    //Text('${product.minPrice}', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, fontFamily: 'SofiaProSemiBold', color: Color(0xff333656)),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget productsContainerHolder(){
    return Consumer<StoreProvider>(
      builder: (context, pProvider, _) {
        return pProvider.plazaProducts.isEmpty
        ? Container(
              width: double.infinity,
              height: 100,
              alignment: Alignment.center,
              child: Text("No Products/Items have been added under this store", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100, color: Colors.black,),),
          )
        : Column(
          children: List.generate(pProvider.plazaProducts.length, (index) => newProductContainer(pProvider.plazaProducts[index])),
        );
      }
    );
  }
  
  Widget dataContainer(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /*SizedBox(
            width: 100,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(StadiumBorder())
              ),
              onPressed: (){},
              child: Text("Follow", style: TextStyle(color: Color(0xff333333)),),
            ),
          ),*/

          Row(
            children: [
              RichText(
                text: TextSpan(
                  text: "Products: ",
                  style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: "${Provider.of<StoreProvider>(context, listen: true).totalProducts}",
                      style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.normal),
                    )
                  ]
                ),
              ),
              SizedBox(width: 20,),

              /*RichText(
                text: TextSpan(
                  text: "Followers: ",
                  style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: "450",
                      style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.normal),
                    )
                  ]
                ),
              ),*/
            ],
          ),

       

          
        ],
      ),
    );
  }
 
 
 Widget middleText(){
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text("Items found in ${widget.storeData!.name}",
      maxLines: 1,
        style: TextStyle(color: Color(0xff4f4f4f), fontSize: 16, fontFamily: 'SofiaProMedium'),
      ),
    );
  }
  
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.storeData!.name}', style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back, color: Colors.black,),
          ),
        ),
        backgroundColor: Color(0xfff8f6f2),
        body: Container(
          width: Get.width,
          height: Get.height,
          child: Column(
            children: [
             
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      infoContainer(),
                      dataContainer(),
                      SizedBox(height: 10,),
                      SizedBox(height: 20,),

                      middleText(),

                      productsContainerHolder(),
                    
                      
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}