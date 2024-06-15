import 'package:app/constants/globalvariable.dart';
import 'package:app/views/auth/screens/forgotpassword.dart';
import 'package:app/views/auth/screens/login.dart';
import 'package:app/views/auth/screens/otpscreen.dart';
import 'package:app/views/auth/screens/register.dart';
import 'package:app/views/auth/screens/resetPassword.dart';
import 'package:app/views/detail/details_page.dart';
import 'package:app/views/home/screens/homepage.dart';
import 'package:app/views/home/screens/notification.dart';
import 'package:app/views/home/screens/searchpage.dart';
import 'package:app/views/products/details_page.dart';
import 'package:app/views/products/productPage.dart';
import 'package:app/views/products/product_details_page.dart';
import 'package:app/views/upload/screens/uploagPage.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginPage(),
      );

    case RegisterPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const RegisterPage(),
      );
    case ProductPage.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const ProductPage());
    case HomePage.routeName:
      return MaterialPageRoute(
        builder: (_) => const HomePage(),
        settings: routeSettings,
      );
    case SearchPage.routeName:
      return MaterialPageRoute(
        builder: (_) => const SearchPage(),
        settings: routeSettings,
      );

    case Notifications.routeName:
      return MaterialPageRoute(
        builder: (_) => const Notifications(),
        settings: routeSettings,
      );

    case ProductDetailsPage.routeName:
      return MaterialPageRoute(
        builder: (_) => const ProductDetailsPage(),
        settings: routeSettings,
      );
    case UploadScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const UploadScreen(),
        settings: routeSettings,
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(),
      );
  }
}
