import 'package:flutter/material.dart';

class SearchDropdownMenu extends StatelessWidget {
  final String hintText;
  final String filterType;

  final List<String> itemList;
  final String itemValue;
  final Function filterAndSetDropdown;

  SearchDropdownMenu(
    this.hintText,
    this.filterType,
    this.itemList,
    this.itemValue,
    this.filterAndSetDropdown,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 40,
      width: (MediaQuery.of(context).size.width - 30) / 2,
      color: Colors.white,
      child: DropdownButton<String>(
        hint: Text(hintText),
        underline: Container(height: 0),
        iconSize: 30,
        iconEnabledColor: Theme.of(context).primaryColor,
        value: itemValue,
        items: itemList.map<DropdownMenuItem<String>>((String place) {
          return DropdownMenuItem(
            value: place,
            child: Text(place),
          );
        }).toList(),
        onChanged: (value) {
          filterAndSetDropdown(value, filterType);
        },
        isExpanded: true,
      ),
    );
  }
}
