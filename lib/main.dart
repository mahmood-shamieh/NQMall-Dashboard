import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nq_mall_dashboard/views/add_product_screen.dart';
import 'package:nq_mall_dashboard/views/style_widget.dart';

import 'apis/category/get_all_category.dart';

TextDirection currentDirection = TextDirection.rtl;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Map response = await GetAllCategoryApi().callApi();
  // print(response);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StyleWidget(),
    );
  }
}
