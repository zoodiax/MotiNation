
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


// Class Marker - Wichtig für Markeraufbau in MapView - Filterfunktion nach bool (z.b. gym, pool)
class Markerz extends Marker {
  Markerz(
      {this.markerId,
      this.position,
      this.infoWindow,
      this.onTap});
  final MarkerId markerId;
  final LatLng position;
  final InfoWindow infoWindow;
  final VoidCallback onTap;
}
