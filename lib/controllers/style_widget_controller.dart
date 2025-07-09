import 'package:get/get.dart';
import 'package:nq_mall_dashboard/main.dart';
import 'package:nq_mall_dashboard/models/user_model.dart';
import 'package:nq_mall_dashboard/shared/pages.dart';

class StyleWidgetController extends GetxController {
  Rx<Pages?> currentPage = Rx(null);
  UserModel userModel = getIt.get<UserModel>();

  void changePage({required currentPage}) {
    this.currentPage(currentPage);
    update();
  }
}
