import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saharin/src/widgets/custom_button.dart';

class LoanProviderCard extends ConsumerWidget {
  final bool isActiveLoan;
  final String imageString;
  final String planName;
  final VoidCallback onTap;

  const LoanProviderCard({
    super.key,
    required this.imageString,
    required this.onTap,
    required this.planName,
    this.isActiveLoan = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: Colors.grey.shade100,
        height: 100,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              imageString,
              width: 80,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    planName,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        width: 80,
                        height: 30,
                        text: 'View More',
                        onTap: () {},
                        isProcessing: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }
}
