import '../firestore.dart';

class FightsApi extends FirestoreApi {
  static final String fightsApi = 'fights'; // Our collections path name
  FightsApi() : super(fightsApi);
}