import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/apis/brand/delete_brand_api.dart';
import 'package:nq_mall_dashboard/apis/brand/get_all_brands.dart';
import 'package:nq_mall_dashboard/apis/brand/update_brand_api.dart';
import 'package:nq_mall_dashboard/apis/category/delete_category_api.dart';
import 'package:nq_mall_dashboard/apis/category/get_all_category.dart';
import 'package:nq_mall_dashboard/apis/product/delete_product_api.dart';
import 'package:nq_mall_dashboard/apis/product/get_all_products.dart';
import 'package:nq_mall_dashboard/apis/product/update_product_api.dart';
import 'package:nq_mall_dashboard/models/brand_model.dart';
import 'package:nq_mall_dashboard/models/category_model.dart';
import 'package:nq_mall_dashboard/models/pagination_model.dart';
import 'package:nq_mall_dashboard/models/product_model.dart';
import 'package:nq_mall_dashboard/models/response_model.dart';

import '../../apis/category/update_category_api.dart';
import '../../exception/connection_time_out.dart';
import '../../exception/un_defined_problem.dart';

class ProductScreenController extends GetxController {
  RxBool loading = true.obs;
  int page = 1;
  int itemPerPage = 4;
  ScrollController scrollController = ScrollController();
  List<ProductModel>? products = [];

  TextEditingController searchBarText = TextEditingController();

  void getAllProducts() async {
    // loading(true);
    // update();
    loading(true);
    update();
    // await Future.delayed(Duration(seconds: 1), () async {
    ResponseModel response = await GetAllProductsApi().callApi(details: {
      "searchQuery": searchBarText.text,
      "page": page.toString(),
      "limit": itemPerPage.toString(),
    });

    PaginationModel paginationModel = PaginationModel.fromMap(response.data);
    List<ProductModel> temp = paginationModel.data!
        .map<ProductModel>(
          (e) => ProductModel.fromMap(e),
        )
        .toList();
    products!.clear();
    if (temp.isEmpty) {
      page--;
    } else {
      for (ProductModel element in temp) {
        products!.addIf(true || !products!.contains(element), element);
      }

      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.offset + 40,
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
        products!.clear();
        getAllProducts();
      },
    );
    getAllProducts();
    super.onInit();
  }

  changeProductStatus(
      {required ProductModel productModel, required bool status}) async {
    try {
      loading(true);
      update();
      ResponseModel responseModel = await UpdateProductApi().callApi(
        productModel: productModel.copyWith(IsActive: status),
      );
      // await Future.delayed(Duration(seconds: 3));
      loading(false);
      update();
      // print(responseModel);
      if (responseModel.code == 200) {
        Get.back();
        ProductScreenController productScreenController =
            Get.find<ProductScreenController>();
        productScreenController.onInit();
        productModel.IsActive = status;
        // print(brandModel.IsActive);
      }
    } catch (e) {
      if (e is ConnectionTimeOut) {
      } else if (e is UndefindProblem) {}
    }
  }

  deleteProduct({required ProductModel productModel}) async {
    try {
      loading(true);
      update();
      ResponseModel responseModel =
          await DeleteProductApi().callApi(productModel: productModel);
      loading(false);
      update();
      if (responseModel.code == 200) {
        Get.back();
        ProductScreenController productScreenController =
            Get.find<ProductScreenController>();
        productScreenController.onInit();
      }
    } catch (e) {
      if (e is ConnectionTimeOut) {
      } else if (e is UndefindProblem) {}
    }
  }

  void getBrandAtNextPage() {
    print("Load more data");
    page++;
    getAllProducts();
    if (products!.isEmpty) page--;
  }
}
