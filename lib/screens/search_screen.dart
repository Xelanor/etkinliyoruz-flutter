import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/events.dart';
import '../widgets/search/search_card.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search-screen';

  @override
  Widget build(BuildContext context) {
    final searchQuery = ModalRoute.of(context).settings.arguments as String;
    final List loadedProducts =
        Provider.of<Events>(context, listen: false).searchByText(searchQuery);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: loadedProducts.length,
          itemBuilder: (_, i) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SearchCard(loadedProducts[i]),
            ],
          ),
        ),
      ),
    );
  }
}
