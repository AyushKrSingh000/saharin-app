// ignore_for_file: deprecated_member_use

import 'package:saharin/src/constants/colors.dart';
import 'package:saharin/src/routing/router.dart';
import 'package:saharin/src/ui/auth/sign_up/sign_up_model.dart';
import 'package:saharin/src/ui/auth/tnc/privacy_policy_page.dart';
import 'package:saharin/src/ui/auth/tnc/tnc_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/fonts.dart';
import '../../../logic/repositories/auth_repository.dart';
import '../../../utils/toast_utils.dart';
import '../../../widgets/custom_scaffold.dart';
import '../widgets/back_btn.dart';
import '../widgets/custom_auth_btn.dart';
import '../widgets/custom_auth_text_field.dart';

@RoutePage()
class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  bool isProcessing = false;
  bool isNotVisible = true;
  bool isNotVisible2 = true;
  bool checkBox = false;
  @override
  Widget build(BuildContext context) {
    ref.listen(signUpPageModelProvider, (prev, next) {});
    ref.listen(authRepositoryProvider, (prev, next) {
      if (prev?.status != next.status) {
        if (next.status == AuthStatus.authenticated) {
          showSuccessMessage('Logged In Successfully!');
          context.replaceRoute(const MainRoute());
        } else if (next.status == AuthStatus.authenticatedNotVerified) {
          context.replaceRoute(const MainRoute());
        } else if (next.status == AuthStatus.unauthenticated) {}
      }
    });

    return WillPopScope(
      onWillPop: () async {
        context.replaceRoute(const WelcomeRoute());
        return false;
      },
      child: SafeArea(
        child: CustomScaffold(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      BackBtn(
                        onTap: () {
                          Focus.maybeOf(context)?.unfocus();
                          context.replaceRoute(const WelcomeRoute());
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Log In",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 32,
                      fontFamily: Fonts.helvtica,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Log In as service provider",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: Fonts.helvtica,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomAuthTextField(
                    hintText: 'Email',
                    isEnabled: !isProcessing,
                    initialText: ref.read(
                        signUpPageModelProvider.select((value) => value.email)),
                    maxLength: null,
                    backgroundColor: Colors.white.withOpacity(0.15),
                    onChanged:
                        ref.read(signUpPageModelProvider.notifier).setEmail,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomAuthTextField(
                    hideText: isNotVisible,
                    suffix: GestureDetector(
                      onTap: () {
                        if (mounted) {
                          setState(() {
                            isNotVisible = !isNotVisible;
                          });
                        }
                      },
                      child: Icon(
                        isNotVisible ? Icons.visibility_off : Icons.visibility,
                        color: Colors.black,
                      ),
                    ),
                    hintText: 'Password',
                    isEnabled: !isProcessing,
                    initialText: ref.read(signUpPageModelProvider
                        .select((value) => value.password)),
                    maxLength: null,
                    onChanged:
                        ref.read(signUpPageModelProvider.notifier).setPassword,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 18,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Checkbox(
                            value: checkBox,
                            splashRadius: 0,
                            focusColor: primaryColor,
                            checkColor: Colors.white,
                            activeColor: primaryColor,
                            side: const BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onChanged: (value) {
                              if (mounted) {
                                setState(() {
                                  checkBox = !checkBox;
                                });
                                //   ref
                                //       .read(authRepositoryProvider.notifier)
                                // .setCheckBox(checkBox);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "Remember me",
                        style: TextStyle(
                          fontFamily: Fonts.helvtica,
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomAuthBtn(
                    height: 50,
                    borderColor: Colors.white.withOpacity(.6),
                    isProcessing: isProcessing,
                    onTap: () async {
                      if (!isProcessing) {
                        if (mounted) {
                          setState(() {
                            isProcessing = true;
                          });
                        }
                        final data = ref.read(
                            signUpPageModelProvider.select((value) => value));
                        final res = await ref
                            .read(authRepositoryProvider.notifier)
                            .loginProvider(data.email, data.password);
                        if (res != '') {
                          showErrorMessage(res);
                        }
                        if (mounted) {
                          setState(() {
                            isProcessing = false;
                          });
                        }
                      }
                    },
                    text: 'Continue',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Are you a community ? ",
                        style: TextStyle(
                          fontFamily: Fonts.helvtica,
                          color: Colors.black,
                          fontSize: 16,
                          letterSpacing: -0.011,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.replaceRoute(const SignInRoute());
                        },
                        child: const Text(
                          "Login Here",
                          style: TextStyle(
                            fontFamily: Fonts.helvtica,
                            color: primaryColor,
                            fontSize: 16,
                            letterSpacing: -0.011,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: Fonts.helvtica,
                          fontWeight: FontWeight.w400,
                          height: 1.7),
                      children: [
                        const TextSpan(
                          text: 'By Logging in you agree to our ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: Fonts.helvtica,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: 'Terms & Condition',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showAdaptiveDialog(
                                context: context,
                                builder: (context) => Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: const TnCPage(),
                                  ),
                                ),
                              );
                            },
                          style: const TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontFamily: Fonts.helvtica,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const TextSpan(
                          text: ' and ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: Fonts.helvtica,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showAdaptiveDialog(
                                context: context,
                                builder: (context) => Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: const PrivacyPolicyPage(),
                                  ),
                                ),
                              );
                            },
                          style: const TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontFamily: Fonts.helvtica,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
