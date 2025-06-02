import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AnimatedMap extends StatelessWidget {
  final AnimationController controller;
  final MapEventCallback onMapEvent;
  final MapController mapController;
  final File? imageFile;
  final LatLngBounds? bounds;

  const AnimatedMap(
      {super.key,
      required this.controller,
      required this.onMapEvent,
      required this.mapController,
       this.imageFile,
       this.bounds});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return FlutterMap(
          mapController: mapController,
          options: MapOptions(
            center: LatLng(12.8797, 121.7740), // Centered on the Philippines
            zoom: 6.5,
            onMapEvent: onMapEvent,
            backgroundColor: Colors.black12,
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}.png',
              userAgentPackageName: 'com.example.app',
            ),
            if(imageFile != null && bounds != null)
            OverlayImageLayer(
              overlayImages: [
                OverlayImage(
                  bounds: bounds!,
                  opacity: 0.75,
                  imageProvider: FileImage(imageFile!),
                  gaplessPlayback: true,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
