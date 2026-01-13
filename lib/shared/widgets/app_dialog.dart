import 'package:flutter/material.dart';

class AppDialog {
  final String title;
  final String message;
  final VoidCallback? onConfirm;

  AppDialog({required this.title, required this.message, this.onConfirm});

  Future<T?> show<T>(BuildContext context) {
    return showDialog<T>(
      context: context,
      builder: (BuildContext context) {
        return _buildDialog(context);
      },
    );
  }

  Widget _buildDialog(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('キャンセル'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          onPressed: () {
            if (onConfirm != null) onConfirm!();
            Navigator.of(context).pop(true);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
