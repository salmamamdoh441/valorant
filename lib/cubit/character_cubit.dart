import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:valorant/data/model/ability_model.dart';
import 'package:valorant/data/model/character_model.dart';
import 'package:valorant/data/model/role_model.dart';
import 'package:valorant/data/model/voice_line.dart';
import 'package:valorant/data/repo/repo_layer.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  CharacterCubit(this.repoLayer) : super(CharacterInitial());
  final RepoLayer repoLayer;

  Future<void> getCharacter() async {
   try{
     emit(CharacterLoading());
     final listOfCharacterModel = await requestCharacter();
     emit(CharacterLoaded(listCharacter: listOfCharacterModel));
   }
   catch(e){
     emit(CharacterError(message: e.toString()));

   }
  }

  Future<List<CharacterModel>> requestCharacter() async {
    try {
      final response = await repoLayer.getAgent();
      if (response == null) {
        return [];
      } else {}
      final responseDecoded = jsonDecode(response.body);
      final shrief = responseDecoded["data"] as List<dynamic>;
      final list = shrief
          .map((dynamic e) {
            final role = e["role"] ?? {};
            final roleInfo = Role(
                uuid: role["uuid"] ?? {},
                displayName: role["displayName"],
                description: role["description"] ?? {},
                displayIcon: role["displayIcon"],
                assetPath: role["assetPath"]);
            final ability = e["abilities"] as List<dynamic>;
            final abilityInfo = ability.map((a) {
              return Ability(
                  slot: a["slot"] ?? "",
                  displayName: a["displayName"] ?? "",
                  description: a["description"] ?? "",
                  displayIcon: a["displayIcon"] ?? "");
            }).toList();
            abilityInfo
                .retainWhere((element) => element.displayIcon.isNotEmpty);
            final voiceLine = e["voiceLine"] ?? {};
            final voiceMediaList = voiceLine["mediaList"] as List;
            final voiceMedia = VoiceLine(voiceLine: voiceMediaList[0]["wave"]);
            return CharacterModel(
                description: e["description"] ?? "",
                displayName: e["displayName"] ?? "",
                fullPortrait: e["fullPortrait"] ?? "",
                displayIcon: e["displayIcon"] ?? "",
                abilities: abilityInfo,
                voiceLine: voiceMedia,
                role: roleInfo);
          })
          .toSet()
          .toList();
      list.retainWhere((element) => element.fullPortrait.isNotEmpty);
      return list;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception(e.toString());
    }
  }
}
