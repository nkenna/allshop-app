import 'dart:async';

import 'package:ems/models/plaza.dart';
import 'package:ems/providers/authprovider.dart';
import 'package:ems/providers/plazaprovider.dart';
import 'package:ems/screens/business/add_business_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SelectPlazasScreen extends StatefulWidget {
  const SelectPlazasScreen({ Key? key }) : super(key: key);

  @override
  _SelectPlazasScreenState createState() => _SelectPlazasScreenState();
}

class _SelectPlazasScreenState extends State<SelectPlazasScreen> {
  final ScrollController scrollController = ScrollController();
  StreamController<List<Plaza>?> _streamController = StreamController<List<Plaza>?>();
  int currentPage = 1;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() async{
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent){
        currentPage = currentPage + 1;
        print("I am at the bottom");
        print("total all plaza page: ${ Provider.of<PlazaProvider>(context, listen: false).totalPlazaPages}");
        print("current page: ${ currentPage}");
        if(currentPage <= Provider.of<PlazaProvider>(context, listen: false).totalPlazaPages){
          final dd = await Provider.of<PlazaProvider>(context, listen: false).getAllPlazas(
            Provider.of<AuthProvider>(context, listen: false).user!.id,
            currentPage
          );
          _streamController.add(dd);
        }

      }
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        initData()
    );

  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    _streamController.close();
  }

  initData() async {
    final dd = await Provider.of<PlazaProvider>(context, listen: false).getAllPlazas(
      Provider.of<AuthProvider>(context, listen: false).user!.id,
      currentPage
    );
    _streamController.add(dd);

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: const Color(0xff464040),
        body: StreamBuilder<List<Plaza>?>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return Center(child: Text("Error occurred retrieving plazas", style: TextStyle(color: Colors.white),),);
            }else if (snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator.adaptive(backgroundColor: Colors.white,));
            }
            else if(snapshot.data == null){
              return Center(child: Text("No Plaza found"),);
            }
            else if(snapshot.hasData == true){
              return snapshot.data!.length == 0
                ? Center(child: Text("No Plaza retrieved"),)
                :  ListView.builder(
                    shrinkWrap: true,
                    controller: scrollController,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i){
                      var plaza = snapshot.data![i];
                      if(plaza.location == null)
                        return Container();
                      return ListTile(
                        onTap: () => Get.to(() => AddBusinessScreen(plazaId: plaza.id,)),
                        tileColor: Colors.white,
                        title: Text("${plaza.name}"),
                        subtitle: Text("${plaza.location!.address}"),
                        trailing:  Icon(Icons.arrow_forward_ios),
                      );
                    },
                  );
            }
            else {
              return Center(child: Text("No Plaza found"),);
            }
          }
        ),
      ),
    );
  }
}