import 'dart:async';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../providers/events.dart';

class EventsScreen extends StatefulWidget {
  static const routeName = '/events-screen';
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.97617213717867, 29.12910103797913),
    zoom: 15,
  );

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final eventsData = Provider.of<Events>(context);

    return Column(
      children: <Widget>[
        Container(
          height: 200,
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: EventsScreen._kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
        Text('ASdasd')
      ],
    );
  }
}
