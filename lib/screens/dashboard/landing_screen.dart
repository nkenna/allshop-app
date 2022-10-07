import 'dart:async';

import 'package:ems/providers/homeprovider.dart';
import 'package:ems/providers/productprovider.dart';
import 'package:ems/screens/home/home_screen.dart';
import 'package:ems/screens/messages/messages_screen.dart';
import 'package:ems/screens/plaza/product_screen.dart';
import 'package:ems/screens/profile/profile_screen.dart';
import 'package:ems/screens/starred/starred_screen.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatefulWidget {
  int? screen = 0;
  LandingScreen({ Key? key,this.screen }) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  StreamSubscription<Position>? _positionStreamSubscription;
  StreamSubscription<ServiceStatus>? _serviceStatusStreamSubscription;
  bool positionStreamStarted = false;

  List<Widget> _screens = [
    HomeScreen(),
    StarredScreen(),
    MessagesScreen(),
    ProfileScreen()
  ];

  int _screen = 0;

  Position? _position;
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  
  @override
  void initState() {
    if(widget.screen != null){
      _screen = widget.screen!;
    }
    super.initState();
    initDynamicLinks();    
    _getCurrentPosition();
    checkForUpdate();
    
  }

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      if(info.updateAvailability == UpdateAvailability.updateAvailable){
        InAppUpdate.performImmediateUpdate()
                            .catchError((e) => print(e.toString()));
      }

    }).catchError((e) {
      print(e.toString());
    });
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
      Provider.of<HomeProvider>(context, listen: false).getPlazaHomeDataRequest(position.latitude, position.longitude);
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

  Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      print(dynamicLinkData.link);
      if(dynamicLinkData.link.queryParameters.containsKey('productId')){
        var productId = dynamicLinkData.link.queryParameters['productId'];
        
        if(productId != null){
          Get.to(() => ProductScreen(productId: productId,));
          
        }
        else{
          ProjectToast.showErrorToast('no product data retrieved');
        }
      }

      //Get.offAll(() => PpleScreen(ppleId: dynamicLinkData.link.queryParameters['ppleId'],));
      //Navigator.pushNamed(context, dynamicLinkData.link.path);
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }


  /// function to change between provided screens
  _changeScreen(int currentScreen){
    setState(() {
      _screen = currentScreen;
    });
    print(_screen);
  }

  Widget menuItem(IconData icd, String text, VoidCallback callback){
    return InkWell(
      onTap: callback,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icd, size: 30, color: Color(0xff4f4f4f),),
          Text(text, style: TextStyle(fontSize: 12, color: Color(0xff4f4f4f)),)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            
            width: double.infinity,
            height: double.infinity,
            child: _screens[_screen],
            
           
          ),
          bottomNavigationBar: Material(
            elevation: 5,
            child: Container(
              color: Colors.white,
              height: kToolbarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
                children: [
                  menuItem(MdiIcons.home, "Home", () {_changeScreen(0);}),
                  menuItem(MdiIcons.starCheck, "Starred", () {_changeScreen(1);}),
                  menuItem(MdiIcons.message, "Messages", () {_changeScreen(2);}),
                  menuItem(MdiIcons.accountCircle, "Profile", () {_changeScreen(3);}),
                ],
                ),
            ),
          ),
        ),
      ),
    );
  }
}