import 'package:flutter/material.dart';

import './search_dropdown_menu.dart';

class SearchFilterContainer extends StatelessWidget {
  final Function filterAndSetDropdown;

  final List<String> townList;
  final String townValue;

  final List<String> categoryList;
  final String categoryValue;

  SearchFilterContainer(
    this.filterAndSetDropdown,
    this.townList,
    this.townValue,
    this.categoryList,
    this.categoryValue,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SearchDropdownMenu(
          "Bir ilçe seçiniz...",
          "town",
          townList,
          townValue,
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
