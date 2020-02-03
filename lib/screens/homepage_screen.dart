import 'package:flutter/material.dart';

import '../widgets/homepage/homepage_card.dart';
import '../widgets/homepage/homepage_text_search.dart';
import '../widgets/homepage/homepage_category_search.dart';
import '../widgets/homepage/homepage_district_search.dart';

class HomepageScreen extends StatelessWidget {
  static const routeName = '/homepage-screen';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (_) {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 450,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    alignment: AlignmentDirectional.topCenter,
                    child: Image.asset('assets/homepage-bg.png',
                        fit: BoxFit.contain),
                  ),
                  HomepageTextSearch(120),
                  HomepageCategorySearch(60),
                  HomepageDistrictSearch(0),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                HomepageCard(
                  'assets/education-logo.png',
                  'Atölye & Eğitim',
                  '17 Etkinlik',
                ),
                HomepageCard(
                  'assets/movie-logo.png',
                  'Tiyatro & Film',
                  '26 Etkinlik',
                ),
                HomepageCard(
                  'assets/avm-logo.png',
                  'AVM Etkinlikleri',
                  '12 Etkinlik',
                ),
                HomepageCard(
                  'assets/concert-logo.png',
                  'Konser & Müzikal',
                  '9 Etkinlik',
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
