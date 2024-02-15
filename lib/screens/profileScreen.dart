import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindcareflutterapp/controllers/profileController.dart';
import 'package:mindcareflutterapp/firebaseFileUpload.dart';
import 'package:mindcareflutterapp/models/user.dart';
import 'package:mindcareflutterapp/firebaseFileUpload.dart';
import 'package:mindcareflutterapp/services/chatServices.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  User user;
  Profile({super.key, required this.user});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final controller = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: GoogleFonts.montserrat(color: Colors.black, fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: Column(children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () async {
                    String? imguri = await FireBaseFunction()
                        .uploadImageToStorage(ImageSource.camera);
                  
                    if (imguri != null) {
                      bool flag = await ChatServices().updateProfile(imguri);
                      controller.userProfile.value.imageUrl = imguri;
                      if (flag) {
                        setState(() {
                          widget.user.imageUrl = imguri;
                        });
                      }
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 40.0,
                    child: widget.user.imageUrl == ''
                        ? const Center(
                            child: Icon(
                              Icons.camera_enhance,
                              size: 30,
                              color: Colors.white,
                            ),
                          )
                        : ClipOval(
                            child:  Image.network(
                              widget.user.imageUrl,
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
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              }, // Ensure the image fills the circular area
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Text(
                      'Email:',
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.user.email,
                      style: GoogleFonts.montserrat(
                          color: Colors.black, fontSize: 15),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'Name:',
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(widget.user.username,
                        style: GoogleFonts.montserrat(
                            color: Colors.black, fontSize: 15))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'Role:',
                      style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(widget.user.role,
                        style: GoogleFonts.montserrat(
                            color: Colors.black, fontSize: 15))
                  ],
                ),
              ],
            ),
          )
        ]));
  }
}
