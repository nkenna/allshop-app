import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:ems/utils/api.dart';
import 'package:ems/utils/sharedprefs.dart';

class ProductService {

  Future<dynamic> getStarredProductsByUserRequest(userId) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = Api.BASE_URL + "product/starred-products-by-user?userId=$userId";
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
  
  Future<dynamic> getProductsByUserRequest(userId) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = Api.BASE_URL + "product/get-products-by-user?userId=$userId";
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
 
  Future<dynamic> addProductRequest(name, detail, minPrice, maxPrice, String link, businessId, userId, categoryId, List<Map<String, String>> socialLinks) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = Api.BASE_URL + "product/add-product";
    print(url);
    List<String>? _links;
    if(link != null && link.isNotEmpty){
      _links = [(Uri.parse(link).toString())];
    }
    
    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {

      var body = jsonEncode(
          <String, dynamic> {
            "name": name,
            "detail": detail,
            "minPrice": minPrice,
            "maxPrice": maxPrice,
            //"onlineLinks": _links,
            "businessId": businessId,
            "userId": userId,
            "categoryId": categoryId,
            "onlineLinks": socialLinks
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

  Future<dynamic> editProductRequest(name, detail, minPrice, maxPrice, String link, userId, categoryId, productId, List<Map<String, String>> socialLinks) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = Api.BASE_URL + "product/edit-product";
    print(url);
    List<String>? _links;
    if(link != null && link.isNotEmpty){
      _links = [(Uri.parse(link).toString())];
    }
    
    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {

      var body = jsonEncode(
          <String, dynamic> {
            "name": name,
            "detail": detail,
            "minPrice": minPrice,
            "maxPrice": maxPrice,
            //"onlineLinks": _links,
            "userId": userId,
            "categoryId": categoryId,
            "productId": productId,
            "onlineLinks": socialLinks
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


  Future<dynamic> getProductRequest(productId) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = Api.BASE_URL + "product/get-product";
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
          <String, dynamic> {
            "productId": productId,
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

  Future<dynamic> starUnstarProductRequest(userId, productId, status) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = Api.BASE_URL + "product/star-unstar-product";
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
          <String, dynamic> {
            "userId": userId,
            "productId": productId,
            "starred": status
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

  Future<dynamic> editProductPicRequest(File imageFile,  Map<String, dynamic> dataToSendMap) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    
    if(imageFile != null){
      String fileName = imageFile.path.split('/').last;
      dataToSendMap['avatar'] = await MultipartFile.fromFile(imageFile.path, filename: fileName);
    }


    print(dataToSendMap);

    var url = Api.BASE_URL + "product/edit-product-avatar";
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

}