import 'package:flutter/material.dart';

// 各ページのインポート
import '../disaster/download/download_page.dart';
import '../disaster/supplies/supply_list_page.dart';
import '../disaster/manuals/manual_list_page.dart';
import '../points/points_home_page.dart';
import '../disaster/quiz/quiz_page.dart';
import '../../models/news.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    _HomeContent(), // ホーム
    ManualPage(), // 防災
    PointPage(), // ポイ活
    Placeholder(), // マイページ（仮）
    Placeholder(), // 安否通知（仮）
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      // ボトムナビゲーションバー
      bottomNavigationBar: SizedBox(
        height: 120,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xff73A17C),
          selectedItemColor: const Color(0xff0B3218),
          unselectedItemColor: const Color(0xFF5C3B28),
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          items: [
            _navItem("assets/icons/home.png", "ホーム", 0),
            _navItem("assets/icons/disaster.png", "防災", 1),
            _navItem("assets/icons/point.png", "ポイ活", 2, isPointTab: true),
            _navItem("assets/icons/mypage.png", "マイページ", 3),
            _navItem("assets/icons/alert.png", "安否通知", 4),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _navItem(
    String asset,
    String label,
    int index, {
    bool isPointTab = false,
  }) {
    final bool isSelected = _selectedIndex == index;

    final Color selectedColor = isPointTab
        ? const Color(0xff0B3218)
        : const Color(0xff0B3218);
    final Color unselectedColor = isPointTab
        ? const Color(0xffF5AC69)
        : const Color(0xFF5C3B28);

    return BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(top: isPointTab ? 0 : 6),
        child: SizedBox(
          height: isPointTab ? 58 : 28,
          width: isPointTab ? 58 : 28,
          child: Image.asset(
            asset,
            fit: BoxFit.contain,
            color: isSelected ? selectedColor : unselectedColor,
          ),
        ),
      ),
      label: label,
    );
  }
}

/// ホーム画面の中身
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

            // お知らせ
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
              children: mockNews
                  .map(
                    (news) => ListTile(
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
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 8),

            // もっと見るボタン
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NewsListPage()),
                  );
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
              destinationPage: QuizPage(),
              width: 450,
              height: 90,
            ),
            const SizedBox(height: 20),

            // 機能カード群
            Wrap(
              spacing: 50,
              runSpacing: 15,
              children: const [
                FunctionCard(
                  imagePath: "assets/images/card1.png",
                  destinationPage: DownloadPage(),
                ),
                FunctionCard(
                  imagePath: "assets/images/card2.png",
                  destinationPage: CheckListPage(listId: null),
                ),
                FunctionCard(
                  imagePath: "assets/images/card3.png",
                  destinationPage: ManualPage(),
                ),
                FunctionCard(
                  imagePath: "assets/images/card4.png",
                  destinationPage: PointPage(),
                ),
                FunctionCard(
                  imagePath: "assets/images/card5.png",
                  destinationPage: PointPage(),
                ),
                FunctionCard(
                  imagePath: "assets/images/card6.png",
                  destinationPage: PointPage(),
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

/// カードウィジェット
class FunctionCard extends StatefulWidget {
  final String imagePath;
  final Widget destinationPage;
  final double width;
  final double height;

  const FunctionCard({
    super.key,
    required this.imagePath,
    required this.destinationPage,
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
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => widget.destinationPage),
          );
        },
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
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 4,
                  spreadRadius: 1,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ニュース一覧ページ
class NewsListPage extends StatelessWidget {
  const NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ニュース一覧')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockNews.length,
        itemBuilder: (context, index) {
          final news = mockNews[index];
          return ListTile(
            title: Text(news.title),
            subtitle: Text(news.date),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
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
        },
      ),
    );
  }
}
