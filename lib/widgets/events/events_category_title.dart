import 'package:flutter/material.dart';

class EventsCategoryTitle extends StatelessWidget {
  final String categoryName;
  final icon;

  EventsCategoryTitle(this.categoryName, this.icon);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        icon is IconData
            ? Icon(
                icon,
                color: Theme.of(context).primaryColor,
                size: 28,
              )
            : Image.asset(
                icon,
                fit: BoxFit.cover,
                width: 32,
                height: 32,
              ),
        Padding(padding: EdgeInsets.only(left: 10.0)),
        Text(
          categoryName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(
          Icons.chevron_left,
          color: Theme.of(context).primaryColor,
          size: 28,
        ),
        Icon(
          Icons.chevron_right,
          color: Theme.of(context).primaryColor,
          size: 28,
        ),
      ],
    );
  }
}
