import 'package:flutter/material.dart';

// Delete button (ex: used to delete character)
class DeleteOption extends StatelessWidget {
  const DeleteOption({
    Key? key,
    required this.onDelete,
  }) : super(key: key);

  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onDelete,
      child: Text('Delete'),
    );
  }
}
