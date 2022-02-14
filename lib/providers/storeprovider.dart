import 'package:ems/models/product.dart';
import 'package:ems/services/businessservice.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:flutter/widgets.dart';

class StoreProvider with ChangeNotifier {
  final BusinessService _httpService = BusinessService();

  List<Product> _plazaProducts = [];
  List<Product> get plazaProducts => _plazaProducts;
  int _totalProducts = 0;
  int get totalProducts => _totalProducts;

  Future<dynamic> getStoreProducts (businessId, page) async {
  
    final response = await _httpService.getProductsByBusinessRequest(businessId, page);

    if(response == null){
      ProjectToast.showErrorToast("It seems you are having network issues. Please check the internet connectivity and try again."); 
      return null;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      ProjectToast.showNormalToast("${payload['message']}");

      List<Product> hhs = [];
      _plazaProducts.clear();
      var data = payload['products'];
      _totalProducts = payload['total'];

      for (var i = 0; i < data.length; i++) {
        try {
          Product hpl = Product.fromJson(data[i]);
          hhs.add(hpl);
        } catch (e) {
          print(e);
        }
      }
      _plazaProducts = hhs;
      notifyListeners();
      return null;

    }
    else{
      ProjectToast.showErrorToast("${payload['message']}");
      return null;
    }
  }



}