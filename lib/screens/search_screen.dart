import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../providers/events.dart';
import '../widgets/search/search_card.dart';
import '../widgets/search/search_filter_container.dart';
import '../widgets/utils/error_page.dart';

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
  var _allEvents = [];
  var _filteredEvents = [];
  var _filter = {};

  Set<Marker> _markers = {};

  List<String> _places = [];
  List<String> _categories = [];
  String _placeValue;
  String _categoryValue;

  Completer<GoogleMapController> _controller = Completer();
  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void filterAndSetDropdown(String value, String filterType) {
    var __filteredEvents = [];
    _markers.clear();

    _filter[filterType] = value;
    __filteredEvents = _allEvents.where((event) {
      for (var key in _filter.keys) {
        if (event[key] == "" || event[key] != _filter[key]) {
          return false;
        }
      }
      return true;
    }).toList();
    __filteredEvents.forEach((event) {
      _markers.add(
          _addMarker(event['latitude'], event['longitude'], event['place']));
    });
    setState(() {
      _filter[filterType] = value;
      _categoryValue = _filter['category'] == "" ? null : _filter['category'];
      _placeValue = _filter['place'] == "" ? null : _filter['place'];
      _filteredEvents = __filteredEvents;
      _markers = _markers;
    });
  }

  Marker _addMarker(String ltd, String lng, String place) {
    return Marker(
      markerId: MarkerId(ltd),
      position: LatLng(
        double.parse(ltd),
        double.parse(lng),
      ),
      infoWindow: InfoWindow(
        title: place,
      ),
      icon: BitmapDescriptor.defaultMarker,
    );
  }

  void searchEvents() {
    setState(() {
      _isLoading = true;
    });
    Provider.of<Events>(context, listen: false)
        .searchEvents(widget.searchQuery, widget.searchType)
        .then(
      (events) {
        events.forEach((event) {
          _markers.add(_addMarker(
              event['latitude'], event['longitude'], event['place']));
          _places.add(event['place']);
          _categories.add(event['category']);
        });
        setState(
          () {
            _allEvents = events;
            _filteredEvents = events;
            _isLoading = false;
            _markers = _markers;
            _places = _places.toSet().toList();
            _categories = _categories.toSet().toList();
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
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.searchQuery} için Arama Sonuçları...'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor)))
          : Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3.6,
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
                  SearchFilterContainer(
                    filterAndSetDropdown,
                    _places,
                    _placeValue,
                    _categories,
                    _categoryValue,
                  ),
                  _filteredEvents.length == 0
                      ? ErrorPage(
                          'Aradığınız kriterlere uygun etkinlik bulunamadı...')
                      : Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: _filteredEvents.length,
                            itemBuilder: (_, i) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SearchCard(_filteredEvents[i], searchEvents),
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
