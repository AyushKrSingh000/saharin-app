import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saharin/src/routing/router.dart';

import '../../constants/fonts.dart';
import '../../widgets/custom_scaffold.dart';
import 'widgets/image_name_section.dart';
import 'widgets/profile_container.dart';

@RoutePage()
class ProfileTabePage extends ConsumerStatefulWidget {
  const ProfileTabePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfileTabePageState();
}

class _ProfileTabePageState extends ConsumerState<ProfileTabePage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: Fonts.helvtica,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const ProfileImageNameSection(),
              const SizedBox(height: 40),
              const ProfileContainer(
                subtitle: 'Edit your profile details',
                title: 'Profile Settings',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 20),
              const ProfileContainer(
                subtitle: 'Edit your home address',
                title: 'Your Address',
                icon: Icons.location_on_outlined,
              ),
              const SizedBox(height: 20),
              const ProfileContainer(
                subtitle:
                    'Check your order status (track, return, cancel, etc)',
                title: 'My Orders',
                icon: Icons.shopping_bag_outlined,
              ),
              const SizedBox(height: 20),
              const ProfileContainer(
                subtitle: 'Check your pending loans status',
                title: 'Laon Status',
                icon: Icons.account_balance_wallet_outlined,
              ),
              const SizedBox(height: 20),
              const ProfileContainer(
                subtitle: 'Edit the settings',
                title: 'Settings',
                icon: Icons.settings_outlined,
              ),
              const SizedBox(height: 20),
              const ProfileContainer(
                subtitle: 'Get help regarding your account or orders',
                title: 'Help and Support',
                icon: Icons.help_outline,
              ),
              const SizedBox(height: 20),
              ProfileContainer(
                onTap: () async {
                  context.replaceRoute(const WelcomeRoute());
                  // if (!isProcessing) {
                  //   if (mounted) {
                  //     setState(() {
                  //       isProcessing = true;
                  //     });
                  //   }
                  //   final res =
                  //       await ref.read(authRepositoryProvider.notifier).logOut();
                  //   if (res != '') {
                  //     debugPrint(res);
                  //   }
                  //   if (mounted) {
                  //     setState(() {
                  //       isProcessing = false;
                  //     });
                  //   }
                  // }
                },
                subtitle: 'Log out of your current account',
                title: 'Logout',
                icon: Icons.logout_outlined,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
