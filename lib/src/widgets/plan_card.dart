import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saharin/src/widgets/custom_button.dart';

class PlanCard extends ConsumerWidget {
  final bool isActiveLoan;
  final String imageString;
  final String planName;
  final String amount;
  final String premium;
  const PlanCard({
    super.key,
    required this.premium,
    required this.amount,
    required this.imageString,
    required this.planName,
    this.isActiveLoan = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
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
                const Text(
                  "Cover amount",
                  maxLines: 1,
                ),
                Text(
                  "Rs. $amount lakh",
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      width: 80,
                      height: 30,
                      text: ' Rs. $premium/mon ',
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
    );
  }
}
