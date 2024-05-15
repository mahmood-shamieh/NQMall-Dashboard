import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/components/app_bar_widget.dart';
import 'package:nq_mall_dashboard/controllers/category/edit_category_screen_controller.dart';
import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/models/category_model.dart';
import 'package:nq_mall_dashboard/shared/constant.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';

import '../components/my_button.dart';
import '../components/responsive.dart';
import '../components/text_field_widget.dart';
import '../components/text_widget.dart';

class EditCategoryScreen extends StatelessWidget {
  CategoryModel categoryModel;
  EditCategoryScreen({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditCategoryScreenController>(
      init: Get.put(EditCategoryScreenController(categoryModel: categoryModel)),
      builder: (controller) => Directionality(
        textDirection: currentDirection,
        child: Scaffold(
          appBar: AppBarWidget(
            showBackButton: true,
          ),
          backgroundColor: MyTheme.blackColor,
          body: controller.loading.value
              ? const Center(
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
                                  Icons.edit,
                                  color: MyTheme.iconColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const TextWidget(text: 'تعديل الصنف')
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: MyTheme.padding,
                        margin: MyTheme.margin,
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
                                MyButton(
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
                                  image: controller.image != null
                                      ? DecorationImage(
                                          image: FileImage(
                                            controller.image!,
                                          ),
                                          fit: BoxFit.cover)
                                      : null,
                                ),
                                child: controller.image == null
                                    ? Image.network(Constants.mediaUrl! +
                                        "/" +
                                        controller.categoryModel.ImageURL!)
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
                            const SizedBox(
                              height: 20,
                            ),
                            MyButton(
                              action: () => controller.submit(),
                              buttonColor: MyTheme.blueColor,
                              text: "تعديل",
                              margin: EdgeInsets.zero,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
