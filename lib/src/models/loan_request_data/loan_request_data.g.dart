// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_request_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoanRequestData _$LoanRequestDataFromJson(Map<String, dynamic> json) =>
    LoanRequestData(
      agent: json['agent'] as String?,
      id: json['_id'] as String,
      selfHelpGroup: json['selfHelpGroup'] as String,
      loanProvider: json['loanProvider'] as String,
      amount: (json['amount'] as num).toInt(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$LoanRequestDataToJson(LoanRequestData instance) =>
    <String, dynamic>{
      'agent': instance.agent,
      '_id': instance.id,
      'selfHelpGroup': instance.selfHelpGroup,
      'loanProvider': instance.loanProvider,
      'amount': instance.amount,
      'status': instance.status,
    };
