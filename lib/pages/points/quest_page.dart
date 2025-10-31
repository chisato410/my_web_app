// lib/pages/points/quest_page.dart
import 'package:flutter/material.dart';

class QuestPage extends StatefulWidget {
  final String title;
  final int point;

  const QuestPage({super.key, required this.title, required this.point});

  @override
  State<QuestPage> createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ミッション挑戦'),
        backgroundColor: const Color(0xFFD99C63),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('このミッションを達成すると +${widget.point} pt 獲得できます。'),
            const SizedBox(height: 40),
            if (!isCompleted)
              Center(
                child: ElevatedButton(
                  onPressed: () => _showCompleteDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade200,
                    minimumSize: const Size(160, 44),
                  ),
                  child: const Text('挑戦する'),
                ),
              )
            else
              const Center(
                child: Column(
                  children: [
                    Icon(Icons.check_circle, color: Colors.grey, size: 40),
                    SizedBox(height: 8),
                    Text('完了済み', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            const Spacer(),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context, isCompleted),
                child: const Text(
                  '一覧に戻る',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCompleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('挑戦完了！'),
        content: Text('「${widget.title}」を達成しました！\n+${widget.point} pt 獲得！'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              setState(() => isCompleted = true);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
