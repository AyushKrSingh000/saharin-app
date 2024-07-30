import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saharin/src/widgets/plan_card.dart';

import '../../../constants/fonts.dart';

class FeaturedPlansSection extends ConsumerStatefulWidget {
  const FeaturedPlansSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FeaturedPlansSectionState();
}

class _FeaturedPlansSectionState extends ConsumerState<FeaturedPlansSection> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Featured Plans",
          style: TextStyle(
            fontSize: 18,
            fontFamily: Fonts.helvtica,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        PlanCard(
          imageString: 'assets/images/ic_logo.png',
          planName: "Career Plus",
          amount: '5',
        ),
        SizedBox(
          height: 10,
        ),
        PlanCard(
          imageString: 'assets/images/ic_plan1.png',
          planName: "Max Life",
          amount: '5',
        ),
        SizedBox(
          height: 10,
        ),
        PlanCard(
          imageString: 'assets/images/ic_plan2.png',
          planName: "Active fit Plus",
          amount: '5',
        ),
        SizedBox(
          height: 80,
        ),
      ],
    );
  }
}
