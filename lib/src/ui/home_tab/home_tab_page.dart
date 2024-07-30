import 'package:saharin/src/ui/home_tab/home_tab_page_model.dart';
import 'package:saharin/src/utils/toast_utils.dart';
import 'package:saharin/src/widgets/custom_scaffold.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    // ref.listen(authRepositoryProvider, (prev, next) {
    //   if (next.status == AuthStatus.unauthenticated) {
    //     showSuccessMessage("Logged Out Sucessfully!");
    //     context.replaceRoute(const WelcomeRoute());
    //   }
    // });

    ref.listen(homeTabPageModelProvider, (prev, next) {});

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
          child: RefreshIndicator(
            displacement: 60,
            edgeOffset: 120,
            onRefresh: () async {
              await ref.read(homeTabPageModelProvider.notifier).init();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        children: [
                          SizedBox(height: 15),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),

                  //  ...[
                  //     TryAgainWidget(
                  //       onTap: () {
                  //         ref.read(homeTabPageModelProvider.notifier).init();
                  //       },
                  //       isProcessing: status == HomePageStatus.initial ||
                  //           status == HomePageStatus.loading,
                  //       errMessage: ref.watch(
                  //         homeTabPageModelProvider.select(
                  //           (value) => value.errorMessage.trim().isEmpty
                  //               ? "Something Went Wrong!!!"
                  //               : value.errorMessage.trim(),
                  //         ),
                  //       ),
                  //     )
                  // ]
                ],
              ),
            ),
          )),
    );
  }
}
