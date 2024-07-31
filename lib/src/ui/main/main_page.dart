import 'package:saharin/src/logic/repositories/auth_repository.dart';

import 'package:saharin/src/widgets/bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../routing/router.dart';

@RoutePage()
class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    final isProvider =
        ref.watch(authRepositoryProvider.select((value) => value.checkbox));
    return AutoTabsScaffold(
      routes: [
        if (isProvider) ...[
          const ProviderHomeTabeRoute(),
          const ProvderInsuranceTabRoute()
        ] else ...[
          const HomeTabRoute(),
          const ActiveLoansTabRoute(),
          const PlansTabRoute(),
        ],
        const ProfileTabeRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) => BottomBar(
        key: ValueKey(tabsRouter.activeIndex),
      ),
    );
  }
}
