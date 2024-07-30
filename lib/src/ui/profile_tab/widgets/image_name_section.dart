// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';

class ProfileImageNameSection extends ConsumerWidget {
  const ProfileImageNameSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hey, Pavan',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 24,
                  height: 2,
                  fontWeight: FontWeight.w400,
                  fontFamily: Fonts.helvtica,
                ),
              ),
              Text(
                "Logged in via ayushkumarsingh0708@gmail.com",
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
        const SizedBox(
          width: 10,
        ),
        const CircleAvatar(
          radius: 41,
          backgroundColor: primaryColor,
        ),
      ],
    );
  }
}
