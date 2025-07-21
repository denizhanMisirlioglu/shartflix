import 'package:flutter/material.dart';
import 'package:shartflix/presentation/pages/profile_page.dart';
import 'package:shartflix/presentation/widgets/custom_bottom_nav_bar.dart';

import 'package:shartflix/presentation/pages/home_page.dart';

class MainNavigationPage extends StatefulWidget {
  final String token;
  const MainNavigationPage({super.key, required this.token});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTap(int index) {
    setState(() => _currentIndex = index);
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomePage(token: widget.token),
          ProfilePage(token: widget.token),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar( // ✅ güncellendi
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
