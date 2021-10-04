import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../api/fights.dart';

class FightsNotifier extends ChangeNotifier {
  FightsApi? _api;

  FightsNotifier(FightsApi api) {
    _api = api;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFightsListOrdered(String userId) {
    return _api!.getFightsListOrdered(userId);
  }

  Future<void> deleteFight(String fightId) {
    return _api!.deleteFight(fightId);
  }

  Future<void> addFightHistoric(
    Map<String, dynamic> ennemie,
    Map<String, dynamic> player,
    List<Map<String, dynamic>> historic,
    String user,
    bool winner,
  ) {
    return _api!.addFightHistoric(
      ennemie,
      player,
      historic,
      user,
      winner,
    );
  }
}
