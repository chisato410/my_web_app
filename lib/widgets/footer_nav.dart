import 'package:flutter/material.dart';
import '../data/dummy_users.dart'; // Userモデルのパスに合わせて
import '../pages/mypage/mypage_page.dart';
import '../pages/home/home_page.dart';
import '../pages/disaster/bosai_page.dart';
import '../pages/points/points_home_page.dart';
import '../pages/safety/safety_page.dart';

/// ✅ ログイン後に呼び出すためのエントリポイント
///     LoginPage からは `MainNavigation(user: user)` を呼び出します。
class MainNavigation extends StatelessWidget {
  final User user;
  const MainNavigation({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // FooterNav をラップするだけ
    return FooterNav(user: user);
  }
}

/// ✅ 実際にタブ切り替えを行うウィジェット
class FooterNav extends StatefulWidget {
  final User user; // ログインユーザー
  const FooterNav({super.key, required this.user});

  @override
  State<FooterNav> createState() => _FooterNavState();
}

class _FooterNavState extends State<FooterNav> {
  int _selectedIndex = 0;

  /// ← user を渡す必要があるので const は外して初期化時に代入
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomePage(),
      const BosaiPage(),
      const PointPage(),
      MyPage(user: widget.user), // ✅ マイページにログインユーザーを渡す
      const SafetyPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
          BottomNavigationBarItem(icon: Icon(Icons.warning), label: '防災'),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'ポイ活',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'マイページ'),
          BottomNavigationBarItem(icon: Icon(Icons.security), label: '安否確認'),
        ],
      ),
    );
  }
}
