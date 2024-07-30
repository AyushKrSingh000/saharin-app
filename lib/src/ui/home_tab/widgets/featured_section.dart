import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saharin/src/ui/home_tab/home_tab_page_model.dart';
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
    final data = ref
        .watch(homeTabPageModelProvider.select((value) => value.insuranceData));
    return data.isEmpty
        ? const SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Insurance Plans",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: Fonts.helvtica,
                  fontWeight: FontWeight.w700,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 10, bottom: 50),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: PlanCard(
                      premium: data[index].premium.toString(),
                      amount: data[index].coverage.toString(),
                      imageString:
                          'assets/images/ic_plan${(index % 2) + 1}.png',
                      planName: data[index].name,
                    ),
                  );
                },
              ),
            ],
          );
  }
}
