import 'package:ems/models/category.dart';
import 'package:ems/models/user.dart';
import 'package:ems/services/authservice.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:ems/utils/sharedprefs.dart';
import 'package:flutter/widgets.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _httpService = AuthService();
  User? _user;
  User? get user => _user;

  String? addCountryCodeToPhone(String phone){
    if(phone == null){
      return null;
    }
    else if(phone.startsWith("+")){
      return phone;
    }
    else if(!phone.startsWith("+")){
      return "+234" + phone.substring(1);
    }else{
      return phone;
    }
  }

  Future<bool> signUp (String firstName, String lastName, String password, String email,  String phone) async {
  
    final response = await _httpService.signupRequest(firstName, lastName, password, email, phone);

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
      Future.delayed(Duration(seconds: 3), () => {});

      return true;

    }
    else{
      ProjectToast.showErrorToast("${payload['message']}");
      return false;
    }
  }

  Future<bool> loginRequest (String email, String password) async {
  
    final response = await _httpService.loginRequest(email, password);

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

      var token = payload['token'];
      if(token != null){
        SharedPrefs.instance.saveToken(token);
      }
      // save user
      _user = User.fromJson(payload['user']);
      if(_user != null){
        SharedPrefs.instance.setUserData(_user!);
      }
      notifyListeners();
      Future.delayed(Duration(seconds: 3), () => {});

      return true;

    }
    else{
      ProjectToast.showErrorToast("${payload['message']}");
      return false;
    }
  }

  Future<bool>  addDeviceToken(String token, String model, String userId) async {
  
    final response = await _httpService.addDeviceTokenRequest(token, model, userId);

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

  Future<bool>  sendResetEmail(String email) async {
  
    final response = await _httpService.sendResetEmailRequest(email);

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

  Future<bool>  resetPassword(String code, String password)async {
  
    final response = await _httpService.resetPasswordRequest(code, password);

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

  Future<bool> getUserProfileDetails(String userId) async {
  
    final response = await _httpService.getUserProfileDetailsRequest(userId);

    if(response == null){
      ProjectToast.showErrorToast("It seems you are having network issues. Please check the internet connectivity and try again."); 
      return false;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      //ProjectToast.showNormalToast("${payload['message']}");

      // save user
      _user = User.fromJson(payload['user']);
      if(_user != null){
        SharedPrefs.instance.setUserData(_user!);
      }
      notifyListeners();
      return true;

    }
    else{
      ProjectToast.showErrorToast("${payload['message']}");
      return false;
    }
  }

  int _numOfStores = 0;
  int get numOfStores => _numOfStores;

  int _numOfProducts = 0;
  int get numOfProducts => _numOfProducts;

  int _numOfServices = 0;
  int get numOfServices => _numOfServices;

  Future<bool> getUserProfileData(String userId) async {
  
    final response = await _httpService.getUserProfileDataRequest(userId);

    if(response == null){
      ProjectToast.showErrorToast("It seems you are having network issues. Please check the internet connectivity and try again."); 
      return false;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      //ProjectToast.showNormalToast("${payload['message']}");

      _numOfStores = payload['numberOfBusiness'];
      _numOfProducts = payload['numberOfProducts'];
      notifyListeners();
      return true;

    }
    else{
      ProjectToast.showErrorToast("${payload['message']}");
      return false;
    }
  }

  Future<void> logout(){
    return SharedPrefs.instance.clearData();
  }

   List<Category> _categories = [];
  List<Category> get categories => _categories;
  
  Future<List<Category>?> getCategoriesByType(type) async{
    final response = await _httpService.allCategoriesRequest(type);

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
      List<Category> hhs = [];
     
      var data = payload['categories'];

      for (var i = 0; i < data.length; i++) {
        try {
          Category hpl = Category.fromJson(data[i]);
          hhs.add(hpl);
        } catch (e) {
          print(e);
        }
      }
      _categories = hhs;
      notifyListeners();
      return _categories;

    }
    else{
      ProjectToast.showErrorToast("${payload['message']}");
      return null;
    }
  }

}