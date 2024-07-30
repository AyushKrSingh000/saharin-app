import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saharin/src/ui/home_tab/home_tab_page_model.dart';
import 'package:saharin/src/widgets/plan_card.dart';
import 'package:saharin/src/widgets/try_again_widget.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../widgets/custom_scaffold.dart';

@RoutePage()
class PlansTabPage extends ConsumerStatefulWidget {
  const PlansTabPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlansTabPageState();
}

class _PlansTabPageState extends ConsumerState<PlansTabPage> {
  @override
  Widget build(BuildContext context) {
    final data = ref
        .watch(homeTabPageModelProvider.select((value) => value.insuranceData));
    final status =
        ref.watch(homeTabPageModelProvider.select((value) => value.status));
    return CustomScaffold(
      bgColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: data.isEmpty
            ? TryAgainWidget(
                onTap: () async {
                  await ref.read(homeTabPageModelProvider.notifier).init();
                },
                isProcessing: status == HomePageStatus.loading ||
                    status == HomePageStatus.initial,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: primaryColor,
                              border: Border.all(
                                color: primaryColor,
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: primaryColor,
                                child: Image.asset('assets/images/ic_logo.png'),
                              ),
                            ),
                          ),
                          const Icon(
                            CupertinoIcons.bell,
                            size: 30,
                          ),
                        ],
                      ),
                      const Text(
                        "EXPLORE INSURANCE PLANS",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: Fonts.helvtica,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      padding: const EdgeInsets.only(bottom: 70),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: PlanCard(
                              premium: data[index].premium.toString(),
                              amount: (index + 1).toString(),
                              imageString:
                                  'assets/images/ic_plan${(index % 2) + 1}.png',
                              planName: data[index].name),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
