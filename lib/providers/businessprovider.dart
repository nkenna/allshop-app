import 'package:ems/services/businessservice.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:ems/models/business.dart';

class BusinessProvider with ChangeNotifier {
  BusinessService _httpService = BusinessService();

  List<Business> _userStores = [];
  List<Business> get userStores => _userStores;

  Future<dynamic> getUserBusinesses (userId) async {
  
    final response = await _httpService.getBusinessesByUserRequest(userId);

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
      _userStores.clear();
      var data = payload['businesses'];

      for (var i = 0; i < data.length; i++) {
        try {
          Business hpl = Business.fromJson(data[i]);
          hhs.add(hpl);
        } catch (e) {
          print(e);
        }
      }
      _userStores = hhs;
      notifyListeners();
      return null;

    }
    else{
      ProjectToast.showErrorToast("${payload['message']}");
      return null;
    }
  }

  Future<bool>  addBusinessRequest(name, detail, plazaId, userId, categoryId) async {
  
    final response = await _httpService.addBusinessRequest(name, detail, plazaId, userId, categoryId);

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