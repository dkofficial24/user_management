import 'package:flutter/material.dart';
import 'package:user_management/shared/constants/string_const.dart';
import 'package:user_management/user/model/user_model.dart';

class UserDetailsScreen extends StatelessWidget {
  final UserModel userModel;

  const UserDetailsScreen({required this.userModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          StringConstant.homeDetailScreenTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            userInfo(Icons.person, StringConstant.userName, userModel.username),
            userInfo(Icons.email, StringConstant.email, userModel.email),
            userInfo(Icons.phone, StringConstant.phone, userModel.phone),
            const SizedBox(height: 16),
            const Text(
              StringConstant.address,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            userInfo(Icons.location_on, StringConstant.street, userModel.address?.street),
            userInfo(Icons.location_city, StringConstant.city, userModel.address?.city),
          ],
        ),
      ),
    );
  }
}

Widget userInfo(
  IconData icon,
  String label,
  String? value,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Icon(
          icon,
          size: 28,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value ?? "-",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ],
    ),
  );
}