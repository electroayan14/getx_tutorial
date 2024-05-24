import 'package:flutter/material.dart';
import 'package:getx_tutorial/routes/route_constants.dart';
import 'package:getx_tutorial/screens/home_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic args = settings.arguments;
    switch (settings.name) {
      case homeRoute:
        return pageRouteBuilder(const HomeScreen());
      case login:
        return pageRouteBuilder(const HomeScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}

PageRouteBuilder pageRouteBuilder(screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
        ) {
      const begin = Offset(2.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 200),
  );
}