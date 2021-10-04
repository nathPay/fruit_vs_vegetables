import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../firebase/@index.dart';
import 'package:provider/provider.dart';
import '../ui_components/@index.dart';
import '../firebase/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Home page of user, manage character and access to fight historic 
class CharacterList extends HookWidget {
  const CharacterList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: theme.background,
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Choose your soldier !',
                    style: TextStyle(fontSize: 32.0),
                  ),
                ),
              ),
              StreamBuilder(
                stream: Provider.of<CharacterNotifier>(context)
                    .getCharacterList(auth.currentUser!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32.0),
                          color: Colors.brown,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.brown[300]!,
                              width: 5.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListView.separated(
                            itemCount: 10,
                            separatorBuilder: (context, index) => Divider(
                              color: Colors.brown[300],
                              thickness: 5.0,
                              height: 5.0,
                            ),
                            itemBuilder: (context, index) {
                              if (snapshot.data!.docs.length > index) {
                                return CharacterCard(
                                  onDelete: () => {
                                    Provider.of<CharacterNotifier>(context,
                                            listen: false)
                                        .deleteCharacter(
                                      snapshot.data!.docs[index].id,
                                    ),
                                  },
                                  onTap: () => Navigator.of(context).pushNamed(
                                      '/characterDetail',
                                      arguments: {
                                        'id': snapshot.data!.docs[index].id,
                                        'data':
                                            snapshot.data!.docs[index].data(),
                                      }),
                                  name:
                                      snapshot.data!.docs[index].data()['name'],
                                  rank:
                                      snapshot.data!.docs[index].data()['rank'],
                                  type:
                                      snapshot.data!.docs[index].data()['type'],
                                );
                              } else {
                                return EmptyCharaterCard();
                              }
                            },
                          ),
                        ),
                      ),
                    );
                  }
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32.0),
                        color: Colors.brown,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.brown[300]!,
                            width: 5.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListView.separated(
                          itemCount: 10,
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.brown[300],
                            thickness: 5.0,
                            height: 5.0,
                          ),
                          itemBuilder: (context, index) {
                            return LoadingCharacterCard();
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 8.0),
                        alignment: Alignment.center,
                        child: ActionButton(
                          label: 'Historic',
                          onTap: () =>
                              Navigator.of(context).pushNamed('/fightList'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder(
                        stream: Provider.of<CharacterNotifier>(context)
                            .getCharacterList(auth.currentUser!.uid),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshots) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 8.0),
                            alignment: Alignment.center,
                            child: ActionButton(
                              label: 'New',
                              disabled: snapshots.hasData
                                  ? snapshots.data!.docs.length >= 10
                                  : false,
                              onTap: () => showGeneralDialog<Widget>(
                                context: context,
                                barrierDismissible: false,
                                barrierLabel: 'Dismiss',
                                barrierColor: Color.fromARGB(100, 0, 0, 0),
                                transitionDuration: Duration(milliseconds: 200),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return CharacterBuilder();
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
            // #####
            // #####
          ),
        ),
      ),
    );
  }
}
