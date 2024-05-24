import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/routes/route_constants.dart';
import 'package:getx_tutorial/routes/route_generator.dart';
import 'package:getx_tutorial/screens/cart/presentation/cart_screen.dart';
import 'package:getx_tutorial/screens/dashboard/dashboard_screen.dart';
import 'package:getx_tutorial/screens/home_screen.dart';
import 'package:getx_tutorial/screens/login/login_screen.dart';
import 'package:getx_tutorial/screens/meals/meals_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      getPages: [
        GetPage(name: homeRoute, page: () => const HomeScreen()),
        GetPage(name: login, page: () =>  LoginScreen()),
        GetPage(name: dashboard, page: () => DashboardScreen()),
        GetPage(name: mealScreen, page: () => MealScreen(),arguments: String),
        GetPage(name: cart, page: () => CartScreen()),
      ],
    );
  }
}
