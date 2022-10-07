import 'dart:io';

import 'package:ems/models/conversation.dart';
import 'package:ems/models/message.dart';
import 'package:ems/services/messageservice.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:flutter/widgets.dart';

class MessageProvider with ChangeNotifier {
  final MessageService _httpService = MessageService();

  List<Conversation> _conversations = [];
  List<Conversation> get conversations => _conversations;

  List<Message> _messages = [];
  List<Message> get messages => _messages;

  int _totalMessages = 0;
  int get totalMessages => _totalMessages;

  int _totalMessagesPages = 0;
  int get totalMessagesPages => _totalMessagesPages;

  Future<List<Conversation>?> getUserConversations(userId) async {
  
    final response = await _httpService.getUserConversationsRequest(userId);

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

      List<Conversation> hhs = [];
      _conversations.clear();
      var data = payload['conversations'];

      for (var i = 0; i < data.length; i++) {
       try {
          Conversation hpl = Conversation.fromJson(data[i]);
          hhs.add(hpl);
        } catch (e) {
        print(e);
       }
      }
      _conversations = hhs;
      notifyListeners();
      return conversations;

    }
    else{
      ProjectToast.showErrorToast("${payload['message']}");
      return null;
    }
  }

  Future<List<Message>?> getMessagesByConversation(page, conversationId) async {
  
    final response = await _httpService.getMessagesByConversationRequest(page, conversationId);

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

      List<Message> hhs = [];
    
      var data = payload['messages'];
       if(page == 1){
        _messages.clear();
      }
      
  
      _totalMessages = payload['total'] ?? 0;
      _totalMessagesPages = (_totalMessages/payload['perPage']).ceil();
      

      for (var i = 0; i < data.length; i++) {
       try {
          Message hpl = Message.fromJson(data[i]);
          hhs.add(hpl);
        } catch (e) {
        print(e);
       }
      }
      _messages = hhs;
      notifyListeners();
      return _messages;

    }
    else{
      ProjectToast.showErrorToast("${payload['message']}");
      return null;
    }
  }

  Future<bool> sendMessage (Map<String, dynamic> dataToSendMap) async {
  
    final response = await _httpService.sendMessageRequest(dataToSendMap);

    if(response == null){
      ProjectToast.showErrorToast("It seems you are having network issues. Please check the internet connectivity and try again."); 
      return false;
    }

    int statusCode = response.statusCode;
    var payload = response.data;
    print(payload);

    String status = payload['status'] ?? "";

    if (status.toLowerCase() == "success" && statusCode == 200){
      
      return true;

    }
    else{
      ProjectToast.showErrorToast("${payload['message']}");
      return false;
    }
  }


}