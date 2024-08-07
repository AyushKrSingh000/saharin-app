import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';

class ProfileContainer extends ConsumerWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  final VoidCallback? onTap;
  const ProfileContainer({
    super.key,
    required this.subtitle,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: Fonts.timesNewRoman,
                  ),
                ),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff8F98AA),
                    fontWeight: FontWeight.w400,
                    fontFamily: Fonts.timesNewRoman,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Icon(icon, color: primaryColor, size: 25)
        ],
      ),
    );
  }
}
