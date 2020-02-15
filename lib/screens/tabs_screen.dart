import 'package:flutter/material.dart';

import '../screens/homepage_screen.dart';
import '../screens/events_screen.dart';
import '../screens/favorites_screen.dart';
import '../screens/settings_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {'page': HomepageScreen(), 'title': 'Etkinliyoruz'},
    {
      'page': WillPopScope(child: EventsScreen(), onWillPop: () {}),
      'title': 'Etkinlikler'
    },
    {
      'page': WillPopScope(child: FavoritesScreen(), onWillPop: () {}),
      'title': 'Favoriler'
    },
    // {
    //   'page': WillPopScope(child: SettingsScreen(), onWillPop: () {}),
    //   'title': 'Ayarlar'
    // },
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(221, 221, 221, 1),
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _selectPage,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.limeAccent,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Homepage'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available),
            title: Text('Events'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorites'),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.settings),
          //   title: Text('Settings'),
          // )
        ],
      ),
    );
  }
}
