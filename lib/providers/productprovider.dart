
import 'package:ems/models/product.dart';
import 'package:ems/models/starred_product.dart';
import 'package:ems/services/productservices.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _httpService = ProductService();

  List<StarredProduct> _sProducts = [];
  List<StarredProduct> get sProducts => _sProducts;

  Future<List<StarredProduct>?>? getStarredProductsByUser(userId) async {
  
    final response = await _httpService.getStarredProductsByUserRequest(userId);
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

      List<StarredProduct> hhs = [];
      _sProducts.clear();
      var data = payload['products'];

      for (var i = 0; i < data.length; i++) {
        //print(data[i].runtimeType);
      //  try {
          StarredProduct hpl = StarredProduct.fromJson(data[i]);
          hhs.add(hpl);
      //  } catch (e) {
      //    print(e);
      //  }
      }
      _sProducts = hhs;
      notifyListeners();
      return _sProducts;

    }
    else{
      ProjectToast.showErrorToast("${payload['message']}");
      return null;
    }
  }

  List<Product> _userProducts = [];
  List<Product> get userProducts => _userProducts;

  Future<dynamic> getUserProducts (userId) async {
  
    final response = await _httpService.getProductsByUserRequest(userId);

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
      _userProducts.clear();
      var data = payload['products'];

      for (var i = 0; i < data.length; i++) {
       // try {
          Product hpl = Product.fromJson(data[i]);
          hhs.add(hpl);
       // } catch (e) {
         // print(e);
       // }
      }
      _userProducts = hhs;
      notifyListeners();
      return null;

    }
    else{
      ProjectToast.showErrorToast("${payload['message']}");
      return null;
    }
  }

  Future<bool> addProduct(name, detail, minPrice, maxPrice, String link, businessId, userId, categoryId) async{
    final response = await _httpService.addProductRequest(name, detail, minPrice, maxPrice, link, businessId, userId, categoryId);

    if(response == null){
      ProjectToast.showErrorToast("It seems you are having network issues. Please check the internet connectivity and try again."); 
      return false;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      ProjectToast.showNormalToast("${payload['message']}");
      return true;

    }
    else{
      ProjectToast.showErrorToast("${payload['message']}");
      return false;
    }
  }
  
  Product? _currentProduct;
  Product? get currentProduct => _currentProduct;

  bool _loadingProduct = false;
  bool get loadingProduct => _loadingProduct;

  setLoadingProduct(bool v){
    _loadingProduct = v;
    notifyListeners();
  }
  
  Future<Product?>? getProduct (productId) async {
    _currentProduct = null;
    setLoadingProduct(true);
  
    final response = await _httpService.getProductRequest(productId);

    if(response == null){
      setLoadingProduct(false);
      ProjectToast.showErrorToast("It seems you are having network issues. Please check the internet connectivity and try again."); 
      return null;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      setLoadingProduct(false);
      ProjectToast.showNormalToast("${payload['message']}");

      _currentProduct =  Product.fromJson(payload['product']);
      notifyListeners();
      return _currentProduct;
    }
    else{
      setLoadingProduct(false);
      ProjectToast.showErrorToast("${payload['message']}");
      return null;
    }
  }


}