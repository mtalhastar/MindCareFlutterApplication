import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
      
         Card(
       shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
        //set border radius more than 50% of height and width to make circle
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
                            child: const Text(
                              'Mr Bashir',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Istok Web',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'How can we improve ...',
                              style: TextStyle(
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
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
        SizedBox(height: 10,),
      ]
    );
  }
}
