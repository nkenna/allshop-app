
import 'package:ems/models/home_product.dart';
import 'package:ems/models/home_store.dart';
import 'package:ems/models/homeplazadata.dart';
import 'package:ems/providers/homeprovider.dart';
import 'package:ems/screens/plaza/plaza_screen.dart';
import 'package:ems/screens/search/search_page.dart';
import 'package:ems/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Widget topText(){
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text("What are you looking for?",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget searchBox(){
    return Padding(
       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: (){
          Get.to(() => SearchPage());
        },
        child: Container(
          width: Get.width,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30))
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(MdiIcons.magnify, color: Color(0xff3D3939),),
                Icon(Icons.settings, color: Color(0xff3D3939))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget plazaContainer(HomePlazaData hpd){
    return InkWell(
      onTap: (){
        Get.to(() => PlazaScreen(plazaId: hpd.plazaId, name: hpd.plaza!.name));
      },
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.transparent,
        child: Container(
          //color: Colors.blue,
          child: Column(
            children: [
              Container(
                width: Get.width * 0.3,
                height: 175,
                decoration: BoxDecoration(
                  //color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  image: DecorationImage(
                    image: AssetImage("assets/images/business.png"),
                    fit: BoxFit.cover
                  )
                ),
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Icon(MdiIcons.mapMarker, color: Colors.white, size: 30,),
                ),
              ),
              SizedBox(height: 5,),
              Text("${hpd.plaza!.name}".toUpperCase(), maxLines: 1, style: TextStyle(fontSize: 12, color: Colors.white),),
            ],
          ),
        ),
      ),
    );
  }

  Widget plazaContainerList(){
    return SizedBox(
       height: 250,
      child: Padding(
        padding: const EdgeInsets.symmetric( vertical: 10),
        child: Consumer<HomeProvider>(
          builder: (context, hProvider, _) {
            return hProvider.homePlazaData.length == 0
            ? Center(child: CircularProgressIndicator.adaptive(backgroundColor: Colors.white))
            
            : ListView.builder(  
                    itemCount: hProvider.homePlazaData.length,  
                    scrollDirection: Axis.horizontal, 
                    itemBuilder: (BuildContext context, int index){  
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: plazaContainer(hProvider.homePlazaData[index]),
                      );  
                    },  
              );
          }
        ),
      ),
    
    );
  }



  Widget productContainer(HomeProduct product){
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      color: Colors.white,
      child: Container(
        width: Get.width * 0.3,
        height: 170,
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          //color: Colors.blue,
        ),
        child: Column(
          children: [
            Container(
              width: Get.width * 0.3,
              height: 150,
              
              
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                image: product.images!.length > 0 && product.images![0] != null
                    ? DecorationImage(
                      image: NetworkImage("${Api.IMAGE_BASE_URL}${product.images![0].imageUrl}") ,                 
                      fit: BoxFit.cover
                    )
                    : const DecorationImage(
                      image: AssetImage("assets/images/product.png"),
                      fit: BoxFit.cover
                    )
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${product.name != null ? product.name : ""}".capitalizeFirst!, maxLines: 2, style: TextStyle(fontSize: 12),),
            ),
          ],
        ),
      ),
    );
  }

  Widget recentProductContainerList(){
    return SizedBox(
       height: 250,
       width: Get.width,
      child: Padding(
        padding: const EdgeInsets.symmetric( vertical: 10),
        child: Consumer<HomeProvider>(
          builder: (context, hProvider, _) {
            print(hProvider.homeProductData.length);
            return hProvider.homeProductData.isEmpty
            ? Center(child: CircularProgressIndicator.adaptive(backgroundColor: Colors.white,))
            
            : ListView.builder(  
                    itemCount: hProvider.homeProductData.length,  
                    scrollDirection: Axis.horizontal, 
                    itemBuilder: (BuildContext context, int index){  
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: productContainer(hProvider.homeProductData[index]),
                      );  
                    },  
              );
          }
        ),
      ),
    
    );
  }

  Widget storeContainer(HomeStore store){
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      color: Colors.white,
      child: Container(
        width: Get.width * 0.3,
        height: 155,
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          //color: Colors.blue,
        ),
        child: Column(
          children: [
            Container(
              width: Get.width * 0.3,
              height: 150,           
              
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                image: DecorationImage(
                      image: AssetImage("assets/images/business.png"),
                      fit: BoxFit.cover
                    )
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${store.name != null ? store.name : ""}".capitalizeFirst!, maxLines: 2, style: TextStyle(fontSize: 12),),
            ),
          ],
        ),
      ),
    );
  }

  Widget recentStoreContainerList(){
    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.symmetric( vertical: 10),
        child: Consumer<HomeProvider>(
          builder: (context, hProvider, _) {
            print(hProvider.homeStoreData.length);
            return hProvider.homeStoreData.isEmpty
            ? Center(child: CircularProgressIndicator.adaptive(backgroundColor: Colors.white,))
            
            : ListView.builder(  
                    itemCount: hProvider.homeStoreData.length,  
                    scrollDirection: Axis.horizontal, 
                    itemBuilder: (BuildContext context, int index){  
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: storeContainer(hProvider.homeStoreData[index]),
                      );  
                    },  
              );
          }
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
        color: const Color(0xff464040),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.05,),
              topText(),
              searchBox(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Text("Plazas Near you",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'SofiaProSemiBold'),
                    ),
                  ],
                ),
              ),
              plazaContainerList(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Text("Newly Added Items",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'SofiaProSemiBold'),
                    ),
                  ],
                ),
              ),
              recentProductContainerList(),
              SizedBox(height: 20,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Text("Newly Added Stores/Businesses",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'SofiaProSemiBold'),
                    ),
                  ],
                ),
              ),
              recentStoreContainerList()
            ],
          ),
        ),
      ),
    );
  }
}