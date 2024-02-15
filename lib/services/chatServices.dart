import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mindcareflutterapp/controllers/chatController.dart';
import 'package:mindcareflutterapp/controllers/profileController.dart';
import 'package:mindcareflutterapp/models/message.dart';
import 'package:mindcareflutterapp/screens/changePassword.dart';
import 'package:mindcareflutterapp/screens/authScreen.dart';
import 'package:mindcareflutterapp/screens/profileScreen.dart';
import 'package:mindcareflutterapp/screens/questionScreen.dart';
import 'package:mindcareflutterapp/models/questionaire.dart';
import 'package:mindcareflutterapp/models/user.dart';
import 'package:mindcareflutterapp/services/authServices.dart';

class ChatServices {
  final _connect = GetConnect();
  static var client = http.Client();



  Future<List<User>> getChatUsers() async {
    String? token = await AuthServices().getToken();
    List<User> users = [];
    print('token $token');
    if (token == null) {
      Get.snackbar('error', 'User not loggedin');
    } else {
      try {
        var response = await _connect.get(
            'http://192.168.18.12:8000/chat/getChatUsers/',
            headers: {'Authorization': 'Token $token'});

        if (response.body != null) {
          List<dynamic> data = response.body;
          print(response.body);
          if (response.statusCode == 200) {
            for (var elements in data) {
              print(1);
              users.add(User.fromJson(elements));
              print(2);
            }

            return users;
          } else {
            Get.snackbar('message', 'Failed to fetch users');
          }
        } else {
          AuthServices().saveToken("");
          await Get.off(LoginScreen());
        }
      } catch (e) {
        print(e);
        Get.snackbar('Execption occured:', 'Failed');
      }
    }
    return users;
  }


  Future<List<Message>> getChatMessages(String senderid) async {
    String? token = await AuthServices().getToken();
    List<Message> messages = [];
    print('token $token');
    if (token == null) {
      Get.snackbar('error', 'User not loggedin');
    } else {
      try {
        var response = await _connect.get(
            'http://192.168.18.12:8000/chat/getMessages/$senderid/',
            headers: {'Authorization': 'Token $token'});

        if (response.body != null) {
          List<dynamic> data = response.body['conversation'];
          print(response.body);
          if (response.statusCode == 200) {
            for (var elements in data) {
              messages.add(Message.fromJson(elements));
            }
            return messages;
          } else {
            Get.snackbar('message', 'Failed to fetch users');
          }
        } else {
          AuthServices().saveToken("");
          await Get.off(const LoginScreen());
        }
      } catch (e) {
        print(e);
        Get.snackbar('Execption occured:', 'Failed');
      }
    }
    return messages;
  }




  Future<bool> updateProfile(String imageurl) async {
    bool flag = false;
    String? token = await AuthServices().getToken();
    if (token == null) {
      Get.snackbar('error', 'User not loggedin');
    } else {
      try {
        var response = await _connect.post(
            'http://192.168.18.12:8000/chat/updateProfile/',
            {"image": imageurl},
            headers: {'Authorization': 'Token $token'});
        if (response.body != null) {
          if (response.statusCode == 200) {
           
            Get.snackbar('success', 'Profile Updated Successfully');
            flag = true;
            return flag;
          } else {
            Get.snackbar('message', 'Failed to fetch users');
            flag = false;
            return flag;
          }
        }
      } catch (e) {
        Get.snackbar('Execption occured:', 'Failed');
      }
    }
    return flag;
  }

  Future<User?> getAUserProfile() async {
    String? token = await AuthServices().getToken();
    User? user;
    if (token == null) {
      Get.snackbar('error', 'User not loggedin');
    } else {
      try {
        var response = await _connect.get(
            'http://192.168.18.12:8000/chat/getProfile/',
            headers: {'Authorization': 'Token $token'});
        print(response);
        if (response.body != null) {
          Map<String, dynamic> data = response.body['profile'];
          print(data);
          if (response.statusCode == 200) {
            Get.snackbar('success', 'Profile Fetched');
            user = User.fromJson(data);
            ;
            return user;
          } else {
            Get.snackbar('message', 'Failed to fetch users');
          }
        }
      } catch (e) {
        Get.snackbar('Execption occured:', 'Failed');
      }
    }
    return user;
  }
}
