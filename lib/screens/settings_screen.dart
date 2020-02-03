import 'package:flutter/material.dart';

import '../helpers/db_helper.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings-screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void didChangeDependencies() async {
    final dataList = await DBHelper.getFavorites('user_favorites');
    print(dataList.length);
    // DBHelper.deleteDB();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings'),
    );
  }
}
