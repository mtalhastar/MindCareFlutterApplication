import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mindcareflutterapp/widgets/chatitem.dart';
import 'package:hexcolor/hexcolor.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        margin: const EdgeInsets.fromLTRB(0, 80, 0, 0),
        width: double.infinity,
        height: 1200,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Text('Chats',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 34,
                      fontFamily: 'Istok Web',
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                height: 53,
                decoration: ShapeDecoration(
                  color: Color.fromARGB(146, 218, 224, 212),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Center(
                    child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.search,
                      color: Color.fromARGB(109, 60, 59, 59),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Search')
                  ],
                )),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 600,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [HexColor('00895F'), HexColor('00B351')]),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: 8,
                    itemBuilder: (context, index) => const ChatItem()),
              )
            ],
          ),
        ),
      ),
      Positioned(
          top: 0,
          right: 0,
          child: Image.asset(
            'assets/images/greenimg.png',
            height: 80,
            width: 80,
          ))
    ]));
  }
}
