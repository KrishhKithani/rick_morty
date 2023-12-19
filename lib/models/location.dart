import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';
@JsonSerializable()
class Location {
  String name;
  String url;

  Location({
    required this.name,
    required this.url,
  });


  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);


}