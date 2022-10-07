import 'dart:async';

import 'package:ems/models/plaza.dart';
import 'package:ems/providers/authprovider.dart';
import 'package:ems/providers/plazaprovider.dart';
import 'package:ems/screens/business/add_business_screen.dart';
import 'package:ems/utils/projectcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class SelectPlazasScreen extends StatefulWidget {
  const SelectPlazasScreen({ Key? key }) : super(key: key);

  @override
  _SelectPlazasScreenState createState() => _SelectPlazasScreenState();
}

class _SelectPlazasScreenState extends State<SelectPlazasScreen> {
  final ScrollController scrollController = ScrollController();
  StreamController<List<Plaza>?> _streamController = StreamController<List<Plaza>?>();
  Future<List<Plaza>?>? _futurePlaza;
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
          _futurePlaza = Provider.of<PlazaProvider>(context, listen: false).getAllPlazas(
            Provider.of<AuthProvider>(context, listen: false).user!.id,
            currentPage
          );
          setState(() {
            
          });
          //_streamController.add(dd);
        }

      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        initData()
    );

  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    //_streamController.close();
  }

  initData() async {
    _futurePlaza = Provider.of<PlazaProvider>(context, listen: false).getAllPlazas(
      Provider.of<AuthProvider>(context, listen: false).user!.id,
      currentPage
    );
    setState(() {
      
    });
    //_streamController.add(dd);

  }

  Widget searchField(){
    return Card(
      child: TextField(
        //controller: _emailController,
        style: const TextStyle(color: Color(0xff333333), fontSize: 14),
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        onChanged: (query){
          if(query.length > 1){
            _futurePlaza = Provider.of<PlazaProvider>(context, listen: false).searchForPlaza(query);
            setState(() {});
          }else if(query.isEmpty){
            currentPage = 1;
            _futurePlaza = Provider.of<PlazaProvider>(context, listen: false).getAllPlazas(
              Provider.of<AuthProvider>(context, listen: false).user!.id,
              currentPage
            );
            setState(() {});
          }
        },
        decoration: const InputDecoration(
          hintText: "Search for Plaza",
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xfff0efeb), width: 2 ),
          //borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffbcd3e3), width: 2 ),
          //borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xfff0efeb), width: 2 ),
          //borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          prefixIcon: Icon(MdiIcons.shoppingSearch, color: Color(0xff333333),)
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: mainColor
          ),
          backgroundColor: Colors.white,
          title: Text('Choose Plaza', style: TextStyle(color: Colors.black),),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            searchField(),
            Expanded(
              child: FutureBuilder<List<Plaza>?>(
                future: _futurePlaza,
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
          ],
        ),
      ),
    );
  }
}