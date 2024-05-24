import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/screens/widget/listtile_widget.dart';
import 'package:getx_tutorial/utils/image_util/image_utils.dart';

import '../routes/route_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(login);
    });
    return Scaffold(
      body: Center(child: Image.asset(ImageUtils.splashImage)),
    );
  }
}
