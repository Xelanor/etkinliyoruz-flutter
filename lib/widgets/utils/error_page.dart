import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String title;

  ErrorPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          Image.asset(
            'assets/no-event.png',
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
    );
  }
}
