import 'package:flutter/material.dart';

// 各ページのインポート（存在しない場合は仮ページを作ってください）
import '../disaster/download/download_page.dart';
import '../disaster/supplies/supply_list_page.dart';
import '../disaster/manuals/manual_list_page.dart';
import '../points/points_home_page.dart';
import '../disaster/quiz/quiz_page.dart';
import '../../models/news.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // タイトル
              const Text(
                "そなポイ",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // お知らせセクション
              const Text(
                "おしらせ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Column(
                children: mockNews
                    .map(
                      (news) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(news.title),
                        subtitle: Text(news.date),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          // 詳細ページに飛ばすならここで Navigator.push
                        },
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),

              // クイズカード風
              GestureDetector(
                onTap: () {
                  // クイズページに遷移（必要ならQuizPageを作成）
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const QuizPage()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.quiz, color: Colors.orange),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "1日1問 防災クイズに挑戦！",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // グリッドボタン風
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildFunctionCard(
                    context,
                    Icons.download,
                    "ダウンロード\nリスト",
                    const DownloadPage(),
                  ),
                  _buildFunctionCard(
                    context,
                    Icons.checklist,
                    "備蓄品\nチェックリスト",
                    const ChecklistPage(),
                  ),
                  _buildFunctionCard(
                    context,
                    Icons.menu_book,
                    "防災\nマニュアル",
                    const ManualPage(),
                  ),
                  _buildFunctionCard(
                    context,
                    Icons.local_activity,
                    "防災\nポイ活",
                    const PointPage(),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 ニュース項目のウィジェット

  // 🔹 機能ボタンのカードウィジェット（遷移付き）
  Widget _buildFunctionCard(
    BuildContext context,
    IconData icon,
    String label,
    Widget destinationPage,
  ) {
    return SizedBox(
      width: 160,
      height: 80,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade100,
          foregroundColor: Colors.black87,
          padding: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => destinationPage),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
