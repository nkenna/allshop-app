import 'dart:math';

import 'package:ems/models/home_product.dart';
import 'package:ems/models/home_service.dart';
import 'package:ems/models/home_store.dart';
import 'package:ems/models/homeplazadata.dart';
import 'package:ems/models/product.dart';
import 'package:ems/providers/homeprovider.dart';
import 'package:ems/screens/plaza/plaza_screen.dart';
import 'package:ems/screens/plaza/product_screen.dart';
import 'package:ems/screens/plaza/store_screen.dart';
import 'package:ems/screens/search/search_page.dart';
import 'package:ems/screens/service/service_detail_screen.dart';
import 'package:ems/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ems/models/business.dart' as bs;
import 'package:latlong2/latlong.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  Position? _position;

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();

  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      print("no locaton permission: ${hasPermission}");
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    print('IS POSITION NULL:::: ${position == null}');
    if(position != null){
      _position = position;
      setState(() {});
    }

  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("is service enabled: ${serviceEnabled}");
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    print("location permission status: ${permission}");
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        await _geolocatorPlatform.openLocationSettings();
        //permission = await _geolocatorPlatform.requestPermission();
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await _geolocatorPlatform.openLocationSettings();
      return false;
    }

    return true;
  }

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  double calDistance(lat, lng) {
    var distance = Distance();

    // km = 423
    final km = distance.as(LengthUnit.Kilometer, LatLng(lat, lng),
        LatLng(_position != null ?  _position!.latitude : 0.0, _position != null ?  _position!.longitude : 0.0));

    // meter = 422591.551
    //final meter =
    //distance(LatLng(52.518611, 13.408056), LatLng(51.519475, 7.46694444));

    print('km: $km');
    return km;
  }

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
        child: Card(
          child: Container(
            width: Get.width,
            height: 50,
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
      ),
    );
  }


  Widget newPlazaContainer(HomePlazaData hpd){
    return InkWell(
      onTap: (){
        Get.to(() => PlazaScreen(plazaId: hpd.plazaId, name: hpd.plaza != null ? hpd.plaza!.name : ""));
      },
      child: Container(
        width: 175,
        //height: 110,
        decoration: BoxDecoration(
          //color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.blue,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                image: DecorationImage(
                      image: NetworkImage("${
                          hpd.plaza != null
                              ? hpd.plaza!.images!.isNotEmpty
                              ? hpd.plaza!.images!.first != null
                              ? Api.IMAGE_BASE_URL + hpd.plaza!.images!.first.imageUrl!
                              : ""
                              : ""
                              : ""
                      }"),
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

                  Text('${hpd.plaza != null ? hpd.plaza!.name : ''}', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, fontFamily: 'SofiaProSemiBold', color: Color(0xff333656)),),
                  SizedBox(height: 3,),
                  Text('${hpd.plaza != null ? hpd.plaza!.detail : ''} ', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: Colors.black)),
                  SizedBox(height: 3,),
                  if(hpd.loc != null)
                    Text('${calDistance(hpd.loc!.coordinates![1], hpd.loc!.coordinates![0])}km away', style: TextStyle(fontSize: 12, color: Colors.black)),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget newPlazaContainerList(){
    return SizedBox(
      height: 200,
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
                        print("what is here: ${hProvider.homePlazaData[index]}");
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: hProvider.homePlazaData[index] == null
                              ? Container()
                              : newPlazaContainer(hProvider.homePlazaData[index]),
                        );
                      },
                  );
            }
        ),
      ),

    );
  }

  Widget productContainer(HomeProduct product){
    return InkWell(
      onTap: (){
        Get.to(() => ProductScreen(productId: product.id,));
      },
      child: Material(
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
                        image: NetworkImage("${Api.IMAGE_BASE_URL}${product.images![0]!.imageUrl}") ,                 
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
      ),
    );
  }

  Widget newProductContainer(HomeProduct product){
    return InkWell(
      onTap: (){
        Get.to(() => ProductScreen(productId: product.id,));
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
                  image: product.images!.length > 0 && product.images![0] != null
                      ? DecorationImage(
                          image: NetworkImage("${Api.IMAGE_BASE_URL}${product.images![0]!.imageUrl}") ,
                          fit: BoxFit.cover
                      )
                      : const DecorationImage(
                          image: AssetImage("assets/images/product.png"),
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

                  Text('${product.name != null ? product.name : ''}', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, fontFamily: 'SofiaProSemiBold', color: Color(0xff333656)),),
                  SizedBox(height: 3,),
                  Text('${product.detail != null ? product.detail : ''} ', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: Colors.black)),
                  SizedBox(height: 10,),
                  if(product.minPrice > 0)
                    Text('from NGN ${product.minPrice }', style: TextStyle(fontSize: 14, color: Colors.black)),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget newRecentProductContainerList(){
    return SizedBox(
      height: 210,
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
                          child: newProductContainer(hProvider.homeProductData[index]),
                        );
                      },
                    );
            }
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
    return InkWell(
      onTap: (){

        bs.Images im = bs.Images(
          sId: store.imageData!.sId,
          imageName: store.imageData!.imageName,
          imageType: store.imageData!.imageType,
          imageUrl: store.imageData!.imageType
        );
        bs.Business business = bs.Business(
          id: store.id,
          image: im,
          name: store.name,

        );
        print("is bs null: ${business == null}");
        Get.to(() => StoreScreen(storeData: business));
      },
      child: Material(
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
                  image: store.imageData != null
                      ? DecorationImage(
                        image: NetworkImage("${Api.IMAGE_BASE_URL}${store.imageData!.imageUrl != null ? store.imageData!.imageUrl : ""}") ,                 
                        fit: BoxFit.cover
                      )
                      : const DecorationImage(
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
      ),
    );
  }

  Widget newStoreContainer(HomeStore store){
    return InkWell(
      onTap: (){

       // print("is bs null: ${store.imageData!.imageName}");
        //return;

        /*bs.Images im = bs.Images(
            sId: store.imageData!.sId,
            imageName: store.imageData!.imageName,
            imageType: store.imageData!.imageType,
            imageUrl: store.imageData!.imageType
        );*/
        bs.Business business = bs.Business(
          id: store.id,
          //image: im,
          name: store.name,

        );
        
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
                  image: store.imageData != null
                      ? DecorationImage(
                      image: NetworkImage("${Api.IMAGE_BASE_URL}${store.imageData!.imageUrl != null ? store.imageData!.imageUrl : ""}") ,
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

                  Text('${store.name ?? ''}', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, fontFamily: 'SofiaProSemiBold', color: Color(0xff333656)),),
                  SizedBox(height: 3,),
                  Text('${store.detail ?? ''} ', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: Colors.black)),
                  SizedBox(height: 3,),
                  Row(
                    children: [
                      IgnorePointer(
                        child: RatingBar.builder(
                          initialRating: store.avgRating != null ? store.avgRating!.toDouble() : 0.0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemSize: 15,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text('${store.avgRating ?? 0.0} (${store.ratingCount ?? 0})')
                    ],
                  )

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
                    child: newStoreContainer(hProvider.homeStoreData[index]),
                  );
                },
              );
            }
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
  
  Widget serviceBox(HomeService service){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: (){
          //Get.to(() => ServiceDetailScreen(serviceId: service.id,));
        },
        child: Container(
          width: Get.width,
          height: 100,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0xff464040),
                    backgroundImage: NetworkImage("${
                      service.user != null
                      ? service.user!.avatar != null
                        ? "${Api.IMAGE_BASE_URL}${service.user!.avatar}"
                        : ""
                      : ""
                    }"),
                  ),
                  SizedBox(height: 5,),
                  Text("${
                    service.user != null
                    ? service.user!.firstname != null
                      ? service.user!.firstname
                      : ""
                    : ""
                  }".capitalizeFirst!, maxLines: 1,),
                ],
              ),
      
              SizedBox(width: 10,),
      
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
              
                    Text("${service.name != null ? service.name : ""}".capitalizeFirst!, style: TextStyle(fontFamily: 'SofiaProSemiBold', fontSize: 14),),
                    SizedBox(height: 10,),
                    Text("${service.detail != null ? service.detail : ""}", maxLines: 2, style: TextStyle(fontSize: 12),),
                    SizedBox(height: 5,),
                    Text("${Jiffy(service.createdAt).yMMMdjm}", maxLines: 2, style: TextStyle(fontFamily: 'SofiaProSemiBold', fontSize: 12),),
                  ],
                ),
              ),
      
            ],
          ),
        ),
      ),
    );
  }
 

  Widget serviceContainer(){
    return Consumer<HomeProvider>(
      builder: (context, hProvider, _) {
        return Column(
          children: List.generate(hProvider.homeServiceData.length > 2 ? 2 : hProvider.homeServiceData.length, (index) => 
            serviceBox(hProvider.homeServiceData[index])
          ),
        );
      }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: Get.width,
        height: Get.height,
        color: Color(0xfff8f6f2),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              //topText(),
              searchBox(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Text("Plazas Near you",
                      style: TextStyle(color: Color(0xff4f4f4f), fontSize: 16, fontFamily: 'SofiaProMedium'),
                    ),
                  ],
                ),
              ),
              newPlazaContainerList(),

              SizedBox(height: 10,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Text("Newly Added Items",
                        style: TextStyle(color: Color(0xff4f4f4f), fontSize: 16, fontFamily: 'SofiaProMedium')
                    ),
                  ],
                ),
              ),
              newRecentProductContainerList(),
              SizedBox(height: 10,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Text("Newly Added Stores/Businesses",
                        style: TextStyle(color: Color(0xff4f4f4f), fontSize: 16, fontFamily: 'SofiaProMedium')
                    ),
                  ],
                ),
              ),
              newRecentStoreContainerList(),
              SizedBox(height: 20,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Text("Featured Services",
                        style: TextStyle(color: Color(0xff4f4f4f), fontSize: 16, fontFamily: 'SofiaProMedium')
                    ),
                  ],
                ),
              ),
              serviceContainer(),


            ],
          ),
        ),
      ),
    );
  }
}