// home_page.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/news.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _quizAvailable = true;

  @override
  void initState() {
    super.initState();
    _checkQuizStatus();
  }

  Future<void> _checkQuizStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final lastPlayed = prefs.getString('lastQuizDate');
    final today = DateTime.now().toIso8601String().substring(0, 10);
    setState(() {
      _quizAvailable = lastPlayed != today;
    });
  }

  Future<void> _markQuizPlayed() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10);
    await prefs.setString('lastQuizDate', today);
    setState(() => _quizAvailable = false);
  }

  void _handleQuizTap(BuildContext context) {
    if (_quizAvailable) {
      _markQuizPlayed();
      Navigator.pushNamed(context, '/quiz');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('クイズは1日1回だよ！また明日挑戦してね！'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeContent(
        quizAvailable: _quizAvailable,
        onQuizTap: () => _handleQuizTap(context),
      ),
    );
  }
}

/// ホーム画面の中身
class _HomeContent extends StatelessWidget {
  final bool quizAvailable;
  final VoidCallback onQuizTap;

  const _HomeContent({required this.quizAvailable, required this.onQuizTap});

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

            // おしらせ
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

            // ニュースリスト
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
                          body: const Center(child: Text('ニュース詳細ページをここに作成')),
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
                onPressed: () => Navigator.pushNamed(context, '/news-list'),
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

            // クイズカード（1日1回制限）
            FunctionCard(
              imagePath: "assets/images/quiz.png",
              width: 450,
              height: 90,
              isDisabled: !quizAvailable,
              onTap: onQuizTap,
            ),
            const SizedBox(height: 20),

            // 機能カード群
            Wrap(
              spacing: 50,
              runSpacing: 15,
              children: [
                FunctionCard(
                  imagePath: "assets/images/card1.png",
                  onTap: () => Navigator.pushNamed(context, '/bosai'),
                ),
                FunctionCard(
                  imagePath: "assets/images/card2.png",
                  onTap: () => Navigator.pushNamed(context, '/bichiku'),
                ),
                FunctionCard(
                  imagePath: "assets/images/card3.png",
                  onTap: () => Navigator.pushNamed(context, '/ranking'),
                ),
                FunctionCard(
                  imagePath: "assets/images/card4.png",
                  onTap: () => Navigator.pushNamed(context, '/mypage'),
                ),
                FunctionCard(
                  imagePath: "assets/images/card5.png",
                  onTap: () => Navigator.pushNamed(context, '/map'),
                ),
                FunctionCard(
                  imagePath: "assets/images/card6.png",
                  onTap: () => Navigator.pushNamed(context, '/info'),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

/// 共通 FunctionCard
class FunctionCard extends StatefulWidget {
  final String imagePath;
  final double width;
  final double height;
  final VoidCallback? onTap;
  final bool isDisabled;

  const FunctionCard({
    super.key,
    required this.imagePath,
    this.width = 180,
    this.height = 110,
    this.onTap,
    this.isDisabled = false,
  });

  @override
  State<FunctionCard> createState() => _FunctionCardState();
}

class _FunctionCardState extends State<FunctionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final opacity = widget.isDisabled ? 0.5 : 1.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.isDisabled ? widget.onTap : widget.onTap,
        child: AnimatedScale(
          scale: _isHovered && !widget.isDisabled ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: Opacity(
            opacity: opacity,
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
        ),
      ),
    );
  }
}
