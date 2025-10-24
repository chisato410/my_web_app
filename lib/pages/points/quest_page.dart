import 'package:flutter/material.dart';

class QuestPage extends StatelessWidget {
  final String title;
  final int point;

  const QuestPage({super.key, required this.title, required this.point});

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
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'このミッションを達成すると +$point pt 獲得できます。',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 40),

            // 挑戦ボタン
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // contextの描画が安定してからダイアログを出す
                  Future.delayed(Duration.zero, () {
                    _showCompleteDialog(context);
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade200,
                  minimumSize: const Size(160, 44),
                ),
                child: const Text('挑戦する'),
              ),
            ),

            const Spacer(),

            // 一覧に戻るボタン
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
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

  // 完了ポップアップ
  void _showCompleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            '挑戦完了！',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text('「$title」を達成しました！\n+$point pt 獲得！'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext); // ダイアログを閉じる
                Navigator.pop(context); // 一覧に戻る
              },
              child: const Text('一覧に戻る'),
            ),
          ],
        );
      },
    );
  }
}
