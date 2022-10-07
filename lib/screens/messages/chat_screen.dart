import 'package:ems/models/message.dart';
import 'package:ems/providers/authprovider.dart';
import 'package:ems/providers/messageprovider.dart';
import 'package:ems/utils/project_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  final String? conservationId;
  final String? recieverId;
  final dynamic reciever;
  const ChatScreen({ Key? key, this.conservationId, this.recieverId, this.reciever }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Future<List<Message>?>? _futureMsgs;
  int currentPage = 1;
  TextEditingController msgController = TextEditingController();
  bool _loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  initData(){
    _futureMsgs = Provider.of<MessageProvider>(context, listen: false).getMessagesByConversation(
      currentPage,
      widget.conservationId!
    );
  }

  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
     // webViewConfiguration: const WebViewConfiguration(
     //     headers: <String, String>{'my_header_key': 'my_header_value'}),
    )
    ) {
      throw 'Could not launch $url';
    }
  }

  Widget testMsgBox(Message msg){
    var user = Provider.of<AuthProvider>(context, listen: false).user;
    bool sentByUser = user!.id == msg.senderId;
    print(sentByUser);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Align(
        alignment: sentByUser ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: Container(
                //width:  Get.width * 0.6,
                constraints: BoxConstraints(maxWidth: Get.width * 0.6),
                decoration: BoxDecoration(
                  //border: Border.all(width: 2, color: _chatToDelete != null && (_chatToDelete.id == nData.id) ? Colors.grey : Colors.transparent),
                  color: sentByUser ? Color(0xfffd5343) : Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                padding: EdgeInsets.all(8),
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableLinkify(
                      onOpen: (le)async{
                        _launchInWebViewOrVC(Uri.parse(le.url));
                      },
                      //textScaleFactor: 1.3,
                      text: msg.content ?? "",
                      style: TextStyle(color: sentByUser ? Colors.white : Colors.black),
                    ),
                    
                    //Text(nData.content != null ? nData.content.capitalizeFirst : "", style: TextStyle(color: nData.sender.toLowerCase() == "user" ? Colors.white : Colors.black),),
                    /*Divider(
                      thickness: 2,
                      height: 15,
                    ),*/
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("${Jiffy(msg.createdAt).format("dd-MM-yyyy hh:mm a")}", style: TextStyle(fontSize: 12, color: sentByUser ? Colors.white : Colors.black,),),
                        //Text("10-01-2022 10:11 pm", style: TextStyle(fontSize: 12, color: Color(0xff333333)),),
                      ],
                    )
                  ],
                ),
              ),
            ),
      ),
    );
  }

  
  Widget chatContainer(){
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: msgController,
                  style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 14, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    hintText: "Type chat here...",
                    hintStyle: TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontSize: 14, fontWeight: FontWeight.w400),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.white)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.white)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.white)
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: () async{
                var cProvider = Provider.of<MessageProvider>(context,listen: false);
                if(msgController.text.isEmpty){
                  ProjectToast.showErrorToast("Chat message is required");
                  return;
                }

                

                Map<String, dynamic> data = {};
                data['conversationId'] = widget.conservationId;
                data['senderId'] = Provider.of<AuthProvider>(context,listen: false).user!.id;
                data['recieverId'] = widget.recieverId;
                data['content'] = msgController.text;

    
                setState(() => _loading = true);
    
                var resp = await cProvider.sendMessage(
                  
                  data
                );
                setState(() => _loading = false);
    
                if(resp){
                  msgController.clear();
                  currentPage = 1;
                  _futureMsgs = Provider.of<MessageProvider>(context, listen: false).getMessagesByConversation(
                    currentPage,
                    widget.conservationId!
                  );
                  
                }
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffFECE2F)
                              
                ),
                //padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: _loading
                ? SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator.adaptive(),
                )
                : Icon(Icons.send, color: Colors.black,),
              ),
            ),
          ],
        ),
      );
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${widget.reciever.firstname != null ? widget.reciever.firstname : ''} ${widget.reciever.lastname != null ? widget.reciever.lastname : ''}"),
        ),
        backgroundColor: Color(0xff3F3F3F),
        body: FooterLayout(
          footer: KeyboardAttachable(
            child: Container(
                      width: Get.width,
                      height: 70,
                      color: Color(0xff3F3F3F),
                      child: chatContainer(),
                    ),
          ),
          child:  Container(
          width: Get.width,
          height: Get.height,
          
          child: FutureBuilder<List<Message>?>(
            future: _futureMsgs,
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator.adaptive(backgroundColor: Colors.white,),
                );
              }
              else if(snapshot.hasError){
                return Center(
                  child: Text("Error occurred retrieving data")
                );
              }
      
              else if(snapshot.hasData){
                return snapshot.data!.isEmpty
                ? Center(
                  child: Text("No message have been started"),
                )
                : ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = snapshot.data![index];
                    
                    return testMsgBox(data);
                  },
                );
              }
              else {
                return Center(
                  child: Text("Error occurred retrieving data")
                );
              }
            },
          )
        ),
      
        ),
      ),
    );
  }
  
 

}