import '../firestore.dart';

class CharacterApi extends FirestoreApi {
  static final String characterApi = 'character'; // Our collections path name
  CharacterApi() : super(characterApi);
}