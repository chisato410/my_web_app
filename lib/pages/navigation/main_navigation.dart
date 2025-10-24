// footer_nav.dart
import 'package:flutter/material.dart';
import '../../data/dummy_users.dart';
import '../home/home_page.dart';
import '../disaster/bosai_page.dart';
import '../mypage/mypage_page.dart';
import '../safety/safety_page.dart';
import '../points/points_home_page.dart';

class MainNavigation extends StatefulWidget {
  final User user;
  const MainNavigation({super.key, required this.user});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomePage(),
      const BosaiPage(),
      PointPage(),
      MyPage(user: widget.user),
      const SafetyCheckPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  BottomNavigationBarItem _navItem(
    String asset,
    String label,
    int index, {
    bool isPointTab = false,
  }) {
    final bool isSelected = _selectedIndex == index;

    final Color selectedColor = const Color(0xff0B3218);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: SizedBox(
        height: 120,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xff73A17C),
          selectedItemColor: const Color(0xff0B3218),
          unselectedItemColor: const Color(0xFF5C3B28),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            _navItem("assets/icons/home.png", "ホーム", 0),
            _navItem("assets/icons/disaster.png", "防災", 1),
            _navItem("assets/icons/point.png", "ポイ活", 2, isPointTab: true),
            _navItem("assets/icons/mypage.png", "マイページ", 3),
            _navItem("assets/icons/alert.png", "安否確認", 4),
          ],
        ),
      ),
    );
  }
}
