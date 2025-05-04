import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/models/user_model.dart';
import 'package:nq_mall_dashboard/views/sign_in_screen.dart';

class LogOutAction {
  static void logOut() {
    GetStorage getStorage = getIt.get<GetStorage>();
    getStorage.erase();
    try {
      getIt.unregister<UserModel>();
    } catch (e) {
      print(e);
    }
    Get.offAll(SignInScreen());
  }
}
