// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';


// // import 'package:flutter_map_leaflet/flutter_map_leaflet.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:provider/provider.dart';
// import 'package:swan/provider/showOverlayGridProvider.dart';
// import 'package:swan/widget/makeSelected.dart';


// class MapView extends StatefulWidget {
//   @override
//   _MapViewState createState() => _MapViewState();
// }

// class _MapViewState extends State<MapView> {
//   LatLng? topLeft;
//   LatLng? bottomRight;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         FlutterMap(
//           options: MapOptions(
//             center: LatLng(51.5, -0.09),
//             zoom: 10.0,
//             onTap: (tap,latlng) {
//               setState(() {
//                 if (topLeft == null) {
//                   topLeft = latlng;
//                 } else if (bottomRight == null) {
//                   bottomRight = latlng;
//                 } else {
//                   topLeft = latlng;
//                   bottomRight = null;
//                 }
//               });
//             },
//           ),
//         children: [
//             TileLayer(
              
//               urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//               userAgentPackageName: 'com.example.app',
//                 subdomains: ['a', 'b', 'c'],
                    
//             ),
//           ],
//         ),
//         if (topLeft != null && bottomRight != null)
//           CustomPaint(
//             painter: RectanglePainter(
//               startOffset: LatLng(topLeft!.latitude, topLeft!.longitude),
//               endOffset: LatLng(bottomRight!.latitude, bottomRight!.longitude),
//             ),
//           ),
//       ],
//     );
//   }
// }

// class RectanglePainter extends CustomPainter {
//   final LatLng startOffset;
//   final LatLng endOffset;

//   RectanglePainter({required this.startOffset, required this.endOffset});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.blue.withOpacity(0.3)
//       ..style = PaintingStyle.fill;

//     final point1 = Offset(startOffset.longitude, startOffset.latitude);
//     final point2 = Offset(endOffset.longitude, startOffset.latitude);
//     final point3 = Offset(endOffset.longitude, endOffset.latitude);
//     final point4 = Offset(startOffset.longitude, endOffset.latitude);
//     final rect = Rect.fromPoints(point1, point2);
//     canvas.drawRect(rect, paint);
//     canvas.drawAtlas([point1, point2, point3, point4], paint);

//     final borderPaint = Paint()
//       ..color = Colors.blue
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.0;
//     canvas.drawPolygon([point1, point2, point3, point4, point1], borderPaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }