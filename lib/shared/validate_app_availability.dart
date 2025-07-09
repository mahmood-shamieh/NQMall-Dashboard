import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/components/dialog_box_2.dart';
import 'package:nq_mall_dashboard/components/my_button.dart';
import 'package:nq_mall_dashboard/components/text_widget.dart';
import 'package:nq_mall_dashboard/models/app_config_model.dart';
import 'package:nq_mall_dashboard/shared/theme.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ValidateAppAvailability {
  static Future<Map<String, bool>> isAppAvailable(
      {required AppConfigModel appConfigModel}) async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version; // e.g. "1.0.0"
      bool workingOrNot = false;
      if (kIsWeb) {
        workingOrNot =
            appConfigModel.Dashboard_Android_Version.toString().trim() ==
                version.trim();
      } else if (Platform.isAndroid) {
        workingOrNot =
            appConfigModel.Dashboard_Android_Version.toString().trim() ==
                version.trim();
      } else if (Platform.isIOS) {
        workingOrNot =
            appConfigModel.Dashboard_Android_Version.toString().trim() ==
                version.trim();
      }
      // print(workingOrNot);
      // print(appConfigModel.DashboardEnabled);
      // if (!(appConfigModel.DashboardEnabled ?? false) || !workingOrNot) {
      //   print(";lkasd ;lkasd  ;laksd l;akds");
      // }
      return {
        "DashboardEnabled": appConfigModel.DashboardEnabled ?? false,
        "WorkingOrNot": workingOrNot
      };
    } catch (e) {
      print('Error checking app availability: $e');
      return {};
    }
  }
}
