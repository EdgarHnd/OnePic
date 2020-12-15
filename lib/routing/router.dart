import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:onepic/app/authPage/auth_widget.dart';
import 'package:onepic/app/authPage/login_page.dart';
import 'package:onepic/app/authPage/register_page.dart';
import 'package:onepic/app/homePage/home_page.dart';
import 'package:onepic/app/userPage/user_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: HomePage, initial: true),
    MaterialRoute(page: LoginPage),
    MaterialRoute(page: RegisterPage),
    /*   MaterialRoute(page: UserPage), */
    CustomRoute(
      page: UserPage,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      /* durationInMilliseconds: 1000 */
    )
  ],
)
class $Router {}
