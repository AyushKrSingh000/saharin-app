import 'package:flutter/cupertino.dart';
import 'package:saharin/src/constants/colors.dart';
import 'package:saharin/src/ui/home_tab/home_tab_page_model.dart';
import 'package:saharin/src/ui/home_tab/widgets/best_offer_card.dart';
import 'package:saharin/src/ui/home_tab/widgets/featured_loans_section.dart';
import 'package:saharin/src/ui/home_tab/widgets/featured_section.dart';
import 'package:saharin/src/utils/toast_utils.dart';
import 'package:saharin/src/widgets/custom_scaffold.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/fonts.dart';
import '../../logic/repositories/auth_repository.dart';
import '../../routing/router.dart';
import '../../widgets/try_again_widget.dart';

@RoutePage()
class HomeTabPage extends ConsumerStatefulWidget {
  const HomeTabPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends ConsumerState<HomeTabPage> {
  late DateTime time;

  @override
  void initState() {
    super.initState();
    time = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authRepositoryProvider, (prev, next) {
      if (next.status == AuthStatus.unauthenticated) {
        showSuccessMessage("Logged Out Sucessfully!");
        context.replaceRoute(const WelcomeRoute());
      }
    });

    ref.listen(homeTabPageModelProvider, (prev, next) {});
    final status =
        ref.watch(homeTabPageModelProvider.select((value) => value.status));
    final userData =
        ref.watch(authRepositoryProvider.select((value) => value.authUser));
    return WillPopScope(
      onWillPop: () async {
        if (context.tabsRouter.activeIndex == 0) {
          final currentTime = DateTime.now();
          if (currentTime.difference(time).inSeconds <= 2) {
            return true;
          } else {
            showSuccessMessage('Press back again to exit');
            time = DateTime.now();
          }
        } else {
          FocusScope.of(context).unfocus();
          context.tabsRouter.setActiveIndex(0);
        }

        return false;
      },
      child: CustomScaffold(
        bgColor: Colors.white,
        child: status == HomePageStatus.loaded
            ? RefreshIndicator(
                displacement: 60,
                edgeOffset: 40,
                onRefresh: () async {
                  await ref.read(homeTabPageModelProvider.notifier).init();
                },
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22),
                                      color: primaryColor,
                                      border: Border.all(
                                        color: primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: primaryColor,
                                        child: Image.asset(
                                            'assets/images/ic_logo.png'),
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    CupertinoIcons.bell,
                                    size: 30,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Hello, ",
                                    style: TextStyle(
                                      // color: primaryColor,
                                      fontSize: 22,
                                      fontFamily: Fonts.helvtica,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    userData?.data.user.fullName ?? "Aditya",
                                    style: const TextStyle(
                                      // color: primaryColor,
                                      fontSize: 23,
                                      fontFamily: Fonts.helvtica,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Welcome Back!",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 14,
                                  fontFamily: Fonts.helvtica,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const BestLaonCard(),
                              const SizedBox(
                                height: 10,
                              ),
                              const FeaturedPlansSection(),
                              const SizedBox(
                                height: 10,
                              ),
                              const FeaturedLoanSection(),
                            ]))))
            : TryAgainWidget(
                onTap: () {
                  ref.read(homeTabPageModelProvider.notifier).init();
                },
                isProcessing: status == HomePageStatus.initial ||
                    status == HomePageStatus.loading,
                errMessage: ref.watch(
                  homeTabPageModelProvider.select(
                    (value) => value.errorMessage.trim().isEmpty
                        ? "Something Went Wrong!!!"
                        : value.errorMessage.trim(),
                  ),
                ),
              ),
      ),
    );
  }
}
