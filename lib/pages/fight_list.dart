import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import '../firebase/@index.dart';
import 'package:provider/provider.dart';
import '../ui_components/@index.dart';

// List all fights and display some informations about them
class FightList extends HookWidget {
  const FightList({
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
                    'Look at your previous fights !',
                    style: TextStyle(
                      fontSize: 32.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              StreamBuilder(
                stream: Provider.of<FightsNotifier>(context)
                    .getFightsListOrdered(auth.currentUser!.uid),
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
                            itemCount: snapshot.data!.docs.length,
                            separatorBuilder: (context, index) => Divider(
                              color: Colors.brown[300],
                              thickness: 5.0,
                              height: 5.0,
                            ),
                            itemBuilder: (context, index) {
                              return FightCard(
                                fightData: snapshot.data!.docs[index].data(),
                                onDelete: () => {
                                  Provider.of<FightsNotifier>(context,
                                          listen: false)
                                      .deleteFight(
                                    snapshot.data!.docs[index].id,
                                  ),
                                },
                                onTap: () => Navigator.of(context)
                                    .pushNamed('/fightDetail', arguments: {
                                  'id': snapshot.data!.docs[index].id,
                                  'data': snapshot.data!.docs[index].data(),
                                }),
                              );
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
                          itemCount: 6,
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.brown[300],
                            thickness: 5.0,
                            height: 5.0,
                          ),
                          itemBuilder: (context, index) {
                            return LoadingFightCard();
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
