import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:ems/utils/api.dart';
import 'package:ems/utils/sharedprefs.dart';
import 'package:http_parser/http_parser.dart';

class MessageService {

  Future<dynamic> makeOfferMessageRequest(productId, userId, offerMsg) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = Api.BASE_URL + "product/make-product-offer";
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
                "productId": productId,
                "offerMsg": offerMsg,
                "userId": userId,
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

  Future<dynamic> getUserConversationsRequest(userId) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = Api.BASE_URL + "chat/all-user-chats-conv";
    print(url);

    var body = jsonEncode(
          <String, dynamic>{
                "userId": userId,
            }
          );
      print(body);
    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {

     
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
 
 Future<dynamic> getMessagesByConversationRequest(page, conversationId) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    print("the token");
    print(token);

    var url = Api.BASE_URL + "chat/all-conversation-messages?page=${page}&conversationId=$conversationId";
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

  Future<dynamic> sendMessageRequest(Map<String, dynamic> dataToSendMap) async {
    String? token = await SharedPrefs.instance.retrieveString("token");
    

    /*if(imageFile != null){
      String fileName = imageFile.path.split('/').last;
      if(imageFile != null){
        dataToSendMap['media'] = await MultipartFile.fromFile(imageFile.path, filename: fileName);
      }
      
    }*/


    print(dataToSendMap);

    var url = Api.BASE_URL + "chat/send-message";
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