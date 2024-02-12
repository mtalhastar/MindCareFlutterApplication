import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mindcareflutterapp/screens/changePassword.dart';
import 'package:mindcareflutterapp/screens/authScreen.dart';
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
        print(response.body);
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
        }
      } catch (e) {
        print(e);
        Get.snackbar('Execption occured:', 'Failed');
      }
    }
    return users;
  }
}
