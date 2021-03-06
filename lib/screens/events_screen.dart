import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../providers/events.dart';
import '../widgets/events/events_category_title.dart';
import '../widgets/events/events_line.dart';

class EventsScreen extends StatefulWidget {
  static const routeName = '/events-screen';

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  var _isInit = true;
  var _isLoading = false;
  var _events = [];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Events>(context, listen: false).fetchEventsScreen().then(
        (events) {
          setState(
            () {
              _events = events;
              _isLoading = false;
            },
          );
        },
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation(Theme.of(context).primaryColor)))
        : SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  EventsCategoryTitle(
                    'Yaklaşan Etkinlikler',
                    Icons.calendar_today,
                  ),
                  EventsLine(
                      'Bütün Etkinlikler', _events[0]), // Upcoming events line
                  EventsCategoryTitle(
                    'Atölye & Eğitim',
                    'assets/education-logo.png',
                  ),
                  EventsLine('Atölye', _events[1]), // Education events line
                  EventsCategoryTitle(
                    'Tiyatro & Film',
                    'assets/movie-logo.png',
                  ),
                  EventsLine('Tiyatro', _events[2]), // Movie events line
                  EventsCategoryTitle(
                    'AVM Etkinlikleri',
                    'assets/concert-logo.png',
                  ),
                  EventsLine(
                      'Eğlence Merkezi', _events[3]), // Movie events line
                  EventsCategoryTitle(
                    'Konser & Müzikal',
                    'assets/concert-logo.png',
                  ),
                  EventsLine(
                      'Müzikal/Gösteri', _events[4]), // Movie events line
                ],
              ),
            ),
          );
  }
}
