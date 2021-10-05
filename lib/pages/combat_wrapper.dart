import 'dart:async';
import 'dart:math';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import '../firebase/@index.dart';
import 'combat.dart';
import '../ui_components/@index.dart';
import 'package:provider/provider.dart';

// Wrap Combat widget and create all functions required for functionnal combat
class CombatWrapper extends HookWidget {
  const CombatWrapper({
    Key? key,
    required this.charactersData,
  }) : super(key: key);

  final Map<String, dynamic> charactersData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final timer = useState(40);
    Map<String, dynamic> playerData = charactersData['fruit']['data'];
    Map<String, dynamic> ennemieData = charactersData['vegetable'];
    final playerHp = useState(playerData['health']);
    final ennemieHp = useState(ennemieData['health']);
    final playerTurn = useState(true);
    var historicList = useState(<Map<String, dynamic>>[]);
    final intro = useState('3');
    final isPaused = useState(false);
    final _playerAnimationController = useAnimationController(
      duration: Duration(milliseconds: 250),
      initialValue: 0,
      lowerBound: 0,
      upperBound: 150,
    );
    final _ennemieAnimationController = useAnimationController(
      duration: Duration(milliseconds: 250),
      initialValue: 0,
      lowerBound: -150,
      upperBound: 0,
    );

    // Start the turn of the active player.
    // Try to attack -> Create text that describe the attack -> update values and pass the turn
    Future<void> doAction() async {
      var rand = Random();
      var action = '';
      // Check timer to avoid infinit combat
      if (timer.value > 0) {
        if (playerTurn.value) {
          int playerAttack;
          if (playerData['attack'] > 0) {
            playerAttack = rand.nextInt(playerData['attack']) + 1;
          } else {
            playerAttack = 0;
          }

          int damages = 0;
          bool isMagikUsed = false;
          if (playerAttack > ennemieData['defense']) {
            damages = playerAttack - ennemieData['defense'] as int;
            if (damages == playerData['magik'] as int) {
              isMagikUsed = true;
              damages = damages + playerData['magik'] as int;
            }
            ennemieHp.value = ennemieHp.value - damages;
          }
          if (damages == 0) {
            action = 'Throw a $playerAttack but miss the attack.';
          } else if (isMagikUsed) {
            _playerAnimationController
                .animateTo(
                  150,
                  curve: Curves.bounceIn,
                )
                .then(
                  (value) => _playerAnimationController.reverse(),
                );
            action =
                'Throw a $playerAttack and use his magik to deal $damages !!';
          } else {
            _playerAnimationController.animateTo(75).then(
                  (value) => _playerAnimationController.reverse(from: 75),
                );
            action = 'Throw a $playerAttack and deal $damages !!';
          }
        } else {
          int ennemieAttack;
          if (ennemieData['attack'] > 0) {
            ennemieAttack = rand.nextInt(ennemieData['attack']) + 1;
          } else {
            ennemieAttack = 0;
          }

          int damages = 0;
          bool isMagikUsed = false;
          if (ennemieAttack > playerData['defense']) {
            damages = ennemieAttack - playerData['defense'] as int;
            if (damages == ennemieData['magik'] as int) {
              isMagikUsed = true;
              damages = damages + ennemieData['magik'] as int;
            }

            playerHp.value = playerHp.value - damages;
          }

          if (damages == 0) {
            action = 'Throw a $ennemieAttack but miss the attack.';
          } else if (isMagikUsed) {
            _ennemieAnimationController
                .animateTo(
                  -150,
                  curve: Curves.bounceIn,
                )
                .then(
                  (value) => _ennemieAnimationController.forward(),
                );
            action =
                'Throw a $ennemieAttack and use his magik to deal $damages !!';
          } else {
            _ennemieAnimationController.animateTo(-75).then(
                  (value) => _ennemieAnimationController.forward(from: -75),
                );
            action = 'Throw a $ennemieAttack and deal $damages !!';
          }
        }

        // Create the combat historic
        historicList.value.add({
          'name': playerTurn.value ? playerData['name'] : ennemieData['name'],
          'text': action,
          'player': playerTurn.value,
        });
      } else {
        playerHp.value = 0;
        historicList.value.add({
          'name': playerTurn.value ? playerData['name'] : ennemieData['name'],
          'text': 'Time out !',
          'player': playerTurn.value,
        });
      }

      playerTurn.value = !playerTurn.value;
    }

    Future<void> _startTimer() async {
      while (playerHp.value > 0 && ennemieHp.value > 0) {
        if (!isPaused.value) {
          await Future.delayed(
            Duration(
              seconds: 1,
            ),
            () => {
              if (timer.value <= 0)
                {
                  timer.value = timer.value,
                }
              else
                {
                  timer.value = timer.value - 1,
                }
            },
          );
        } else {
          await Future.delayed(Duration(seconds: 1));
        }
      }
    }

    // Combat loop until someone comes to 0HP or time is up
    Future<void> _startCombat() async {
      intro.value = '3';
      await Future.delayed(Duration(seconds: 1));
      intro.value = '2';
      await Future.delayed(Duration(seconds: 1));
      intro.value = '1';
      await Future.delayed(Duration(seconds: 1));
      intro.value = 'GO';
      await Future.delayed(Duration(seconds: 1));
      intro.value = '';
      _startTimer();
      while (playerHp.value > 0 && ennemieHp.value > 0) {
        if (!isPaused.value) {
          doAction();
        }
        await Future.delayed(Duration(seconds: 1));
      }

      // Update rank and skills point if player win or loose
      final oldRank = playerData['rank'];
      var newRank = playerData['rank'];
      // LOOSE
      if (playerHp.value <= 0) {
        if (playerData['rank'] > 1) {
          await Provider.of<CharacterNotifier>(context, listen: false)
              .rankUpdate(
            charactersData['fruit']['id'] as String,
            playerData['rank'] - 1,
            false,
          );
          newRank--;
        }
        await Provider.of<FightsNotifier>(context, listen: false)
            .addFightHistoric(
          {
            'name': ennemieData['name'],
            'type': ennemieData['rank'],
          },
          {
            'name': playerData['name'],
            'type': playerData['type'],
          },
          historicList.value,
          auth.currentUser!.uid,
          false,
        );
        await showGeneralDialog<Widget>(
          context: context,
          barrierDismissible: false,
          barrierLabel: 'Dismiss',
          barrierColor: Color.fromARGB(100, 0, 0, 0),
          transitionDuration: Duration(milliseconds: 200),
          pageBuilder: (context, animation, secondaryAnimation) {
            return ResultCard(
              oldRank: oldRank,
              newRank: newRank,
              isWin: false,
              onTap: () => {
                Navigator.of(context).popUntil(
                  (route) => route.settings.name == '/characterList',
                ),
              },
            );
          },
        );
      } else {
        // WIN
        if (playerData['rank'] < 10) {
          await Provider.of<CharacterNotifier>(context, listen: false)
              .rankUpdate(
            charactersData['fruit']['id'] as String,
            playerData['rank'] + 1,
            true,
          );
          newRank++;
        }
        await Provider.of<FightsNotifier>(context, listen: false)
            .addFightHistoric(
          {
            'name': ennemieData['name'],
            'type': ennemieData['rank'],
          },
          {
            'name': playerData['name'],
            'type': playerData['type'],
          },
          historicList.value,
          auth.currentUser!.uid,
          true,
        );

        await showGeneralDialog<Widget>(
          context: context,
          barrierDismissible: false,
          barrierLabel: 'Dismiss',
          barrierColor: Color.fromARGB(100, 0, 0, 0),
          transitionDuration: Duration(milliseconds: 200),
          pageBuilder: (context, animation, secondaryAnimation) {
            return Container(
              child: ResultCard(
                oldRank: oldRank,
                newRank: newRank,
                isWin: true,
                onTap: () => Navigator.of(context).popUntil(
                  (route) => route.settings.name == '/characterList',
                ),
              ),
            );
          },
        );
      }
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: theme.background,
        body: Combat(
          key: key,
          startCombat: _startCombat,
          playerData: playerData,
          ennemieData: ennemieData,
          playerHp: playerHp.value,
          ennemieHp: ennemieHp.value,
          timer: timer.value,
          historicList: historicList.value,
          intro: intro.value,
          playerTurn: playerTurn.value,
          isPaused: isPaused,
          ennemieAnimation: _ennemieAnimationController,
          playerAnimation: _playerAnimationController,
        ),
      ),
    );
  }
}
