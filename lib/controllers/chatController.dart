import 'package:get/get.dart';
import 'package:mindcareflutterapp/models/user.dart';
import 'package:mindcareflutterapp/services/chatServices.dart';

class ChatController extends GetxController {
  List<User> chatUsers = <User>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
   
    super.onInit();
    fetchChatUsers();
  }

  void fetchChatUsers() async {
    var chat = await ChatServices().getChatUsers();
    chatUsers.addAll(chat);
  }

  List<User> getUsers() {
    return chatUsers;
  }

  List<User> searchResults(String username) {
    return chatUsers.where((element) => element.username == username).toList();
  }
}
