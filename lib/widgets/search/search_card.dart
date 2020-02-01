import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../providers/event.dart';

class SearchCard extends StatelessWidget {
  final Event event;

  SearchCard(this.event);

  DateTime get date {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(event.date);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 155,
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
                    width: 140,
                    height: double.infinity,
                    child: Image.network(
                      event.imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  width: MediaQuery.of(context).size.width - 190,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        event.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.calendar_today,
                            color: Theme.of(context).primaryColor,
                          ),
                          Padding(padding: EdgeInsets.only(left: 10.0)),
                          Text(DateFormat.yMMMMd().format(date)),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: Theme.of(context).primaryColor,
                          ),
                          Padding(padding: EdgeInsets.only(left: 10.0)),
                          Text('İstanbul Oyuncak Müzesi'),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.local_activity,
                            color: Theme.of(context).primaryColor,
                          ),
                          Padding(padding: EdgeInsets.only(left: 10.0)),
                          Text('Atölye & Eğitim'),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.attach_money,
                            color: Theme.of(context).primaryColor,
                          ),
                          Padding(padding: EdgeInsets.only(left: 10.0)),
                          Text('50'),
                          Padding(padding: EdgeInsets.only(left: 25.0)),
                          Icon(
                            Icons.people,
                            color: Theme.of(context).primaryColor,
                          ),
                          Padding(padding: EdgeInsets.only(left: 10.0)),
                          Text('4-8 Yaş'),
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
