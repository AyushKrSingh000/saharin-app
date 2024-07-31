import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saharin/src/ui/provider/provider_home_tab/provider_home_tab_model.dart';

import '../../../../constants/fonts.dart';
import '../../../../widgets/loan_requests_card.dart';

class LoanRequestsSection extends ConsumerStatefulWidget {
  const LoanRequestsSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FeaturedPlansSectionState();
}

class _FeaturedPlansSectionState extends ConsumerState<LoanRequestsSection> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(providerHomeTabPageModelProvider
        .select((value) => value.insuranceProviders));
    final loans = ref.watch(
        providerHomeTabPageModelProvider.select((value) => value.loanRequests));
    return data.isEmpty || loans.isEmpty
        ? const SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Loan Requests",
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
                    child: LoanRequestsCard(
                      status: loans[index].status,
                      onTap: () {},
                      imageString: 'assets/images/ic_logo.png',
                      planName: loans[index].selfHelpGroup,
                    ),
                  );
                },
              ),
            ],
          );
  }
}
