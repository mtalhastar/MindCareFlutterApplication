import 'package:get/get.dart';
import 'package:mindcareflutterapp/models/user.dart';
import 'package:mindcareflutterapp/services/chatServices.dart';

class ProfileController extends GetxController {
  var userProfile =
      User(email: '', id: 1, imageUrl: '', userId: 1, role: '', username: '')
          .obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchUserProfile();
  }

  void fetchUserProfile() async {
    User? user = await ChatServices().getAUserProfile();
    if (user != null) {
      userProfile.value = user;
    }
  }
}
