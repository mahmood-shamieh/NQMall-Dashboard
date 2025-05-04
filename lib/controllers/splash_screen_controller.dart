import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nq_mall_dashboard/apis/user/sign_in_api.dart';
import 'package:nq_mall_dashboard/components/dialog_box.dart';
import 'package:nq_mall_dashboard/components/dialog_box_2.dart';
import 'package:nq_mall_dashboard/components/my_button.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/exception/connection_time_out.dart';
import 'package:nq_mall_dashboard/exception/un_defined_problem.dart';
import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/models/response_model.dart';
import 'package:nq_mall_dashboard/models/user_model.dart';
import 'package:nq_mall_dashboard/shared/local_storage_keys.dart';
import 'package:nq_mall_dashboard/shared/pages.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';
import 'package:nq_mall_dashboard/views/sign_in_screen.dart';
import 'package:nq_mall_dashboard/views/style_widget.dart';

class SplashScreenController extends GetxController {
  RxBool loading = false.obs;

  @override
  void onInit() {
    // print("aaaaa");
    String? userString =
        getIt.get<GetStorage>().read(LocalStorageKeys.LocalUserModel.key);
    if (userString != null) {
      UserModel userModel = UserModel.fromJson(userString);
      signinAction(userModel: userModel);
    } else {
      Future.delayed(Duration.zero, () => Get.offAll(const SignInScreen()));
    }
    // super.onInit();
  }

  signinAction({required UserModel userModel}) async {
    try {
      loading(true);
      update();
      ResponseModel responseModel = await SignInApi().callApi(
          username: userModel.Email.toString(),
          password: userModel.password.toString());
      loading(false);
      update();
      if (responseModel.code == 200) {
        UserModel userModel = UserModel.fromMap(responseModel.data);
        if (getIt.isRegistered<UserModel>()) {
          getIt.unregister<UserModel>();
        }
        getIt.registerSingleton(userModel);
        getIt
            .get<GetStorage>()
            .write(LocalStorageKeys.LocalUserModel.key, userModel.toJson());
        Get.offAll(const StyleWidget());
      } else if (responseModel.code == 403) {
        Get.offAll(const SignInScreen());
      }
    } catch (e) {
      if (e is ConnectionTimeOut) {
      } else if (e is UndefindProblem) {}
    }
  }
}
