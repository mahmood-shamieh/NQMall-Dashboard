import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nq_mall_dashboard/apis/user/sign_in_api.dart';
import 'package:nq_mall_dashboard/models/response_model.dart';
import 'package:nq_mall_dashboard/models/user_model.dart';
import 'package:nq_mall_dashboard/shared/local_storage_keys.dart';
import 'package:nq_mall_dashboard/views/add_product_screen.dart';
import 'package:nq_mall_dashboard/views/sign_in_screen.dart';
import 'package:nq_mall_dashboard/views/splash_screen.dart';
import 'package:nq_mall_dashboard/views/style_widget.dart';
import 'services/notification_service.dart';
import 'firebase_options.dart';

import 'apis/category/get_all_category.dart';

TextDirection currentDirection = TextDirection.rtl;
GetIt getIt = GetIt.I;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Notification Service
  final notificationService = Get.put(NotificationService());
  await notificationService.init();

  await GetStorage.init();
  getIt.registerSingleton<GetStorage>(GetStorage());
  // getIt.get<GetStorage>().erase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NQMall Dashboard',
      textDirection: currentDirection,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
