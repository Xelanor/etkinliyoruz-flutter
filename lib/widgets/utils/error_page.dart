import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String title;

  ErrorPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 15),
        Icon(
          Icons.error_outline,
          size: 60,
          color: Theme.of(context).primaryColor,
        )
      ],
    );
  }
}
