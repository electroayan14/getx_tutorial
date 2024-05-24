import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/screens/login/controller/login_controller.dart';
import 'package:getx_tutorial/screens/widget/custom_button.dart';
import 'package:getx_tutorial/utils/image_util/image_utils.dart';

import '../../routes/route_constants.dart';

//ignore:must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController loginController = Get.put(LoginController());
  dynamic username;
  dynamic password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: MediaQuery.sizeOf(context).height * 0.3,
              flexibleSpace: Stack(
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(color: Colors.red[400]),
                        padding: const EdgeInsets.only(left: 12.0),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Welcome back",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                            SizedBox(height: 14.0),
                            Text("We miss you! Login to get started  ",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(ImageUtils.splashImage),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ];
        },
        body: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0))),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  obscureText: false,
                  onChanged: (value) {
                    username = value.toString();
                    loginController.checkValidation(value, password);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(20.0), // Rounded corners
                    ),
                    labelText: "Username",
                    hintText: 'Enter your username',
                    suffixIcon: const Icon(Icons.person), // Icon on the left
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  obscureText: false,
                  onChanged: (value) {
                    password = value.toString();
                    loginController.checkValidation(username, value);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(20.0), // Rounded corners
                    ),
                    labelText: "Password",
                    hintText: 'Enter your password',
                    suffixIcon:
                        const Icon(Icons.remove_red_eye), // Icon on the left
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.red[400],
                      value: true,
                      onChanged: (bool? value) {},
                    ),
                    const Text('Remember me'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Need help?",
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    Obx(() => CustomButton(
                          onPress: () => Get.offAllNamed(dashboard),
                          enableButton: loginController.isValid.value,
                          backgroundColor: Colors.red[400],
                          height: MediaQuery.sizeOf(context).height * 0.06,
                          width: MediaQuery.sizeOf(context).width * 0.3,
                          buttonText: 'Sign in',
                          radius: 24.0,
                          textColor: Colors.white,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 150.0,
                ),
                RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: const TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Register instead',
                        style: TextStyle(
                            color: Colors.red[400],
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onPressed(context) {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(dashboard);
    });
    return Center(child: CircularProgressIndicator(color: Colors.red.shade400));
  }
}
