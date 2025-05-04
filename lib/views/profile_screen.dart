import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/state_manager.dart';
import 'package:nq_mall_dashboard/components/loading_widget.dart';
import 'package:nq_mall_dashboard/components/my_button.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/controllers/profile_screen_controller.dart';
import 'package:nq_mall_dashboard/shared/log_out_action.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(ProfileScreenController()),
      builder: (controller) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12)
                  .add(const EdgeInsets.only(top: 12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: MyTheme.shadowColor,
                          ),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: MyTheme.shadowColor,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      SizedBox(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: controller.userModel!.FullName.toString(),
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                            TextWidget(
                              text: controller.userModel!.Email.toString(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  MyButton(
                    text: "تسجيل الخروج",
                    buttonColor: MyTheme.blueColor,
                    action: () => LogOutAction.logOut(),
                  )
                ],
              ),
            ),
            Visibility(
              visible: controller.loading.value,
              child: Container(
                decoration: BoxDecoration(
                  color: MyTheme.loadingColor,
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: LoadingWidget(),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
