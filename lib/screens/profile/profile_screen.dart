import 'package:cached_network_image/cached_network_image.dart';
import 'package:ems/models/user.dart';
import 'package:ems/providers/authprovider.dart';
import 'package:ems/screens/auth/login_screen.dart';
import 'package:ems/screens/business/my_business_screen.dart';
import 'package:ems/screens/product/my_products_screen.dart';
import 'package:ems/utils/api.dart';
import 'package:ems/utils/sharedprefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async{
    
    Provider.of<AuthProvider>(context, listen: false).getUserProfileData(
      Provider.of<AuthProvider>(context, listen: false).user!.id!
    );
  }
  
  Widget profileImage(User user){
    return CachedNetworkImage(
              imageUrl: "${Api.IMAGE_BASE_URL}${user.avatar}",
              imageBuilder: (context, imageProvider) => Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      //colorFilter:  ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                    ),
                ),
              ),
              
              progressIndicatorBuilder: (context,_, progress) => Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Center(
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(value: progress.progress,)),
                )),
              errorWidget: (context, url, error) => Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                alignment: Alignment.center,
                child: Icon(Icons.error)),
            );
  }

  Widget itemsContainer(Widget title, Widget subTitle, Widget leadingIcon, Widget trailingIcon, VoidCallback callback){
    return ListTile(
      onTap: callback,
      tileColor: Colors.white,
      leading: leadingIcon,
      title: title,
      subtitle: subTitle,
      trailing: trailingIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<AuthProvider>(
        builder: (context, aProvider, _) {
          return Container(
            width: Get.width,
            height: Get.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30,),

                  profileImage(aProvider.user!),
                  SizedBox(height: 20,),

                  Text("${aProvider.user!.firstname} ${aProvider.user!.lastname}", style: TextStyle(color: Colors.white, fontFamily: 'SofiaProMedium', fontSize: 16),),
                  SizedBox(height: 20,),

                  itemsContainer(
                    Text("Your Stores"),
                    Text("${aProvider.numOfStores} Stores"), 
                    Icon(Icons.shopping_bag), 
                    Icon(Icons.arrow_forward_ios),
                    (){
                      Get.to(() => MyBusinessScreen());
                    }
                  ),

                  itemsContainer(
                    Text("Your Products"),
                    Text("${aProvider.numOfProducts} Products"), 
                    Icon(Icons.toys_rounded), 
                    Icon(Icons.arrow_forward_ios),
                    (){
                      Get.to(() => MyProductsScreen());
                    }
                  ),

                  itemsContainer(
                    Text("Your Services - Coming Soon"),
                    Text("${aProvider.numOfServices} Services"), 
                    Icon(Icons.room_service), 
                    Icon(Icons.arrow_forward_ios),
                    (){}
                  ),

                  itemsContainer(
                    Text("Your Profile"),
                    Text("Edit Profile"), 
                    Icon(Icons.person), 
                    Icon(Icons.arrow_forward_ios),
                    (){}
                  ),

                  itemsContainer(
                    Text("Fund Wallet - Coming Soon"),
                    Text("NGN 0.00"), 
                    Icon(Icons.account_balance_wallet_rounded), 
                    Icon(Icons.arrow_forward_ios),
                    (){}
                  ),

                  itemsContainer(
                    Text("Log out"),
                    Text(""), 
                    Icon(Icons.logout_rounded), 
                    Icon(Icons.arrow_forward_ios),
                    (){
                      aProvider.logout()
                      .then((value) => Get.offAll(() => LoginScreen()) );
                    }
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}