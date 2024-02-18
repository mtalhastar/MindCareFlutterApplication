import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindcareflutterapp/controllers/chatController.dart';
import 'package:mindcareflutterapp/models/message.dart';
import 'package:mindcareflutterapp/services/chatServices.dart';
import 'package:mindcareflutterapp/widgets/messageItem.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class MessagingScreen extends StatefulWidget {
  String username;
  String recieverId;
  String senderId;

  MessagingScreen(
      {super.key,
      required this.username,
      required this.recieverId,
      required this.senderId});

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  final controller = Get.find<ChatController>();
  late ScrollController _scrollController;
  final textcontroller = TextEditingController();
  String message = '';
  bool isSent = false;
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      await controller.fetchChatMessages(widget.recieverId);

      //here is the async code, you can execute any async code here
      print('scrollnow');
    });
    super.initState();
    _scrollController = ScrollController();
    webSocketConnection();
  }

  // void _scrollToBottom() {
  //   if (_scrollController.hasClients) {
  //     _scrollController.animateTo(
  //       _scrollController.position.maxScrollExtent,
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeOut,
  //     );
  //   }
  // }

  void webSocketConnection() async {
    final wsUrl = Uri.parse(
        'ws://192.168.18.12:8000/ws/chating/${widget.senderId}/${widget.recieverId}/');
    final channel = WebSocketChannel.connect(wsUrl);

    await channel.ready;
    print('is ready');
    channel.stream.listen((message) {
      Map<String, dynamic> messages = jsonDecode(message);

      int senderId = messages["senderid"];
      int receiverId = messages["receiverid"];

      print('message sent');

      controller.chatmessagas.insert(
          0,
          (Message(
              id: 40,
              content: messages["content"],
              seen: true,
              senderId: senderId,
              receiverId: receiverId,
              timestamp: DateTime.now())));

      channel.sink.close(status.goingAway);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.username,
          style: GoogleFonts.montserrat(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Column(children: [
        Expanded(
            child: Obx(
          () => controller.flagLoader.value == true
              ? ListView.builder(
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.chatmessagas
                      .length, // Specify the number of items you want to display
                  itemBuilder: (BuildContext context, int index) {
                    return Obx(
                      () => MessageItem(
                          message: controller.chatmessagas[index].content,
                          uid: controller.chatmessagas[index].senderId
                              .toString(),
                          time: controller.chatmessagas[index].timestamp),
                    );
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                ),
        )),
        Card(
          elevation: 10,
          child: Container(
            color: const Color.fromARGB(255, 216, 233, 217),
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Row(children: [
              Expanded(
                child: TextField(
                  controller: textcontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter a message',
                      hintStyle: GoogleFonts.montserrat(
                          color: Colors.black, fontSize: 16)),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        message = value;
                      });
                    }
                  },
                ),
              ),
              Obx(() => controller.flagLoader.value == true
                  ? GestureDetector(
                      onTap: () async {
                        if (message.isNotEmpty) {
                          setState(() {
                            isSent = true;
                          });
                          await ChatServices()
                              .sendMessage(message, widget.recieverId);
                          setState(() {
                            isSent = false;
                            textcontroller.clear();
                          });
                        }
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: const Color.fromARGB(255, 84, 175, 76),
                        child: isSent == false
                            ? const Icon(
                                Icons.send,
                                color: Color.fromARGB(255, 253, 253, 253),
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              ),
                      ),
                    )
                  : const CircleAvatar(
                      radius: 25,
                      backgroundColor: Color.fromARGB(255, 73, 94, 75),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ))
            ]),
          ),
        ),
      ]),
    );
  }
}
