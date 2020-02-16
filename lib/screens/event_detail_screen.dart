import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../helpers/db_helper.dart';
import '../presentation/money_icons_icons.dart' show MoneyIcons;

class EventDetailScreen extends StatefulWidget {
  final Map event;

  EventDetailScreen(this.event);
  static const routeName = '/event-detail-screen';

  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  var _isInit = true;
  var _isLoading = false;
  var _isFavorite = false;

  DateTime date(date) {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      DBHelper.getFavoriteDataById('user_favorites', widget.event['_id']).then(
        (events) {
          if (events.length == 0) {
            setState(
              () {
                _isLoading = false;
                _isFavorite = false;
              },
            );
          } else {
            var isFavorite = events[0]['isFavorite'] == 1 ? true : false;
            setState(
              () {
                _isLoading = false;
                _isFavorite = isFavorite;
              },
            );
          }
        },
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Completer<GoogleMapController> _controller = Completer();
  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event['name']),
        actions: <Widget>[
          IconButton(
            icon: _isFavorite
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border),
            onPressed: () async {
              DBHelper.insert('user_favorites', {
                '_id': widget.event['_id'],
                'name': widget.event['name'],
                'description': widget.event['description'],
                'category': widget.event['category'],
                'date': widget.event['date'],
                'image': widget.event['image'],
                'eventAge': widget.event['eventAge'],
                'eventPrice': widget.event['eventPrice'],
                'eventLink': widget.event['eventLink'],
                'location': widget.event['location'],
                'place': widget.event['place'],
                'latitude': widget.event['latitude'],
                'longitude': widget.event['longitude'],
                'isFavorite': _isFavorite ? 0 : 1,
              });
              setState(() {
                _isFavorite ? _isFavorite = false : _isFavorite = true;
              });
            },
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).primaryColor)))
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3.4,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: widget.event['image'],
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Image.asset(
                          'assets/homepage-bg.png',
                          fit: BoxFit.contain),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.event['name'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              color: Theme.of(context).primaryColor,
                            ),
                            Padding(padding: EdgeInsets.only(left: 10.0)),
                            Text(DateFormat('dd.MM.yyyy')
                                .add_Hm()
                                .format(date(widget.event['date']))),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              MoneyIcons.money_1,
                              color: Theme.of(context).primaryColor,
                            ),
                            Padding(padding: EdgeInsets.only(left: 10.0)),
                            Text(widget.event['eventPrice']),
                            Padding(padding: EdgeInsets.only(left: 25.0)),
                            Icon(
                              Icons.people,
                              color: Theme.of(context).primaryColor,
                            ),
                            Padding(padding: EdgeInsets.only(left: 10.0)),
                            Text(widget.event['eventAge']),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 10,
                    thickness: 1,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Etkinlik Detayları',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          widget.event['description'],
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    padding: EdgeInsets.only(bottom: 8, left: 8, right: 8),
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          double.parse(widget.event['latitude']),
                          double.parse(widget.event['longitude']),
                        ),
                        zoom: 15.0,
                      ),
                      mapType: MapType.normal,
                      markers: {
                        Marker(
                          markerId: MarkerId("1"),
                          position: LatLng(
                            double.parse(widget.event['latitude']),
                            double.parse(widget.event['longitude']),
                          ),
                          infoWindow: InfoWindow(
                            title: widget.event['place'],
                          ),
                          icon: BitmapDescriptor.defaultMarker,
                        ),
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
