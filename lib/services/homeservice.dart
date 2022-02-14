import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ems/utils/api.dart';
import 'package:ems/utils/sharedprefs.dart';

class HomeService {

  Future<dynamic> getPlazaHomeDataRequest(lat, lng) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = Api.BASE_URL + "plaza/get-plaza-home?lat=" + lat.toString() + "&lng=" + lng.toString();
    print(url);
    var dio = Dio();
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
 
  Future<dynamic> getBusinessesByPlazaRequest(plazaId, page) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = Api.BASE_URL + "business/get-business-by-plaza?page=" + page.toString() + "&plazaId=" + plazaId;
    print(url);
    var dio = Dio();
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
  
  Future<dynamic> getProductsByPlazaRequest(plazaId, page) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = Api.BASE_URL + "product/get-product-by-plaza?page=" + page.toString() + "&plazaId=" + plazaId;
    print(url);
    var dio = Dio();
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
  
  Future<dynamic> getAllPlazasRequest(userId, page) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = Api.BASE_URL + "plaza/all-plazas?page=" + page.toString() + "&userId=" + userId;
    print(url);
    var dio = Dio();
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
 
  Future<dynamic> searchAllRequest(query) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = Api.BASE_URL + "plaza/search-all?query=$query";
    print(url);
    var dio = Dio();
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
  
  Future<dynamic> getPlazaRequest(plazaId) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = Api.BASE_URL + "plaza/get-plaza";
    print(url);
  
    
    var dio = Dio();
    try {

      var body = jsonEncode(
          <String, dynamic> {
            "plazaId": plazaId,
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