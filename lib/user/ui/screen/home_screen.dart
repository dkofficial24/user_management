import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_management/shared/shared.dart';
import 'package:user_management/user/controller/users_controller.dart';
import 'package:user_management/user/ui/widget/list_tile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    Future.delayed(Duration.zero, () async {
      await userController.fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConstant.homeScreenTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              onChanged: (query) {
                userController.searchUsers(query);
              },
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: StringConstant.searchHintText,
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (userController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (userController.userSearchResults.isEmpty) {
                  return const Center(child: Text(StringConstant.userNotFound));
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: userController.userSearchResults.toList().length,
                    itemBuilder: (context, index) {
                      return ListTileWidget(
                        user: userController.userSearchResults.toList()[index],
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
