// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationDetails _$LocationDetailsFromJson(Map<String, dynamic> json) =>
    LocationDetails(
      id: json['id'] as int,
      name: json['name'] as String,
      type: json['type'] as String,
      dimension: json['dimension'] as String,
      residents:
          (json['residents'] as List<dynamic>).map((e) => e as String).toList(),
      url: json['url'] as String,
    );

Map<String, dynamic> _$LocationDetailsToJson(LocationDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'dimension': instance.dimension,
      'residents': instance.residents,
      'url': instance.url,
    };
