import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nq_mall_dashboard/components/my_button.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/models/category_model.dart';
import 'package:nq_mall_dashboard/shared/constant.dart';
import 'package:nq_mall_dashboard/shared/string_utility.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';

class CategoryItem extends StatelessWidget {
  bool? isMobile;
  CategoryModel categoryModel;
  Function() action;
  Widget actionWidget;
  CategoryItem(
      {super.key,
      required this.action,
      this.isMobile,
      required this.categoryModel,
      required this.actionWidget});

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      Container(
        width: isMobile ?? false ? 100 : 40,
        height: isMobile ?? false ? 100 : 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          image: DecorationImage(
            image: NetworkImage(
                "${Constants.mediaUrl!}/${categoryModel.ImageURL!.toUrl()}"),
          ),
        ),
      ),
      SizedBox(
        // color: Colors.amber,
        width: isMobile ?? false
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width / 8,
        child: TextWidget(
          text: categoryModel.NameAr ?? '',
          fontWeight: FontWeight.w300,
          textAlign: TextAlign.start,
        ),
      ),
      SizedBox(
        // color: Colors.green,
        width: isMobile ?? false
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width / 8,
        child: TextWidget(
          text: categoryModel.NameEn ?? '',
          fontWeight: FontWeight.w300,
          textAlign: TextAlign.start,
        ),
      ),
      SizedBox(
        // color: Colors.blue,
        width: isMobile ?? false
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width / 8,
        child: TextWidget(
          text: categoryModel.DescriptionAr ?? '',
          fontWeight: FontWeight.w300,
          textAlign: TextAlign.start,
        ),
      ),
      SizedBox(
        // color: Colors.cyan,
        width: isMobile ?? false
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width / 8,
        child: TextWidget(
          text: categoryModel.DescriptionEn ?? '',
          fontWeight: FontWeight.w300,
          textAlign: TextAlign.start,
        ),
      ),
      SizedBox(
        // color: Colors.red,
        width: isMobile ?? false
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width / 8,
        child: TextWidget(
          text: categoryModel.ImageURL ?? '',
          fontWeight: FontWeight.w300,
          textAlign: TextAlign.start,
        ),
      ),
      SizedBox(
        // color: Colors.amber,
        width: isMobile ?? false
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width / 8,
        child: Container(
          child: categoryModel.IsActive ?? false
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.green,
                  ),
                  child: TextWidget(
                    text: "فعال",
                    textAlign: TextAlign.center,
                    color: MyTheme.iconColor,
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: MyTheme.errorColor,
                  ),
                  child: TextWidget(
                    text: "غير فعال",
                    textAlign: TextAlign.center,
                    color: MyTheme.iconColor,
                  ),
                ),
        ),
      ),

      // IconButton(
      //   onPressed: action,
      //   icon: Icon(
      //     Icons.menu,
      //   ),
      //   color: MyTheme.iconColor,
      // )
      actionWidget
    ];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: isMobile ?? false ? null : 60,
      decoration: BoxDecoration(
          color: MyTheme.appBarColor,
          border: Border.all(
            color: MyTheme.shadowColor,
            width: 0.6,
          ),
          borderRadius: BorderRadius.circular(
            10,
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isMobile ?? false
            ? Column(
                // alignment: WrapAlignment.spaceBetween,
                children: items,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: items,
              ),
      ),
    );
  }
}
