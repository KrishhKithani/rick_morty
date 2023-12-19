import 'package:json_annotation/json_annotation.dart';
import 'package:rickandmorty_app/models/location.dart';
import 'package:json_annotation/json_annotation.dart';

import 'location.dart';

part 'character.g.dart';
@JsonSerializable()
class Character{

  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final Location origin;
  final Location location;
  final String image;
  final List<String> episode;
  final String url;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
  });


  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);

}

enum Species {
  Alien,
  Human
}

enum Status {
  Alive,
  Dead,
  unknown
}
enum Gender {
  Female,
  Male,
  unknown
}

