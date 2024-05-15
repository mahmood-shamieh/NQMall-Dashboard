import 'package:get/get.dart';
import 'package:nq_mall_dashboard/shared/pages.dart';

class StyleWidgetController extends GetxController {
  Rx<Pages> currentPage = Pages.products.obs;

  void changePage({required currentPage}) {
    this.currentPage(currentPage);
    print(currentPage);
    update();
  }
}
