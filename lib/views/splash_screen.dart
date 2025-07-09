import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/components/loading_widget.dart';
import 'package:nq_mall_dashboard/components/responsive.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/controllers/splash_screen_controller.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.put(SplashScreenController()),
        builder: (controller) => Scaffold(
              backgroundColor: MyTheme.blackColor,
              body: Responsive(
                  mobile: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 2,
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        const TextWidget(
                          text: "قاسيون مول داشبورد",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 44,
                        ),
                        const TextWidget(
                          text: "أهلاً وسهلاً بك، يرجى الانتظار قليلاً",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(
                          height: 64,
                        ),
                        Visibility(
                          visible: controller.loading.value,
                          child: LoadingWidget(
                            color: MyTheme.textBlackColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  desktop: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                          width: MediaQuery.of(context).size.width / 6,
                          height: MediaQuery.of(context).size.width / 6,
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        const TextWidget(
                          text: "قاسيون مول داشبورد",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 44,
                        ),
                        const TextWidget(
                          text: "أهلاً وسهلاً بك، يرجى الانتظار قليلاً",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(
                          height: 64,
                        ),
                        Visibility(
                          visible: controller.loading.value,
                          child: LoadingWidget(
                            color: MyTheme.textBlackColor,
                          ),
                        )
                      ],
                    ),
                  )),
            ));
  }
}
