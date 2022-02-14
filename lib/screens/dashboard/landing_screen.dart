import 'dart:async';

import 'package:ems/providers/homeprovider.dart';
import 'package:ems/screens/home/home_screen.dart';
import 'package:ems/screens/messages/messages_screen.dart';
import 'package:ems/screens/profile/profile_screen.dart';
import 'package:ems/screens/starred/starred_screen.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    if(widget.screen != null){
      _screen = widget.screen!;
    }
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
    if(position != null){
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
          Icon(icd, size: 30,),
          Text(text, style: TextStyle(fontSize: 12),)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff464040),
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
    );
  }
}