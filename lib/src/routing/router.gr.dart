// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    ActiveLoansTabRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ActiveLoansTabPage(),
      );
    },
    HomeTabRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeTabPage(),
      );
    },
    InsuranceRoute.name: (routeData) {
      final args = routeData.argsAs<InsuranceRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: InsurancePage(
          key: args.key,
          data: args.data,
          index: args.index,
        ),
      );
    },
    LoanRoute.name: (routeData) {
      final args = routeData.argsAs<LoanRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoanPage(
          key: args.key,
          data: args.data,
          index: args.index,
        ),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainPage(),
      );
    },
    PlansTabRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PlansTabPage(),
      );
    },
    PrivacyPolicyRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PrivacyPolicyPage(),
      );
    },
    ProfileTabeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileTabePage(),
      );
    },
    ProvderInsuranceTabRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProvderInsuranceTabPage(),
      );
    },
    ProviderHomeTabeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProviderHomeTabePage(),
      );
    },
    SignInRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignInPage(),
      );
    },
    SignUpRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashPage(),
      );
    },
    TnCRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TnCPage(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WelcomePage(),
      );
    },
  };
}

/// generated route for
/// [ActiveLoansTabPage]
class ActiveLoansTabRoute extends PageRouteInfo<void> {
  const ActiveLoansTabRoute({List<PageRouteInfo>? children})
      : super(
          ActiveLoansTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'ActiveLoansTabRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeTabPage]
class HomeTabRoute extends PageRouteInfo<void> {
  const HomeTabRoute({List<PageRouteInfo>? children})
      : super(
          HomeTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeTabRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [InsurancePage]
class InsuranceRoute extends PageRouteInfo<InsuranceRouteArgs> {
  InsuranceRoute({
    Key? key,
    required InsurancePlanData data,
    required int index,
    List<PageRouteInfo>? children,
  }) : super(
          InsuranceRoute.name,
          args: InsuranceRouteArgs(
            key: key,
            data: data,
            index: index,
          ),
          initialChildren: children,
        );

  static const String name = 'InsuranceRoute';

  static const PageInfo<InsuranceRouteArgs> page =
      PageInfo<InsuranceRouteArgs>(name);
}

class InsuranceRouteArgs {
  const InsuranceRouteArgs({
    this.key,
    required this.data,
    required this.index,
  });

  final Key? key;

  final InsurancePlanData data;

  final int index;

  @override
  String toString() {
    return 'InsuranceRouteArgs{key: $key, data: $data, index: $index}';
  }
}

/// generated route for
/// [LoanPage]
class LoanRoute extends PageRouteInfo<LoanRouteArgs> {
  LoanRoute({
    Key? key,
    required InsuranceProviderData data,
    required int index,
    List<PageRouteInfo>? children,
  }) : super(
          LoanRoute.name,
          args: LoanRouteArgs(
            key: key,
            data: data,
            index: index,
          ),
          initialChildren: children,
        );

  static const String name = 'LoanRoute';

  static const PageInfo<LoanRouteArgs> page = PageInfo<LoanRouteArgs>(name);
}

class LoanRouteArgs {
  const LoanRouteArgs({
    this.key,
    required this.data,
    required this.index,
  });

  final Key? key;

  final InsuranceProviderData data;

  final int index;

  @override
  String toString() {
    return 'LoanRouteArgs{key: $key, data: $data, index: $index}';
  }
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PlansTabPage]
class PlansTabRoute extends PageRouteInfo<void> {
  const PlansTabRoute({List<PageRouteInfo>? children})
      : super(
          PlansTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'PlansTabRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PrivacyPolicyPage]
class PrivacyPolicyRoute extends PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<PageRouteInfo>? children})
      : super(
          PrivacyPolicyRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrivacyPolicyRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileTabePage]
class ProfileTabeRoute extends PageRouteInfo<void> {
  const ProfileTabeRoute({List<PageRouteInfo>? children})
      : super(
          ProfileTabeRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileTabeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProvderInsuranceTabPage]
class ProvderInsuranceTabRoute extends PageRouteInfo<void> {
  const ProvderInsuranceTabRoute({List<PageRouteInfo>? children})
      : super(
          ProvderInsuranceTabRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProvderInsuranceTabRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProviderHomeTabePage]
class ProviderHomeTabeRoute extends PageRouteInfo<void> {
  const ProviderHomeTabeRoute({List<PageRouteInfo>? children})
      : super(
          ProviderHomeTabeRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProviderHomeTabeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TnCPage]
class TnCRoute extends PageRouteInfo<void> {
  const TnCRoute({List<PageRouteInfo>? children})
      : super(
          TnCRoute.name,
          initialChildren: children,
        );

  static const String name = 'TnCRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [WelcomePage]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
