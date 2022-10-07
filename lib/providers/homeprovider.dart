import 'package:ems/models/home_product.dart';
import 'package:ems/models/home_store.dart';
import 'package:ems/models/homeplazadata.dart';
import 'package:ems/models/product.dart';
import 'package:ems/models/home_service.dart' as hs;
import 'package:ems/models/searchplaza.dart';
import 'package:ems/models/service.dart';
import 'package:ems/services/homeservice.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:ems/utils/sharedprefs.dart';
import 'package:flutter/widgets.dart';

class HomeProvider with ChangeNotifier {
  final HomeService _httpService = HomeService();

  List<HomePlazaData> _homePlazaData = [];
  List<HomePlazaData> get homePlazaData => _homePlazaData;

  List<HomeProduct> _homeProductData = [];
  List<HomeProduct> get homeProductData => _homeProductData;

  List<HomeStore> _homeStoreData = [];
  List<HomeStore> get homeStoreData => _homeStoreData;

  List<hs.HomeService> _homeServiceData = [];
  List<hs.HomeService> get homeServiceData => _homeServiceData;

  Future<dynamic> getPlazaHomeDataRequest (lat, lng) async {
  
    final response = await _httpService.getPlazaHomeDataRequest(lat, lng);

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

      List<HomePlazaData> hhs = [];
      _homePlazaData.clear();
      var data = payload['locations'];

      for (var i = 0; i < data.length; i++) {
        try {
          HomePlazaData hpl = HomePlazaData.fromJson(data[i]);
          hhs.add(hpl);
        } catch (e) {
          print(e);
        }
      }
      _homePlazaData = hhs;
      notifyListeners();

      List<HomeProduct> hhp = [];
      _homeProductData.clear();
      var datap = payload['products'];
      print(payload['products']);

      for (var i = 0; i < datap.length; i++) {
        try {
          HomeProduct hpp = HomeProduct.fromJson(datap[i]);
          hhp.add(hpp);
        } catch (e) {
          print(e);
        }
      }
      print("ridgt size: ${hhp.length}");
      _homeProductData = hhp;
       print("ridgt size2: ${_homeProductData.length}");
      notifyListeners();

      List<HomeStore> hss = [];
      _homeStoreData.clear();
      var datas = payload['business'];

      for (var i = 0; i < datas.length; i++) {
       // try {
          HomeStore hs = HomeStore.fromJson(datas[i]);
          hss.add(hs);
       // } catch (e) {
       //   print(e);
     //   }
      }
      _homeStoreData = hss;

      List<hs.HomeService> hos = [];
      _homeServiceData.clear();
      var datahs = payload['services'];

      for (var i = 0; i < datahs.length; i++) {
        try {
          hs.HomeService hns = hs.HomeService.fromJson(datahs[i]);
          hos.add(hns);
        } catch (e) {
          print(e);
        }
      }
      _homeServiceData = hos;


      notifyListeners();
      return null;

    }
    else{
      ProjectToast.showErrorToast("${payload['message']}");
      return null;
    }
  }

  List<SearchPlaza> _searchPlazas = [];
  List<SearchPlaza> get searchPlazas => _searchPlazas;

  List<Product> _searchProducts = [];
  List<Product> get searchProducts => _searchProducts;

  List<HomeStore> _searchStores = [];
  List<HomeStore> get searchStores  => _searchStores;

  

  
  
  Future<dynamic> searchAll(query) async {
  
    final response = await _httpService.searchAllRequest(query);

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

      List<SearchPlaza> sps = [];
      _searchPlazas.clear();
      var datap = payload['plazas'];

      for (var i = 0; i < datap.length; i++) {
        try {
          SearchPlaza hpl = SearchPlaza.fromJson(datap[i]);
          sps.add(hpl);
        } catch (e) {
          print(e);
        }
      }
      _searchPlazas = sps;
      notifyListeners();

      List<Product> spp = [];
      _searchProducts.clear();
      var datapp = payload['products'];

      print("search product len: ${datapp.length}" );

      for (var i = 0; i < datapp.length; i++) {
        //try {
          Product hpl = Product.fromJson(datapp[i]);
          spp.add(hpl);
        //} catch (e) {
        //  print(e);
        //}
      }
      _searchProducts = spp;
      print("final product len: ${_searchProducts.length}" );
      notifyListeners();

      List<HomeStore> spps = [];
      _searchStores.clear();
      var datapps = payload['business'];

      for (var i = 0; i < datapps.length; i++) {
        try {
          HomeStore hpl = HomeStore.fromJson(datapps[i]);
          spps.add(hpl);
        } catch (e) {
          print(e);
        }
      }
      _searchStores = spps;
      notifyListeners();

      return null;

    }
    else{
      ProjectToast.showErrorToast("${payload['message']}");
      return null;
    }
  }

}