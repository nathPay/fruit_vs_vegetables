import 'package:flutter/material.dart';
import '../firebase/@index.dart';
import '../skills_manager.dart';
import '../ui_components/@index.dart';
import 'package:provider/provider.dart';

// Interface for skill management 
class SkillsSelection extends StatelessWidget {
  const SkillsSelection({
    Key? key,
    required this.characterId,
    required this.health,
    required this.attack,
    required this.defense,
    required this.magik,
  }) : super(key: key);

  final String characterId;
  final int health;
  final int attack;
  final int defense;
  final int magik;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Consumer<SkillsManager>(
      builder: (context, skillsManager, child) => Container(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'Available skill points: ${skillsManager.skillPoints}',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: theme.onPrimary,
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                'Health:',
                                'Attack:',
                                'Defense:',
                                'Magik:',
                              ]
                                  .map(
                                    (item) => Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: theme.onPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                '$health',
                                '$attack',
                                '$defense',
                                '$magik',
                              ]
                                  .map(
                                    (item) => Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              width: 40.0,
                                              child: Text(
                                                item,
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: theme.onPrimary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                'health',
                                'attack',
                                'defense',
                                'magik',
                              ]
                                  .map(
                                    (skillName) => Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 40.0,
                                              width: 40.0,
                                              child: MyIconButton(
                                                icon: Icons.remove,
                                                onTap: () => skillsManager
                                                    .remove(skillName),
                                                size: 20,
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              width: 40.0,
                                              child: Text(
                                                '${skillsManager.skillPointsAllocated[skillName]}',
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: theme.onPrimary,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 40.0,
                                              width: 40.0,
                                              child: MyIconButton(
                                                icon: Icons.add,
                                                onTap: () => skillsManager
                                                    .add(skillName),
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: ActionButton(
                              label: 'reset',
                              state: skillsManager.isSkillPointSpent()
                                  ? ActionButtonState.DISABLED
                                  : ActionButtonState.NEGATIVE,
                              onTap: () => skillsManager.reset(),
                            ),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                            child: ActionButton(
                              label: 'apply',
                              state: skillsManager.isSkillPointSpent()
                                  ? ActionButtonState.DISABLED
                                  : ActionButtonState.POSITIVE,
                              onTap: () => skillsManager.apply(
                                characterId,
                                (
                                  characterId,
                                  skillPoints,
                                  newStats,
                                ) =>
                                    Provider.of<CharacterNotifier>(context,
                                            listen: false)
                                        .updateCharacterSkills(
                                  characterId,
                                  skillPoints,
                                  newStats,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingSkillSelection extends StatelessWidget {
  const LoadingSkillSelection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(32.0),
              ),
              child: Column(
                children: [
                  // Text(
                  //   'Available skill points: ${skillsManager.skillPoints}',
                  //   style: TextStyle(
                  //     fontSize: 20.0,
                  //     color: theme.onPrimary,
                  //   ),
                  // ),
                  Expanded(
                    flex: 6,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              'Health:',
                              'Attack:',
                              'Defense:',
                              'Magik:',
                            ]
                                .map(
                                  (item) => Expanded(
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        item,
                                        // style: TextStyle(
                                        //   fontSize: 20.0,
                                        // ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              '0',
                              '0',
                              '0',
                              '0',
                            ]
                                .map(
                                  (item) => Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          // Container(
                                          //   alignment: Alignment.center,
                                          //   width: 40.0,
                                          //   child: Text(
                                          //     item,
                                          //     style: TextStyle(
                                          //       fontSize: 20.0,
                                          //       color: theme.onPrimary,
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              'health',
                              'attack',
                              'defense',
                              'magik',
                            ]
                                .map(
                                  (skillName) => Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                        children: [
                                          // Container(
                                          //   height: 40.0,
                                          //   width: 40.0,
                                          //   child: MyIconButton(
                                          //     icon: Icons.remove,
                                          //     onTap: () => skillsManager
                                          //         .remove(skillName),
                                          //     size: 20,
                                          //   ),
                                          // ),
                                          // Container(
                                          //   alignment: Alignment.center,
                                          //   width: 40.0,
                                          //   child: Text(
                                          //     '${skillsManager.skillPointsAllocated[skillName]}',
                                          //     style: TextStyle(
                                          //       fontSize: 20.0,
                                          //       color: theme.onPrimary,
                                          //     ),
                                          //   ),
                                          // ),
                                          // Container(
                                          //   height: 40.0,
                                          //   width: 40.0,
                                          //   child: MyIconButton(
                                          //     icon: Icons.add,
                                          //     onTap: () => skillsManager
                                          //         .add(skillName),
                                          //     size: 20,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        // Expanded(
                        //   child: ActionButton(
                        //     label: 'reset',
                        //     state: ActionButtonState.NEGATIVE,
                        //     onTap: () => skillsManager.reset(),
                        //   ),
                        // ),
                        SizedBox(
                          width: 16.0,
                        ),
                        // Expanded(
                        //   child: ActionButton,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
