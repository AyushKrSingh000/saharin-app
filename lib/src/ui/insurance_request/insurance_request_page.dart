import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saharin/src/models/insurance_requests_data/insurance_requests_data.dart';

import '../../constants/fonts.dart';
import '../../logic/repositories/auth_repository.dart';
import '../../utils/toast_utils.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_scaffold.dart';
import '../auth/widgets/back_btn.dart';
import '../provider/provider_home_tab/provider_home_tab_model.dart';

@RoutePage()
class InsuranceRequestPage extends ConsumerStatefulWidget {
  final InsuranceRequestsData data;
  final int index;
  const InsuranceRequestPage({
    super.key,
    required this.data,
    required this.index,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InsuranceRequestPageState();
}

class _InsuranceRequestPageState extends ConsumerState<InsuranceRequestPage> {
  bool isProcessing = false;
  bool isProcessing2 = false;

  Future<String> requestForLoan() async {
    try {
      final token =
          ref.read(authRepositoryProvider.select((value) => value.idToken));
      final res = await Dio().patch(
          'http://localhost:8000/api/v1/insuranceProvider/approveInsuranceRequest',
          data: {
            "insuranceRequestId": widget.data.id,
          },
          options: Options(method: 'POST', headers: {
            'Content-Type': 'application/json',
            'Cookie': 'jwt=$token'
          }));
      if (res.statusCode == 200) {
        showSuccessMessage('Loan has been accepted and sent to an agent!');
      } else {
        return res.statusMessage ?? "Something Went Wrong!!!";
      }
      return '';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> rejectLoan() async {
    try {
      final token =
          ref.read(authRepositoryProvider.select((value) => value.idToken));
      final res = await Dio().patch(
          'http://localhost:8000/api/v1/insuranceProvider/rejectInsuranceRequest',
          data: {
            "insuranceRequestId": widget.data.id,
          },
          options: Options(method: 'POST', headers: {
            'Content-Type': 'application/json',
            'Cookie': 'jwt=$token'
          }));
      if (res.statusCode == 200) {
        showSuccessMessage('Loan has been rejected!');
      } else {
        return res.statusMessage ?? "Something Went Wrong!!!";
      }
      return '';
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
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
                        BackBtn(onTap: () {
                          context.maybePop();
                        })
                      ],
                    ),
                    Text(
                      "Community: ${widget.data.selfHelpGroup.substring(widget.data.selfHelpGroup.length - 5, widget.data.selfHelpGroup.length)}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: Fonts.helvtica,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 80,
                ),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(300),
                      child: Image.asset(
                        'assets/images/ic_plan1.png',
                        height: 200,
                        width: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // Text(
                    //   widget.data,
                    //   style: const TextStyle(
                    //     fontSize: 32,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      "The ${"Community: ${widget.data.selfHelpGroup.substring(widget.data.selfHelpGroup.length - 5, widget.data.selfHelpGroup.length)}"} has requested for  Rs. 12 lakh coverage amount at 100/month",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                if (widget.data.status == 'pending')
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomButton(
                          secondUI: true,
                          height: 40,
                          isProcessing: isProcessing2,
                          onTap: () async {
                            if (!isProcessing2) {
                              if (mounted) {
                                setState(() {
                                  isProcessing2 = true;
                                });
                              }
                              final res = await rejectLoan();
                              if (res != '') {
                                showErrorMessage(res);
                              } else {
                                await ref
                                    .read(providerHomeTabPageModelProvider
                                        .notifier)
                                    .init();
                                context.maybePop();
                              }
                              if (mounted) {
                                setState(() {
                                  isProcessing2 = false;
                                });
                              }
                            }
                          },
                          text: 'Reject Request',
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: CustomButton(
                          height: 40,
                          isProcessing: isProcessing,
                          onTap: () async {
                            if (!isProcessing) {
                              if (mounted) {
                                setState(() {
                                  isProcessing = true;
                                });
                              }
                              final res = await requestForLoan();
                              if (res != '') {
                                showErrorMessage(res);
                              } else {
                                await ref
                                    .read(providerHomeTabPageModelProvider
                                        .notifier)
                                    .init();
                                context.maybePop();
                              }
                              if (mounted) {
                                setState(() {
                                  isProcessing = false;
                                });
                              }
                            }
                          },
                          text: 'Accept Request',
                        ),
                      ),
                    ],
                  ),
                if (widget.data.status == 'approved')
                  Center(
                    child: Text(
                      "Insurance has been already accepted and sent to the agent with agent id ${widget.data.agent?.substring((widget.data.agent?.length ?? 0) - 6) ?? ''}",
                      textAlign: TextAlign.center,
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
