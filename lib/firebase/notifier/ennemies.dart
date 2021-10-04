import 'package:flutter/material.dart';
import '../api/ennemies.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EnnemiesNotifier extends ChangeNotifier {
  EnnemiesApi? _api;

  EnnemiesNotifier(EnnemiesApi api) {
    _api = api;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getEnnemieDataWithRank(int rank) {
    return _api!.getEnnemieDataWithRank(rank);
  }
}
