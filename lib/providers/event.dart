import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Event with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final String category;
  final String date;
  final String imageUrl;
  final String eventAge;
  final String eventPrice;
  final String eventLink;
  final String location;
  final String place;
  final String latitude;
  final String longitude;

  Event({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.category,
    @required this.date,
    @required this.imageUrl,
    @required this.eventAge,
    @required this.eventPrice,
    @required this.eventLink,
    @required this.location,
    @required this.place,
    @required this.latitude,
    @required this.longitude,
  });
}
