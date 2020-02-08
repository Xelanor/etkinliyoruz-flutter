import 'package:flutter/material.dart';

import '../../screens/search_screen.dart';
import './event_card.dart';

class EventsLine extends StatelessWidget {
  final List events;

  EventsLine(this.events);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      height: 235.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: events.length + 1,
              itemBuilder: (_, i) {
                if (i == events.length) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Tümünü Gör',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor),
                        child: IconButton(
                          icon: Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    SearchScreen("Atölye", 'category'),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return EventCard(events[i]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
