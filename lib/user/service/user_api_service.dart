import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:user_management/shared/shared.dart';
import 'package:user_management/user/model/user_model.dart';

class UserApiService {

  Future<List<UserModel>> fetchUsers() async {
    final response = await Get.find<Dio>().get(ApiEndpoints.getUserEndpoint);
      if (response.statusCode == 200) {
        List<UserModel> userList = (response.data as List)
            .map((userJson) => UserModel.fromJson(userJson))
            .toList();
        return userList;
      } else {
        throw Exception('Failed to load data');
      }
  }
}
