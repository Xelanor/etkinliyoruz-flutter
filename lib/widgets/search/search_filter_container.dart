import 'package:flutter/material.dart';

import './search_dropdown_menu.dart';

class SearchFilterContainer extends StatelessWidget {
  final Function filterAndSetDropdown;

  final List<String> placeList;
  final String placeValue;

  final List<String> categoryList;
  final String categoryValue;

  SearchFilterContainer(
    this.filterAndSetDropdown,
    this.placeList,
    this.placeValue,
    this.categoryList,
    this.categoryValue,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SearchDropdownMenu(
          "Bir mekan seçiniz...",
          "place",
          placeList,
          placeValue,
          filterAndSetDropdown,
        ),
        SearchDropdownMenu(
          "Bir kategori seçiniz...",
          "category",
          categoryList,
          categoryValue,
          filterAndSetDropdown,
        ),
      ],
    );
  }
}
