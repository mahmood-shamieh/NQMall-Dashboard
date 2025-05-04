import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/apis/brand/delete_brand_api.dart';
import 'package:nq_mall_dashboard/apis/brand/get_all_brands.dart';
import 'package:nq_mall_dashboard/apis/brand/update_brand_api.dart';
import 'package:nq_mall_dashboard/apis/category/delete_category_api.dart';
import 'package:nq_mall_dashboard/apis/category/get_all_category.dart';
import 'package:nq_mall_dashboard/models/brand_model.dart';
import 'package:nq_mall_dashboard/models/category_model.dart';
import 'package:nq_mall_dashboard/models/pagination_model.dart';
import 'package:nq_mall_dashboard/models/response_model.dart';

import '../../apis/category/update_category_api.dart';
import '../../exception/connection_time_out.dart';
import '../../exception/un_defined_problem.dart';

class BrandScreenController extends GetxController {
  RxBool loading = true.obs;
  int page = 1;
  int itemPerPage = 4;
  ScrollController scrollController = ScrollController();
  List<BrandModel>? brands = [];

  TextEditingController searchBarText = TextEditingController();

  void getAllBrands() async {
    // loading(true);
    // update();
    loading(true);
    update();
    await Future.delayed(Duration(seconds: 1), () async {
      ResponseModel response = await GetAllBrands().callApi(details: {
        "searchQuery": searchBarText.text,
        "page": page.toString(),
        "limit": itemPerPage.toString(),
      });

      PaginationModel paginationModel = PaginationModel.fromMap(response.data);
      List<BrandModel> temp = paginationModel.data!
          .map<BrandModel>(
            (e) => BrandModel.fromMap(e),
          )
          .toList();
      if (temp.isEmpty) {
        page--;
      } else {
        for (BrandModel element in temp) {
          brands!.addIf(!brands!.contains(element), element);
        }

        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.offset + 40,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        }
      }
    });
    loading(false);
    update();
  }

  @override
  void onInit() {
    searchBarText.addListener(
      () {
        page = 1;
        brands!.clear();
        getAllBrands();
      },
    );
    getAllBrands();
    super.onInit();
  }

  changeBrandStatus(
      {required BrandModel brandModel, required bool status}) async {
    try {
      loading(true);
      update();
      ResponseModel responseModel = await UpdateBrandApi().callApi(
          brandModel: brandModel.copyWith(IsActive: status), image: null);
      // await Future.delayed(Duration(seconds: 3));
      loading(false);
      update();
      // print(responseModel);
      if (responseModel.code == 200) {
        Get.back();
        BrandScreenController categoryScreenController =
            Get.find<BrandScreenController>();
        categoryScreenController.onInit();
        brandModel.IsActive = status;
        // print(brandModel.IsActive);
      }
    } catch (e) {
      if (e is ConnectionTimeOut) {
      } else if (e is UndefindProblem) {}
    }
  }

  deleteBrand({required BrandModel brandModel}) async {
    try {
      loading(true);
      update();
      ResponseModel responseModel =
          await DeleteBrandApi().callApi(brandModel: brandModel);
      loading(false);
      update();
      if (responseModel.code == 200) {
        brands?.removeWhere((e) => e.Id == brandModel.Id);
        Get.back();
        BrandScreenController categoryScreenController =
            Get.find<BrandScreenController>();
        categoryScreenController.onInit();
      }
    } catch (e) {
      if (e is ConnectionTimeOut) {
      } else if (e is UndefindProblem) {}
    }
  }

  void getBrandAtNextPage() {
    print("Load more data");
    page++;
    getAllBrands();
    if (brands!.isEmpty) page--;
  }
}
