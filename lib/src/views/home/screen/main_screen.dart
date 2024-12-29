import 'package:flutter/material.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/core/constant/color_style.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/views/home/screen/home_screen.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/views/home/screen/profle_screen.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/views/home/screen/top_up_screen.dart';
import 'package:sims_ppob_thiyara_al_mawaddah/src/views/home/screen/transaction_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const TopUpScreen(),
    const TransactionScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: ColorStyle.neutral100,
              width: 1.0,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.white,
          selectedItemColor: ColorStyle.brand800,
          unselectedItemColor: ColorStyle.neutral600,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _currentIndex == 0
                      ? ColorStyle.brand800
                      : ColorStyle.neutral600,
                  BlendMode.srcIn,
                ),
                child: Icon(Icons.home),
              ),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _currentIndex == 1
                      ? ColorStyle.brand800
                      : ColorStyle.neutral600,
                  BlendMode.srcIn,
                ),
                child: Icon(
                  Icons.money,
                ),
              ),
              label: 'Top Up',
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _currentIndex == 2
                      ? ColorStyle.brand800
                      : ColorStyle.neutral600,
                  BlendMode.srcIn,
                ),
                child: Icon(Icons.history),
              ),
              label: 'Transaction',
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _currentIndex == 3
                      ? ColorStyle.brand800
                      : ColorStyle.neutral600,
                  BlendMode.srcIn,
                ),
                child: Icon(Icons.person),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
