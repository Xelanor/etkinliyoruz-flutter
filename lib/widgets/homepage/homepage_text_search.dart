import 'package:flutter/material.dart';

import '../../screens/search_screen.dart';

class HomepageTextSearch extends StatefulWidget {
  final double vertical;

  HomepageTextSearch(this.vertical);

  @override
  _HomepageTextSearchState createState() => _HomepageTextSearchState();
}

class _HomepageTextSearchState extends State<HomepageTextSearch> {
  String searchTextInput;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: widget.vertical),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Card(
          child: Container(
            child: TextField(
              autofocus: false,
              onChanged: (value) => searchTextInput = value,
              decoration: InputDecoration(
                prefixIcon: Container(
                  child: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    if (searchTextInput != null && searchTextInput != '') {
                      Navigator.of(context).pushNamed(SearchScreen.routeName,
                          arguments: searchTextInput);
                    }
                  },
                  child: Container(
                    width: 70,
                    alignment: Alignment.center,
                    height: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.bottomRight,
                            colors: [
                          Colors.yellow[100],
                          Colors.blue[200],
                        ])),
                    child: Text('Ara'),
                  ),
                ),
                hintText: 'Etkinlik arayın...',
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
