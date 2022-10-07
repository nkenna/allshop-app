import 'package:ems/models/service.dart';
import 'package:ems/services/serviceservice.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:flutter/cupertino.dart';

class ServiceProvider with ChangeNotifier {
  final ServiceService _httpService = ServiceService();

  List<Service> _userServices = [];
  List<Service> get userServices => _userServices;

  int _userServiceTotalPage = 0;
  int get userServiceTotalPage => _userServiceTotalPage;

  Service? _selectedService;
  Service? get selectedService => _selectedService;

  Future<bool> addService(name, detail, businessId, userId, categoryId) async{
    final response = await _httpService.addServiceRequest(name, detail, businessId, userId, categoryId);

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
  

  Future<List<Service>?> getUserServices(userId, page) async {
  
    final response = await _httpService.getServicesByUserRequest(userId, page);

    if(response == null){
      ProjectToast.showErrorToast("It seems you are having network issues. Please check the internet connectivity and try again."); 
      if(page > 1){
        return _userServices;
      }
      return null;
    }

    int statusCode = response.statusCode;
    print(statusCode);
    var payload = response.data;
    //rint(payload);

    String status = payload['status'] ?? "";
    

    if (status.toLowerCase() == "success" && statusCode == 200){
      print(payload);

      ProjectToast.showNormalToast("${payload['message']}");

      
      int total = payload['total'];
      int perPage = payload['perPage'];

      if(page == 1){
        _userServices.clear();
      }

      _userServiceTotalPage = (total/perPage).ceil();
      print( _userServiceTotalPage);

      List<Service> hhs = [];
      _userServices.clear();
      var data = payload['services'];

      print(data[0]);

      for (var i = 0; i < data.length; i++) {
       try {
          Service hpl = Service.fromJson(data[i]);
          hhs.add(hpl);
       } catch (e) {
         print(e);
        }
      }
      _userServices.addAll(hhs);
      notifyListeners();
      return _userServices;

    }
    else{
      ProjectToast.showErrorToast("${payload['message']}");
      return null;
    }
  }

  Future<Service?> getServiceDetails(serviceId) async {
    final response = await _httpService.getServiceDetailsRequest(serviceId);

    if(response == null){
      ProjectToast.showErrorToast("It seems you are having network issues. Please check the internet connectivity and try again."); 
      return null;
    }

    int statusCode = response.statusCode;
    print(statusCode);
    var payload = response.data;
    print(payload);

    String status = payload['status'] ?? "";
    

    if (status.toLowerCase() == "success" && statusCode == 200){
      var data = payload['service'];

      ProjectToast.showNormalToast("${payload['message']}");
      try {
          Service hpl = Service.fromJson(data);
          _selectedService = hpl;
        } catch (e) {
          print(e);
        }
      
      notifyListeners();
      return _selectedService;

    }
    else{
      ProjectToast.showErrorToast("${payload['message']}");
      return null;
    }
  }
  
}