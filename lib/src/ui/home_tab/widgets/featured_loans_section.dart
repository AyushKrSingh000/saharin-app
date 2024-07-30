import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saharin/src/routing/router.dart';
import 'package:saharin/src/ui/home_tab/home_tab_page_model.dart';
import 'package:saharin/src/widgets/insurance_provider_cards.dart';

import '../../../constants/fonts.dart';

class FeaturedLoanSection extends ConsumerStatefulWidget {
  const FeaturedLoanSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FeaturedPlansSectionState();
}

class _FeaturedPlansSectionState extends ConsumerState<FeaturedLoanSection> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(
        homeTabPageModelProvider.select((value) => value.insuranceProviders));
    return data.isEmpty
        ? const SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Featured Loan Providers",
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
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: LoanProviderCard(
                      onTap: () {
                        context.navigateTo(LoanRoute(
                          data: data[data.length - 1 - index],
                          index: data.length - 1 - index,
                        ));
                      },
                      imageString: 'assets/images/ic_logo.png',
                      planName: data[data.length - 1 - index].name!,
                    ),
                  );
                },
              ),
            ],
          );
  }
}
