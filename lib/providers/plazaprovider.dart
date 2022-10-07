import 'package:ems/models/business.dart';
import 'package:ems/models/plaza.dart' as pl;
import 'package:ems/models/product.dart' as pr;
import 'package:ems/services/homeservice.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:flutter/cupertino.dart';

class PlazaProvider with ChangeNotifier {
  final HomeService _httpService = HomeService();

  List<Business> _plazaBusinesses = [];
  List<Business> get plazaBusinesses => _plazaBusinesses;

  Future<dynamic> getPlazaBusinesses (plazaId, page) async {
  
    final response = await _httpService.getBusinessesByPlazaRequest(plazaId, page);

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

      List<Business> hhs = [];
      _plazaBusinesses.clear();
      var data = payload['businesses'];

      for (var i = 0; i < data.length; i++) {
        try {
          Business hpl = Business.fromJson(data[i]);
          hhs.add(hpl);
        } catch (e) {
          print(e);
        }
      }
      _plazaBusinesses = hhs;
      notifyListeners();
      return null;

    }
    else{
      ProjectToast.showErrorToast("${payload['message']}");
      return null;
    }
  }

  List<pr.Product> _plazaProducts = [];
  List<pr.Product> get plazaProducts => _plazaProducts;

  Future<dynamic> getPlazaProducts (plazaId, page) async {
  
    final response = await _httpService.getProductsByPlazaRequest(plazaId, page);

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

      List<pr.Product> hhs = [];
      _plazaProducts.clear();
      var data = payload['products'];

      for (var i = 0; i < data.length; i++) {
        try {
          pr.Product hpl = pr.Product.fromJson(data[i]);
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

  List<pl.Plaza> _plazas = [];
  List<pl.Plaza> get plazas => _plazas;

  pl.Plaza? _currentPlaza;
  pl.Plaza? get currentPlaza => _currentPlaza;

  int _totalPlazas = 0;
  int get totalPlazas => _totalPlazas;

  int _totalPlazaPages = 0;
  int get totalPlazaPages => _totalPlazaPages;

  Future<List<pl.Plaza>?> getAllPlazas (userId, page) async {
  
    final response = await _httpService.getAllPlazasRequest(userId, page);

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

      List<pl.Plaza> hhs = [];
      if(page == 1){
        _plazas.clear();
      }
      
      var data = payload['plazas'];
      _totalPlazas = payload['total'];
      _totalPlazaPages = (_totalPlazas/payload['perPage']).ceil();

      for (var i = 0; i < data.length; i++) {
        try {
          pl.Plaza hpl = pl.Plaza.fromJson(data[i]);
          hhs.add(hpl);
        } catch (e) {
          print(e);
        }
      }
      _plazas.addAll(hhs);
      notifyListeners();
      return _plazas;

    }
    else{
      ProjectToast.showErrorToast("${payload['message']}");
      return null;
    }
  }


  Future<List<pl.Plaza>?> searchForPlaza(query) async {
  
    final response = await _httpService.searchForPlazaRequest(query);

    if(response == null){
      ProjectToast.showErrorToast("It seems you are having network issues. Please check the internet connectivity and try again."); 
      return null;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      //ProjectToast.showNormalToast("${payload['message']}");

      List<pl.Plaza> hhs = [];
      _plazas.clear();
      
      var data = payload['plazas'];
     // _totalPlazas = payload['total'];
      //_totalPlazaPages = (_totalPlazas/payload['perPage']).ceil();

      for (var i = 0; i < data.length; i++) {
        try {
          pl.Plaza hpl = pl.Plaza.fromJson(data[i]);
          hhs.add(hpl);
        } catch (e) {
          print(e);
        }
      }
      _plazas.addAll(hhs);
      notifyListeners();
      return _plazas;

    }
    else{
      ProjectToast.showErrorToast("${payload['message']}");
      return null;
    }
  }

  bool _loadingPlaza = false;
  bool get loadingPlaza => _loadingPlaza;

  setLoadingPlaza(bool v){
    _loadingPlaza = v;
    notifyListeners();
  }
  
  Future<pl.Plaza?>? getPlaza (plazaId) async {
    _currentPlaza = null;
    setLoadingPlaza(true);
  
    final response = await _httpService.getPlazaRequest(plazaId);

    if(response == null){
      setLoadingPlaza(false);
      ProjectToast.showErrorToast("It seems you are having network issues. Please check the internet connectivity and try again."); 
      return null;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      setLoadingPlaza(false);
      ProjectToast.showNormalToast("${payload['message']}");

      _currentPlaza =  pl.Plaza.fromJson(payload['plaza']);
      notifyListeners();
      return _currentPlaza;
    }
    else{
      setLoadingPlaza(false);
      ProjectToast.showErrorToast("${payload['message']}");
      return null;
    }
  }

  
}