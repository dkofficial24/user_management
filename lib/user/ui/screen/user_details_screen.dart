import 'package:flutter/material.dart';
import 'package:user_management/shared/constants/string_const.dart';
import 'package:user_management/user/ui/widget/user_info_widget.dart';
import 'package:user_management/user/user.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({required this.userModel, super.key});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringConstant.homeDetailScreenTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserInfoWidget(
              icon: Icons.person,
              label: StringConstant.userName,
              value: userModel.username,
            ),
            UserInfoWidget(
              icon: Icons.email,
              label: StringConstant.email,
              value: userModel.email,
            ),
            UserInfoWidget(
              icon: Icons.phone,
              label: StringConstant.phone,
              value: userModel.phone,
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              StringConstant.address,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            UserInfoWidget(
              icon: Icons.location_on,
              label: StringConstant.street,
              value: userModel.address?.street,
            ),
            UserInfoWidget(
              icon: Icons.location_city,
              label: StringConstant.city,
              value: userModel.address?.city,
            ),
          ],
        ),
      ),
    );
  }
}
