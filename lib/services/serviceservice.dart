import 'dart:convert';
import 'dart:io';
//import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:ems/utils/api.dart';
import 'package:ems/utils/sharedprefs.dart';

class ServiceService {

  Future<dynamic> getServicesByUserRequest(userId, page) async {
    //String? token = await SharedPrefs.instance.retrieveString("token");
    //print("the token");
    //print(token);

    var url = Api.BASE_URL + "service/get-services-by-user?userId=$userId" + "&page=$page";
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
              //HttpHeaders.authorizationHeader: 'Bearer ' + token!
            }
        ),
      );
     // print("this response");
     // print(response);
      return response;
    } on DioError catch (e) {
      return e.response != null ? e.response : null;
    }
  }
  
  Future<dynamic> addServiceRequest(name, detail, businessId, userId, categoryId) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = Api.BASE_URL + "service/create-service";
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
              "name": name,
              "detail": detail,
              "userId": userId,
              "categoryId": categoryId,
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

  Future<dynamic> getServiceDetailsRequest(serviceId) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = Api.BASE_URL + "service/get-service?serviceId=$serviceId";
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
  

}