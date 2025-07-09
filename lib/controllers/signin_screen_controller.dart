import 'dart:io';

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
import 'package:nq_mall_dashboard/shared/validate_app_availability.dart';
import 'package:nq_mall_dashboard/views/style_widget.dart';

class SignInScreenController extends GetxController {
  TextEditingController username =
      TextEditingController(text: "mahmood@mahmood.mahmood");
  TextEditingController password = TextEditingController(text: "11111111");
  RxBool loading = false.obs;

  void signinAction() async {
    try {
      loading(true);
      update();

      ResponseModel responseModel = await SignInApi().callApi(
          username: username.text.trim(), password: password.text.trim());
      loading(false);
      update();
      if (responseModel.code == 200) {
        UserModel userModel = UserModel.fromMap(responseModel.data);
        userModel.password = password.text.trim();
        Map isAppAvailable = await ValidateAppAvailability.isAppAvailable(
            appConfigModel: userModel.appConfig!);
        if (!isAppAvailable['WorkingOrNot']) {
          Get.dialog(
            DialogBox2(
              title: "تحديث التطبيق",
              body: const TextWidget(
                text:
                    "يرجى تحديث التطبيق إلى أحدث إصدار للاستمرار في استخدام الخدمة",
                textAlign: TextAlign.center,
              ),
              actions: Wrap(
                children: [
                  MyButton(
                    action: () => exit(0),
                    text: "إغلاق",
                    textColor: MyTheme.mainColor,
                    buttonColor: MyTheme.iconColor,
                    fontSize: 16,
                  ),
                ],
              ),
            ),
          );
          return;
        } else if (!isAppAvailable['DashboardEnabled']) {
          Get.dialog(
            DialogBox2(
              title: "التطبيق غير مفعل",
              body: const TextWidget(
                text: "يرجى التواصل مع الدعم للاستمرار في استخدام الخدمة",
                textAlign: TextAlign.center,
              ),
              actions: Wrap(
                children: [
                  MyButton(
                    action: () => exit(0),
                    text: "إغلاق",
                    textColor: MyTheme.mainColor,
                    buttonColor: MyTheme.iconColor,
                    fontSize: 16,
                  ),
                ],
              ),
            ),
          );
          return;
        }
        if (getIt.isRegistered<UserModel>()) {
          getIt.unregister<UserModel>();
        }
        getIt.registerSingleton(userModel);
        getIt
            .get<GetStorage>()
            .write(LocalStorageKeys.LocalUserModel.key, userModel.toJson());
        Get.offAll(const StyleWidget());
      } else if (responseModel.code == 403) {
        showWrongCredentialsDialog(responseModel: responseModel);
      }
    } catch (e) {
      print(e);
      if (e is ConnectionTimeOut) {
      } else if (e is UndefindProblem) {}
    }
  }

  showWrongCredentialsDialog({required ResponseModel responseModel}) {
    Get.dialog(DialogBox2(
      title: "العمليات",
      body: TextWidget(text: responseModel.message.toString()),
      actions: Wrap(
        children: [
          MyButton(
            action: () => Get.back(),

            // width: 120,
            text: "إغلاق",
            textColor: MyTheme.mainColor,
            buttonColor: MyTheme.iconColor,
            fontSize: 16,
          ),
        ],
      ),
    ));
  }
}
