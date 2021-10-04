import 'package:cloud_firestore/cloud_firestore.dart';

// Contain all function that call FireStore database
class FirestoreApi {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference? _collectionReference;

  FirestoreApi(String collectionPath) {
    _collectionReference = firestore.collection(collectionPath);
  }

  // ########## CHARACTER API ###########

  Stream<QuerySnapshot<Map<String, dynamic>>> getCharacterList(
      String userId) async* {
    yield* firestore
        .collection('character')
        .where('user', isEqualTo: userId)
        .snapshots();
  }

  Future<void> deleteCharacter(String characterId) async {
    await firestore.collection('character').doc(characterId).delete();
  }

  Future<String> createCharacter(
      String userId, String characterName, int type) async {
    var character = {
      'user': userId,
      'name': characterName,
      'type': type,
      'rank': 1,
      'attack': 0,
      'defense': 0,
      'magik': 0,
      'health': 10,
      'skillPoints': 12,
    };

    return (await firestore.collection('character').add(character)).id;
  }

  Future<Map<String, dynamic>?> getCharacterById(String characterId) async {
    return (await firestore.collection('character').doc(characterId).get())
        .data();
  }

  Future<void> updateCharacterSkills(
      String characterId, int skillPoints, Map<String, int> newStats) async {
    await firestore.collection('character').doc(characterId).update({
      'health': newStats['health'],
      'attack': newStats['attack'],
      'defense': newStats['defense'],
      'magik': newStats['magik'],
      'skillPoints': skillPoints,
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getCharacter(
      String characterId) async* {
    yield* firestore.collection('character').doc(characterId).snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getCharacterFuture(String characterId) async {
    return await firestore.collection('character').doc(characterId).get();
  }

  // ########## ENNEMIES API ###########

  Future<String> getEnnemieIdWithRank(int rank) async {
    var query = await firestore
        .collection('ennemies')
        .where(
          'rank',
          isEqualTo: rank,
        )
        .limit(1)
        .get();
    return query.docs[0].id;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getEnnemieDataWithRank(
      int rank) async {
    var id = await getEnnemieIdWithRank(rank);
    return await firestore.collection('ennemies').doc(id).get();
  }

  Future<void> rankUpdate(
      String characterId, int rank, bool addSkillPoint) async {
    var characterUpdate = {
      'rank': rank,
    };

    if (addSkillPoint) {
      var oldSkillPoint =
          await firestore.collection('character').doc(characterId).get();
      characterUpdate['skillPoints'] =
          (oldSkillPoint.data()!['skillPoints'] as int) + 1;
    }
    await firestore
        .collection('character')
        .doc(characterId)
        .update(characterUpdate);
  }

  // ########## FIGHTS API ###########

  Future<bool> startNewFight(String characterId, String userId) async {
    var characterRank = (await getCharacterById(characterId));
    if (characterRank == null) {
      return false;
    }
    characterRank = characterRank['rank'];
    var ennemieId = await getEnnemieIdWithRank(characterRank as int);
    var fight = {
      'characterId': characterId,
      'ennemieId': ennemieId,
      'historic': [],
      'user': userId,
    };
    await firestore.collection('fights').add(fight);
    return true;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFightsListOrdered(
      String userId) async* {
    yield* firestore
        .collection('fights')
        .where('user', isEqualTo: userId).orderBy('date', descending: true)
        .snapshots();
  }

  Future<void> deleteFight(String fightId) async {
    await firestore.collection('fights').doc(fightId).delete();
  }

  Future<void> addFightHistoric(
    Map<String, dynamic> ennemie,
    Map<String, dynamic> player,
    List<Map<String, dynamic>> historic,
    String user,
    bool winner,
  ) async {
    await firestore.collection('fights').add({
      'ennemie': ennemie,
      'player': player,
      'historic': historic,
      'user': user,
      'winner': winner,
      'date': Timestamp.now(),
    });
  }
}
