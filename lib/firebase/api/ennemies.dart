import '../firestore.dart';

class EnnemiesApi extends FirestoreApi {
  static final String ennemiesApi = 'ennemies'; // Our collections path name
  EnnemiesApi() : super(ennemiesApi);
}