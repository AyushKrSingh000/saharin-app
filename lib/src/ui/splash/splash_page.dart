// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/colors.dart';
import '../../logic/repositories/auth_repository.dart';
import '../../routing/router.dart';

@RoutePage()
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.sizeOf(context).height;
    // ref.listen(authRepositoryProvider, (previous, next) async {
    //   await Future.delayed(const Duration(milliseconds: 2500));
    //   if (next.status == AuthStatus.authenticated) {
    //     context.replaceRoute(const MainRoute());
    //   } else if (next.status == AuthStatus.authenticatedNotVerified) {
    //     context.replaceRoute(const WelcomeRoute());
    //   } else if (next.status == AuthStatus.unauthenticated) {
    //     context.replaceRoute(const WelcomeRoute());
    //   }
    // });
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/ic_logo.png,',
        ),
      ),
    );
  }
}
