import 'package:flutter/material.dart';

import '../../screens/search_screen.dart';

class HomepageCategorySearch extends StatefulWidget {
  final double vertical;

  HomepageCategorySearch(this.vertical);

  @override
  _HomepageCategorySearchState createState() => _HomepageCategorySearchState();
}

class _HomepageCategorySearchState extends State<HomepageCategorySearch> {
  final searchTextInputContoller = TextEditingController();
  String dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: widget.vertical),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Card(
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, right: 3),
                child: Icon(
                  Icons.category,
                  color: Theme.of(context).primaryColor,
                  size: 25,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 90,
                padding: EdgeInsets.all(10),
                child: DropdownButton<String>(
                  icon: Icon(Icons.keyboard_arrow_down),
                  iconSize: 28,
                  underline: Container(height: 0),
                  isExpanded: true,
                  isDense: true,
                  onChanged: (String newValue) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            SearchScreen(newValue, 'category'),
                      ),
                    );
                  },
                  hint: Text('Kategori seçin...'),
                  items: <Map>[
                    {"text": 'Atölye & Eğitim', "value": "Atölye"},
                    {"text": 'Tiyatro & Film', "value": "Tiyatro"},
                    {"text": 'AVM Etkinlikleri', "value": "Eğlence Merkezi"},
                    {"text": 'Müzikal & Konser', "value": "Müzikal/Gösteri"}
                  ].map<DropdownMenuItem<String>>((Map item) {
                    return DropdownMenuItem(
                      value: item['value'],
                      child: Text(item['text']),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
