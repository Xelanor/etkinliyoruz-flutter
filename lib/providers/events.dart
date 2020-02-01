import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../providers/event.dart';

class Events with ChangeNotifier {
  List<Event> _events = [
    Event(
      id: 'e1',
      name: 'Yeni yıl etkinliği',
      description: 'Yein yıl Kozzy\'de çocuklar eğleniyor...',
      category: "Atölye",
      date: "2020-01-03T12:00:00.000+00:00",
      imageUrl:
          'http://5.196.225.93:83/images/events/ba9b4398-c1e7-4120-b6b7-088c8f4fe2e9.png',
      eventAge: "5-12 yaş",
      eventPrice: "Ücretsiz",
      eventLink:
          "http://www.kozzyavm.com/tr/etkinlikler/yeni-yil-geliyor-kozzy-de-cocuklar-cok-egleniyor",
      location:
          "Bayar Cd. Buket Sk. No:14 34742 Kozyatağı, İstanbulKadıköy, İstanbul Anadolu",
      place: "Kozzy AVM",
      latitude: "40.969206500",
      longitude: "29.091638000",
    ),
    Event(
      id: 'e2',
      name: 'Yeni yıl etkinliği2',
      description: 'Yein yıl Kozzy\'de çocuklar eğleniyor...',
      category: "Atölye",
      date: "2020-01-03T12:00:00.000+00:00",
      imageUrl:
          'http://5.196.225.93:83/images/events/ba9b4398-c1e7-4120-b6b7-088c8f4fe2e9.png',
      eventAge: "5-12 yaş",
      eventPrice: "Ücretsiz",
      eventLink:
          "http://www.kozzyavm.com/tr/etkinlikler/yeni-yil-geliyor-kozzy-de-cocuklar-cok-egleniyor",
      location:
          "Bayar Cd. Buket Sk. No:14 34742 Kozyatağı, İstanbulKadıköy, İstanbul Anadolu",
      place: "Kozzy AVM",
      latitude: "40.969206500",
      longitude: "29.091638000",
    ),
  ];

  List<Event> get events {
    // if (_showFavoritesOnly) {
    //   return _items.where((product) => product.isFavorite).toList();
    // }
    return [..._events];
  }

  Event findById(String id) {
    return _events.firstWhere((event) => event.id == id);
  }

  List<Event> searchByText(String text) {
    return _events
        .where((event) => event.name.toLowerCase().contains(text.toLowerCase()))
        .toList();
  }
}
