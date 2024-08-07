import 'package:saharin/src/constants/colors.dart';
import 'package:saharin/src/constants/fonts.dart';

import 'package:saharin/src/routing/router.dart';
import 'package:saharin/src/ui/auth/widgets/custom_auth_btn.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Image.asset(
                  'assets/images/ic_logo.png',
                  height: 280,
                ),
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome to",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 32,
                        fontFamily: Fonts.helvtica,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      " Saharin",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 32,
                        fontFamily: Fonts.helvtica,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomAuthBtn(
                      height: 40,
                      isProcessing: false,
                      onTap: () {
                        context.replaceRoute(const SignInRoute());
                      },
                      text: 'Let\'s Get Started',
                      width: 188,
                    )
                  ],
                ),
                const SizedBox(
                  height: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
