import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:coaster_control_center/Components/Hoverbutton.dart';
import 'package:coaster_control_center/FlowWidgets/FutureWidgetsSelector.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/AddModelProvider.dart';

class SelectCenters extends StatefulWidget {
  const SelectCenters({super.key});

  @override
  State<SelectCenters> createState() => _SelectCentersState();
}

class _SelectCentersState extends State<SelectCenters>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final MapController _mapController;
  late String lat = "12.8797";
  late String lon = "121.7740";
  late String zoomLevel = "6.5";
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _mapController = MapController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onMapEvent(MapEvent event) {
    if (event is MapEventMoveEnd || event is MapEventScrollWheelZoom) {
      final center = _mapController.camera.center;
      final zoom = _mapController.camera.zoom;
      setState(() {
        lat = center.latitude.toString();
        lon = center.longitude.toString();
        zoomLevel = zoom.toString();
      });
      print(
          "Current center: Latitude = ${center.latitude}, Longitude = ${center.longitude}, Zoom Level = $zoom");
    }
  }

  @override
  Widget build(BuildContext context) {
    // final _formKey1 = GlobalKey<FormState>();
    final AMP = Provider.of<AddModelProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(70), // Margin from the screen edges
            decoration: BoxDecoration(
              color: Colors.grey[900], // Box background color
              borderRadius: BorderRadius.circular(12), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(0, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(12), // Apply to the map as well
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center:
                      LatLng(12.8797, 121.7740), // Centered on the Philippines
                  zoom: 6.5,
                  onMapEvent: _onMapEvent,
                  backgroundColor: Colors.black12,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 50,
            top: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'coaster',
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.lightGreen,
                            Colors.green.shade900, // Dark green
                            Colors.green.shade400,
                            Colors.lightGreen,
                          ],
                        ),
                      ),
                      child: const Text(
                        'Pick Map Center',
                        style: TextStyle(
                          fontSize: 36.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 80,
            bottom: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        // gradient: LinearGradient(
                        //   begin: Alignment.topCenter,
                        //   end: Alignment.bottomCenter,
                        //   colors: [
                        //     Colors.lightGreen,
                        //     Colors.green.shade900, // Dark green
                        //     Colors.green.shade400,
                        //     Colors.lightGreen,
                        //   ],
                        // ),
                        ),
                    child: Text(
                      "Current center: Latitude = $lat, Longitude = $lon, Zoom Level = $zoomLevel",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 80,
            bottom: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HoverElevatedButtonIcon(
                  hoverColor: Colors.red,
                  primaryColor: Colors.orange,
                  icon: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                  label: 'Save',
                  onPressed: () {
                    AMP.getPresentationSetting(lat,lon,zoomLevel);

                    // AMP.centerLat = lat;
                    // AMP.centerLon = lon;
                    // AMP.centerZoom = zoomLevel;
                    // AMP.getPresentationSetting();
                    Navigator.of(context).pop();
                  },
                  // primaryColor: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
