import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saharin/src/models/loan_request_data/loan_request_data.dart';

import 'package:saharin/src/ui/provider/provider_home_tab/provider_home_tab_model.dart';
import 'package:saharin/src/widgets/custom_button.dart';
import 'package:saharin/src/widgets/custom_scaffold.dart';

import '../../constants/fonts.dart';
import '../../logic/repositories/auth_repository.dart';
import '../../utils/toast_utils.dart';
import '../auth/widgets/back_btn.dart';

@RoutePage()
class LoanRequestPage extends ConsumerStatefulWidget {
  final LoanRequestData data;
  final int index;
  const LoanRequestPage({
    super.key,
    required this.data,
    required this.index,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoanRequestPageState();
}

class _LoanRequestPageState extends ConsumerState<LoanRequestPage> {
  double amount = 0;
  double amountHeWant = 0;
  double riskFactor = 0;
  bool isProcessing = false;
  bool isProcessing2 = false;
  int year = 1;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      year = Random().nextInt(5);
      try {
        final res = await Dio().post('http://localhost:5000/predict', data: {
          "Gender": 1,
          "Married": 1,
          "Dependents": 1,
          "Education": 1,
          "Self_Employed": 0,
          "ApplicantIncome": ((widget.index) % 4 + 3) * 4300,
          "CoapplicantIncome": 158.0,
          "Loan_Amount_Term": 365.0,
          "SHG_ID": 1
        });
        if (res.statusCode == 200) {
          if (mounted) {
            amount = res.data['prediction'] ?? 0;
            riskFactor =
                (widget.data.amount - amount * 100) * 100 / widget.data.amount;

            setState(() {});
          }
        }
      } catch (e) {}
    });
  }

  Future<String> requestForLoan() async {
    try {
      final token =
          ref.read(authRepositoryProvider.select((value) => value.idToken));
      final res = await Dio().patch(
          'http://localhost:8000/api/v1/insuranceProvider/approveLoanRequest',
          data: {
            "loanRequestId": widget.data.id,
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
          'http://localhost:8000/api/v1/insuranceProvider/rejectLoanRequest',
          data: {
            "loanRequestId": widget.data.id,
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
        child: amount == 0
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
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
                            "The ${"Community: ${widget.data.selfHelpGroup.substring(widget.data.selfHelpGroup.length - 5, widget.data.selfHelpGroup.length)}"} has requested for  Rs. ${(widget.data.amount).toStringAsFixed(2)}/- for 1 years",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Text(
                            "The total risk factor will be  ${riskFactor > 0 ? riskFactor.toStringAsFixed(2) : "0.0"}% and total amount they will be able to pay is Rs. ${(amount * 100).toStringAsFixed(2)}/- yearly",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
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
                            "Loan has been already accepted and sent to the agent with agent id ${widget.data.agent?.substring((widget.data.agent?.length ?? 0) - 6) ?? ''}",
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
