import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mindcareflutterapp/screens/changePassword.dart';
import 'package:mindcareflutterapp/screens/authScreen.dart';
import 'package:mindcareflutterapp/screens/chatScreen.dart';
import 'package:mindcareflutterapp/screens/questionScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  final _connect = GetConnect();
  static var client = http.Client();
  String url = "54.91.156.11";

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> SignUp(
      String username, String email, String password, String role) async {
    try {
      var response = await http.post(Uri.parse('http://${url}:8000/signup/'), body:{
        'username': username,
        'email': email,
        'password': password,
        'role': role
      });

      if (response.statusCode == 200) {
        Get.snackbar('Signup Status:', 'Signup Successful');
        String token = jsonDecode(response.body)['token'];
        await saveToken(token);

        Get.off(const ChatScreen());
      } else {
        Get.snackbar('Signup Status:', 'Signup Failed');
      }
      print(response);
    } catch (e) {
      Get.snackbar('Signup Status:', 'Signup Failed');
    }
  }

  Future<void> Login(String email, String password) async {
    try {
      var response = await http.post(
        Uri.parse('http://${url}:8000/login/'),
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        String token = jsonDecode(response.body)['token'];
        if (jsonDecode(response.body)['role'] == 'Admin' ||
            jsonDecode(response.body)['role'] == 'Student') {
          Get.snackbar(
              'ERROR', '${jsonDecode(response.body)['role']} is not allowed ');
          return;
        }
        Get.off(const ChatScreen());
        await saveToken(token);
        Get.snackbar('Login Status:', 'Login Successful');
      } else {
        Get.snackbar('Error:', 'Login Failed');
      }
      print(response.statusCode);
      print(response.body);
    } catch (e) {
      print(e);
      Get.snackbar('Login Status:', 'Login Failed');
    }
  }

  Future<dynamic> ForgotPassword(String email) async {
    try {
      var response = await http
          .post(Uri.parse('http://${url}/forgot_password/'), body:{'email': email});

      if (response.statusCode == 200) {
        Get.snackbar('OTP Sent:', 'OTP Sent to your email');
        Get.off(const ChangePasswordScreen());
      } else {
        Get.snackbar('Error:', 'OTP Failed to Send Try again');
      }
      return response;
    } catch (e) {
      Get.snackbar('Status:', 'Forgot Password Failed');
    }
  }

  dynamic ChangePassword(String verificationCode, String newpassword) async {
    try {
      var response = await http.post(Uri.parse('http://${url}/change_password/'),
          body:{'vcode': verificationCode, 'password': newpassword});

      if (response.statusCode == 200) {
        Get.off(const LoginScreen(),
            transition: Transition.leftToRight, duration: Duration(seconds: 1));
        Get.snackbar('Status:', 'Password Change was successful');
      } else {
        Get.snackbar('Error:', 'Password Change was unsuccessful');
      }

      return response;
    } catch (e) {
      print(e);
      Get.snackbar('Status:', 'Change Password Failed');
    }
  }
}
