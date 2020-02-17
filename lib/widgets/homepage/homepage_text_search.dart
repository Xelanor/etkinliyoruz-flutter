import 'package:flutter/material.dart';

import '../../screens/search_screen.dart';

class HomepageTextSearch extends StatefulWidget {
  final double vertical;

  HomepageTextSearch(this.vertical);

  @override
  _HomepageTextSearchState createState() => _HomepageTextSearchState();
}

class _HomepageTextSearchState extends State<HomepageTextSearch> {
  final searchTextInputContoller = TextEditingController();

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
              onSubmitted: (_) {
                if (searchTextInputContoller.text != null &&
                    searchTextInputContoller.text != '') {
                  var searchText = searchTextInputContoller.text;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(searchText, 'text'),
                    ),
                  );
                  setState(() {
                    // searchTextInputContoller.text = "";
                  });
                }
              },
              textAlignVertical: TextAlignVertical.center,
              autofocus: false,
              controller: searchTextInputContoller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 9),
                prefixIcon: Container(
                  child: Icon(
                    Icons.search,
                    color: Theme.of(context).primaryColor,
                    size: 25,
                  ),
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    if (searchTextInputContoller.text != null &&
                        searchTextInputContoller.text != '') {
                      var searchText = searchTextInputContoller.text;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              SearchScreen(searchText, 'text'),
                        ),
                      );
                      setState(() {
                        // searchTextInputContoller.text = "";
                      });
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
