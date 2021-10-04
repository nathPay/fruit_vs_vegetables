import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum ActionButtonState { POSITIVE, NEUTRAL, DISABLED, NEGATIVE }

// Personnal implementation of ElevatedButton
class ActionButton extends HookWidget {
  const ActionButton(
      {Key? key,
      required this.onTap,
      required this.label,
      this.disabled = false,
      this.state = ActionButtonState.POSITIVE,
      this.width = 300.0,
      this.height = 52.0})
      : super(key: key);

  final void Function()? onTap;
  final String label;
  final bool disabled;
  final ActionButtonState state;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    var textColor = state == ActionButtonState.POSITIVE
        ? theme.onPrimary
        : state == ActionButtonState.DISABLED
            ? theme.onBackground
            : theme.onError;
    final text = Text(
      label.toUpperCase(),
      maxLines: 1,
      style: TextStyle(
        color: textColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );

    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: state == ActionButtonState.POSITIVE
              ? theme.primary
              : state == ActionButtonState.NEGATIVE
                  ? theme.error
                  : state == ActionButtonState.NEUTRAL
                      ? theme.secondary
                      : theme.secondaryVariant,
        ),
        onPressed: disabled || state == ActionButtonState.DISABLED ? null : onTap,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Center(
            child: text,
          ),
        ),
      ),
    );
  }
}
