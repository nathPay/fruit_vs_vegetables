import 'package:flutter/material.dart';

class SkillsManager with ChangeNotifier {
  int initialSkillPoints = 0;
  int skillPoints = 0;

  Map<String, int> characterStats = {};

  Map<String, int> skillPointsAllocated = {};
  Map<String, int> tmpCharacterStats = {};

  SkillsManager(Map<String, int> _characterStats, int _skillPoints) {
    characterStats = _characterStats;
    skillPoints = _skillPoints;
    initialSkillPoints = _skillPoints;
    skillPointsAllocated = {
      'health': 0,
      'attack': 0,
      'defense': 0,
      'magik': 0,
    };
    tmpCharacterStats = {
      'health': _characterStats['health'] as int,
      'attack': _characterStats['attack'] as int,
      'defense': _characterStats['defense'] as int,
      'magik': _characterStats['magik'] as int,
    };
  }

  void add(String skillName) {
    switch (skillName) {
      case 'health':
        if (skillPoints >= 1) {
          skillPointsAllocated[skillName] =
              skillPointsAllocated[skillName]! + 1;
          tmpCharacterStats[skillName] = tmpCharacterStats[skillName]! + 1;
          skillPoints = skillPoints - 1;
        }
        break;
      default:
        {
          var requirement = (tmpCharacterStats[skillName]! / 5).truncate() + 1;
          if (skillPoints >= requirement) {
            skillPointsAllocated[skillName] =
                skillPointsAllocated[skillName]! + requirement;
            tmpCharacterStats[skillName] = tmpCharacterStats[skillName]! + 1;
            skillPoints = skillPoints - requirement;
          }
        }
    }
    notifyListeners();
  }

  void remove(String skillName) {
    switch (skillName) {
      case 'health':
        if (skillPointsAllocated[skillName]! >= 1) {
          skillPointsAllocated[skillName] =
              skillPointsAllocated[skillName]! - 1;
          tmpCharacterStats[skillName] = tmpCharacterStats[skillName]! - 1;
          skillPoints = skillPoints + 1;
        }
        break;
      default:
        {
          var requirement = tmpCharacterStats[skillName]! / 5;
          if (requirement != requirement.truncate()) {
            requirement = requirement.truncate() + 1;
          }
          if (skillPointsAllocated[skillName]! >= requirement) {
            skillPointsAllocated[skillName] =
                skillPointsAllocated[skillName]! - requirement.toInt();
            tmpCharacterStats[skillName] = tmpCharacterStats[skillName]! - 1;
            skillPoints = skillPoints + requirement.toInt();
          }
        }
    }
    notifyListeners();
  }

  void reset() {
    skillPointsAllocated.forEach((key, value) {
      skillPoints = skillPoints + value;
    });
    skillPointsAllocated = {
      'health': 0,
      'attack': 0,
      'defense': 0,
      'magik': 0,
    };
    notifyListeners();
  }

  Future<void> apply(String characterId,
      Future<void> Function(String, int, Map<String, int>) onApply) async {
    await onApply(characterId, skillPoints, tmpCharacterStats);
    characterStats = {
      'health': tmpCharacterStats['health']!,
      'attack': tmpCharacterStats['attack']!,
      'defense': tmpCharacterStats['defense']!,
      'magik': tmpCharacterStats['magik']!,
    };
    skillPointsAllocated = {
      'health': 0,
      'attack': 0,
      'defense': 0,
      'magik': 0,
    };
    initialSkillPoints = skillPoints;
    notifyListeners();
  }

  bool isSkillPointSpent() {
    return initialSkillPoints == skillPoints;
  }
}
