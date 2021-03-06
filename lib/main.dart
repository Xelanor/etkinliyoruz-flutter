import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/tabs_screen.dart';
import './screens/homepage_screen.dart';
import './screens/events_screen.dart';
import './screens/favorites_screen.dart';
import './screens/settings_screen.dart';

import './providers/events.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Events(),
        ),
      ],
      child: MaterialApp(
        title: 'Etkinliyoruz',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(232, 90, 96, 1),
        ),
        // home: HomepageScreen(),
        initialRoute: '/',
        routes: {
          '/': (ctx) => TabsScreen(),
          HomepageScreen.routeName: (ctx) => HomepageScreen(),
          EventsScreen.routeName: (ctx) => EventsScreen(),
          FavoritesScreen.routeName: (ctx) => FavoritesScreen(),
          SettingsScreen.routeName: (ctx) => SettingsScreen(),
        },
      ),
    );
  }
}
