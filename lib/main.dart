import 'package:flutter/material.dart';
import 'firebase/notifier/character.dart';
import 'pages/combat_wrapper.dart';
import 'pages/@index.dart';
import 'theme.dart';
import 'firebase/@index.dart';
import 'package:provider/provider.dart';
import 'firebase/firebase.dart';
import 'firebase/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  // Prepare firebase and API
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();

  var _characterApi = CharacterApi();
  var _ennemiesApi = EnnemiesApi();
  var _fightsApi = FightsApi();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CharacterNotifier(_characterApi)),
        ChangeNotifierProvider(create: (_) => EnnemiesNotifier(_ennemiesApi)),
        ChangeNotifierProvider(create: (_) => FightsNotifier(_fightsApi)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    this.initialRoute = '',
  }) : super(key: key);

  final String initialRoute;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fruit VS Vegetable',
      theme: mainTheme,
      initialRoute: auth.currentUser != null ? '/characterList' : '/signIn',
      routes: {
        '/signIn': (context) => Home(),
        '/characterList': (context) => CharacterList(),
        '/fightList': (context) => FightList(),
        '/fightDetail': (context) => FightDetail(
              fightData: ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>,
            ),
        '/characterDetail': (context) => CharacterDetail(
              characterData: ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>,
            ),
        '/combat': (context) => CombatWrapper(
              charactersData: ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>,
            ),
      },
    );
  }
}
