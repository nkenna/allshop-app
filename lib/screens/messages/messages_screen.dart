import 'package:ems/models/conversation.dart';
import 'package:ems/providers/authprovider.dart';
import 'package:ems/providers/messageprovider.dart';
import 'package:ems/screens/messages/chat_screen.dart';
import 'package:ems/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({ Key? key }) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  Future<List<Conversation>?>? _futureConversations;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  initData(){
    _futureConversations = Provider.of<MessageProvider>(context, listen: false).getUserConversations(
      Provider.of<AuthProvider>(context, listen: false).user!.id
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      
      child: FutureBuilder<List<Conversation>?>(
        future: _futureConversations,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator.adaptive(backgroundColor: Colors.white,),
            );
          }
          else if(snapshot.hasError){
            return Center(
              child: Text("Error occurred retrieving data",style: TextStyle(color: Colors.white,))
            );
          }

          else if(snapshot.hasData){
            return snapshot.data!.isEmpty
            ? Center(
              child: Text("No conversation have been started",style: TextStyle(color: Colors.white,)),
            )
            : ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data![index];
                var profile = Provider.of<AuthProvider>(context, listen: false).user;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    color: Colors.white,
                    child: ListTile(
                      onTap: (){
                        var recieverId = data.user1Id == profile!.id
                          ? data.user2Id
                          : data.user1Id;
                        dynamic reciever = recieverId == profile.id
                          ? data.user2
                          : data.user1;
                        Get.to(() => ChatScreen(conservationId: data.id, recieverId: recieverId, reciever: reciever));
                      },
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundImage: data.user1Id == profile!.id
                        ? NetworkImage("${Api.IMAGE_BASE_URL}${data.user2!.avatar}")
                        : NetworkImage("${Api.IMAGE_BASE_URL}${data.user1!.avatar}"),
                      ),
                      title: data.user1Id == profile.id
                      ? Text("${data.user2!.firstname} ${data.user2!.lastname}")
                      : Text("${data.user1!.firstname} ${data.user1!.lastname}"),
                      subtitle: Text("${data.lastMessage != null ? data.lastMessage!.content : ""}", maxLines: 1,),
                      trailing: Text("${Jiffy(data.updatedAt).fromNow()}"),
                    ),
                  ),
                );
              },
            );
          }
          else {
            return Center(
              child: Text("Error occurred retrieving data",style: TextStyle(color: Colors.white,))
            );
          }
        },
      )
    );
  }

}