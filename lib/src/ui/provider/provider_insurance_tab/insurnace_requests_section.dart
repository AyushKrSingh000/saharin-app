import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saharin/src/routing/router.dart';
import 'package:saharin/src/ui/provider/provider_home_tab/provider_home_tab_model.dart';

import '../../../constants/fonts.dart';
import '../../../widgets/insuarance_request_card.dart';

class InsuranceRequestsSection extends ConsumerStatefulWidget {
  const InsuranceRequestsSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FeaturedPlansSectionState();
}

class _FeaturedPlansSectionState
    extends ConsumerState<InsuranceRequestsSection> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(providerHomeTabPageModelProvider
        .select((value) => value.insuranceProviders));
    final loans = ref.watch(providerHomeTabPageModelProvider
        .select((value) => value.insuranceRequests));
    return data.isEmpty || loans.isEmpty
        ? const SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Insurance Requests",
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: Fonts.helvtica,
                  fontWeight: FontWeight.w700,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 10, bottom: 50),
                itemCount: loans.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InsuranceRequestsCard(
                      status: loans[index].status,
                      onTap: () {
                        context.navigateTo(InsuranceRequestRoute(
                          data: loans[index],
                          index: index,
                        ));
                      },
                      imageString: 'assets/images/ic_logo.png',
                      shgId: loans[index].selfHelpGroup,
                    ),
                  );
                },
              ),
            ],
          );
  }
}
