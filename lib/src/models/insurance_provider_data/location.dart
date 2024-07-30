import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
	String? type;
	List<int>? coordinates;

	Location({this.type, this.coordinates});

	factory Location.fromJson(Map<String, dynamic> json) {
		return _$LocationFromJson(json);
	}

	Map<String, dynamic> toJson() => _$LocationToJson(this);
}
