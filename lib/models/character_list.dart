

import 'package:json_annotation/json_annotation.dart';
import 'package:rickandmorty_app/models/character.dart';
import 'character.dart';

part 'character_list.g.dart';
@JsonSerializable(explicitToJson: true)
class CharacterList {
  CharacterList({
    required this.info,
    required this.results,
  });

  Map<String,dynamic>info;
  final List<Character> results;
  factory CharacterList.fromJson(Map<String, dynamic> json) =>
      _$CharacterListFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterListToJson(this);
}
