import 'package:flutter/gestures.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

// Button that display some information about character
class CharacterCard extends HookWidget {
  const CharacterCard({
    Key? key,
    required this.onDelete,
    required this.onTap,
    required this.name,
    required this.rank,
    required this.type,
  }) : super(key: key);

  final void Function() onDelete;
  final void Function() onTap;
  final String name;
  final int rank;
  final int type;

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
              // position: RelativeRect.fromLTRB(localOffset.dx, localOffset.dx, localOffset.dy, localOffset.dy),
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
              Container(
                height: 70.0,
                width: 70.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Image.asset('assets/fruits/$type.png'),
              ),
              Expanded(
                child: Container(),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Text(
                  'Rank: $rank',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
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

class EmptyCharaterCard extends HookWidget {
  const EmptyCharaterCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 80.0,
      decoration: BoxDecoration(
        color: Colors.brown,
      ),
      child: Text(
        'Not created yet',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
