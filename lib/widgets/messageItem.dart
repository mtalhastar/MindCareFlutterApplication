import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindcareflutterapp/controllers/profileController.dart';

class MessageItem extends StatelessWidget {
  final String message;
  final String uid;
  final String time;

  MessageItem(
      {super.key,
      required this.message,
      required this.uid,
      required this.time});

  final controller = Get.find<ProfileController>();
  
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
          alignment: uid == controller.userProfile.value.userId.toString() ? Alignment.centerLeft : Alignment.centerRight,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: uid == controller.userProfile.value.userId.toString()
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
              color: uid == controller.userProfile.value.userId.toString()
                  ? Colors.green
                  : const Color.fromARGB(255, 14, 95, 17),
              elevation: 4,
              margin: uid == controller.userProfile.value.toString()
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
          alignment: uid == controller.userProfile.value.userId .toString()? Alignment.centerLeft : Alignment.centerRight,
          margin:const EdgeInsets.symmetric(horizontal: 10),
          child: Text(time,
              style: GoogleFonts.montserrat(
                  color: const Color.fromARGB(255, 0, 0, 0), fontSize: 13)))
    ]);
  }
}
