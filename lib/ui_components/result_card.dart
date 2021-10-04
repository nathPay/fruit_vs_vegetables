import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fruit_vs_vegetable_afk/ui_components/action_button.dart';

// Interface for displaying end of combat informations
class ResultCard extends StatelessWidget {
  const ResultCard({
    Key? key,
    required this.isWin,
    required this.oldRank,
    required this.newRank,
    required this.onTap,
  }) : super(key: key);

  final bool isWin;
  final int oldRank;
  final int newRank;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 160),
          decoration: BoxDecoration(
            color: theme.background,
            borderRadius: BorderRadius.circular(32.0),
            boxShadow: [
              BoxShadow(
                spreadRadius: 5.0,
                blurRadius: 40.0,
              ),
            ],
          ),
          child: Column(
            children: [
              Image.asset(
                isWin ? 'assets/youWin.png' : 'assets/youLoose.png',
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    isWin && (oldRank == 10)
                        ? 'You stay at rank 10 but earn 1 skillpoint!'
                        : isWin && (oldRank < 10)
                            ? 'You passed rank $newRank and earn 1 skillpoint!'
                            : !isWin && (oldRank == 0)
                                ? 'You cannot be less than rank 0...'
                                : 'Welcome back to rank $newRank...',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: theme.onSecondary,
                    ),
                  ),
                ),
              ),
              Container(
                height: 64.0,
                alignment: Alignment.center,
                child: ActionButton(
                  label: 'continue',
                  onTap: onTap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
