import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:http/http.dart' as http;

import '../widgets/homepage/homepage_card.dart';
import '../widgets/homepage/homepage_text_search.dart';
import '../widgets/homepage/homepage_category_search.dart';
import '../widgets/homepage/homepage_district_search.dart';

class HomepageScreen extends StatefulWidget {
  static const routeName = '/homepage-screen';

  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  var _isInit = true;
  var _isLoading = false;
  var _eventCounts = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void getMyStocks() {
    const url = 'http://34.67.211.44/api/events/multiple/count';
    setState(() {
      _isLoading = true;
    });
    http.get(url).then(
      (response) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        setState(() {
          _isLoading = false;
          _eventCounts = extractedData;
        });
      },
    ).catchError((err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      getMyStocks();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> initPlatformState() async {
    await OneSignal.shared.init("cd24a945-b519-4bef-81b8-6262ce6c4f24",
        iOSSettings: {
          OSiOSSettings.autoPrompt: false,
          OSiOSSettings.inAppLaunchUrl: true
        });

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation(Theme.of(context).primaryColor)))
        : WillPopScope(
            onWillPop: onWillPop,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanDown: (_) {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
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
                          '${_eventCounts[0]} Etkinlik',
                          'Atölye',
                        ),
                        HomepageCard(
                          'assets/movie-logo.png',
                          'Tiyatro & Film',
                          '${_eventCounts[1]} Etkinlik',
                          'Tiyatro',
                        ),
                        HomepageCard(
                          'assets/avm-logo.png',
                          'AVM Etkinlikleri',
                          '${_eventCounts[2]} Etkinlik',
                          'Eğlence Merkezi',
                        ),
                        HomepageCard(
                          'assets/concert-logo.png',
                          'Konser & Müzikal',
                          '${_eventCounts[3]} Etkinlik',
                          'Müzikal/Gösteri',
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
  }
}

DateTime currentBackPressTime;

Future<bool> onWillPop() {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime) > Duration(seconds: 2)) {
    currentBackPressTime = now;
    Fluttertoast.showToast(
        msg: "Uygulamadan çıkmak için tekrar geri tuşuna basınız...");
    return Future.value(false);
  }
  return Future.value(true);
}
