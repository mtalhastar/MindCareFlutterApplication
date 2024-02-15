import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mindcareflutterapp/controllers/profileController.dart';
import 'package:mindcareflutterapp/models/user.dart';
import 'package:mindcareflutterapp/screens/authScreen.dart';
import 'package:mindcareflutterapp/screens/messageScreen.dart';
import 'package:mindcareflutterapp/screens/profileScreen.dart';
import 'package:mindcareflutterapp/services/authServices.dart';
import 'package:mindcareflutterapp/services/chatServices.dart';
import 'package:mindcareflutterapp/widgets/chatitem.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindcareflutterapp/controllers/chatController.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final controller = Get.put(ChatController());
  final profileController = Get.put(ProfileController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 67, 157, 70)));
    profileController.fetchUserProfile();
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
                    child: Obx(
                      () => CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.black,
                        child: profileController.userProfile.value.imageUrl ==
                                ''
                            ? const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.white,
                              )
                            : ClipOval(
                                child: Image.network(
                                  profileController.userProfile.value.imageUrl,
                                  fit: BoxFit.cover,
                                  width:
                                      80.0, // Set width and height to ensure a circular image
                                  height: 80.0,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  }, // Ensure the image fills the circular area
                                ),
                              ),
                      ),
                    )),
                InkWell(
                  onTap: () async {
                    if (profileController.userProfile.value != null) {
                      Get.to(
                          Profile(user: profileController.userProfile.value));
                    }
                    ;
                  },
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
                  onTap: () async {
                    await AuthServices().saveToken("");
                    Get.off(const LoginScreen());
                  },
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
                    child: Center(
                        child: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        const Icon(
                          Icons.search,
                          color: Color.fromARGB(109, 60, 59, 59),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(124, 45, 44, 44)),
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                                color: Color.fromARGB(124, 45, 44, 44)),
                            cursorColor: const Color.fromARGB(124, 45, 44, 44),
                            onChanged: (value) {
                              controller.searchResults(value);
                            },
                          ),
                        ),
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
                        child: Obx(() => controller.flag.value == false
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.filteredlist.length,
                                itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MessagingScreen(username: controller
                                            .filteredlist[index].username,recieverId:controller
                                            .filteredlist[index].userId.toString(),senderId:profileController.userProfile.value.userId.toString())));
                                      },
                                      child: ChatItem(
                                        userName: controller
                                            .filteredlist[index].username,
                                        message: controller
                                            .filteredlist[index].email,
                                        messageCount: 4,
                                      ),
                                    ))),
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
