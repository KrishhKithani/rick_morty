import 'package:json_annotation/json_annotation.dart';

part 'info.g.dart';
@JsonSerializable(explicitToJson: true)
class Info {
  final int count ;
  final int pages;
  final String next ;
  final String prev ;

  Info({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev
});

  factory Info.fromJson(Map<String, dynamic> json) {
    return _$InfoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InfoToJson(this);

}

