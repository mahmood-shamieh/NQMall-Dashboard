import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/models/user_model.dart';
import 'package:nq_mall_dashboard/shared/local_storage_keys.dart';
import 'package:nq_mall_dashboard/shared/pages.dart';

class ProfileScreenController extends GetxController {
  RxBool loading = false.obs;
  UserModel? userModel;
  @override
  void onInit() {
    GetStorage getStorage = getIt.get<GetStorage>();
    String? userModelString =
        getStorage.read(LocalStorageKeys.LocalUserModel.key);
    if (userModelString != null) {
      userModel = UserModel.fromJson(userModelString);
    }
    super.onInit();
  }
}
