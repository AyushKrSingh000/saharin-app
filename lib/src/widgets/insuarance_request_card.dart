import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saharin/src/widgets/custom_button.dart';

class InsuranceRequestsCard extends ConsumerWidget {
  final bool isActiveLoan;
  final String imageString;
  final String status;
  final String shgId;
  final VoidCallback onTap;

  const InsuranceRequestsCard({
    super.key,
    required this.imageString,
    required this.onTap,
    required this.shgId,
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
                    "Community: ${shgId.substring(shgId.length - 5, shgId.length)}",
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
