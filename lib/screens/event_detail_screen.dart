import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share/share.dart';
import 'package:device_id/device_id.dart';

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
  var isAdmin;

  DateTime date(date) {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
  }

  @override
  void didChangeDependencies() async {
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
    var deviceId = await DeviceId.getID;
    ["2cda060b694e23db", "b21d164725ce480a", "366707b12d879e78"]
            .contains(deviceId)
        ? isAdmin = true
        : isAdmin = false;
    _isInit = false;
    super.didChangeDependencies();
  }

  Completer<GoogleMapController> _controller = Completer();
  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void deleteEvent(ctx) {
    showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              "${widget.event['name']} etkinliğini gerçekten silmek istiyor musun?"),
          actions: <Widget>[
            RaisedButton(
              color: Theme.of(context).colorScheme.primary,
              child: Text("İptal"),
              onPressed: () {
                Navigator.of(context).pop();
                return false;
              },
            ),
            FlatButton(
              child: Text("Devam"),
              onPressed: () {
                var deleteUrl =
                    'http://10.0.2.2:5000/api/deactivate/${widget.event['_id']}';
                DBHelper.deleteEvent(widget.event['_id']);
                http.post(deleteUrl);
                Navigator.of(context).pop();
                return true;
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event['name']),
        actions: <Widget>[
          isAdmin
              ? IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deleteEvent(context);
                  },
                )
              : Container(),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              final RenderBox box = context.findRenderObject();
              Share.share(
                  'Etkinliyoruz mobil uygulamasından bulduğum bu etkinliği seninle paylaşmak istedim ❤\n${widget.event['name']}\nTarih: ${DateFormat('dd.MM.yyyy').add_Hm().format(date(widget.event['date']))}\nKategori: ${widget.event['category']}\nYer: ${widget.event['place']}\nFiyat:${widget.event['eventPrice']}\nDetaylı Bilgi: ${widget.event['eventLink']}',
                  subject: widget.event['category'],
                  sharePositionOrigin:
                      box.localToGlobal(Offset.zero) & box.size);
            },
          ),
          IconButton(
            icon: _isFavorite
                ? Icon(
                    Icons.star,
                    color: Colors.yellow,
                  )
                : Icon(Icons.star_border),
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
                        'assets/no-image.png',
                        fit: BoxFit.cover,
                      ),
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
                      gestureRecognizers:
                          <Factory<OneSequenceGestureRecognizer>>[
                        new Factory<OneSequenceGestureRecognizer>(
                          () => new EagerGestureRecognizer(),
                        ),
                      ].toSet(),
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
