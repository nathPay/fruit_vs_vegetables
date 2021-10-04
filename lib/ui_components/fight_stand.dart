import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Display the character in "3D"
class FightStand extends HookWidget {
  const FightStand({
    Key? key,
    required this.type,
    required this.team,
  }) : super(key: key);

  final int type;
  final String team;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0)
            ..rotateX(1.1)
            ..rotateY(0.0),
          alignment: FractionalOffset.bottomCenter,
          child: Container(
            height: 160,
            width: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.brown,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5.0,
                  spreadRadius: 5.0,
                  offset: Offset.fromDirection(1.4, 10),
                ),
              ],
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(0, -40),
          child: Container(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0011) // perspective
              ..rotateX(team == 'fruits' ? -0.3 : 0.3)
              ..rotateY(0.6),
            transformAlignment: Alignment.center,
            alignment: Alignment.center,
            child: Image.asset('assets/$team/$type.png'),
          ),
        ),
      ],
    );
  }
}
