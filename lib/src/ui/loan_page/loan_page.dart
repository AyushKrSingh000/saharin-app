import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saharin/src/logic/repositories/auth_repository.dart';
import 'package:saharin/src/models/insurance_provider_data/insurance_provider_data.dart';
import 'package:saharin/src/ui/auth/widgets/back_btn.dart';
import 'package:saharin/src/ui/auth/widgets/custom_auth_text_field.dart';
import 'package:saharin/src/utils/toast_utils.dart';
import 'package:saharin/src/widgets/custom_button.dart';

import '../../constants/fonts.dart';
import '../../widgets/custom_scaffold.dart';

@RoutePage()
class LoanPage extends ConsumerStatefulWidget {
  final InsuranceProviderData data;
  final int index;
  const LoanPage({
    super.key,
    required this.data,
    required this.index,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoanPageState();
}

class _LoanPageState extends ConsumerState<LoanPage> {
  double amount = 0;
  double amountHeWant = 0;
  bool isProcessing = false;
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
      final res = await Dio().post(
          'http://localhost:8000/api/v1/selfHelpGroup/loanRequest',
          data: {
            "loanProviderId": widget.data.id,
            "amount": amountHeWant,
          },
          options: Options(method: 'POST', headers: {
            'Content-Type': 'application/json',
            'Cookie': 'jwt=$token'
          }));
      if (res.statusCode == 201) {
        showSuccessMessage('Request sent to provider!');
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
    return CustomScaffold(
      bgColor: Colors.white,
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
                    "${widget.data.name}",
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
                  Text(
                    widget.data.name!,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Get Loan Upto Rs. ${(amount * 100).toStringAsFixed(2)}/- for 1 years",
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
              CustomAuthTextField(
                  hintText: 'Enter the loan amount',
                  initialText: amountHeWant.toString() == '0.0'
                      ? ""
                      : amountHeWant.toString(),
                  isDigitOnly: true,
                  maxLength: null,
                  onChanged: (value) {
                    amountHeWant = double.tryParse(
                            value.trim().isEmpty ? "0" : value.trim()) ??
                        0;
                  }),
              const SizedBox(
                height: 10,
              ),
              CustomAuthTextField(
                  hintText: 'Enter the requested interest rate',
                  initialText: '',
                  isDigitOnly: true,
                  maxLength: null,
                  onChanged: (value) {}),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                height: 45,
                text: 'Request for loan',
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
                      context.maybePop();
                    }
                    if (mounted) {
                      setState(() {
                        isProcessing = false;
                      });
                    }
                  }
                },
                isProcessing: isProcessing,
              )
            ],
          ),
        ),
      ),
    );
  }
}
