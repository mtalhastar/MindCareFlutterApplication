import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mindcareflutterapp/screens/changePassword.dart';
import 'package:mindcareflutterapp/screens/authScreen.dart';
import 'package:mindcareflutterapp/screens/questionScreen.dart';

class AuthServices {
  final _connect = GetConnect();
  static var client = http.Client();

  dynamic SignUp(String username, String email, String password) async {
    try {
      var response = await _connect.post('http://10.0.2.2:8000/signup/',
          {'username': username, 'email': email, 'password': password});

      if (response.statusCode == 200) {
        Get.snackbar('Signup Status:', 'Signup Successful');
        Get.off(const QuestionScreen());
      } else {
        Get.snackbar('Signup Status:', 'Signup Failed');
      }
      print(response);
      return response;
    } catch (e) {
      Get.snackbar('Signup Status:', 'Signup Failed');
    }
  }

  dynamic Login(String email, String password) async {
    try {
      var response = await _connect.post('http://10.0.2.2:8000/login/',
          {'email': email, 'password': password});
      if (response.statusCode == 200) {
        Get.off(const QuestionScreen());
        Get.snackbar('Login Status:', 'Login Successful');
      } else {
        Get.snackbar('Error:', 'Login Failed');
      }
      print(response.statusCode);
      print(response.body);
      return response;
    } catch (e) {
      Get.snackbar('Login Status:', 'Login Failed');
    }
  }

  Future<dynamic> ForgotPassword(String email) async {
    try {
      var response = await _connect
          .post('http://10.0.2.2:8000/forgot_password/', {'email': email});
      print(response);
      
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
      var response = await _connect.post(
          'http://10.0.2.2:8000/change_password/',
          {'vcode': verificationCode, 'password': newpassword});

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
