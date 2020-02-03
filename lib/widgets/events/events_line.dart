import 'package:flutter/material.dart';

import './event_card.dart';

class EventsLine extends StatelessWidget {
  final List events;

  EventsLine(this.events);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      height: 235.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        itemBuilder: (_, i) => EventCard(events[i]),
      ),
    );
  }
}
