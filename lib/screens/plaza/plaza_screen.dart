import 'package:ems/models/business.dart';
import 'package:ems/models/product.dart' as pr;
import 'package:ems/providers/homeprovider.dart';
import 'package:ems/providers/plazaprovider.dart';
import 'package:ems/screens/plaza/product_screen.dart';
import 'package:ems/screens/plaza/store_screen.dart';
import 'package:ems/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

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
    initData();
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
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget middleText(){
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text("Items found in ${widget.name}",
        style: TextStyle(color: Colors.white, fontSize: 16),
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

  Widget plazaStoreContainer(Business business){
    return InkWell(
      onTap: (){
        Get.to(() => StoreScreen(storeData: business));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          /*image: DecorationImage(
            image: AssetImage("assets/images/araimo.jpeg"),
            fit: BoxFit.cover
          )*/
        ),
        alignment: Alignment.center,
        child: Text("${business.name != null ? business.name : ""}", style: TextStyle(color: Colors.white),),
      ),
    );
  }

  Widget plazaStoresHolder(){
    return Consumer<PlazaProvider>(
      builder: (context, pProvider, _) {
        return AnimatedSwitcher(
          duration: Duration(milliseconds: 700),
          child: pProvider.plazaBusinesses.isEmpty          
          ? Container(
              width: double.infinity,
              height: 100,
              alignment: Alignment.center,
              child: Text("No Store/Business have been added under this Plaza", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100, color: Colors.white54,),),
          )
          : Container(
              width: double.infinity,
              height: 350,
              //color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: GridView.builder(  
                        itemCount: pProvider.plazaBusinesses.length, 
                        physics: NeverScrollableScrollPhysics(), 
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(  
                            crossAxisCount: 3,  
                            crossAxisSpacing: 20.0,  
                            mainAxisSpacing: 20.0,
                            mainAxisExtent: 150
                        ),  
                        itemBuilder: (BuildContext context, int index){  
                          return plazaStoreContainer(pProvider.plazaBusinesses[index]);  
                        },  
                      ),
              ),
            
            )
        );
      }
    );
  }
  
  Widget productsContainer(pr.Product product){
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
                Get.to(() => ProductScreen(product: product,));
              },
              child: Container(
                width: Get.width * 0.3,
                decoration: BoxDecoration(
                  image:  product.images!.length > 0 && product.images![0] != null
                  ? DecorationImage(
                    image: NetworkImage("${Api.IMAGE_BASE_URL}${product.images![0].imageUrl}")                  
                    //fit: BoxFit.cover
                  )
                  : const DecorationImage(
                    image: AssetImage("assets/images/hifi.jpg"),
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
                        Get.to(() => ProductScreen());
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
          children: List.generate(pProvider.plazaProducts.length, (index) => productsContainer(pProvider.plazaProducts[index])),
        );
      }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff464040),
        body: Container(
          width: Get.width,
          height: Get.height,
          child: Column(
            children: [
              topBox(),
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
                      plazaStoresHolder(),
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