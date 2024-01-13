import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:user_management/app.dart';
import 'package:user_management/user/user.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

Future<void> init() async {
  initDI();
  await Get.find<UserDbService>().initDatabase();
}

void initDI() {
  Get.put(Dio());
  Get.put(UserApiService());
  Get.put(UserDbService());
  Get.put(UserController());
}
