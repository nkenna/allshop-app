
import 'dart:io';

import 'package:ems/models/product.dart';
import 'package:ems/models/starred_product.dart';
import 'package:ems/services/messageservice.dart';
import 'package:ems/services/productservices.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _httpService = ProductService();
  final MessageService _msgService = MessageService();

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
      try {
          StarredProduct hpl = StarredProduct.fromJson(data[i]);
          hhs.add(hpl);
        } catch (e) {
          print(e);
        }
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

  Future<List<Product>?> getUserProducts (userId) async {
  
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
       try {
          Product hpl = Product.fromJson(data[i]);
          hhs.add(hpl);
       } catch (e) {
         print(e);
       }
      }
      _userProducts = hhs;
      notifyListeners();
      return _userProducts;

    }
    else{
      ProjectToast.showErrorToast("${payload['message']}");
      return null;
    }
  }

  Future<bool> addProduct(name, detail, minPrice, maxPrice, String link, businessId, userId, categoryId, List<Map<String, String>> socialLinks) async{
    final response = await _httpService.addProductRequest(name, detail, minPrice, maxPrice, link, businessId, userId, categoryId, socialLinks);

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

  Future<bool> editProduct(name, detail, minPrice, maxPrice, String link, userId, categoryId, productId, List<Map<String, String>> socialLinks) async{
    final response = await _httpService.editProductRequest(name, detail, minPrice, maxPrice, link, userId, categoryId, productId, socialLinks);

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
      try{
        _currentProduct =  Product.fromJson(payload['product']);
        print('show starred: ${_currentProduct!.starred}');
        notifyListeners();
        return _currentProduct;
      }catch(e){
        print(e);
        notifyListeners();
        return null;
      }

    }
    else{
      setLoadingProduct(false);
      ProjectToast.showErrorToast("${payload['message']}");
      return null;
    }
  }

  Future<bool> starUnstarProduct(userId, productId, stat) async{
    if(stat){
      ProjectToast.showNormalToast("Adding product to star list");
    }else{
      ProjectToast.showNormalToast("removing product from star list");
    }
    final response = await _httpService.starUnstarProductRequest(userId, productId, stat);

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
  
  Future<bool> makeOfferMessage(productId, userId, offerMsg) async{
   
    final response = await _msgService.makeOfferMessageRequest(productId, userId, offerMsg);

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

  Future<bool> editProductImageRequest (File imageFile,  Map<String, dynamic> dataToSendMap, String userId) async {
  
    final response = await _httpService.editProductPicRequest(imageFile, dataToSendMap);

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

  

}