import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splash/component/utils/const_var.dart';
import 'package:splash/module/user/Service/user_service.dart';
import 'package:splash/module/user/View/self_user_login_page.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final UserService _userService = Get.find<UserService>();

  @override
  void initState() {
    super.initState();
    ever(_userService.isLogined, (_) {
      Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getGlobalBackGroundColor(),
      appBar: AppBar(
        backgroundColor: getGlobalBackGroundColor(),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: const SelfUserLoginPage(),
    );
  }
}
