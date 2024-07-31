import 'package:json_annotation/json_annotation.dart';

part 'loan_request_data.g.dart';

@JsonSerializable()
class LoanRequestData {
  final String? agent;
  @JsonKey(name: '_id')
  final String id;
  final String selfHelpGroup;
  final String loanProvider;
  final int amount;

  final String status;

  LoanRequestData({
    this.agent,
    required this.id,
    required this.selfHelpGroup,
    required this.loanProvider,
    required this.amount,
    required this.status,
  });

  factory LoanRequestData.fromJson(Map<String, dynamic> json) {
    return _$LoanRequestDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoanRequestDataToJson(this);
}
