import 'package:flutter/material.dart';

import '../../screens/search_screen.dart';

class HomepageDistrictSearch extends StatefulWidget {
  final double vertical;

  HomepageDistrictSearch(this.vertical);

  @override
  _HomepageDistrictSearchState createState() => _HomepageDistrictSearchState();
}

class _HomepageDistrictSearchState extends State<HomepageDistrictSearch> {
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
                  Icons.location_city,
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
                        builder: (context) => SearchScreen(newValue, 'town'),
                      ),
                    );
                  },
                  hint: Text('İlçe Seçin...'),
                  items: <String>[
                    'Ataşehir',
                    'Bahçelievler',
                    'Bakırköy',
                    'Başakşehir',
                    'Beyoğlu',
                    'Beşiktaş',
                    'Esenyurt',
                    'Kadıköy',
                    'Konak',
                    'Maltepe',
                    'Nilüfer',
                    'Sancaktepe',
                    'Sarıyer',
                    'Yenimahalle',
                    'Çankaya',
                    'Üsküdar',
                    'İnegöl',
                    'Şişli',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
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
