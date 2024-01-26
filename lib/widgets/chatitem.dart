import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatItem extends StatelessWidget {
  final String userName;
  final String message;
  final int messageCount;
  const ChatItem({super.key, required this.userName, required this.message,required this.messageCount});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 80,
          decoration: ShapeDecoration(
            color: const Color.fromARGB(146, 236, 243, 229),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset('assets/images/image-remove.png')),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            userName,
                            style: GoogleFonts.montserrat(color:Colors.black ,fontSize: 20),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            message,
                            style: const TextStyle(
                              color: Color(0xFFC7C2C2),
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Istok Web',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  messageCount!=0?
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: Color.fromARGB(255, 11, 128, 54),child: Text(messageCount.toString(),style: const TextStyle(color: Colors.white,fontSize: 10),))
                    :SizedBox()
                ],
              ),
            ],
          ),
        ),
      ),
     const SizedBox(
        height: 10,
      ),
    ]);
  }
}
