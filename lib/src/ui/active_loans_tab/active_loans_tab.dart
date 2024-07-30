import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/plan_card.dart';

@RoutePage()
class ActiveLoansTabPage extends ConsumerStatefulWidget {
  const ActiveLoansTabPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ActiveLoansTabPageState();
}

class _ActiveLoansTabPageState extends ConsumerState<ActiveLoansTabPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bgColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
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
                  "YOUR ACTIVE LOANS",
                  style: TextStyle(
                    fontSize: 20,
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
                itemCount: 2,
                padding: const EdgeInsets.only(bottom: 70),
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: PlanCard(
                        isActiveLoan: true,
                        amount: (index + 1).toString(),
                        imageString:
                            'assets/images/ic_plan${(index % 2) + 1}.png',
                        planName: 'Care Supreme ${index + 1}'),
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
