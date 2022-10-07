import 'package:ems/models/home_store.dart';
import 'package:ems/providers/homeprovider.dart';
import 'package:ems/screens/plaza/store_screen.dart';
import 'package:ems/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:ems/models/business.dart' as bs;

class SearchStoreScreen extends StatefulWidget {
  const SearchStoreScreen({ Key? key }) : super(key: key);

  @override
  _SearchStoreScreenState createState() => _SearchStoreScreenState();
}

class _SearchStoreScreenState extends State<SearchStoreScreen> {

   Widget storeContainer(HomeStore store){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        width: double.infinity,
        height: 80,
        color: Colors.white,
        child: Row(
              children: [
                InkWell(
                  onTap: () async{
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
                  child: Container(
                    width: Get.width * 0.3,
                    height: 80,
                    decoration: BoxDecoration(
                      image: store.imageData != null
                    ? DecorationImage(
                        image: NetworkImage("${Api.IMAGE_BASE_URL}${store.imageData!.imageUrl}") ,                 
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
                          child: Text("${store.name != null ? store.name : ""}".capitalize!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff333333)),)),
                       
                        Text("${store.detail != null ? store.detail : ""}".capitalize!, maxLines: 2, style: TextStyle(fontSize: 12, color: Color(0xff333333)),),

                                 
                        
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
          child: hProvider.searchStores.isEmpty
          ? Center(
            child: Text('No Business/Stores found'),
          )
          : ListView.builder(
            itemCount: hProvider.searchStores.length,
            shrinkWrap: true,
            itemBuilder: (context, i){
              return storeContainer(hProvider.searchStores[i]);
            },
          ),
        );
      }
    );
  }

}