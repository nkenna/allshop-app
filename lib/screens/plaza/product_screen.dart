import 'package:ems/models/product.dart';
import 'package:ems/providers/authprovider.dart';
import 'package:ems/providers/productprovider.dart';
import 'package:ems/screens/product/make_offer_modal.dart';
import 'package:ems/utils/api.dart';
import 'package:ems/utils/deeplink_controller.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductScreen extends StatefulWidget {
  String? productId;
  ProductScreen({ Key? key, this.productId }) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {


  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).getProduct(widget.productId)!
    .then((value) => setState((){}));
  }

  changeSelectedImage(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget topBox(){
    var product = Provider.of<ProductProvider>(context, listen: false).currentProduct;
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
              padding: const EdgeInsets.only(left: 20),
              child: InkWell(
                onTap: () => Get.back(),
                child: Container(
                  alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff30b85a),
                    ),
                    child: Icon(MdiIcons.arrowLeft, color: Colors.white,)),
              ),
            ),
            /*SizedBox(width: 30,),
            Expanded(
              child: Text("", style: const TextStyle(color: Color(0xff333333), fontSize: 14),)
            ),
            SizedBox(width: 30,),*/
            Spacer(),

            if(product != null)
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () async{
                  if(product.starred == null || product.starred ==false){
                    var resp = await Provider.of<ProductProvider>(context, listen: false).starUnstarProduct(
                        Provider.of<AuthProvider>(context, listen: false).user!.id,
                        product.id,
                        true
                    );

                    if(resp){
                      product.starred = true;
                      setState(() {});
                    }
                  }

                },
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff30b85a),
                    ),
                    child: Icon(MdiIcons.star, color: product!.starred  != null && product.starred == true ? Colors.red :   Color(0xffE5E5E5),)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () async{
                  var qId = await DeepLinkController.createDynamicLinkPost(product!);

                  if(qId == null){
                    return;
                  }

                  await Share.share('Check out: $qId', subject: 'AllShop Platform');

                },
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff30b85a),
                    ),
                    child: Icon(MdiIcons.share, color: Color(0xffE5E5E5),)),
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
    var product = Provider.of<ProductProvider>(context, listen: false).currentProduct;
    return GestureDetector(
      onHorizontalDragEnd: (dragEndDetails){
        print(dragEndDetails.primaryVelocity);
        if(dragEndDetails.primaryVelocity! > 0){ // right swipe
          if(_selectedIndex < (product!.images!.length - 1)){
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
                "${Api.IMAGE_BASE_URL}${
                  product!.images!.isNotEmpty 
                    ? product.images![_selectedIndex].imageUrl != null
                      ? product.images![_selectedIndex].imageUrl
                      : ""
                    : ""
                }", 
                width: double.infinity, 
                fit: BoxFit.cover,
                errorBuilder: (context, st, ob){
                  return Container(
                    width: Get.width,
                    height: Get.height * 0.3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/product.png"),
                        fit: BoxFit.cover
                    )
                    ),
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
                      children: List.generate(product.images!.length, (index) => smallBox(_selectedIndex == index ? true : false)),
                    ),
    
                    SizedBox(height: 10,),
    
                   /* Divider(thickness: 3, color: Color(0xff464040),),
    
                    SizedBox(height: 10,),
    
    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${product.name}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),),
                        Spacer(),
                        if(product.maxPrice != null && product.maxPrice > 0)
                          Text("NGN ${product.maxPrice != null ? product.maxPrice : 0.0}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),)
                      ],
                    )*/
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: 140,
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xff30b85a)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))
                    )
                  )
                ),
                onPressed: (){
                  Get.dialog(
                    MakeOfferModal(product: Provider.of<ProductProvider>(context, listen: false).currentProduct,),
                    barrierDismissible: false
                  );
                },
                child: Text("Make an Offer", style: TextStyle(color: Colors.white),),
              ),
          ),

          SizedBox(width: 10,),

          SizedBox(
              width: 140,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))
                    )
                  )
                ),
                onPressed: (){
                  if(Provider.of<ProductProvider>(context, listen: false).currentProduct!.business!.contactPhone != null){
                    _callNumber(Provider.of<ProductProvider>(context, listen: false).currentProduct!.business!.contactPhone);
                  }else{
                    ProjectToast.showErrorToast('Contact Phone number not available');
                  }
                },
                child: Text("Call", style: TextStyle(color: Color(0xff333333)),),
              ),
          ),
        ],
      ),
    );
  }

  _callNumber(phoneNumber) async{
    //const number = '08592119XXXX'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }

  Widget businessContainer(){
    var product = Provider.of<ProductProvider>(context, listen: false).currentProduct;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                  '${product!.business!.name ?? ''}',
                style: TextStyle(fontSize: 14, fontFamily: 'SofiaProSemiBold'),
              ),

              Text(
                  '${product.business!.address ?? ''}',
                style: TextStyle(fontSize: 12,),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.platformDefault,
    )) {
      print('Could not launch $url');
    }
  }



  Widget linkContainer(){
    var product = Provider.of<ProductProvider>(context, listen: false).currentProduct;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
            children: List.generate(product!.socialLinks!.length, (index) {
              if(product.socialLinks![index].linkTitle == 'website'){
                return ListTile(
                  onTap: (){
                    _launchInBrowser(Uri.parse(product.socialLinks![index].linkUrl!));
                  },
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 5,
                  minLeadingWidth: 6,
                  leading: FaIcon(FontAwesomeIcons.internetExplorer, size: 20,),
                  title: Text('View on Website'),
                );
              }

              else if(product.socialLinks![index].linkTitle == 'facebook'){
                return ListTile(
                  onTap: (){
                    _launchInBrowser(Uri.parse(product.socialLinks![index].linkUrl!));
                  },
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 5,
                  minLeadingWidth: 6,
                  leading: FaIcon(FontAwesomeIcons.facebook, size: 20,),
                  title: Text('View on Facebook'),
                );
              }

              else if(product.socialLinks![index].linkTitle == 'twitter'){
                return ListTile(
                  onTap: (){
                    _launchInBrowser(Uri.parse(product.socialLinks![index].linkUrl!));
                  },
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 5,
                  minLeadingWidth: 6,
                  leading: FaIcon(FontAwesomeIcons.twitter, size: 20,),
                  title: Text('View on Twitter'),
                );
              }

              else if(product.socialLinks![index].linkTitle == 'instagram'){
                return ListTile(
                  onTap: (){
                    _launchInBrowser(Uri.parse(product.socialLinks![index].linkUrl!));
                  },
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 5,
                  minLeadingWidth: 6,
                  leading: FaIcon(FontAwesomeIcons.instagram, size: 20,),
                  title: Text('View on Instagram'),
                );
              }

              else if(product.socialLinks![index].linkTitle == 'instagram'){
                return ListTile(
                  onTap: (){
                    _launchInBrowser(Uri.parse(product.socialLinks![index].linkUrl!));
                  },
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 5,
                  minLeadingWidth: 6,
                  leading: FaIcon(FontAwesomeIcons.tiktok, size: 20,),
                  title: Text('View on tiktok'),
                );
              }

              return SizedBox(height: 0,);
              
            })
          ),
    );
  }

  Widget detailsContainer(){
    var product = Provider.of<ProductProvider>(context, listen: false).currentProduct;
    return Container(
      width: Get.width,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //SizedBox(height: 30,),
          //Text("Product Details", style: TextStyle(decorationThickness: 3, decoration: TextDecoration.underline, fontWeight: FontWeight.w700, fontSize: 16),),

          SizedBox(height: 20,),
          Text("${product!.detail ?? ''}")
        ],
      ),
    );
  }

  Widget titleContainer(){
    var product = Provider.of<ProductProvider>(context, listen: false).currentProduct;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${product!.name ?? ''}',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'SofiaProBold'
            )
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                  '${product.category!.name ?? ''}',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff626262)

                ),
              ),

              Spacer(),

              Icon(Icons.star, color: Color(0xff30b85a), size: 14,),
              SizedBox(width: 5,),

              Text(
                '${product.avgRating} (${product.ratingCount})',
                style: TextStyle(
                  fontSize: 12,
                    color: Color(0xff626262)

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

        backgroundColor: Colors.white,
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
                            Provider.of<ProductProvider>(context, listen: false).getProduct(widget.productId);
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
                      titleContainer(),
                      btnRows(),
                      Divider(),
                      businessContainer(),
                      linkContainer(),
                      Divider(),

                      //SizedBox(height: 30,),

                      Divider(),

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
