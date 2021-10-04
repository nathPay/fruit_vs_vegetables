// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fruit_vs_vegetable_afk/firebase/@index.dart';
import 'package:fruit_vs_vegetable_afk/firebase/firebase.dart';
import 'package:fruit_vs_vegetable_afk/main.dart';
import 'package:fruit_vs_vegetable_afk/ui_components/@index.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:mockito/mockito.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

void main() async {

  var _characterApi = CharacterApi();
  var _ennemiesApi = EnnemiesApi();
  var _fightsApi = FightsApi();

  group('HomePage', () {
    testWidgets('Visual Home page test', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (_) => CharacterNotifier(_characterApi)),
            ChangeNotifierProvider(
                create: (_) => EnnemiesNotifier(_ennemiesApi)),
            ChangeNotifierProvider(create: (_) => FightsNotifier(_fightsApi)),
          ],
          child: MyApp(),
        ),
      );

      // finders
      final signInButton = find.text('SIGN IN');
      final signUpButton = find.text('SIGN UP');
      final emailFinder = find.bySemanticsLabel('Email');
      final passwordFinder = find.bySemanticsLabel('Password');

      // Expects
      expect(signInButton, findsOneWidget);
      expect(signUpButton, findsOneWidget);
      expect(emailFinder, findsOneWidget);
      expect(passwordFinder, findsOneWidget);
    });

    testWidgets('Login failed test', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (_) => CharacterNotifier(_characterApi)),
            ChangeNotifierProvider(
                create: (_) => EnnemiesNotifier(_ennemiesApi)),
            ChangeNotifierProvider(create: (_) => FightsNotifier(_fightsApi)),
          ],
          child: MyApp(),
        ),
      );

      // finders
      final signInButton = find.text('SIGN IN');
      final emailTextField = find.widgetWithText(TextField, 'Email');
      var passwordTextField = find.widgetWithText(TextField, 'Password');

      // Prepare test
      await tester.enterText(emailTextField, 'wrongAdress');
      await tester.enterText(passwordTextField, 'wrongPassword');
      await tester.pump();
      expect(find.text('wrongAdress'), findsOneWidget);
      await tester.tap(signInButton);
      await tester.pumpAndSettle();

      final passwordWidget = tester.widget(passwordTextField) as TextField;

      // Expect
      expect(passwordWidget.decoration!.errorText, isNotNull);
    });

    testWidgets('Login working test', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (_) => CharacterNotifier(_characterApi)),
            ChangeNotifierProvider(
                create: (_) => EnnemiesNotifier(_ennemiesApi)),
            ChangeNotifierProvider(create: (_) => FightsNotifier(_fightsApi)),
          ],
          child: MyApp(),
        ),
      );

      // finders
      final signInButton = find.text('SIGN IN');
      final emailTextField = find.bySemanticsLabel('Email');
      final passwordTextField = find.bySemanticsLabel('Password');

      // Prepare test
      await tester.enterText(emailTextField, 'test@test.com');
      await tester.enterText(passwordTextField, 'testtest');
      await tester.pump();
      await tester.tap(signInButton);
      await tester.pumpAndSettle();
      // Expect
      final newPage = find.text('Choose your soldier !');
      expect(newPage, findsOneWidget);
    });
  });
  group('CharacterList Page', () {
    testWidgets('Visual Character List page test', (tester) async {
      await signInMail('test@test.com', 'testtest');
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (_) => CharacterNotifier(_characterApi)),
            ChangeNotifierProvider(
                create: (_) => EnnemiesNotifier(_ennemiesApi)),
            ChangeNotifierProvider(create: (_) => FightsNotifier(_fightsApi)),
          ],
          child: MyApp(
            initialRoute: '/characterList',
          ),
        ),
        Duration(seconds: 2),
      );

      final title = find.text('Choose your soldier !');
      final card = find.byType(CharacterCard);
      final emptyCard = find.byType(EmptyCharaterCard);
    });
  });
}

// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// typedef Callback(MethodCall call);

// setupCloudFirestoreMocks([Callback? customHandlers]) {
//   TestWidgetsFlutterBinding.ensureInitialized();

//   MethodChannelFirebase.channel.setMockMethodCallHandler((call) async {
//     if (call.method == 'Firebase#initializeCore') {
//       return [
//         {
//           'name': defaultFirebaseAppName,
//           'options': {
//             'apiKey': 'AIzaSyDqovMMNievpUICFW1fwmm9aLOChO5F7oI',
//             'appId': '1:875689937765:android:2bf90a4edd1aa3b66f6f8c',
//             'messagingSenderId':
//                 '875689937765-6aop0rrk5kddaqqtrosk8iedl28jkvft.apps.googleusercontent.com',
//             'projectId': 'fruitvsvegetable-3c750',
//           },
//           'pluginConstants': {},
//         }
//       ];
//     }

//     if (call.method == 'Firebase#initializeApp') {
//       return {
//         'name': call.arguments['appName'],
//         'options': call.arguments['options'],
//         'pluginConstants': {},
//       };
//     }

//     if (customHandlers != null) {
//       customHandlers(call);
//     }

//     return null;
//   });
// }
