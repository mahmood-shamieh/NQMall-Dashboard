import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/state_manager.dart';
import 'package:nq_mall_dashboard/components/loading_widget.dart';
import 'package:nq_mall_dashboard/components/my_button.dart';
import 'package:nq_mall_dashboard/components/responsive.dart';
import 'package:nq_mall_dashboard/components/text_field_widget.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/controllers/signin_screen_controller.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(SignInScreenController()),
      builder: (controller) => Responsive(
          mobile: Stack(
            children: [
              Scaffold(
                backgroundColor: MyTheme.blackColor,
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: MyTheme.buttonsRadius,
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/photo_2023-11-22_20-25-26.jpg',
                                      ),
                                    ),
                                  ),
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: MediaQuery.of(context).size.width / 2,
                                ),
                              ),
                              const SizedBox(
                                height: 22,
                              ),
                              const TextWidget(
                                text: "قاسيون مول داشبورد",
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                              const TextWidget(
                                text: "سجل دخولك لإدارة منتجاتك",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              TextFieldWidget(
                                margin: const EdgeInsets.only(bottom: 12),
                                controller: controller.username,
                                hintText: "اسم المستخدم",
                              ),
                              TextFieldWidget(
                                margin: const EdgeInsets.only(bottom: 12),
                                controller: controller.password,
                                hintText: "كلمة المرور",
                              ),
                            ],
                          ),
                          MyButton(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            buttonColor: MyTheme.blueColor,
                            text: "تسجيل الدخول",
                            action: () => controller.signinAction(),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 6,
                          ),
                        ],
                      ),
                    ),
                  ),
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
          ),
          desktop: Stack(
            children: [
              Scaffold(
                backgroundColor: MyTheme.blackColor,
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: MyTheme.buttonsRadius,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/photo_2023-11-22_20-25-26.jpg',
                                    ),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.width / 4,
                              ),
                              const SizedBox(
                                height: 22,
                              ),
                              const TextWidget(
                                text: "قاسيون مول داشبورد",
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                              const TextWidget(
                                text: "سجل دخولك لإدارة منتجاتك",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFieldWidget(
                                margin: const EdgeInsets.only(bottom: 12),
                                controller: controller.username,
                                hintText: "اسم المستخدم",
                              ),
                              TextFieldWidget(
                                margin: const EdgeInsets.only(bottom: 12),
                                controller: controller.password,
                                hintText: "كلمة المرور",
                              ),
                              MyButton(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                buttonColor: MyTheme.blueColor,
                                text: "تسجيل الدخول",
                                action: () => controller.signinAction(),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
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
          )),
    );
  }
}
