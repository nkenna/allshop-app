import 'package:ems/models/homeplazadata.dart';
import 'package:ems/models/searchplaza.dart';
import 'package:ems/providers/homeprovider.dart';
import 'package:ems/screens/plaza/plaza_screen.dart';
import 'package:ems/utils/api.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SearchPlazaScreen extends StatefulWidget {
  const SearchPlazaScreen({ Key? key }) : super(key: key);

  @override
  _SearchPlazaScreenState createState() => _SearchPlazaScreenState();
}

class _SearchPlazaScreenState extends State<SearchPlazaScreen> {

  Widget plazaContainer(SearchPlaza plaza){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        width: double.infinity,
        height: 80,
        color: Colors.white,
        child: Row(
              children: [
                InkWell(
                  onTap: () {
                    //print(plaza.sId);
                    //return;
                     Get.to(() => PlazaScreen(plazaId: plaza.id, name: plaza.name));
                  },
                  child: Container(
                    width: Get.width * 0.3,
                    height: 80,
                    decoration: BoxDecoration(
                      image: plaza.images!.length > 0 && plaza.images![0] != null
                    ? DecorationImage(
                        image: NetworkImage("${Api.IMAGE_BASE_URL}${plaza.images![0].imageUrl}") ,                 
                        fit: BoxFit.cover
                    )
                    : const DecorationImage(
                        image: AssetImage("assets/images/business.png"),
                        fit: BoxFit.cover
                    )
                    ),   
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            //Get.to(() => ProductScreen());
                          },
                          child: Text("${plaza.name != null ? plaza.name : ""}".capitalize!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff333333)),)),
                       
                        Text("${plaza.detail != null ? plaza.detail : ""}".capitalize!, maxLines: 2, style: TextStyle(fontSize: 12, color: Color(0xff333333)),),

                                 
                        
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
  

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, hProvider,_) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: hProvider.searchPlazas.isEmpty
          ? Center(
            child: Text('No Plazas found'),
          )
          :ListView.builder(
            itemCount: hProvider.searchPlazas.length,
            shrinkWrap: true,
            itemBuilder: (context, i){
              return plazaContainer(hProvider.searchPlazas[i]);
            },
          ),
        );
      }
    );
  }

}