import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../providers/events.dart';
import '../widgets/search/search_card.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';

  final String searchQuery;
  final String searchType;

  SearchScreen(this.searchQuery, this.searchType);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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

  void searchEvents() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<Events>(context, listen: false)
        .searchEvents(widget.searchQuery, widget.searchType)
        .then(
      (events) {
        events.forEach((event) =>
            _addMarker(event['latitude'], event['longitude'], event['place']));
        setState(
          () {
            _events = events;
            _isLoading = false;
          },
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      searchEvents();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final searchQuery = ModalRoute.of(context).settings.arguments as String;
    // List loadedEvents =
    //     Provider.of<Events>(context, listen: false).searchByText(searchQuery);

    // loadedEvents
    //     .forEach((event) => _addMarker(event.latitude, event.longitude));
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.searchQuery} için Arama Sonuçları...'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor)))
          : _events.length == 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Aradığınız kriterlere uygun etkinlik bulunamadı...',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15),
                    Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                )
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
                          itemCount: _events.length,
                          itemBuilder: (_, i) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SearchCard(_events[i], searchEvents),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
