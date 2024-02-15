import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireBaseFunction {
  final picker = ImagePicker();

  Future<String?> uploadImageToStorage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      File image = File(pickedFile.path);
      String imageName = pickedFile.path.split('/').last;

      try {
        // Upload image to Firebase Storage
        TaskSnapshot snapshot = await FirebaseStorage.instance
            .ref()
            .child('images/$imageName')
            .putFile(image);

        // Get download URL
        String downloadURL = await snapshot.ref.getDownloadURL();

        // Print download URL (or do something else with it)
        print('Image uploaded. Download URL: $downloadURL');

        // Return the download URL
        return downloadURL;
      } catch (e) {
        // Handle errors
        print('Error uploading image to Firebase Storage: $e');
        return null;
      }
    } else {
      // User canceled image selection
      print('No image selected.');
      return null;
    }
  }
}
