import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/components/app_bar_widget.dart';
import 'package:nq_mall_dashboard/components/my_button.dart';
import 'package:nq_mall_dashboard/components/responsive.dart';
import 'package:nq_mall_dashboard/components/text_field_widget.dart';
import 'package:nq_mall_dashboard/controllers/brand/add_brand_screen_controller.dart';
import 'package:nq_mall_dashboard/controllers/category/add_category_screen_controller.dart';
import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';

import '../components/text_widget.dart';

class AddBrandScreen extends StatelessWidget {
  const AddBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddBrandScreenController>(
      init: Get.put(AddBrandScreenController()),
      builder: (controller) => Directionality(
        textDirection: currentDirection,
        child: Scaffold(
          body: controller.loading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Container(
                        padding: MyTheme.padding,
                        margin: MyTheme.margin,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: MyTheme.iconColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const TextWidget(text: 'إضافة براند جديد')
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 0,
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const TextWidget(
                                  text: "الصورة",
                                  textAlign: TextAlign.start,
                                ),
                                controller.imageBytes == null
                                    ? Container()
                                    : MyButton(
                                        action: () => controller.chooseImage(),
                                        width: 40,
                                        margin: EdgeInsets.only(bottom: 5),
                                        text: "تغيير الصورة",
                                        buttonColor: MyTheme.blueColor,
                                      )
                              ],
                            ),
                            Center(
                              child: Container(
                                width: Responsive.isDesktop(context)
                                    ? 200
                                    : MediaQuery.of(context).size.width,
                                height: 250,
                                decoration: BoxDecoration(
                                  color: MyTheme.appBarColor,
                                  image: controller.imageBytes != null
                                      ? DecorationImage(
                                          image: MemoryImage(
                                              controller.imageBytes!),
                                          fit: BoxFit.cover)
                                      : null,
                                ),
                                child: controller.imageBytes == null
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextWidget(
                                              text: "لا يوجد صورة",
                                              color: MyTheme.iconColor,
                                            ),
                                            MyButton(
                                              width: 60,
                                              // height: 60,
                                              action: () =>
                                                  controller.chooseImage(),
                                              icon: Icon(
                                                Icons.image,
                                                color: MyTheme.iconColor,
                                              ),
                                              buttonColor: MyTheme.blueColor,
                                              text: "إختر صورة",
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                              ),
                            ),
                            const TextWidget(
                              text: "الاسم بالعربي",
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(height: 5),
                            TextFieldWidget(
                              hintText: "الاسم بالعربي",
                              margin: EdgeInsets.all(0),
                              controller: controller.nameAr,
                            ),
                            const TextWidget(
                              text: "الاسم بالإنكليزي",
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(height: 5),
                            TextFieldWidget(
                              hintText: "الاسم بالإنكليزي",
                              margin: EdgeInsets.all(0),
                              controller: controller.nameEn,
                            ),
                            const TextWidget(
                              text: "الوصف العربي",
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(height: 5),
                            TextFieldWidget(
                              hintText: "الوصف العربي",
                              margin: EdgeInsets.all(0),
                              controller: controller.descAr,
                            ),
                            const TextWidget(
                              text: "الوصف الإنكليزي",
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(height: 5),
                            TextFieldWidget(
                              hintText: "الوصف الإنكليزي",
                              margin: EdgeInsets.all(0),
                              controller: controller.descEn,
                            ),
                            const TextWidget(
                              text: "رابط الموقع الخاص بالبراند",
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(height: 5),
                            TextFieldWidget(
                              hintText: "رابط الموقع الخاص بالبراند",
                              margin: EdgeInsets.all(0),
                              controller: controller.url,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MyButton(
                              action: () => controller.submit(),
                              buttonColor: MyTheme.blueColor,
                              text: "إنشاء",
                              margin: EdgeInsets.zero,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          appBar: AppBarWidget(
            showBackButton: true,
          ),
          backgroundColor: MyTheme.blackColor,
        ),
      ),
    );
  }
}
