import 'package:flutter/material.dart';
import '../api/character.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CharacterNotifier extends ChangeNotifier {
  CharacterApi? _api;

  CharacterNotifier(CharacterApi api) {
    _api = api;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCharacterList(String userId) {
    return _api!.getCharacterList(userId);
  }

  Future<void> deleteCharacter(String characterId) {
    return _api!.deleteCharacter(characterId);
  }

  Future<String> createCharacter(String userId, String characterName, int type) {
    return _api!.createCharacter(userId, characterName, type);
  }

  Future<void> updateCharacterSkills(String characterId, int skillPoints, Map<String, int> addStats) {
    return _api!.updateCharacterSkills(characterId, skillPoints, addStats);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getCharacter(String characterId) {
    return _api!.getCharacter(characterId);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getCharacterFuture(String characterId) {
    return _api!.getCharacterFuture(characterId);
  }

  Future<void> rankUpdate(String characterId, int rank, bool addSkillPoint) {
    return _api!.rankUpdate(characterId, rank, addSkillPoint);
  }
}
