import 'package:get/get.dart';
import 'package:mindcareflutterapp/models/message.dart';
import 'package:mindcareflutterapp/models/user.dart';
import 'package:mindcareflutterapp/services/chatServices.dart';

class ChatController extends GetxController {
  List<User> chatUsers = <User>[].obs;
  List<User> filteredlist = <User>[].obs;
  List<Message> chatmessagas = <Message>[].obs;
  var flag = false.obs;
  var flagLoader = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
    fetchChatUsers();
  }

  Future<void> fetchChatUsers() async {
    var chat = await ChatServices().getChatUsers();
    chatUsers.addAll(chat);
    filteredlist.assignAll(chatUsers);
    flag.value = true;
  }

  Future<void> fetchChatMessages(String recieverId) async {
    chatmessagas.clear();
    flagLoader.value = false;
    var chat = await ChatServices().getChatMessages(recieverId);
    chatmessagas.assignAll(chat);
    flagLoader.value = true;
  }

  List<User> getUsers() {
    return chatUsers;
  }

  void searchResults(String username) {
    if (username.isEmpty) {
      // If the search query is empty, reset filteredlist to the full list of chatUsers
      filteredlist.assignAll(chatUsers);
    } else {
      // Filter the chatUsers list based on the search query
      filteredlist.assignAll(chatUsers
          .where((element) =>
              element.username.toLowerCase().contains(username.toLowerCase()))
          .toList());
    }
  }
}
