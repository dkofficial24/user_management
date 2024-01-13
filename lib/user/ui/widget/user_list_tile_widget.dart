import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_management/user/model/user_model.dart';
import 'package:user_management/user/ui/screen/user_details_screen.dart';

class UserListTileWidget extends StatelessWidget {
  const UserListTileWidget({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(UserDetailsScreen(
          userModel: user,
        ));
      },
      contentPadding: const EdgeInsets.all(16),
      title: Text(
        user.username ?? '',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 6),
          Text(
            user.email ?? '',
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            user.phone ?? '-',
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
      trailing: const Icon(
        Icons.keyboard_arrow_right_rounded,
      ),
    );
  }
}
