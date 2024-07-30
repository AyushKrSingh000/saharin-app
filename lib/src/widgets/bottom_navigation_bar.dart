import 'package:saharin/src/constants/fonts.dart';

import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/colors.dart';

class BottomBar extends ConsumerStatefulWidget {
  const BottomBar({
    super.key,
  });

  @override
  ConsumerState<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(135, 225, 227, .24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  color: Colors.black.withOpacity(.1),
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 25,
                      right: 25,
                      bottom: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _NavigationBarItem(
                          label: 'Home',
                          index: 0,
                          icon: Icons.home,
                          isActive: context.tabsRouter.activeIndex == 0,
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            context.tabsRouter.setActiveIndex(0);

                            setState(() {});
                          },
                        ),
                        _NavigationBarItem(
                          label: 'Plans',
                          index: 2,
                          icon: Icons.policy_outlined,
                          isActive: context.tabsRouter.activeIndex == 2,
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            context.tabsRouter.setActiveIndex(2);
                          },
                        ),
                        _NavigationBarItem(
                          label: 'Loans',
                          icon: Icons.flag_outlined,
                          index: 1,
                          isActive: context.tabsRouter.activeIndex == 1,
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            context.tabsRouter.setActiveIndex(1);
                          },
                        ),
                        _NavigationBarItem(
                          label: 'Profile',
                          index: 3,
                          icon: Icons.person_outline,
                          isActive: context.tabsRouter.activeIndex == 3,
                          onTap: () {
                            FocusScope.of(context).unfocus();

                            context.tabsRouter.setActiveIndex(3);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final IconData icon;
  final VoidCallback onTap;
  final int? index;

  const _NavigationBarItem({
    required this.label,
    required this.isActive,
    required this.icon,
    required this.onTap,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? primaryColor : const Color(0xff89909A);

    return SizedBox(
      width: 70,
      height: 65,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 2,
              width: 60,
              color: isActive ? primaryColor : Colors.white,
            ),
            const Expanded(child: SizedBox()),
            Center(
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              label,
              style: TextStyle(
                fontFamily: Fonts.timesNewRoman,
                color: color,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
