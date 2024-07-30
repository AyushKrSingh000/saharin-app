import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../models/insurance_provider_data/insurance_provider_data.dart';
import '../ui/active_loans_tab/active_loans_tab.dart';
import '../ui/auth/sign_in/signin_page.dart';
import '../ui/auth/sign_up/sign_up_page.dart';
import '../ui/auth/tnc/privacy_policy_page.dart';
import '../ui/auth/tnc/tnc_page.dart';

import '../ui/auth/welcome/welcome_page.dart';
import '../ui/home_tab/home_tab_page.dart';
import '../ui/loan_page/loan_page.dart';
import '../ui/main/main_page.dart';
import '../ui/plans_tab/plans_tab.dart';
import '../ui/profile_tab/profile_tab.dart';
import '../ui/splash/splash_page.dart';

part 'router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      path: '/',
      page: SplashRoute.page,
    ),
    CustomRoute(
      path: '/auth',
      page: WelcomeRoute.page,
      transitionsBuilder: (context, animation2, animation, child) =>
          FadeTransition(
        opacity: animation2,
        child: child,
      ),
    ),
    AutoRoute(
      path: '/signin',
      page: SignInRoute.page,
    ),
    AutoRoute(
      path: '/tnc',
      page: TnCRoute.page,
    ),
    AutoRoute(
      path: '/privacy_plicy',
      page: PrivacyPolicyRoute.page,
    ),
    AutoRoute(
      path: '/signup',
      page: SignUpRoute.page,
    ),
    AutoRoute(path: '/main', page: MainRoute.page, children: [
      AutoRoute(
        page: HomeTabRoute.page,
        path: "home_tab",
      ),
      AutoRoute(
        page: ActiveLoansTabRoute.page,
        path: "user_loans",
      ),
      AutoRoute(
        page: PlansTabRoute.page,
        path: "plans",
      ),
      AutoRoute(
        page: ProfileTabeRoute.page,
        path: "profile",
      ),
    ]),
    AutoRoute(
      page: LoanRoute.page,
      path: '/loan',
    ),
  ];
}
