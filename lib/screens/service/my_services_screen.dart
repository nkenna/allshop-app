import 'dart:async';
import 'dart:ui';

import 'package:ems/models/service.dart';
import 'package:ems/providers/authprovider.dart';
import 'package:ems/providers/serviceprovider.dart';
import 'package:ems/screens/dashboard/landing_screen.dart';
import 'package:ems/screens/service/add_service_screen.dart';
import 'package:ems/utils/projectcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyServicesScreen extends StatefulWidget {
  const MyServicesScreen({ Key? key }) : super(key: key);

  @override
  State<MyServicesScreen> createState() => _MyServicesScreenState();
}

class _MyServicesScreenState extends State<MyServicesScreen> {
  final ScrollController scrollController = ScrollController();
  StreamController<List<Service>> _streamController = StreamController<List<Service>>();
  int currentPage = 1;
  Future<List<Service>?>? _futureService;
  
  @override
  void initState() {
    super.initState();

    scrollController.addListener(() async{
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent){
        currentPage = currentPage + 1;
        print("I am at the bottom");
      
        print("current page: ${ currentPage}");
        if(currentPage <= Provider.of<ServiceProvider>(context, listen: false).userServiceTotalPage){
          _futureService = Provider.of<ServiceProvider>(context, listen: false).getUserServices(
            
            Provider.of<AuthProvider>(context, listen: false).user!.id,
            currentPage,
          );

          setState(() {
            
          });
       
          //_streamController.add(dd!);
        }

      }
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        initData()
    );

  }

  initData() async {
    _futureService = Provider.of<ServiceProvider>(context, listen: false).getUserServices(
      
      Provider.of<AuthProvider>(context, listen: false).user!.id,
      currentPage,
    );
    setState(() {
      
    });
    //_streamController.add(dd!);

  }

  Widget serviceContainer(Service service){
    return InkWell(
      onTap: (){},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${service.name != null ? service.name : ""}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                  Text("${service.category != null ? service.category!.name : ""}"),
                ],
              ),
              Spacer(),

              InkWell(
                onTap: (){},
                child: Icon(Icons.edit),
              )
            ],
          ),

          
        ),
      ),
    );
  }

 
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Get.to(() => LandingScreen(screen: 3)),
            child: Icon(Icons.arrow_back, color: mainColor,),
            
          ),
          iconTheme: IconThemeData(
            color: mainColor
          ),
          title: Text('My Services', style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: (){
                  Get.to(() => AddServiceScreen());
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder<List<Service>?>(
            future: _futureService,
            builder: (context, snapshot){
              if(snapshot.hasError){
                return Center(
                  child:  Text("Error retrieving your services", style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
                );
              }else if (snapshot.connectionState == ConnectionState.waiting){
                //return SkeletonLoadingGrid(items: 10,);
                return Center(child: CircularProgressIndicator.adaptive(backgroundColor: Colors.white,),);
              }
              else if(snapshot.data == null){
                return Center(child: Text("No services here", style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),);
              }
              else if(snapshot.hasData == true){
                return snapshot.data!.length == 0
                    ? Center(child: Text("No services found", style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)))
                    : ListView.builder(
                    itemCount: snapshot.data!.length,
                    controller: scrollController,
                    shrinkWrap: true,
                    itemBuilder: (context, i){
                      var nData = snapshot.data![i];
                     
                      return serviceContainer(nData);
                    }
                );
              }
              else{
                //print("snapshot length: ${snapshot.data!.length}");
                return Center(child: Text("No services here", style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)));
              }
            }
          ),
        
      ),
    );
  }
}