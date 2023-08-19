import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:get/get.dart';
import 'package:mindcareflutterapp/screens/changePassword.dart';
import 'package:mindcareflutterapp/screens/authScreen.dart';

class AuthServices {
  final _connect = GetConnect();
  static var client = http.Client();

  dynamic SignUp(String username, String email, String password) async {
    try {
      var response = await _connect.post('http://10.0.2.2:8000/signup/',
          {'username': username, 'email': email, 'password': password});

      if (response.statusCode == 200) {
        Get.snackbar('Signup Status:', 'Signup Successful');
      }
      print(response);
      return response;
    } catch (e) {
      Get.snackbar('Signup Status:', 'Signup Failed');
    }
  }

  dynamic Login(String username, String password) async {
    try {
      var response = await _connect.post('http://10.0.2.2:8000/login/',
          {'username': username, 'password': password});
      if (response.statusCode == 200) {
        Get.snackbar('Login Status:', 'Login Successful');
      }
      print(response.statusCode);
      print(response.body);
      return response;
    } catch (e) {
      Get.snackbar('Login Status:', 'Login Failed');
    }
  }

  dynamic ForgotPassword(String username) async {
    try {
      var response = await _connect.post(
          'http://10.0.2.2:8000/forgot_password/', {'username': username});
          if (response.statusCode == 200) {
                Get.off(const ChangePasswordScreen());
             Get.snackbar('OTP Sent:', 'OTP Sent to your email');
      }
      return response;
    } catch (e) {
      Get.snackbar('Status:', 'Forgot Password Failed');
    }
  }

  dynamic ChangePassword(String verificationCode, String newpassword) async {
    try {
      var response = await _connect.post(
          'http://10.0.2.2:8000/change_password/',
          {'vcode': verificationCode, 'password': newpassword});

          if(response.statusCode==200){
              Get.off(const LoginScreen(),transition: Transition.leftToRight, duration: Duration(seconds: 1));
             Get.snackbar('Status:', 'Password Change was successful');
          
          }
      return response;
    } catch (e) {
      print(e);
      Get.snackbar('Status:', 'Change Password Failed');
    }
  }
}
