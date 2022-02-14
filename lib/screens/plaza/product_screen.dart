import 'package:ems/models/product.dart';
import 'package:ems/providers/productprovider.dart';
import 'package:ems/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  Product? product;
  ProductScreen({ Key? key, this.product }) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<String> _imageList = [
    "assets/images/hifi.jpg",
    "assets/images/araimo.jpeg",
    "assets/images/plaza1.jpg",
    "assets/images/plaza2.jpeg",
    "assets/images/zealot.png",
  ];

  int _selectedIndex = 0;

  changeSelectedImage(int index){
    setState(() {
      _selectedIndex = index;
    });
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
              child: Text("", style: const TextStyle(color: Color(0xff333333), fontSize: 14),)
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

  Widget smallBox(bool selected){
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: selected ? Color(0xff464040) : Colors.transparent,
          border: Border.all(color: Color(0xff464040)),
          shape: BoxShape.circle
        ),
      ),
    );
  }
  
  Widget imageContainer(){
    return GestureDetector(
      onHorizontalDragEnd: (dragEndDetails){
        print(dragEndDetails.primaryVelocity);
        if(dragEndDetails.primaryVelocity! > 0){ // right swipe
          if(_selectedIndex < (widget.product!.images!.length - 1)){
            changeSelectedImage(_selectedIndex + 1);
          }
          
        }

        if(dragEndDetails.primaryVelocity! < 0){ // left swipe
          if(_selectedIndex > 0){
            changeSelectedImage(_selectedIndex - 1);
          }
          
        }
      },
      child: Container(
        width: Get.width,
        height: Get.height * 0.3,
        decoration: const BoxDecoration(
          color: Colors.white
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.network(
                "${Api.IMAGE_BASE_URL}${widget.product!.images![_selectedIndex].imageUrl}", 
                width: double.infinity, 
                fit: BoxFit.cover,
                errorBuilder: (context, st, ob){
                  return Container(
                    width: Get.width,
                    height: Get.height * 0.3,
                  );
                },
              ),
            ),
    
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 100,
                //color: Colors.orange,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(widget.product!.images!.length, (index) => smallBox(_selectedIndex == index ? true : false)),
                    ),
    
                    SizedBox(height: 10,),
    
                    Divider(thickness: 3, color: Color(0xff464040),),
    
                    SizedBox(height: 10,),
    
    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${widget.product!.name}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff333333)),),
                        Text("NGN ${widget.product!.maxPrice}")
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  
  Widget btnRows(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
            width: 150,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(StadiumBorder())
              ),
              onPressed: (){},
              child: Text("Make an Offer", style: TextStyle(color: Color(0xff333333)),),
            ),
        ),

        SizedBox(
            width: 150,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(StadiumBorder())
              ),
              onPressed: (){},
              child: Text("Call", style: TextStyle(color: Color(0xff333333)),),
            ),
        ),
      ],
    );
  }

  Widget detailsContainer(){
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
            Text("Product Details", style: TextStyle(decorationThickness: 3, decoration: TextDecoration.underline, fontWeight: FontWeight.w700, fontSize: 16),),

            SizedBox(height: 20,),
            Text("${widget.product!.detail}")
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff464040),
        body: Container(
          width: Get.width,
          height: Get.height,
          child: Column(
            children: [
              topBox(),
               Provider.of<ProductProvider>(context, listen: true).loadingProduct
              ? Expanded(
                child: Center(
                    child: CircularProgressIndicator.adaptive(backgroundColor: Colors.white,),
                  ),
              )
              : Provider.of<ProductProvider>(context, listen: true).currentProduct == null
                ? Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("Ochs!! Something went wrong. Try again", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100, color: Colors.white54,),),
                        SizedBox(height: 20,),
                        InkWell(
                          onTap: (){
                            Provider.of<ProductProvider>(context, listen: false).getProduct(widget.product!.id);
                          },
                          child: Icon(MdiIcons.refresh, color:  Colors.white,),
                        )
                      ],
                    ),
                )
              : Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      imageContainer(),
                      SizedBox(height: 30,),
                      btnRows(),
                      SizedBox(height: 30,),

                      detailsContainer()
                      
                      
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
