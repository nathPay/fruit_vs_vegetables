import 'package:flutter/gestures.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

// Personnal adaptation of IconButton widget
class MyIconButton extends HookWidget {
  const MyIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
    this.size = 32.0,
  }) : super(key: key);

  final IconData icon;
  final void Function() onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: theme.secondary,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 1.0,
            spreadRadius: 0.1,
            offset: Offset.fromDirection(1.5, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
        child: IconButton(
          color: theme.onSecondary,
          splashColor: Colors.brown[300],
          icon: Icon(
            icon,
            size: size,
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}
