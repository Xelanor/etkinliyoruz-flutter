import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../screens/event_detail_screen.dart';
import '../../presentation/money_icons_icons.dart';

class SearchCard extends StatelessWidget {
  final Map event;
  final Function refreshScreen;

  SearchCard(this.event, this.refreshScreen);

  DateTime get date {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(event['date']);
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
        // .whenComplete(refreshScreen);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: MediaQuery.of(context).size.height / 3.8,
          width: double.infinity,
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: MediaQuery.of(context).size.height / 4.4,
                      height: MediaQuery.of(context).size.height / 4.4,
                      child: Image.network(
                        event['image'],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 34),
                  Container(
                    width: MediaQuery.of(context).size.width -
                        MediaQuery.of(context).size.height / 4.4 -
                        50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          event['name'],
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width / 100 * 3.4,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              color: Theme.of(context).primaryColor,
                              size:
                                  MediaQuery.of(context).size.width / 100 * 5.8,
                            ),
                            Padding(padding: EdgeInsets.only(left: 10.0)),
                            Flexible(
                              child: Text(
                                DateFormat.yMMMMd().format(date),
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width /
                                      100 *
                                      3.2,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width / 100),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Theme.of(context).primaryColor,
                              size:
                                  MediaQuery.of(context).size.width / 100 * 5.8,
                            ),
                            Padding(padding: EdgeInsets.only(left: 10.0)),
                            Flexible(
                              child: Text(
                                event['place'],
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width /
                                      100 *
                                      3.2,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width / 100),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.local_activity,
                              color: Theme.of(context).primaryColor,
                              size:
                                  MediaQuery.of(context).size.width / 100 * 5.8,
                            ),
                            Padding(padding: EdgeInsets.only(left: 10.0)),
                            Text(
                              event['category'],
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width /
                                    100 *
                                    3.2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width / 100),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              MoneyIcons.money_1,
                              color: Theme.of(context).primaryColor,
                              size:
                                  MediaQuery.of(context).size.width / 100 * 5.8,
                            ),
                            Padding(padding: EdgeInsets.only(left: 10.0)),
                            Text(
                              event['eventPrice'],
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width /
                                    100 *
                                    3.2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width / 100),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.people,
                              color: Theme.of(context).primaryColor,
                              size:
                                  MediaQuery.of(context).size.width / 100 * 5.8,
                            ),
                            Padding(padding: EdgeInsets.only(left: 10.0)),
                            Text(
                              event['eventAge'],
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width /
                                    100 *
                                    3.2,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
