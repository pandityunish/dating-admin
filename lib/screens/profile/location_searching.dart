import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../globalVars.dart';
import '../../models/user_model.dart';

class LocationSearchByDistance {
  double _radius = 5000; // Default radius of 5km
  List<String> _uids = [];

// Get the user's current location using the `geolocator` package

// Calculate the distance (in meters) between two coordinates using the Haversine formula
  static double _calculateDistance(
      double lat1, double lng1, double lat2, double lng2) {
    const earthRadius = 6371000; // Radius of the earth in meters

    final latDistance = math.pi * (lat2 - lat1) / 180;
    final lngDistance = math.pi * (lng2 - lng1) / 180;
    final a = math.pow(math.sin(latDistance / 2), 2) +
        math.cos(math.pi * lat1 / 180) *
            math.cos(math.pi * lat2 / 180) *
            math.pow(math.sin(lngDistance / 2), 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c;
  }

// Search for UIDs within a particular radius of the user's current location
  static searchUids(double radius, var query) async {
    // Query the Firestore database to retrieve UIDs within the radius
    QuerySnapshot querySnapshot = await query.get();

    // Extract the UIDs from the query snapshot that are within the given radius
    final distanceThreshold = radius;
    final uidsWithinRadius = <String>[];
    for (var doc in querySnapshot.docs) {
      try {
        final data = User.fromdoc(doc);
        print("data: $data");
        final uidLat = data.latitude as double;
        final uidLng = data.longitude as double;
        final distance = await _calculateDistance(
            userSave.latitude!, userSave.longitude!, uidLat, uidLng);
        if (distance <= distanceThreshold) {
          uidsWithinRadius.add(doc['uid']);
        }
      } catch (e) {
        print(e);
      }
    }
    return uidsWithinRadius;
  }
}
