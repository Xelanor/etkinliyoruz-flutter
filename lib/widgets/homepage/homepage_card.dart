import 'package:flutter/material.dart';

import '../../screens/search_screen.dart';

class HomepageCard extends StatelessWidget {
  final String logo;
  final String title;
  final String subtitle;
  final String searchQuery;

  HomepageCard(this.logo, this.title, this.subtitle, this.searchQuery);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SearchScreen(searchQuery, 'category'),
            ),
          );
        },
        child: Container(
          height: 120,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Image.asset(logo, fit: BoxFit.cover),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
