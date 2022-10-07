import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:ems/utils/api.dart';
import 'package:ems/utils/sharedprefs.dart';
import 'package:http_parser/http_parser.dart';

class BusinessService {

  Future<dynamic> getProductsByBusinessRequest(businessId, page) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = Api.BASE_URL + "product/get-product-by-business?page=" + page.toString() + "&businessId=" + businessId;
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
  
  Future<dynamic> getBusinessesByUserRequest(userId) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = Api.BASE_URL + "business/get-business-by-user?userId=$userId";
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
  
  Future<dynamic> addBusinessRequest(name, detail, plazaId, userId, categoryId, address, contactPhone) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = Api.BASE_URL + "business/create-business";
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
                "name": name,
                "detail": detail,
                "plazaId": plazaId,
                "userId": userId,
                "categoryId": categoryId,
                "address": address,
                "contactPhone": contactPhone
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

  Future<dynamic> uploadBusinessImageRequest(userId, businessId, File file) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    var url = Api.BASE_URL  + "business/edit-business-image";
    print(url);

    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {
      dio.options.headers = {
        HttpHeaders.acceptHeader: 'multipart/form-data',
        HttpHeaders.contentTypeHeader: 'multipart/form-data',
        HttpHeaders.authorizationHeader: 'Bearer ' + token!
      };


      FormData formdata;
      formdata = new FormData.fromMap({
        "userId": userId,
        "businessId": businessId,
        'avatar': await MultipartFile.fromFile(file.path, contentType: MediaType("image", "png"))
      });


      //print(file.path);
      print(formdata.fields);
      print(formdata.files.first.value.contentType);
      dio.options.connectTimeout = 35000;
      Response response = await dio.post(
        url,
        data: formdata,
        options: Options(
            contentType: 'multipart/form-data',
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer ' + token
            }

        ),
      );
      print("this response");
      print(response.statusCode);
      print(response);

      print("this response ends");
      print("");
      print("");
      print(response.data);
      return response;
    } on DioError catch (e) {

      return e.response != null ? e.response : null;
    }
  }

  Future<dynamic> editBusinessRequest(name, detail, plazaId, userId, categoryId, address, contactPhone, businessId) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = Api.BASE_URL + "business/edit-business";
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
                "name": name,
                "detail": detail,
                "plazaId": plazaId,
                "userId": userId,
                "categoryId": categoryId,
                "address": address,
                "contactPhone": contactPhone,
                "businessId": businessId
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

}