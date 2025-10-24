import 'package:flutter/material.dart';
import 'quest_page.dart'; // ← これを忘れずに追加！

class PointPage extends StatelessWidget {
  const PointPage({super.key});

  @override
  Widget build(BuildContext context) {
    int currentPoints = 300; // 仮データ

    return Scaffold(
      appBar: AppBar(
        title: const Text('防災ポイント'),
        backgroundColor: const Color(0xFFD99C63),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),

              // 説明カード
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF4E5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '防災ポイントとは\n\nアプリ内で防災に関する行動をするとポイントが貯まります。\n貯めたポイントは防災グッズと交換することができます。',
                  style: TextStyle(fontSize: 14, height: 1.6),
                ),
              ),
              const SizedBox(height: 24),

              // 現在ポイント
              Text(
                '$currentPoints pt',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '現在のポイント',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),

              // 防災グッズ交換ボタン
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/goods_exchange');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD99C63),
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  '防災グッズに交換',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(height: 32),

              // ミッション一覧
              Column(
                children: [
                  _buildMissionButton(context, '防災イベントに参加してみよう', 100),
                  _buildMissionButton(context, '1日1回 防災クイズに答えよう', 5),
                  _buildMissionButton(context, '備蓄チェックリストを確認', 10),
                  _buildMissionButton(context, '避難場所を調べてみよう', 100),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ミッションボタン共通UI
  Widget _buildMissionButton(BuildContext context, String title, int point) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton(
        onPressed: () {
          // ✅ ミッション押下で挑戦画面へ
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuestPage(title: title, point: point),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.yellow.shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '+$point pt',
                style: const TextStyle(color: Colors.orange),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
