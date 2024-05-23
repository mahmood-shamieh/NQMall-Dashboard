import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/components/my_button.dart';
import 'package:nq_mall_dashboard/models/attribute_model.dart';
import 'package:nq_mall_dashboard/shared/constant.dart';
import 'package:nq_mall_dashboard/shared/string_utility.dart';

import '../shared/theme.dart';
import 'text_widget.dart';

class TextAttributeWidget extends StatelessWidget {
  AttributeModel attributeModel;
  bool isArabic;
  bool? isDeleted;
  Function()? deleteAction;
  TextAttributeWidget({
    super.key,
    required this.attributeModel,
    required this.isArabic,
    this.isDeleted,
    this.deleteAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextWidget(
              text:
                  "${(isArabic ? attributeModel.NameAr : attributeModel.NameEn) ?? ''}: "
                      .capitalizeFirst!,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            const SizedBox(
              width: 5,
            ),
            Visibility(
              visible: isDeleted ?? false,
              child: TextWidget(
                text: "محذوفة".capitalizeFirst!,
                fontWeight: FontWeight.bold,
                color: MyTheme.errorColor,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Visibility(
              visible: deleteAction != null,
              child: IconButton(
                onPressed: deleteAction,
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    MyTheme.darkGreyColor.withOpacity(
                      0.5,
                    ),
                  ),
                ),
                icon: Icon(
                  isDeleted ?? false ? Icons.close : Icons.delete,
                  color: MyTheme.iconColor,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          // color: Colors.amber,
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: ((isArabic
                        ? attributeModel.ContentAr
                        : attributeModel.ContentEn) ??
                    [])
                .map(
                  (e) => InkWell(
                    onLongPress: () => showCupertinoModalPopup(
                      context: context,
                      builder: (context) => Container(
                        decoration: BoxDecoration(
                          color: MyTheme.appBarColor,
                          borderRadius: MyTheme.buttonsRadius,
                        ),
                        child: SizedBox(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () => Get.back(),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    MyTheme.darkGreyColor.withOpacity(
                                      0.5,
                                    ),
                                  ),
                                ),
                                icon: FaIcon(
                                  FontAwesomeIcons.close,
                                  color: MyTheme.iconColor,
                                  // size: 30,
                                ),
                              ),
                              Container(
                                height: 400,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                // width: MediaQuery.of(context).size.width - 40,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            '${Constants.mediaUrl}/${e.hoverImage!.toUrl()}'))),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      width: 50,
                      // height: 60,
                      decoration: BoxDecoration(
                        borderRadius: MyTheme.buttonsRadius,
                        color: MyTheme.blackColor,
                        // shape: BoxShape.circle,
                        border: Border.all(
                          color: MyTheme.blueColor,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: TextWidget(
                          text: e.item ?? '',
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        )
      ],
    );
  }
}
