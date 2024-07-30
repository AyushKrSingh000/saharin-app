import 'package:json_annotation/json_annotation.dart';

import 'location.dart';

part 'insurance_provider_data.g.dart';

@JsonSerializable()
class InsuranceProviderData {
	Location? location;
	@JsonKey(name: '_id') 
	String? id;
	String? name;
	String? email;
	@JsonKey(name: '__v') 
	int? v;

	InsuranceProviderData({
		this.location, 
		this.id, 
		this.name, 
		this.email, 
		this.v, 
	});

	factory InsuranceProviderData.fromJson(Map<String, dynamic> json) {
		return _$InsuranceProviderDataFromJson(json);
	}

	Map<String, dynamic> toJson() => _$InsuranceProviderDataToJson(this);
}
