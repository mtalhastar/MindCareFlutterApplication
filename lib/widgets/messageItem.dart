import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageItem extends StatelessWidget {
  final String message;
  final String uid;
  final String time;

  const MessageItem(
      {super.key,
      required this.message,
      required this.uid,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[ Align(
          alignment: uid == '1' ? Alignment.centerLeft : Alignment.centerRight,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: uid == '1'
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(15))
                    : const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(0)),
              ),
              color: uid == '1'
                  ? Colors.green
                  : const Color.fromARGB(255, 14, 95, 17),
              elevation: 8,
              margin: uid == '1'
                  ? const EdgeInsets.fromLTRB(10, 10, 40, 10)
                  : const EdgeInsets.fromLTRB(40, 10, 10, 10),
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: Text(
                  message,
                  style: GoogleFonts.montserrat(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16),
                ),
              ))),
               Container(
                      alignment:  uid == '1'?Alignment.centerLeft:Alignment.centerRight,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(time,style: GoogleFonts.montserrat(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 13)))
      ]
    );
  }
}
