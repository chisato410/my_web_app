import 'package:flutter/material.dart';
import '../../models/news.dart';

/// ホーム画面本体
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _HomeContent());
  }
}

/// ホーム画面の中身（既存UI復元）
class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Image.asset('assets/images/name.png', height: 40),
            const SizedBox(height: 20),

            // おしらせ見出し
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/notice.png',
                    height: 24,
                    width: 24,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "おしらせ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // ニュースリスト（モックデータ3件程度表示）
            Column(
              children: mockNews.take(3).map((news) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    news.title,
                    style: const TextStyle(
                      color: Color(0xff4880C0),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    news.date,
                    style: const TextStyle(
                      color: Color(0xff4880C0),
                      fontSize: 12,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Color(0xff4880C0),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Scaffold(
                          appBar: AppBar(title: Text(news.title)),
                          body: Center(child: Text('ニュース詳細ページをここに作成')),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 8),

            // もっと見る
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/news-list');
                  // → 次に渡す news_list_page.dart で解決
                },
                child: const Text(
                  'もっと見る',
                  style: TextStyle(
                    color: Color(0xff4880C0),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // クイズカード
            const FunctionCard(
              imagePath: "assets/images/quiz.png",
              width: 450,
              height: 90,
            ),
            const SizedBox(height: 20),

            // 機能カード群
            Wrap(
              spacing: 50,
              runSpacing: 15,
              children: const [
                FunctionCard(imagePath: "assets/images/card1.png"),
                FunctionCard(imagePath: "assets/images/card2.png"),
                FunctionCard(imagePath: "assets/images/card3.png"),
                FunctionCard(imagePath: "assets/images/card4.png"),
                FunctionCard(imagePath: "assets/images/card5.png"),
                FunctionCard(imagePath: "assets/images/card6.png"),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

/// 共通 FunctionCard（hover対応）
class FunctionCard extends StatefulWidget {
  final String imagePath;
  final double width;
  final double height;

  const FunctionCard({
    super.key,
    required this.imagePath,
    this.width = 180,
    this.height = 110,
  });

  @override
  State<FunctionCard> createState() => _FunctionCardState();
}

class _FunctionCardState extends State<FunctionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(widget.imagePath),
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withValues(alpha: 0.15),
                blurRadius: 4,
                spreadRadius: 1,
                offset: const Offset(2, 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
