import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/apis/brand/delete_brand_api.dart';
import 'package:nq_mall_dashboard/apis/brand/get_all_brands.dart';
import 'package:nq_mall_dashboard/apis/brand/update_brand_api.dart';
import 'package:nq_mall_dashboard/apis/category/delete_category_api.dart';
import 'package:nq_mall_dashboard/apis/category/get_all_category.dart';
import 'package:nq_mall_dashboard/apis/orders/get_all_orders_api.dart';
import 'package:nq_mall_dashboard/apis/product/delete_product_api.dart';
import 'package:nq_mall_dashboard/apis/product/get_all_products.dart';
import 'package:nq_mall_dashboard/apis/product/update_product_api.dart';
import 'package:nq_mall_dashboard/models/brand_model.dart';
import 'package:nq_mall_dashboard/models/category_model.dart';
import 'package:nq_mall_dashboard/models/order_model.dart';
import 'package:nq_mall_dashboard/models/pagination_model.dart';
import 'package:nq_mall_dashboard/models/product_model.dart';
import 'package:nq_mall_dashboard/models/response_model.dart';

import '../../apis/category/update_category_api.dart';
import '../../exception/connection_time_out.dart';
import '../../exception/un_defined_problem.dart';

class OrdersScreenController extends GetxController {
  RxBool loading = true.obs;
  int page = 1;
  int itemPerPage = 4;
  ScrollController scrollController = ScrollController();
  List<OrderModel>? orders = [];
  // double lastScrollPosition = 0.0;
  TextEditingController searchBarText = TextEditingController();

  void getAllOrders() async {
    loading(true);
    update();
    ResponseModel response = await GetAllOrdersApi().callApi(details: {
      "searchQuery": searchBarText.text,
      "page": page.toString(),
      "limit": itemPerPage.toString(),
    });

    PaginationModel paginationModel = PaginationModel.fromMap(response.data);
    List<OrderModel> temp = paginationModel.data!
        .map<OrderModel>(
          (e) => OrderModel.fromMap(e),
        )
        .toList();
    // products!.clear();
    if (temp.isEmpty) {
      page--;
    } else {
      for (OrderModel element in temp) {
        orders!.addIf(!orders!.contains(element), element);
      }

      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.offset + 40,
          // lastScrollPosition,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    }
    // });
    loading(false);
    update();
  }

  @override
  void onInit() {
    searchBarText.addListener(
      () {
        page = 1;
        orders!.clear();
        // update();
        getAllOrders();
      },
    );

    getAllOrders();
    super.onInit();
  }

  void getOrderNextPage() {
    // lastScrollPosition = scrollController.position.pixels;
    page++;
    getAllOrders();
    if (orders!.isEmpty) page--;
  }

  refreshStatusAction() {
    page = 1;
    orders!.clear();
    getAllOrders();
  }
}
