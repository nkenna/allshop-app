import 'package:ems/models/business.dart';
import 'package:ems/models/product.dart' as pr;
import 'package:ems/providers/authprovider.dart';
import 'package:ems/providers/homeprovider.dart';
import 'package:ems/providers/plazaprovider.dart';
import 'package:ems/providers/productprovider.dart';
import 'package:ems/screens/plaza/product_screen.dart';
import 'package:ems/screens/plaza/store_screen.dart';
import 'package:ems/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart' as scheduler;

class PlazaScreen extends StatefulWidget {
  final String? plazaId;
  String? name;
  PlazaScreen({ Key? key, this.plazaId, this.name }) : super(key: key);

  @override
  _PlazaScreenState createState() => _PlazaScreenState();
}

class _PlazaScreenState extends State<PlazaScreen> {
  

  @override
  void initState() {
    super.initState();
    scheduler.SchedulerBinding.instance!.addPostFrameCallback((_) {
      initData();
    });
    
  }

  initData() async {
    await Provider.of<PlazaProvider>(context, listen: false).getPlaza(widget.plazaId);
    Provider.of<PlazaProvider>(context, listen: false).getPlazaBusinesses(widget.plazaId, 1);
    Provider.of<PlazaProvider>(context, listen: false).getPlazaProducts(widget.plazaId, 1);
  }

  Widget topText(){
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text("Stores",
        style: TextStyle(color: Color(0xff4f4f4f), fontSize: 16, fontFamily: 'SofiaProMedium'),
      ),
    );
  }

  Widget middleText(){
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text("Items found in ${widget.name}",
        style: TextStyle(color: Color(0xff4f4f4f), fontSize: 16, fontFamily: 'SofiaProMedium'),
      ),
    );
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
                    hintText: "Search for something in Banex Plaza",
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

  Widget newStoreContainer(Business business){
    return InkWell(
      onTap: (){
        Get.to(() => StoreScreen(storeData: business));
      },
      child: Container(
        width: 175,
        //height: 110,
        decoration: BoxDecoration(
          //color: Colors.green,
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  image: business.image != null
                      ? DecorationImage(
                      image: NetworkImage("${Api.IMAGE_BASE_URL}${business.image!.imageUrl != null ? business.image!.imageUrl : ""}") ,
                      fit: BoxFit.cover
                  )
                      : const DecorationImage(
                      image: AssetImage("assets/images/business.png"),
                      fit: BoxFit.cover
                  )
              ),
            ),
            Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                //color: Colors.orange
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text('${business.name ?? ''}', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, fontFamily: 'SofiaProSemiBold', color: Color(0xff333656)),),
                  SizedBox(height: 3,),
                  Text('${business.detail ?? ''} ', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: Colors.black)),
                  SizedBox(height: 3,),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget newRecentStoreContainerList(){
    return SizedBox(
      height: 210,
      child: Padding(
        padding: const EdgeInsets.symmetric( vertical: 10),
        child: Consumer<PlazaProvider>(
            builder: (context, pProvider, _) {
             // print(hProvider.homeStoreData.length);
              return AnimatedSwitcher(
                duration: Duration(milliseconds: 400),
                child: pProvider.plazaBusinesses.isEmpty
                  ? Container(
                  width: double.infinity,
                  height: 100,
                  alignment: Alignment.center,
                  child: Text("No Store/Business have been added under this Plaza", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100, color: Colors.white54,),),
                )
                : ListView.builder(
                  itemCount: pProvider.plazaBusinesses.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: newStoreContainer(pProvider.plazaBusinesses[index]),
                    );
                  },
                )
              );
            }
        ),
      ),

    );
  }

  
  
  Widget newProductContainer(pr.Product product){
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
    return Consumer<PlazaProvider>(
      builder: (context, pProvider, _) {
        return pProvider.plazaProducts.isEmpty
        ? Container(
              width: double.infinity,
              height: 100,
              alignment: Alignment.center,
              child: Text("No Products/Items have been added under this Plaza", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100, color: Colors.white54,),),
          )
        : Column(
          children: List.generate(pProvider.plazaProducts.length, (index) => newProductContainer(pProvider.plazaProducts[index])),
        );
      }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.name}', style: TextStyle(color: Colors.black),),
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
              //topBox(),
              Provider.of<PlazaProvider>(context, listen: true).loadingPlaza
              ? Expanded(
                child: Center(
                    child: CircularProgressIndicator.adaptive(backgroundColor: Colors.white,),
                  ),
              )
              : Provider.of<PlazaProvider>(context, listen: true).currentPlaza == null
                ? Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("Ochs!! Something went wrong. Try again", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100, color: Colors.white54,),),
                        SizedBox(height: 20,),
                        InkWell(
                          onTap: (){
                            Provider.of<PlazaProvider>(context, listen: false).getPlaza(widget.plazaId);
                          },
                          child: Icon(MdiIcons.refresh, color:  Colors.white,),
                        )
                      ],
                    ),
                )
               
              : Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      topText(),
                      SizedBox(height: 20,),
                      newRecentStoreContainerList(),
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