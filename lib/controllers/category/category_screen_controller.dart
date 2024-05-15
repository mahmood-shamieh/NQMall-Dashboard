import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/apis/category/delete_category_api.dart';
import 'package:nq_mall_dashboard/apis/category/get_all_category.dart';
import 'package:nq_mall_dashboard/models/category_model.dart';
import 'package:nq_mall_dashboard/models/pagination_model.dart';
import 'package:nq_mall_dashboard/models/response_model.dart';

import '../../apis/category/update_category_api.dart';
import '../../exception/connection_time_out.dart';
import '../../exception/un_defined_problem.dart';

class CategoryScreenController extends GetxController {
  RxBool loading = true.obs;
  int page = 1;
  int itemPerPage = 4;
  ScrollController scrollController = ScrollController();
  List<CategoryModel>? categories = [];
  TextEditingController searchBarText = TextEditingController();

  void getAllCategory() async {
    // loading(true);
    // update();
    loading(true);
    update();
    await Future.delayed(Duration(seconds: 1), () async {
      ResponseModel response = await GetAllCategoryApi().callApi(details: {
        "searchQuery": searchBarText.text,
        "page": page.toString(),
        "limit": itemPerPage.toString(),
      });
      PaginationModel paginationModel = PaginationModel.fromMap(response.data);
      // print(.runtimeType);
      // categories = paginationModel.data!
      //     .map<CategoryModel>(
      //       (e) => CategoryModel.fromMap(e),
      //     )
      //     .toList();
      List<CategoryModel> temp = paginationModel.data!
          .map<CategoryModel>(
            (e) => CategoryModel.fromMap(e),
          )
          .toList();
      if (temp.isEmpty) {
        page--;
      } else {
        for (var element in temp) {
          categories!.addIf(!categories!.contains(element), element);
        }

        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.offset + 40,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        }
        // categories!.addAllIf(!categories!.contains(temp), temp);
        // categories!.addAll(temp);
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
        categories!.clear();
        getAllCategory();
      },
    );
    getAllCategory();
    super.onInit();
  }

  changeCategoryStatus(
      {required CategoryModel categoryModel, required bool status}) async {
    try {
      loading(true);
      update();
      ResponseModel responseModel = await UpdateCategoryApi().callApi(
          categoryModel: categoryModel.copyWith(IsActive: status), image: null);
      loading(false);
      update();
      if (responseModel.code == 200) {
        Get.back();
        CategoryScreenController categoryScreenController =
            Get.find<CategoryScreenController>();
        categoryScreenController.onInit();
        categoryModel.IsActive = status;
      }
    } catch (e) {
      if (e is ConnectionTimeOut) {
      } else if (e is UndefindProblem) {}
    }
  }

  deleteCategory({required CategoryModel categoryModel}) async {
    try {
      loading(true);
      update();
      ResponseModel responseModel =
          await DeleteCategoryApi().callApi(categoryModel: categoryModel);
      loading(false);
      update();
      if (responseModel.code == 200) {
        Get.back();
        CategoryScreenController categoryScreenController =
            Get.find<CategoryScreenController>();
        categoryScreenController.onInit();
      }
    } catch (e) {
      if (e is ConnectionTimeOut) {
      } else if (e is UndefindProblem) {}
    }
  }

  void getCategoryAtNextPage() {
    print("Load more data");
    page++;
    getAllCategory();
    if (categories!.isEmpty) page--;
  }
}
