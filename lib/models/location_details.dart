import 'package:json_annotation/json_annotation.dart';

part 'location_details.g.dart';
@JsonSerializable()
class LocationDetails {
  int id;
  String name;
  String type;
  String dimension;
  List<String> residents;
  String url;

  LocationDetails({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
    required this.url,
  });


  factory LocationDetails.fromJson(Map<String, dynamic> json) =>
      _$LocationDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDetailsToJson(this);


}

