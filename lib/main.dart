import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:user_management/shared/shared.dart';
import 'package:user_management/user/controller/users_controller.dart';
import 'package:user_management/user/service/user_api_service.dart';
import 'package:user_management/user/service/user_db_service.dart';
import 'package:user_management/user/ui/screen/home_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencyInjection();
  await Get.find<UserDbService>().initDatabase();
  runApp(const MyApp());
}

void initDependencyInjection() {
  Get.put(Dio());
  Get.put(UserApiService());
  Get.put(UserDbService());
  Get.put(UserController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(title: StringConstant.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
