import 'dart:io';

import 'package:ems/providers/homeprovider.dart';
import 'package:ems/screens/search/search_plaza_screen.dart';
import 'package:ems/screens/search/search_product_screen.dart';
import 'package:ems/screens/search/search_store_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({ Key? key }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final InAppReview _inAppReview = InAppReview.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      requestForReview();
    });
    
  }

  requestForReview() async{
    if(Platform.isAndroid){
      try {
        final isAvailable = await _inAppReview.isAvailable();

        if(isAvailable){
          _inAppReview.requestReview();
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }
  
  Widget searchBox(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          InkWell(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back_rounded, color: Colors.black,),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: TextField(
              style: TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                hintText: "Search here",
                hintStyle: TextStyle(color: Colors.black),
                border: InputBorder.none,
              ),
              onChanged: (value){
                if(value != null){
                  if(value.length > 3){
                    Provider.of<HomeProvider>(context, listen: false).searchAll(value);
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Scaffold(
        
        backgroundColor: Colors.white,
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
              body: TabBarView(
                children: [
                  SearchPlazaScreen(),
                  SearchProductScreen(),
                  SearchStoreScreen()
                ],
              ),
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
              
                SliverPadding(
                  padding: EdgeInsets.all(0),
                  sliver: SliverToBoxAdapter(
                    child: searchBox()
                  ),
                ),
                SliverAppBar(
                  
                  backgroundColor: Colors.transparent,
                  pinned: true,
                  elevation: 12.0,
                  leading: Container(),
                  titleSpacing: 0.0,
                  toolbarHeight: 10,
                  bottom: TabBar(
                    indicatorWeight: 5,
                    indicatorColor: Color(0xff30b85a),
                    tabs: [
                    Tab(
                      child: Text(
                        "Plazas",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
               
                    Tab(
                      child: Text(
                        "Products",
                        style: TextStyle(color: Colors.black),
                      
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Stores",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ]),
                ),
              
              ],
            ),
        ),
     
      ),
     
    );
  }
}