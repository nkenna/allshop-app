import 'package:ems/models/service.dart';
import 'package:ems/providers/serviceprovider.dart';
import 'package:ems/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class ServiceDetailScreen extends StatefulWidget {
  final String? serviceId;
  const ServiceDetailScreen({ Key? key, this.serviceId }) : super(key: key);

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  Future<Service?>? _futureService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();

  }

  initData(){
    _futureService = Provider.of<ServiceProvider>(context, listen: false).getServiceDetails(widget.serviceId!);
    setState(() {});
  }

  Widget topAvatar(Service service){
    return CircleAvatar(
      radius: 30,
      backgroundColor: Color(0xff464040),
      backgroundImage: NetworkImage("${
      service.user != null
      ? service.user!.avatar != null
        ? "${Api.IMAGE_BASE_URL}${service.user!.avatar}"
        : ""
      : ""
     }"),
    );
  }

  Widget detailsContainer(Service service){

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        width: Get.width,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            Text("Service Details", style: TextStyle(decorationThickness: 3, decoration: TextDecoration.underline, fontWeight: FontWeight.w700, fontSize: 16),),

            SizedBox(height: 20,),
            Text("${service.detail}")
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: FutureBuilder<Service?>(
            future: _futureService,
            builder: (context, service){
              if(service.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              else if(service.hasError){
                return Expanded(
                  child: Center(
                    child: Text("Service details could not be retrieved"),
                  ),
                );
              }
              else if(service.hasData){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    topAvatar(service.data!),
                    SizedBox(height: 10,),
                    Text("${
                      service.data!.user != null
                      ? service.data!.user!.firstname != null
                        ? service.data!.user!.firstname
                        : ""
                      : ""
                    } ${
                      service.data!.user != null
                      ? service.data!.user!.lastname != null
                        ? service.data!.user!.lastname
                        : ""
                      : ""
                    }".capitalizeFirst!, maxLines: 1, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),

                    SizedBox(height: 10,),
                    Text("${service.data!.name} | ${service.data!.category!.name}"),
                    Text("${service.data!.detail != null ? service.data!.detail : ""}"),

                  ],
                );
              }
              else{
                return Expanded(
                  child: Center(
                    child: Text("Error occured retrieving Service details"),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}