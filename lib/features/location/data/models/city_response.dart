import 'package:json_annotation/json_annotation.dart';
part 'city_response.g.dart';

@JsonSerializable()
class CityInfoResponse {
  @JsonKey(name: "name")
  String name;

  @JsonKey(name: "lat")
  double lat;
  @JsonKey(name: "lon")
  double lon;
  @JsonKey(name: "country")
  String country;

  CityInfoResponse({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
  });

  factory CityInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$CityInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CityInfoResponseToJson(this);
}
