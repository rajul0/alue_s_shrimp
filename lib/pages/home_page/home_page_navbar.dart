import 'package:alues_shrimp_app/pages/feed_control_page/feed_control_page.dart';
import 'package:alues_shrimp_app/pages/home_page/home_page.dart';
import 'package:alues_shrimp_app/pages/profile_page.dart';
import 'package:alues_shrimp_app/pages/water_quality_page.dart';
import 'package:flutter/material.dart';

class HomePageNav extends StatefulWidget {
  @override
  _HomePageNavState createState() => _HomePageNavState();
}

class _HomePageNavState extends State<HomePageNav> {
  int _selectedIndex = 0;

  final List<String> _pngIcon = [
    'assets/icons/home_ic.png',
    'assets/icons/feed_control_ic.png',
    'assets/icons/quality_water_ic.png',
    'assets/icons/profile_ic.png',
  ];

  final List<Widget> _widgetOptions = [
    HomePage(),
    FeedControlPage(),
    WaterQualityPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Image(
                image: _selectedIndex ==
                        _pngIcon.indexOf('assets/icons/home_ic.png')
                    ? AssetImage(
                        'assets/icons/home_select_ic.png',
                      )
                    : AssetImage(
                        'assets/icons/home_ic.png',
                      ),
                width: 60,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Image(
                image: _selectedIndex ==
                        _pngIcon.indexOf('assets/icons/feed_control_ic.png')
                    ? AssetImage(
                        'assets/icons/feed_control_select_ic.png',
                      )
                    : AssetImage(
                        'assets/icons/feed_control_ic.png',
                      ),
                width: 60,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Image(
                image: _selectedIndex ==
                        _pngIcon.indexOf('assets/icons/quality_water_ic.png')
                    ? AssetImage(
                        'assets/icons/quality_water_select_ic.png',
                      )
                    : AssetImage(
                        'assets/icons/quality_water_ic.png',
                      ),
                width: 60,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Image(
                image: _selectedIndex ==
                        _pngIcon.indexOf('assets/icons/profile_ic.png')
                    ? AssetImage(
                        'assets/icons/profile_select_ic.png',
                      )
                    : AssetImage(
                        'assets/icons/profile_ic.png',
                      ),
                width: 60,
              ),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
