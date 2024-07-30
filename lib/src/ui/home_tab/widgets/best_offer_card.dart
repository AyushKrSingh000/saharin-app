import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BestLaonCard extends ConsumerWidget {
  const BestLaonCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Image.asset(
      'assets/images/ic_best.png',
      width: MediaQuery.sizeOf(context).width,
      fit: BoxFit.fitWidth,
    );
  }
}
