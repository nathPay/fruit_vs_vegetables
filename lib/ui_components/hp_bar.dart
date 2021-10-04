import 'package:flutter/material.dart';

// Display HP informations of fighter during combat 
class HpBar extends StatelessWidget {
  const HpBar({
    Key? key,
    required this.characterName,
    required this.maxHp,
    required this.currentHp,
    this.rotation = 0.3,
  }) : super(key: key);

  final String characterName;
  final double maxHp;
  final int currentHp;
  final double rotation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Transform(
      transform: Matrix4.skewX(rotation),
      child: Container(
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: [
            BoxShadow(
              spreadRadius: 1.0,
              blurRadius: 1.0,
              offset: Offset.fromDirection(1.2),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Transform(
                transform: Matrix4.skewX(-rotation),
                child: Text(
                  characterName,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: theme.onPrimary,
                  ),
                  textAlign: rotation <= 0.0 ? TextAlign.right : TextAlign.left,
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: rotation <= 0.0
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        '${currentHp.toInt() <= 0 ? 0 : currentHp.toInt()} / ${maxHp.toInt()}',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: theme.onPrimary,
                        ),
                      ),
                    ),
                    LinearProgressIndicator(
                      minHeight: 10.0,
                      value: currentHp / maxHp,
                      color: currentHp / maxHp >= 0.5
                          ? Colors.green
                          : currentHp / maxHp < 0.25
                              ? Colors.red
                              : Colors.orange,
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
