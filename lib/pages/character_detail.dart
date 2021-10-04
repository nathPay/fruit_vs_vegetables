import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../firebase/@index.dart';
import '../ui_components/@index.dart';
import 'package:provider/provider.dart';
import '../skills_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Display all information about a character
// Include skill points management and start combat
class CharacterDetail extends HookWidget {
  const CharacterDetail({
    Key? key,
    required this.characterData,
  }) : super(key: key);

  final Map<String, dynamic> characterData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final characterStats = {
      'health': characterData['data']['health'] as int,
      'attack': characterData['data']['attack'] as int,
      'defense': characterData['data']['defense'] as int,
      'magik': characterData['data']['magik'] as int,
    };

    final loading = useState(false);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: theme.background,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: theme.background,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Image.asset(
                      'assets/fruits/${characterData['data']['type']}.png',
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Expanded(
                    flex: 5,
                    child: ChangeNotifierProvider(
                      create: (context) => SkillsManager(
                        characterStats,
                        characterData['data']['skillPoints'],
                      ),
                      child: StreamBuilder(
                        stream: Provider.of<CharacterNotifier>(context)
                            .getCharacter(characterData['id']),
                        builder: (BuildContext context,
                            AsyncSnapshot<
                                    DocumentSnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.hasData) {
                            return SkillsSelection(
                              characterId: characterData['id'],
                              health: snapshot.data!['health'],
                              attack: snapshot.data!['attack'],
                              defense: snapshot.data!['defense'],
                              magik: snapshot.data!['magik'],
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Expanded(
                    child: ActionButton(
                      label: 'Start combat',
                      onTap: () => {
                        loading.value = true,
                        Provider.of<CharacterNotifier>(context, listen: false)
                            .getCharacterFuture(characterData['id'])
                            .then(
                              (fruit) => Provider.of<EnnemiesNotifier>(
                                context,
                                listen: false,
                              )
                                  .getEnnemieDataWithRank(
                                    characterData['data']['rank'],
                                  )
                                  .then(
                                    (vegetable) => {
                                      loading.value = false,
                                      Navigator.of(context).popAndPushNamed(
                                        '/combat',
                                        arguments: {
                                          'vegetable': vegetable.data()!,
                                          'fruit': {
                                            'data': fruit.data()!,
                                            'id': fruit.id,
                                          },
                                        },
                                      ),
                                    },
                                  ),
                            ),
                      },
                    ),
                  ),
                ],
              ),
            ),
            if (loading.value)
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: Transform.scale(
                  scale: 3.0,
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
