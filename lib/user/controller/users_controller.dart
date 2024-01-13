import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:user_management/shared/shared.dart';
import 'package:user_management/user/model/user_model.dart';
import 'package:user_management/user/service/user_api_service.dart';
import 'package:user_management/user/service/user_db_service.dart';

class UserController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<UserModel> userList = <UserModel>[].obs;
  RxList<UserModel> userSearchResults = <UserModel>[].obs;

  Future<void> _fetchUserFromApi() async {
    try {
      isLoading.value = true;
      userList.value = await Get.find<UserApiService>().fetchUsers();
      userSearchResults.value = userList.toList().obs;
      await Get.find<UserDbService>().saveUsers(userList.toList());
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      AppUtils.showToast(e.toString());
    }
  }

  Future<void> _loadUserFromDb() async {
    isLoading.value = true;
    final usersFromDb = await Get.find<UserDbService>().getUsers();
    userList.value = userSearchResults.value = usersFromDb;
    isLoading.value = false;
  }

  Future<void> fetchUsers() async {
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      await _loadUserFromDb();
    } else {
      await _fetchUserFromApi();
    }
  }

  Future searchUsers(String value) async {
    if (value.isEmpty) {
      userSearchResults.value = userList;
    } else {
      final searchResults = userList.where((user) {
        return (user.username?.toLowerCase().contains(value.toLowerCase()) ?? false) ||
            (user.email?.toLowerCase().contains(value.toLowerCase()) ?? false) ||
            (user.phone?.toLowerCase().contains(value.toLowerCase()) ?? false);
      }).toList();
      userSearchResults.value = searchResults.obs;///<----
    }
  }
}