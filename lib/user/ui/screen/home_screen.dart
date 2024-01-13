import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_management/shared/shared.dart';
import 'package:user_management/user/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void fetchUsers() {
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
              onChanged: userController.searchUsers,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: StringConstant.searchHintText,
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            Expanded(
              child: Obx(() {
                final userList = userController.userSearchResults.toList();
                if (userController.isLoading.value) {
                  return const ProgressIndicatorWidget();
                } else if (userList.isEmpty) {
                  return const Center(child: Text(StringConstant.userNotFound));
                } else {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: userList.length,
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemBuilder: (context, index) {
                      return UserListTileWidget(
                        user: userList[index],
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
