// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app/authPage/login_page.dart';
import '../app/authPage/register_page.dart';
import '../app/homePage/home_page.dart';
import '../app/userPage/user_page.dart';

class Routes {
  static const String homePage = '/';
  static const String loginPage = '/login-page';
  static const String registerPage = '/register-page';
  static const String userPage = '/user-page';
  static const all = <String>{
    homePage,
    loginPage,
    registerPage,
    userPage,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homePage, page: HomePage),
    RouteDef(Routes.loginPage, page: LoginPage),
    RouteDef(Routes.registerPage, page: RegisterPage),
    RouteDef(Routes.userPage, page: UserPage),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    HomePage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomePage(),
        settings: data,
      );
    },
    LoginPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginPage(),
        settings: data,
      );
    },
    RegisterPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisterPage(),
        settings: data,
      );
    },
    UserPage: (data) {
      final args = data.getArgs<UserPageArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => UserPage(
          key: args.key,
          userId: args.userId,
          oneUrl: args.oneUrl,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// UserPage arguments holder class
class UserPageArguments {
  final Key key;
  final String userId;
  final String oneUrl;
  UserPageArguments({this.key, @required this.userId, @required this.oneUrl});
}
