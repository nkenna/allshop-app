import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:ems/utils/api.dart';
import 'package:dio/dio.dart';
import 'package:ems/utils/sharedprefs.dart';

class AuthService {
  
  Future<dynamic> signupRequest(String firstName, String lastName, String password, String email,  String phone) async {

    var url = Api.BASE_URL + "user/create-user";
    print(url);
    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "firstname": firstName,
            "lastname": lastName,
            "password": password,
            "phone": phone,
            "email": email
          }
      );
      print(body);

      dio.options.connectTimeout = 35000;
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
            contentType: 'application/json',
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
            }
        ),
      );
      print("this response");
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response != null ? e.response : null;
    }
  }


  Future<dynamic> loginRequest(String email, String password) async {

    var url = Api.BASE_URL + "user/login-user";
      print(url);
    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "password": password,
            "email": email
          }
      );
      print("body: ${body}");

      dio.options.connectTimeout = 35000;
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
            contentType: 'application/json',
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
            }
        ),
      );
      print("this response");
      print(response);
      return response;
    } on DioError catch (e) {
      print(e);
      return e.response != null ? e.response : null;
    }
  }

  Future<dynamic> addDeviceTokenRequest(String tok, String model, String userId) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    
    String os = Platform.isAndroid ? "android" : "ios";

    var url = Api.BASE_URL + "user/add-update-device";
    print(url);
    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "token": tok,
            "deviceModel": model,
            "os": os,
            "userId": userId
          }
      );
      print(body);

      dio.options.connectTimeout = 35000;
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
            contentType: 'application/json',
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
              HttpHeaders.authorizationHeader: 'Bearer ' + token!
            }
        ),
      );
      print("this response");
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response != null ? e.response : null;
    }
  }

  Future<dynamic> sendResetEmailRequest(String email) async {
    //String? token = await SharedPrefs.instance.retrieveString("token");

    var url = Api.BASE_URL + "user/user-send-reset-email";
    print(url);
    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "email": email
          }
      );
      print(body);

      dio.options.connectTimeout = 35000;
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
            contentType: 'application/json',
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
            }
        ),
      );
      print("this response");
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response != null ? e.response : null;
    }
  }

  Future<dynamic> resetPasswordRequest(String code, String password) async {
    //String? token = await SharedPrefs.instance.retrieveString("token");

    var url = Api.BASE_URL + "user/user-reset-password";
    print(url);
    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "password": password,
            "code": code
          }
      );
      print(body);

      dio.options.connectTimeout = 35000;
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
            contentType: 'application/json',
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
            }
        ),
      );
      print("this response");
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response != null ? e.response : null;
    }
  }

  Future<dynamic> getUserProfileDetailsRequest(String userId) async {
    String? token = await SharedPrefs.instance.retrieveString("token");

    var url = Api.BASE_URL + "user/user-profile-by-id";
    print(url);
    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {

      var body = jsonEncode(
          <String, dynamic>{
            "userId": userId
          }
      );
      print(body);

      dio.options.connectTimeout = 35000;
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
            contentType: 'application/json',
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
               HttpHeaders.authorizationHeader: 'Bearer ' + token!
            }
        ),
      );
      print("this response");
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response != null ? e.response : null;
    }
  }

  Future<dynamic> getUserProfileDataRequest(String userId) async {
    String? token = await SharedPrefs.instance.retrieveString("token");


    var url = Api.BASE_URL + "user/user-profie-data?userId=$userId";
    print(url);
    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {

      dio.options.connectTimeout = 35000;
      Response response = await dio.get(
        url,
        options: Options(
            contentType: 'application/json',
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
               HttpHeaders.authorizationHeader: 'Bearer ' + token!
            }
        ),
      );
      print("this response");
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response != null ? e.response : null;
    }
  }

  Future<dynamic> allCategoriesRequest(type) async {

    var url = Api.BASE_URL + "category/categories-by-type?type=$type";
    print(url);
    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {


      dio.options.connectTimeout = 35000;
      Response response = await dio.get(
        url,
        options: Options(
            contentType: 'application/json',
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
            }
        ),
      );
      print("this response");
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response != null ? e.response : null;
    }
  }

  Future<dynamic> editProfilePicRequest(File imageFile,  Map<String, dynamic> dataToSendMap) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    

    if(imageFile != null){
      String fileName = imageFile.path.split('/').last;
      dataToSendMap['avatar'] = await MultipartFile.fromFile(imageFile.path, filename: fileName);
    }


    print(dataToSendMap);

    var url = Api.BASE_URL + "user/edit-profile-avatar";
    print("url $url");
   
    try {


      FormData data = FormData.fromMap(dataToSendMap);
      
      Dio _dio = Dio();
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
          return client;
        };
      
      _dio.options.headers["authorization"] = "Bearer $token";
     

      print("data body ======= ${data.fields}");

      final response = await _dio.post(url, data: data,
      options: Options(
            contentType: 'application/json',
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
              HttpHeaders.authorizationHeader: 'Bearer ' + token!
            }
        ), 
        onSendProgress: (a, b){
          print(a);
          print(b);
        }
      );
      
      print("this response");
      print(response.statusCode);
      return response;
    } on DioError catch (e) {
      print("error here =====${e.response}");
     
       return e.response != null ? e.response : null;
    }
}

  Future<dynamic> googleLoginRequest(idToken, accessToken) async {
    var url = Api.BASE_URL + "user/google-login?idToken=${idToken}&accessToken=${accessToken}";
    
    print(url);
   
    var dio = Dio();
    try {

      dio.options.connectTimeout = 35000;
      Response response = await dio.get(
        url,
        //data: json.encode(data),
        options: Options(
            contentType: 'application/json',
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.acceptHeader: 'application/json',
            }
        ),
      );
      print("this response");
      print(response.statusCode);
      return response;
    } on DioError catch (e) {
      return e.response != null ? e.response : null;
    }
  }
}

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}