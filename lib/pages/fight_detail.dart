import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import '../ui_components/@index.dart';

// Display all selected fight informations
class FightDetail extends HookWidget {
  const FightDetail({
    Key? key,
    required this.fightData,
  }) : super(key: key);

  final Map<String, dynamic> fightData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: theme.background,
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: FightStand(
                            type: fightData['data']['player']['type'],
                            team: 'fruits',
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(
                              (fightData['data']['winner'] as bool)
                                  ? 'WINNER'
                                  : 'LOOSER',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: FightStand(
                            type: fightData['data']['ennemie']['type'],
                            team: 'vegetables',
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(
                              !(fightData['data']['winner'] as bool)
                                  ? 'WINNER'
                                  : 'LOOSER',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: HistoricDisplay(
                  historic: List<Map<String, dynamic>>.from(
                    fightData['data']['historic'],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
