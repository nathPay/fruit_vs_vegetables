import 'package:flutter/gestures.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

// Button that display some information of a fight
class FightCard extends HookWidget {
  const FightCard({
    Key? key,
    required this.onDelete,
    required this.onTap,
    required this.fightData,
  }) : super(key: key);

  final void Function() onDelete;
  final void Function() onTap;
  final Map<String, dynamic> fightData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    var _tapPosition;
    void _storePosition(TapDownDetails details) {
      _tapPosition = details.globalPosition;
    }

    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;

    return Container(
      width: double.infinity,
      height: 80.0,
      decoration: BoxDecoration(
        color: Colors.brown,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: theme.secondaryVariant,
          onTap: onTap,
          onTapDown: _storePosition,
          onLongPress: () => {
            showMenu(
              color: theme.error,
              position: RelativeRect.fromRect(
                _tapPosition & Size(40, 40),
                Offset.zero & overlay.size,
              ),
              items: <PopupMenuEntry>[
                PopupMenuItem(
                  onTap: onDelete,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.delete),
                      Text("Delete"),
                    ],
                  ),
                ),
              ],
              context: context,
            ),
          },
          child: Row(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      // height: 60.0,
                      // width: 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Image.asset(
                          'assets/fruits/${fightData['player']['type']}.png'),
                    ),
                  ),
                  Text(
                    fightData['player']['name'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  child: Text(
                    fightData['winner']
                        ? 'Winner: ${fightData['player']['name']}'
                        : 'Winner: ${fightData['ennemie']['name']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: fightData['winner'] ? theme.primary : theme.error,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Expanded(
                    child: Container(
                      // height: 60.0,
                      // width: 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Image.asset(
                          'assets/vegetables/${fightData['ennemie']['type']}.png'),
                    ),
                  ),
                  Text(
                    fightData['ennemie']['name'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class EmptyFightCard extends HookWidget {
//   const EmptyFightCard({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       width: double.infinity,
//       height: 80.0,
//       decoration: BoxDecoration(
//         color: Colors.brown,
//       ),
//       child: Text(
//         'Not created yet',
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 16.0,
//         ),
//       ),
//     );
//   }
// }

