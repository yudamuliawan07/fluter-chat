import 'package:chat/componens/chat_bubble.dart';
import 'package:chat/componens/my_text_field.dart';
import 'package:chat/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  const ChatPage({super.key,
  required this.receiverUserEmail,
    required this.receiverUserID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async{
    if (_messageController.text.isNotEmpty){
      await _chatService.sendMessage(widget.receiverUserID, _messageController.text);

      _messageController.clear();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverUserEmail),),
      body: Column(
        children: [
          Expanded(
              child: _buildMessageList(),
          ),

          // input message
          _buildMessageInput(),
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList(){
    return  StreamBuilder(
        stream: _chatService.getMessages(
            widget.receiverUserID, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot){
          if (snapshot.hasError) {
            return Text('Error ${snapshot.error}');
          }
          if (snapshot.connectionState ==ConnectionState.waiting) {
            return const Text("Loading ..");
          }
          return ListView(
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        },

    );
  }


  //build message item
  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
      ? Alignment.centerRight : Alignment.centerLeft;
    if (alignment == (data['senderId'] == _firebaseAuth.currentUser!.uid)) {

    }
    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
            (data['senderId'] == _firebaseAuth.currentUser!.uid)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
          mainAxisAlignment: (data['SenderId'] == _firebaseAuth.currentUser!.uid) ? MainAxisAlignment.end: MainAxisAlignment.start,
          children: [

            ChatBuble(message: data['message']),
          ],
        ),
      ),
    );
  }

  //build message input
  Widget _buildMessageInput(){
    return Row(
      children: [
        Expanded(
            child: MyTextField(
              mycontroller: _messageController,
              hintText: 'Enter Message',
              obscureText: false,
            ),
        ),
        IconButton(onPressed: sendMessage,
            icon: const Icon(Icons.arrow_upward, size: 40,),
        ),
      ],
    );
  }
}
