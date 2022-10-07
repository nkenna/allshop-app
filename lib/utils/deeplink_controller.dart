
import 'package:ems/models/product.dart';
import 'package:ems/utils/api.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';


class DeepLinkController {
  static FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;



  static IOSParameters iosParameters = IOSParameters(
    bundleId: "com.steinacoz.allshop",
    appStoreId: '1498909115',
  );


  static Future<String> createDynamicLinkPost(Product product) async {

    final DynamicLinkParameters parameters = DynamicLinkParameters( //"account/cards/$cardSlug"
      uriPrefix: 'https://allshoppf.page.link',
      link: Uri.parse('${Api.BASE_URL}product/get-public-product?productId=${product.id}'),
      androidParameters: AndroidParameters(
        packageName: "com.steinacoz.allshop",
      ),
      
       iosParameters: iosParameters,
       socialMetaTagParameters: SocialMetaTagParameters(
        title: '${product.name ?? ''}',
        description: '${product.detail ?? ''} - See more on Allshop Platform',
        imageUrl: product.images!.isNotEmpty
        ? Uri.parse('${Api.IMAGE_BASE_URL}${product.images!.first.imageUrl}')
        : null
      ),

      /*googleAnalyticsParameters: const GoogleAnalyticsParameters(
        source: "twitter",
        medium: "social",
        campaign: "example-promo",
      ),*/
    );
    // ignore: unused_local_variable
  
    //var dynamicUrl = await dynamicLinks.buildLink(parameters);
    var shortLink = await  dynamicLinks.buildShortLink(parameters);
    var shortUrl = shortLink.shortUrl;

    return shortUrl.toString();
  }


}