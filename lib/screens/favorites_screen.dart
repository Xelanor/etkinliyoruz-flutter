import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import '../helpers/db_helper.dart';
import '../widgets/search/search_card.dart';
import '../widgets/utils/error_page.dart';

class FavoritesScreen extends StatefulWidget {
  static const routeName = '/favorites-screen';

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  var _isInit = true;
  var _isLoading = false;
  var _events = [];

  Completer<GoogleMapController> _controller = Completer();
  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  final Set<Marker> _markers = {};

  _addMarker(String ltd, String lng, String place) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(ltd),
          position: LatLng(
            double.parse(ltd),
            double.parse(lng),
          ),
          infoWindow: InfoWindow(
            title: place,
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });
  }

  DateTime date(date) {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
  }

  void retreiveFavorites() {
    setState(() {
      _isLoading = true;
      _markers.clear();
    });
    DBHelper.getFavorites('user_favorites').then(
      (events) {
        events.forEach((event) =>
            _addMarker(event['latitude'], event['longitude'], event['place']));
        setState(
          () {
            _isLoading = false;
            _events = events;
          },
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      retreiveFavorites();
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
        : _events.length == 0
            ? ErrorPage(
                "Henüz Favorilerinize kaydettiğiniz bir etkinlik bulunmamaktadır...")
            : Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 200,
                      child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            double.parse("41.025961"),
                            double.parse("28.996379"),
                          ),
                          zoom: 9.0,
                        ),
                        mapType: MapType.normal,
                        markers: _markers,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: _events.length,
                        itemBuilder: (_, i) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SearchCard(_events[i], retreiveFavorites),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}
