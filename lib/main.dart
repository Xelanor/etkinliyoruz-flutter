import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Etkinliyoruz',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Etkinliyoruz!'),
        ),
        body: Center(
          child: Text('Etkinliyoruz!!'),
        ),
      ),
    );
  }
}
