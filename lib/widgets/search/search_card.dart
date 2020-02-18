import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share/share.dart';

import '../../screens/event_detail_screen.dart';
import '../../presentation/money_icons_icons.dart';
import '../../helpers/db_helper.dart';

class SearchCard extends StatelessWidget {
  final Map event;
  final Function refreshScreen;
  final bool isFavorite;

  SearchCard(this.event, this.refreshScreen, {this.isFavorite = false});

  DateTime get date {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(event['date']);
  }

  DateTime getDate(date) {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
  }

  void addFavorites(BuildContext ctx) {
    DBHelper.insert('user_favorites', {
      '_id': event['_id'],
      'name': event['name'],
      'description': event['description'],
      'category': event['category'],
      'date': event['date'],
      'image': event['image'],
      'eventAge': event['eventAge'],
      'eventPrice': event['eventPrice'],
      'eventLink': event['eventLink'],
      'location': event['location'],
      'place': event['place'],
      'latitude': event['latitude'],
      'longitude': event['longitude'],
      'isFavorite': 1,
    });
    Scaffold.of(ctx).hideCurrentSnackBar();
    Scaffold.of(ctx).showSnackBar(
      SnackBar(
        content: Text(
          "${event['name']} favorilere eklendi",
          // '${stock['shortName']} porföyüne eklendi!',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void shareEvent(BuildContext ctx) {
    final RenderBox box = ctx.findRenderObject();
    Share.share(
        'Etkinliyoruz mobil uygulamasından bulduğum bu etkinliği seninle paylaşmak istedim ❤\n${event['name']}\nTarih: ${DateFormat('dd.MM.yyyy').add_Hm().format(getDate(event['date']))}\nKategori: ${event['category']}\nYer: ${event['place']}\nFiyat:${event['eventPrice']}\nDetaylı Bilgi: ${event['eventLink']}',
        subject: event['category'],
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey('${event['name']}${event['date']}'),
      secondaryBackground: Container(
        color: Colors.yellow[600],
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20, left: 20, bottom: 15, top: 15),
        margin: EdgeInsets.all(5),
      ),
      background: Container(
        color: Colors.green,
        child: Icon(
          Icons.share,
          color: Colors.white,
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(right: 20, left: 20, bottom: 15, top: 15),
        margin: EdgeInsets.all(5),
      ),
      direction: isFavorite
          ? DismissDirection.startToEnd
          : DismissDirection.horizontal,
      confirmDismiss: (DismissDirection direction) async {
        if (direction == DismissDirection.endToStart) {
          addFavorites(context);
        } else {
          shareEvent(context);
        }
        return false;
      },
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EventDetailScreen(event),
            ),
          );
          // .whenComplete(refreshScreen);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            height: MediaQuery.of(context).size.height / 3.8,
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
                        width: MediaQuery.of(context).size.height / 4.4,
                        height: MediaQuery.of(context).size.height / 4.4,
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: event['image'],
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Image.asset(
                              'assets/homepage-bg.png',
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width / 34),
                    Container(
                      width: MediaQuery.of(context).size.width -
                          MediaQuery.of(context).size.height / 4.4 -
                          50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            event['name'],
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width / 100 * 3.4,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.calendar_today,
                                color: Theme.of(context).primaryColor,
                                size: MediaQuery.of(context).size.width /
                                    100 *
                                    5.8,
                              ),
                              Padding(padding: EdgeInsets.only(left: 10.0)),
                              Flexible(
                                child: Text(
                                  DateFormat('dd.MM.yyyy')
                                      .add_Hm()
                                      .format(date),
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width /
                                            100 *
                                            3.2,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width / 100),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                color: Theme.of(context).primaryColor,
                                size: MediaQuery.of(context).size.width /
                                    100 *
                                    5.8,
                              ),
                              Padding(padding: EdgeInsets.only(left: 10.0)),
                              Flexible(
                                child: Text(
                                  event['place'],
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width /
                                            100 *
                                            3.2,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width / 100),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.local_activity,
                                color: Theme.of(context).primaryColor,
                                size: MediaQuery.of(context).size.width /
                                    100 *
                                    5.8,
                              ),
                              Padding(padding: EdgeInsets.only(left: 10.0)),
                              Text(
                                event['category'],
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width /
                                      100 *
                                      3.2,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width / 100),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                MoneyIcons.money_1,
                                color: Theme.of(context).primaryColor,
                                size: MediaQuery.of(context).size.width /
                                    100 *
                                    5.8,
                              ),
                              Padding(padding: EdgeInsets.only(left: 10.0)),
                              Text(
                                event['eventPrice'],
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width /
                                      100 *
                                      3.2,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width / 100),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.people,
                                color: Theme.of(context).primaryColor,
                                size: MediaQuery.of(context).size.width /
                                    100 *
                                    5.8,
                              ),
                              Padding(padding: EdgeInsets.only(left: 10.0)),
                              Text(
                                event['eventAge'],
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width /
                                      100 *
                                      3.2,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
