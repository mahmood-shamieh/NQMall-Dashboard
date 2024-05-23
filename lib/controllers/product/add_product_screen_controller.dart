// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/apis/attributes/add_image_attribute_api.dart';
import 'package:nq_mall_dashboard/apis/attributes/add_text_attribute_api.dart';
import 'package:nq_mall_dashboard/apis/brand/get_all_brands_no_pagination.dart';
import 'package:nq_mall_dashboard/apis/category/get_all_categories_no_pagination.dart';
import 'package:nq_mall_dashboard/apis/media/add_media_api.dart';
import 'package:nq_mall_dashboard/apis/product/add_product_api.dart';
import 'package:nq_mall_dashboard/controllers/product/product_screen_controller.dart';
import 'package:nq_mall_dashboard/models/attribute_model.dart';
import 'package:nq_mall_dashboard/models/brand_model.dart';
import 'package:nq_mall_dashboard/models/category_model.dart';
import 'package:nq_mall_dashboard/models/product_model.dart';
import 'package:nq_mall_dashboard/models/response_model.dart';

class AddProductScreenController extends GetxController {
  RxBool loading = false.obs;
  RxBool showDialog = false.obs;
  RxBool createProduct = true.obs;
  RxBool uploadMedia = true.obs;
  RxBool uploadProductDetails = true.obs;
  List<Uint8List> imagesBytes = [];
  List<CategoryModel>? categories;
  List<BrandModel>? brands;
  Rx<CategoryModel>? selectedCategory;
  Rx<BrandModel>? selectedBrand;
  List<Map<String, TextEditingController>> attributes = [];
  List<Map<String, TextEditingController>> textAttributes = [];
  List<Map<String, TextEditingController>> imageAttributes = [];
  Map<int, List<Map<String, dynamic>>> textAttributesValues = {};
  Map<int, List<Map<String, dynamic>>> imageAttributesValues = {};
  TextEditingController categorySearchController = TextEditingController();
  TextEditingController brandSearchController = TextEditingController();
  TextEditingController nameAr = TextEditingController();
  TextEditingController nameEn = TextEditingController();
  TextEditingController descAr = TextEditingController();
  TextEditingController descEn = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  @override
  void onInit() async {
    // fillfileds();
    await loadBrands();
    await loadCategories();
    selectedBrand = Rx(brands!.first);
    selectedCategory = Rx(categories!.first);
    update();
    super.onInit();
  }

  fillfileds() async {
    nameAr.text = "product1";
    nameEn.text = "product2";
    descAr.text = "descAr";
    descEn.text = "descEn";
    price.text = 123.toString();
    salePrice.text = 321.toString();
    for (var element in [1, 2]) {
      Map<String, TextEditingController> data = {
        "nameAr": TextEditingController(),
        "valueAr": TextEditingController(),
        "nameEn": TextEditingController(),
        "valueEn": TextEditingController(),
      };
      data['nameAr']!.text = "nameAr" + element.toString();
      data['valueAr']!.text = "valueAr" + element.toString();
      data['nameEn']!.text = "nameEn" + element.toString();
      data['valueEn']!.text = "valueEn" + element.toString();
      attributes.add(data);
    }
    final ByteData data = await rootBundle.load(
        "assets/images/DALL·E 2024-04-24 15.19.36 - A creative brand logo for a fictional pet store called 'Paw Paradise'. The logo features a playful depiction of a dog's paw print, with each pad shape.webp");
    final ByteData data1 = await rootBundle.load(
        "assets/images/DALL·E 2024-04-24 15.48.56 - A vibrant brand logo for a fictional smoothie shop called 'Tropical Blends'. The logo features a colorful illustration of a tropical paradise scene wi.webp");
    final ByteData data2 = await rootBundle.load(
        "assets/images/DALL·E 2024-04-24 15.49.37 - A minimalist brand logo for a fictional software development company called 'CodeCraft'. The logo features a simple, geometric design of an abstract c.webp");
    final ByteData data3 = await rootBundle.load(
        "assets/images/DALL·E 2024-04-24 15.50.14 - An elegant brand logo for a fictional vineyard and winery called 'Vine Visions'. The logo features a stylized grapevine with lush, green leaves and cl.webp");
    final Uint8List bytes = data.buffer.asUint8List();
    final Uint8List bytes1 = data1.buffer.asUint8List();
    final Uint8List bytes2 = data2.buffer.asUint8List();
    final Uint8List bytes3 = data3.buffer.asUint8List();
    imagesBytes.addAll([bytes, bytes1, bytes2, bytes3]);
    Map<String, TextEditingController> textAttribute = {
      "nameAr": TextEditingController(),
      "nameEn": TextEditingController(),
    };
    textAttribute['nameAr']!.text = "text att1";
    textAttribute['nameEn']!.text = "text att1";
    textAttributes.add(textAttribute);
    Map<String, dynamic> dataValue = {
      "valueAr": TextEditingController(),
      "valueEn": TextEditingController(),
      "imageByte": bytes,
    };
    dataValue['valueAr']!.text = "text att1 val1";
    dataValue['valueEn']!.text = "text att1 val1";
    if (textAttributesValues[textAttribute.hashCode] == null) {
      textAttributesValues[textAttribute.hashCode] = [];
    }
    textAttributesValues[textAttribute.hashCode]!.add(dataValue);
    dataValue = {
      "valueAr": TextEditingController(),
      "valueEn": TextEditingController(),
      "imageByte": bytes,
    };
    dataValue['valueAr']!.text = "text att1 val2";
    dataValue['valueEn']!.text = "text att1 val2";
    if (textAttributesValues[textAttribute.hashCode] == null) {
      textAttributesValues[textAttribute.hashCode] = [];
    }
    textAttributesValues[textAttribute.hashCode]!.add(dataValue);
    textAttribute = {
      "nameAr": TextEditingController(),
      "nameEn": TextEditingController(),
    };
    textAttribute['nameAr']!.text = "text att2";
    textAttribute['nameEn']!.text = "text att2";
    textAttributes.add(textAttribute);
    dataValue = {
      "valueAr": TextEditingController(),
      "valueEn": TextEditingController(),
      "imageByte": bytes,
    };
    dataValue['valueAr']!.text = "text att2 val1";
    dataValue['valueEn']!.text = "text att2 val1";
    if (textAttributesValues[textAttribute.hashCode] == null) {
      textAttributesValues[textAttribute.hashCode] = [];
    }
    textAttributesValues[textAttribute.hashCode]!.add(dataValue);
    dataValue = {
      "valueAr": TextEditingController(),
      "valueEn": TextEditingController(),
      "imageByte": bytes,
    };
    dataValue['valueAr']!.text = "text att2 val2";
    dataValue['valueEn']!.text = "text att2 val2";
    if (textAttributesValues[textAttribute.hashCode] == null) {
      textAttributesValues[textAttribute.hashCode] = [];
    }
    textAttributesValues[textAttribute.hashCode]!.add(dataValue);
    Map<String, TextEditingController> imageAttributesMap = {
      "nameAr": TextEditingController(),
      "nameEn": TextEditingController(),
    };
    imageAttributesMap['nameAr']!.text = "image att1";
    imageAttributesMap['nameEn']!.text = "image att1";
    imageAttributes.add(imageAttributesMap);
    Map<String, dynamic> dataValueImageAttributes = {
      "imageByteAr": bytes2,
      "imageByteEn": bytes1,
      "imageByte": bytes3,
    };
    if (imageAttributesValues[imageAttributesMap.hashCode] == null) {
      imageAttributesValues[imageAttributesMap.hashCode] = [];
    }
    imageAttributesValues[imageAttributesMap.hashCode]!
        .add(dataValueImageAttributes);
    dataValueImageAttributes = {
      "imageByteAr": bytes2,
      "imageByteEn": bytes1,
      "imageByte": bytes3,
    };
    if (imageAttributesValues[imageAttributesMap.hashCode] == null) {
      imageAttributesValues[imageAttributesMap.hashCode] = [];
    }

    imageAttributesValues[imageAttributesMap.hashCode]!
        .add(dataValueImageAttributes);
    imageAttributesMap = {
      "nameAr": TextEditingController(),
      "nameEn": TextEditingController(),
    };
    imageAttributesMap['nameAr']!.text = "image att2";
    imageAttributesMap['nameEn']!.text = "image att2";
    imageAttributes.add(imageAttributesMap);
    dataValueImageAttributes = {
      "imageByteAr": bytes2,
      "imageByteEn": bytes1,
      "imageByte": bytes3,
    };
    if (imageAttributesValues[imageAttributesMap.hashCode] == null) {
      imageAttributesValues[imageAttributesMap.hashCode] = [];
    }

    imageAttributesValues[imageAttributesMap.hashCode]!
        .add(dataValueImageAttributes);

    update();
  }

  Future loadBrands() async {
    try {
      loading(true);
      update();
      ResponseModel responseModel =
          await GetAllBrandsNoPaginationApi().callApi();

      brands = (responseModel.data as List)
          .map((e) => BrandModel.fromMap(e))
          .toList();
      loading(false);
      update();
    } catch (e) {}
  }

  Future loadCategories() async {
    try {
      loading(true);
      update();
      ResponseModel responseModel =
          await GetAllCategoriesNoPaginationApi().callApi();

      categories = (responseModel.data as List)
          .map((e) => CategoryModel.fromMap(e))
          .toList();
      loading(false);
      update();
    } catch (e) {}
  }

  void chooseCategory({required CategoryModel category}) {
    selectedCategory = Rx(category);
    update();
  }

  void chooseBrand({required BrandModel brand}) {
    selectedBrand = Rx(brand);
    update();
  }

  void addAttribute() {
    Map<String, TextEditingController> data = {
      "nameAr": TextEditingController(),
      "valueAr": TextEditingController(),
      "nameEn": TextEditingController(),
      "valueEn": TextEditingController(),
    };
    attributes.add(data);
    update();
  }

  addTextAttribute() {
    Map<String, TextEditingController> data = {
      "nameAr": TextEditingController(),
      "nameEn": TextEditingController(),
    };
    textAttributes.add(data);
    update();
  }

  addImageAttribute() {
    Map<String, TextEditingController> data = {
      "nameAr": TextEditingController(),
      "nameEn": TextEditingController(),
    };
    imageAttributes.add(data);

    update();
  }

  void addTextAttributeValue({required int attributeHashCode}) {
    Map<String, dynamic> dataValue = {
      "valueAr": TextEditingController(),
      "valueEn": TextEditingController(),
      "imageByte": null,
    };

    if (textAttributesValues[attributeHashCode] == null) {
      textAttributesValues[attributeHashCode] = [];
    }
    textAttributesValues[attributeHashCode]!.add(dataValue);
    update();
  }

  void addImageAttributeValue({required int attributeHashCode}) {
    Map<String, dynamic> dataValue = {
      "imageByteAr": null,
      "imageByteEn": null,
      "imageByte": null,
    };
    if (imageAttributesValues[attributeHashCode] == null) {
      imageAttributesValues[attributeHashCode] = [];
    }
    imageAttributesValues[attributeHashCode]!.add(dataValue);
    update();
  }

  void deleteAttribute(Map<String, TextEditingController> data) {
    attributes.remove(data);

    update();
  }

  deleteTextAttribute(Map<String, TextEditingController> data) {
    textAttributes.remove(data);
    update();
  }

  deleteImageAttribute(Map<String, TextEditingController> data) {
    imageAttributes.remove(data);
    update();
  }

  deleteTextAttributeValue(
      {required Map<String, dynamic> data, required int attributeHashCode}) {
    textAttributesValues[attributeHashCode]!.remove(data);
    update();
  }

  deleteImageAttributeValue(
      {required Map<String, dynamic> data, required int attributeHashCode}) {
    imageAttributesValues[attributeHashCode]!.remove(data);
    update();
  }

  void chooseImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
      withData: true,
    );

    if (result != null) {
      // FileReader reader = html.FileReader();
      // PlatformFile file1 = result.files.single;
      for (PlatformFile element in result.files) {
        Uint8List uploadFile = element.bytes!;
        imagesBytes.add(uploadFile);
      }

      update();
    } else {}
  }

  void chooseImageForTextAttribute(
      {required int attributeHashCode,
      required int attributeValueHashCode}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: true,
    );

    if (result != null) {
      for (PlatformFile element in result.files) {
        Uint8List uploadFile = element.bytes!;
        textAttributesValues[attributeHashCode]!
            .where((element) => element.hashCode == attributeValueHashCode)
            .first['imageByte'] = uploadFile;
      }

      update();
    } else {}
  }

  void chooseImageForImageAttribute(
      {required int attributeHashCode,
      required int attributeValueHashCode,
      required String key}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: true,
    );

    if (result != null) {
      for (PlatformFile element in result.files) {
        Uint8List uploadFile = element.bytes!;
        imageAttributesValues[attributeHashCode]!
            .where((element) => element.hashCode == attributeValueHashCode)
            .first[key] = uploadFile;
      }

      update();
    } else {}
  }

  void submit() async {
    Map<String, String> descriptionAr = {};
    attributes.forEach((element) {
      print(element);
    });
    for (var element in attributes) {
      descriptionAr[element['nameAr']!.text.trim()] =
          element['valueAr']!.text.trim();
    }
    Map<String, String> descriptionEn = {};
    for (var element in attributes) {
      descriptionEn[element['nameEn']!.text.trim()] =
          element['valueEn']!.text.trim();
    }
    ProductModel productModel = ProductModel(
      NameAr: nameAr.text.trim(),
      NameEn: nameEn.text.trim(),
      DescriptionAr: descAr.text.trim(),
      DescriptionEn: descEn.text.trim(),
      Price: int.parse(price.text.trim()),
      SalePrice: int.parse(salePrice.text.trim()),
      DetailsAr: descriptionAr,
      DetailsEn: descriptionEn,
      userId: 1,
      IsActive: true,
      categoryId: selectedCategory?.value.Id,
      brandId: selectedBrand?.value.Id,
    );
    showDialog(true);
    createProduct(true);
    uploadMedia(true);
    uploadProductDetails(true);
    update();
    ResponseModel responseModel =
        await AddProductApi().callApi(productModel: productModel);
    if (responseModel.code == 200) {
      productModel = ProductModel.fromMap(responseModel.data);
      createProduct(false);
      update();

      ResponseModel uploadMediaResponse = await AddMediaApi()
          .callApi(productModel: productModel, images: imagesBytes);
      if (uploadMediaResponse.code == 200) {
        uploadMedia(false);
        update();
        textAttributes.forEach((element) async {
          List<String> itemsAr = [];
          textAttributesValues[element.hashCode]!
              .forEach((textAttributesValue) {
            itemsAr.add(textAttributesValue["valueAr"]!.text.trim());
          });
          List<String> itemsEn = [];
          textAttributesValues[element.hashCode]!
              .forEach((textAttributesValue) {
            itemsEn.add(textAttributesValue["valueEn"]!.text.trim());
          });
          List<Uint8List> mediaAr = [];
          textAttributesValues[element.hashCode]!
              .forEach((textAttributesValue) async {
            mediaAr.add(textAttributesValue['imageByte'] ??
                await loadPlaceHolderFile());
          });
          List<Uint8List> mediaEn = [];
          textAttributesValues[element.hashCode]!
              .forEach((textAttributesValue) async {
            mediaEn.add(textAttributesValue['imageByte'] ??
                await loadPlaceHolderFile());
          });
          late ResponseModel uploadAttributeResponse;
          // await Future.delayed(const Duration(seconds: 2), () async {
          uploadAttributeResponse = await AddTextAttributeApi().callApi(
            productModel: productModel,
            attributeModel: AttributeModel(
              NameAr: element['nameAr']!.text.trim(),
              NameEn: element['nameAr']!.text.trim(),
              IsActive: true,
            ),
            itemsAr: itemsAr,
            itemsEn: itemsEn,
            mediaAr: mediaAr,
            mediaEn: mediaEn,
          );
          // });
        });
      }
      imageAttributes.forEach((element) async {
        List<Uint8List> itemsAr = [], itemsEn = [], mediaAr = [], mediaEn = [];
        imageAttributesValues[element.hashCode]!.forEach((element) {
          itemsAr.add(element["imageByteAr"] ?? loadPlaceHolderFile());
          itemsEn.add(element["imageByteEn"] ?? loadPlaceHolderFile());
          mediaAr.add(element["imageByte"] ?? loadPlaceHolderFile());
          mediaEn.add(element["imageByte"] ?? loadPlaceHolderFile());
        });
        ResponseModel uploadImageAttributesResponse =
            await AddImageAttributeApi().callApi(
          productModel: productModel,
          attributeModel: AttributeModel(
            NameAr: element['nameAr']!.text.trim(),
            NameEn: element['nameEn']!.text.trim(),
          ),
          itemsAr: itemsAr,
          itemsEn: itemsEn,
          mediaAr: mediaAr,
          mediaEn: mediaEn,
        );
      });
      uploadProductDetails(false);
      update();
      Get.back();
      ProductScreenController productScreenController =
          Get.find<ProductScreenController>();
      productScreenController.onInit();
    }

    // await AddProductApi().callApi(
    //   productModel: ,
    // );
  }

  Future<Uint8List> loadPlaceHolderFile() async {
    final ByteData data = await rootBundle.load(
        "assets/images/DALL·E 2024-04-24 15.19.36 - A creative brand logo for a fictional pet store called 'Paw Paradise'. The logo features a playful depiction of a dog's paw print, with each pad shape.webp");
    final Uint8List bytes = data.buffer.asUint8List();
    return bytes;
  }
}
