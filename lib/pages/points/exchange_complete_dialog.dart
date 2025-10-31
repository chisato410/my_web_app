// lib/pages/points/exchange_complete_dialog.dart
import 'package:flutter/material.dart';

Future<void> showExchangeCompleteDialog(
  BuildContext context,
  String itemName,
) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Color(0xFFD99C63), size: 60),
            const SizedBox(height: 12),
            const Text(
              '交換完了！',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text('「$itemName」を交換しました。', textAlign: TextAlign.center),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
