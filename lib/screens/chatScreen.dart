import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mindcareflutterapp/screens/messageScreen.dart';
import 'package:mindcareflutterapp/widgets/chatitem.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 67, 157, 70)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _globalKey,
          drawer: Drawer(
            child: ListView(
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  color: const Color.fromARGB(146, 218, 224, 212),
                  alignment: Alignment.center,
                  child: const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    title: Text(
                      'Profile',
                      style: GoogleFonts.montserrat(
                          color: Colors.black, fontSize: 15),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    title: Text(
                      'Logout',
                      style: GoogleFonts.montserrat(
                          color: Colors.black, fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
          ),
          body: Stack(children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 80, 0, 0),
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      'Chats',
                      style: GoogleFonts.montserrat(
                          color: Colors.black, fontSize: 32),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    height: 53,
                    decoration: ShapeDecoration(
                      color: const Color.fromARGB(146, 218, 224, 212),
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
                        Text(
                          'Search',
                          style:
                              TextStyle(color: Color.fromARGB(124, 45, 44, 44)),
                        )
                      ],
                    )),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [HexColor('00895F'), HexColor('00B351')]),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: 7,
                            itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    //api request of message reset or scene
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MessagingScreen()));
                                  },
                                  child: const ChatItem(
                                    userName: 'Rashid',
                                    message: 'Anwar',
                                    messageCount: 4,
                                  ),
                                )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/greenimg.png',
                  height: 80,
                  width: 80,
                )),
            Positioned(
              top: 10,
              left: 15,
              child: GestureDetector(
                onTap: () {
                  _globalKey.currentState!.openDrawer();
                },
                child: const Icon(
                  Icons.menu,
                  color: Color.fromARGB(255, 41, 84, 46),
                  size: 28,
                ),
              ),
            )
          ])),
    );
  }
}
