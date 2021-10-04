import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter/material.dart';

// Display the Historic of a combat
class HistoricDisplay extends HookWidget {
  const HistoricDisplay({
    Key? key,
    required this.historic,
  }) : super(key: key);

  final List<Map<String, dynamic>> historic;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
        color: Colors.brown,
      ),
      child: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          child: Column(
            children: historic
                .map(
                  (e) => Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Text(
                      '${e['name']}: ${e['text']}',
                      style: TextStyle(
                        color: e['player'] ? theme.primary : theme.error,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
