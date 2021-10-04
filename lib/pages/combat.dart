import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../ui_components/@index.dart';
import '../ui_components/historic_display.dart';

// Display combat graphical interface
class Combat extends StatefulWidget {
  const Combat({
    Key? key,
    required this.startCombat,
    required this.playerHp,
    required this.ennemieHp,
    required this.playerData,
    required this.ennemieData,
    required this.timer,
    required this.historicList,
    required this.intro,
    required this.playerTurn,
    required this.isPaused,
  }) : super(key: key);

  final Future<void> Function() startCombat;
  final int playerHp;
  final int ennemieHp;
  final Map<String, dynamic> playerData;
  final Map<String, dynamic> ennemieData;
  final int timer;
  final List<Map<String, dynamic>> historicList;
  final String intro;
  final bool playerTurn;
  final ValueNotifier<bool> isPaused;

  @override
  _CombatState createState() => _CombatState();
}

class _CombatState extends State<Combat> {
  @override
  void initState() {
    widget.startCombat();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    // Avoid missclick on combat
    Future<bool> _onWillPop() async {
      widget.isPaused.value = true;
      return await showDialog(
            context: context,
            barrierColor: Color.fromARGB(100, 0, 0, 0),
            builder: (context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you really want to quit?'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () => {
                    widget.isPaused.value = false,
                    Navigator.of(context).pop(false),
                  },
                  //return false when click on "NO"
                  child: Text(
                    'No',
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 8.0,
                ),
                // TIMER
                SizedBox(
                  height: 36.0,
                  width: 100.0,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      widget.timer.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: theme.onPrimary,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 16.0, left: 16.0, right: 8.0),
                                child: HpBar(
                                  characterName: widget.playerData['name'],
                                  maxHp: (widget.playerData['health'] as int)
                                      .toDouble(),
                                  rotation: -0.4,
                                  currentHp: widget.playerHp,
                                ),
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              FightStand(
                                type: widget.playerData['type'],
                                team: 'fruits',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 16.0, right: 16.0, left: 8.0),
                                child: HpBar(
                                  characterName: widget.ennemieData['name'],
                                  maxHp: (widget.ennemieData['health'] as int)
                                      .toDouble(),
                                  rotation: 0.4,
                                  currentHp: widget.ennemieHp,
                                ),
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Container(
                                child: FightStand(
                                  type: widget.ennemieData['rank'],
                                  team: 'vegetables',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // HISTORIC
                Expanded(
                  child: HistoricDisplay(
                    historic: widget.historicList,
                  ),
                ),
              ],
            ),
          ),
          if (widget.intro != '')
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: theme.secondary,
              ),
              child: Text(
                widget.intro,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: theme.onSecondary,
                    fontSize: MediaQuery.of(context).size.width / 3,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'comic'),
              ),
            ),
        ],
      ),
    );
  }
}
