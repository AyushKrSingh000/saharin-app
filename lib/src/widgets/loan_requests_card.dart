import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saharin/src/widgets/custom_button.dart';

class LoanRequestsCard extends ConsumerWidget {
  final bool isActiveLoan;
  final String imageString;
  final String planName;
  final String status;
  final VoidCallback onTap;

  const LoanRequestsCard({
    super.key,
    required this.imageString,
    required this.onTap,
    required this.planName,
    required this.status,
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
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Community: ${planName.substring(planName.length - 5, planName.length)}",
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        secondUI: status == 'approved' || status == 'rejected'
                            ? true
                            : false,
                        width: 80,
                        height: 30,
                        text: status,
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
