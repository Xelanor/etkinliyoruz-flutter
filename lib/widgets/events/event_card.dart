import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../screens/event_detail_screen.dart';
import '../../presentation/money_icons_icons.dart';

class EventCard extends StatelessWidget {
  final Map event;

  EventCard(this.event);

  DateTime date(date) {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EventDetailScreen(event),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 7, bottom: 7, right: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 120,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 100,
                      child: Image.network(
                        event['image'],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        event['name'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.calendar_today,
                            color: Theme.of(context).primaryColor,
                            size: 10,
                          ),
                          Padding(padding: EdgeInsets.only(left: 5.0)),
                          Expanded(
                            child: Text(
                              DateFormat('dd.MM.yyyy')
                                  .format(date(event['date'])),
                              style: TextStyle(fontSize: 10),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: Theme.of(context).primaryColor,
                            size: 10,
                          ),
                          Padding(padding: EdgeInsets.only(left: 5.0)),
                          Expanded(
                            child: Text(
                              event['place'],
                              style: TextStyle(fontSize: 10),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.local_activity,
                            color: Theme.of(context).primaryColor,
                            size: 10,
                          ),
                          Padding(padding: EdgeInsets.only(left: 5.0)),
                          Text(
                            event['category'],
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            MoneyIcons.money_1,
                            color: Theme.of(context).primaryColor,
                            size: 10,
                          ),
                          Padding(padding: EdgeInsets.only(left: 5.0)),
                          Text(
                            event['eventPrice'],
                            style: TextStyle(fontSize: 10),
                          ),
                          Padding(padding: EdgeInsets.only(left: 5.0)),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.people,
                            color: Theme.of(context).primaryColor,
                            size: 10,
                          ),
                          Padding(padding: EdgeInsets.only(left: 5.0)),
                          Text(
                            event['eventAge'],
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
