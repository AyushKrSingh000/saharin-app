import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saharin/src/constants/fonts.dart';
import 'package:saharin/src/ui/provider/provider_home_tab/provider_home_tab_model.dart';
import 'package:saharin/src/ui/provider/provider_home_tab/widgets/loan_requests_page.dart';

import '../../../constants/colors.dart';
import '../../../logic/repositories/auth_repository.dart';
import '../../../routing/router.dart';
import '../../../utils/toast_utils.dart';
import '../../../widgets/try_again_widget.dart';

@RoutePage()
class ProviderHomeTabePage extends ConsumerStatefulWidget {
  const ProviderHomeTabePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProviderHomeTabePageState();
}

class _ProviderHomeTabePageState extends ConsumerState<ProviderHomeTabePage> {
  @override
  Widget build(BuildContext context) {
    ref.listen(authRepositoryProvider, (prev, next) {
      if (next.status == AuthStatus.unauthenticated) {
        showSuccessMessage("Logged Out Sucessfully!");
        context.replaceRoute(const WelcomeRoute());
      }
    });
    ref.listen(providerHomeTabPageModelProvider, (prev, next) {});
    final userData =
        ref.watch(authRepositoryProvider.select((value) => value.authUser));
    final status = ref.watch(
        providerHomeTabPageModelProvider.select((value) => value.status));
    return WillPopScope(
      onWillPop: () async {
        if (context.tabsRouter.activeIndex == 0) {
          return true;
        } else {
          FocusScope.of(context).unfocus();
          context.tabsRouter.setActiveIndex(0);
        }

        return false;
      },
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
          body: status == ProviderHomePageStatus.loaded
              ? RefreshIndicator(
                  displacement: 60,
                  edgeOffset: 40,
                  onRefresh: () async {
                    await ref
                        .read(providerHomeTabPageModelProvider.notifier)
                        .init();
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
                                      userData?.data.user.fullName ?? "User",
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
                                LoanRequestsSection(),
                              ]))))
              : TryAgainWidget(
                  onTap: () {
                    ref.read(providerHomeTabPageModelProvider.notifier).init();
                  },
                  isProcessing: status == ProviderHomePageStatus.initial ||
                      status == ProviderHomePageStatus.loading,
                  errMessage: ref.watch(
                    providerHomeTabPageModelProvider.select(
                      (value) => value.errorMessage.trim().isEmpty
                          ? "Something Went Wrong!!!"
                          : value.errorMessage.trim(),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
