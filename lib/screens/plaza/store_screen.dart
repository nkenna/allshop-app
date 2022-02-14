import 'package:ems/models/business.dart' as bs;
import 'package:ems/models/product.dart';
import 'package:ems/providers/storeprovider.dart';
import 'package:ems/screens/plaza/product_screen.dart';
import 'package:ems/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class StoreScreen extends StatefulWidget {
  final bs.Business? storeData;
  const StoreScreen({ Key? key, this.storeData }) : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    Provider.of<StoreProvider>(context, listen: false).getStoreProducts(widget.storeData!.id, 1);
    //Provider.of<StoreProvider>(context, listen: false).getStoreProducts(widget.storeData!.id, 1);
  }

  Widget topBox(){
    return Material(
      type: MaterialType.card,
      elevation: 20,
      child: Container(
        width: double.infinity,
        height: Get.height * 0.07,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: InkWell(
                onTap: () => Get.back(),
                child: Icon(MdiIcons.arrowLeft, color: Color(0xff333333),),
              ),
            ),
            SizedBox(width: 30,),
            Expanded(
              child: TextField(
                  style: const TextStyle(color: Color(0xff333333), fontSize: 14),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Search for something in Araimo Store",
                    border: InputBorder.none,
                  ),
                ),
            ),
            SizedBox(width: 30,),

             Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {},
                child: Icon(MdiIcons.star, color: Color(0xffE5E5E5),),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget infoContainer(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        width: double.infinity,
        height: Get.height * 0.12,
        //color: Colors.blue,
        child: Row(
          children: [
            Container(
              width: Get.width * 0.3,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                image: DecorationImage(
                  image: AssetImage("assets/images/araimo.jpeg"),
                  fit: BoxFit.fill
                )
              ),
              
              
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text("${
                      widget.storeData != null
                      ? widget.storeData!.name != null
                        ? widget.storeData!.name
                        : ""
                      : "" 
                    }", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),),
                   

                   SizedBox(
                     width: 100,
                     child: ElevatedButton(
                       style: ButtonStyle(
                         backgroundColor: MaterialStateProperty.all(Colors.white)
                       ),
                       onPressed: (){},
                       child: Text("Call", style: TextStyle(color: Color(0xff333333)),),
                     ),
                   ),

                    
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
  
 
  Widget productsContainer(Product product){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        width: double.infinity,
        height: Get.height * 0.12,
        color: Colors.white,
        child: Row(
          children: [
            InkWell(
              onTap: (){
                Get.to(() => ProductScreen(product: product,));
              },
              child: Container(
                width: Get.width * 0.3,
                decoration: BoxDecoration(
                  image:  product.images!.length > 0 && product.images![0] != null
                  ? DecorationImage(
                    image: NetworkImage("${Api.IMAGE_BASE_URL}${product.images![0].imageUrl}")                  
                    //fit: BoxFit.cover
                  )
                  : const DecorationImage(
                    image: AssetImage("assets/images/hifi.jpg"),
                    //fit: BoxFit.cover
                  )
                ),
                
                
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (){
                        Get.to(() => ProductScreen());
                      },
                      child: Text("${product.name}".capitalize!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff333333)),)),
                   
                    Row(
                      children: [
                        Icon(Icons.store, color: Color(0xff333333)),
                        Text("${product.business!.name}".capitalize!, style: TextStyle(fontSize: 14, color: Color(0xff333333)),),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("NGN ${product.maxPrice}", style: TextStyle(fontSize: 14, color: Color(0xff333333)),),
                        //Text("Contact", style: TextStyle(fontSize: 14, color: Color(0xff333333)),),
                        InkWell(
                          onTap: (){},
                          child: Icon(MdiIcons.heartOutline, color: Colors.red,),
                        )
                      ],
                    ),

                    
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
  
  
  Widget productsContainerHolder(){
    return Consumer<StoreProvider>(
      builder: (context, pProvider, _) {
        return Column(
          children: List.generate(pProvider.plazaProducts.length, (index) => productsContainer(pProvider.plazaProducts[index])),
        );
      }
    );
  }

  Widget dataContainer(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(StadiumBorder())
              ),
              onPressed: (){},
              child: Text("Follow", style: TextStyle(color: Color(0xff333333)),),
            ),
          ),

          Row(
            children: [
              RichText(
                text: TextSpan(
                  text: "Products: ",
                  style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: "${Provider.of<StoreProvider>(context, listen: true).totalProducts}",
                      style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.normal),
                    )
                  ]
                ),
              ),
              SizedBox(width: 20,),

              RichText(
                text: TextSpan(
                  text: "Followers: ",
                  style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: "450",
                      style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.normal),
                    )
                  ]
                ),
              ),
            ],
          ),

       

          
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff0a0b0d),
        body: Container(
          width: Get.width,
          height: Get.height,
          child: Column(
            children: [
              topBox(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      infoContainer(),
                      dataContainer(),
                      SizedBox(height: 10,),
                      SizedBox(height: 20,),

                      productsContainerHolder(),
                    
                      
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}