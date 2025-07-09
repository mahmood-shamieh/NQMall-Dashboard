import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';

class ImageCanBeDeletedWidget extends StatelessWidget {
  String url;
  bool isDeleted;
  Function() action;
  ImageCanBeDeletedWidget(
      {super.key,
      required this.url,
      required this.isDeleted,
      required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      child: Stack(
        children: [
          Visibility(
            visible: isDeleted,
            child: Container(
              decoration: BoxDecoration(
                color: MyTheme.darkGreyColor.withOpacity(
                  0.5,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: action,
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  MyTheme.appBarColor.withOpacity(
                    0.3,
                  ),
                ),
              ),
              icon: isDeleted
                  ? Icon(
                      Icons.close,
                      color: MyTheme.errorColor,
                    )
                  : Icon(
                      Icons.delete,
                      color: MyTheme.greyColor,
                    ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(url),
        ),
      ),
    );
  }
}
