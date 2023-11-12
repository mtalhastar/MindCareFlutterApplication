import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mindcareflutterapp/screens/changePassword.dart';
import 'package:mindcareflutterapp/screens/authScreen.dart';
import 'package:mindcareflutterapp/screens/questionScreen.dart';
import 'package:mindcareflutterapp/models/questionaire.dart';

class ResponseServices {
  final _connect = GetConnect();
  static var client = http.Client();

  Future<List<Questionaire>> getQuestionaires() async {
    List<Questionaire> questionnaires = [];
    try {
      var response = await _connect.get('http://10.0.2.2:8000/question/getQuestionaire/');
      dynamic list = response.body["questionnaires"];

      if (response.statusCode == 200) {
        for (var elements in list) {
        questionnaires.add(Questionaire.fromJson(elements));
        }
      } else {
        Get.snackbar('Signup Status:', 'Signup Failed');
      }
      print(response);
      return questionnaires;
    } catch (e) {
      Get.snackbar('Signup Status:', 'Signup Failed');
   
    }
    throw (Exception e) {
      Get.snackbar('Unknown Error', 'App encountered unkown error');
    };
  }
}
