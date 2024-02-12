import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindcareflutterapp/widgets/messageItem.dart';

class MessagingScreen extends StatefulWidget {
  const MessagingScreen({super.key});

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mr Bashir',
          style: GoogleFonts.montserrat(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Column(children: [
        const Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(children: [
              MessageItem(
                  message: 'hello how are you', uid: '1', time: '12:56'),
              MessageItem(message: 'I am fine', uid: '2', time: '4:56'),
              MessageItem(
                  message: 'Cool todays lunch was Good, What about you',
                  uid: '1',
                  time: '12:56'),
              MessageItem(
                  message: 'Awsome it was great', uid: '2', time: '4:56'),
              MessageItem(message: 'Also whats next', uid: '2', time: '4:56'),
              MessageItem(
                  message: 'Cool todays lunch was Good, What about you',
                  uid: '1',
                  time: '12:56'),
              MessageItem(
                  message: 'Awsome it was great', uid: '2', time: '4:56'),
              MessageItem(message: 'Also whats next', uid: '2', time: '4:56')
            ]),
          ),
        ),
        Card(
          elevation: 10,
          child: Container(
            color: const Color.fromARGB(255, 216, 233, 217),
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: Row(children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter a message',
                      hintStyle: GoogleFonts.montserrat(
                          color: Colors.black, fontSize: 16)),
                ),
              ),
              const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              )
            ]),
          ),
        ),
      ]),
    );
  }
}
