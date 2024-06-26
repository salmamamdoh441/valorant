import 'package:valorant/data/model/ability_model.dart';
import 'package:valorant/data/model/role_model.dart';
import 'package:valorant/data/model/voice_line.dart';

class CharacterModel {
  String description, displayName, fullPortrait, displayIcon;
  List<Ability> abilities;
  VoiceLine voiceLine;
  Role role;

  CharacterModel(
      {required this.description,
      required this.displayName,
      required this.fullPortrait,
      required this.displayIcon,
      required this.abilities,
      required this.voiceLine,
        required this.role,

      });
}
