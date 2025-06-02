import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:coaster_control_center/LandingPage.dart';
import 'package:coaster_control_center/widget/selectTyphoonDialog.dart';

class VisLandingPage extends StatefulWidget {
  const VisLandingPage({Key? key}) : super(key: key);

  @override
  State<VisLandingPage> createState() => _VisLandingPageState();
}

class _VisLandingPageState extends State<VisLandingPage> {
  late Timer _timer;
  int _currentIndex = 0;
  bool _isPlaying = true;

// Debug Version
  List<String> _overlayImages =
      List.generate(186, (index) => 'lib/Assets/Raw/${index + 1}.png');

// Release Version
  //   List<String> _overlayImages =
  // List.generate(186, (index) => 'assets/lib/Assets/Raw/${index + 1}.png');

  @override
  void initState() {
    super.initState();
    _startSlideshow();
  }

  void _startSlideshow() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_isPlaying) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % _overlayImages.length;
        });
      }
    });
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.black,
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(12.8797, 129.7740),
              initialZoom: 6.5,
              // center: LatLng(12.8797, 129.7740),
              // zoom: 6.5,
              backgroundColor: Colors.black12,
              interactionOptions: InteractionOptions(
                  // flags: InteractiveFlag.none, // Disable all interactions
                  ),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}.png',
                userAgentPackageName: 'com.example.app',
                subdomains: ['a', 'b', 'c'],
              ),
              // OverlayImageLayer(
              //   overlayImages: [
              //     OverlayImage(
              //       bounds: LatLngBounds(
              //         LatLng(2.0525927337113665, 107.03514716442793),
              //         LatLng(28.50509192411439, 135.26960583104557),
              //       ),
              //       opacity: 0.75,
              //       imageProvider: AssetImage(_overlayImages[_currentIndex]),
              //       gaplessPlayback: true,
              //     ),
              //   ],
              // ),
            ],
          ),

   Positioned(
            right: MediaQuery.of(context).size.width * 0.07,
            top: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.lightGreen,
                        Colors.green.shade900, // Dark green
                        Colors.green.shade400,
                               Colors.lightGreen, // Lighter green
                      ],
                    ),
                  ),
                  child: Text(
                    'Visualization Area',
                    style: TextStyle(
                      fontSize: 48.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        """              Coastal Engineering\n        and Management Research \n          and Development Center""",
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    totalRepeatCount: 1,
                    pause: const Duration(milliseconds: 1000),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  ),
                ),
                SizedBox(height: 200),
                HoverButton(
                  onPressed: () {
                                        showTyphoonDialog(context);
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LMap(),));
                    // Handle Simulation Area button press
                  },
                  child: Text(
                    'SWAN Outputs',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                HoverButton(
                  onPressed: () {
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => selectTyp(),));
                      //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Visualization(),));
                    // Handle Visualization Area button press
                  },
                  child: Text(
                    'DELFT Outputs',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),


                 SizedBox(height: 10),
                HoverButton(
                  onPressed: () {
                    // Navigator.pop(context);
                            // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Visualization(),));
                      //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Visualization(),));
                    // Handle Visualization Area button press
                  },
                  child: Text(
                    'HECRAS Outputs',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),


           Positioned(
            left: MediaQuery.of(context).size.width * 0.03,
            top: MediaQuery.of(context).size.height * 0.025,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LandingPage(),));
              },
              child: Hero(
                tag: 'coaster',
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.lightGreen,
                        Colors.green.shade900, // Dark green
                        Colors.green.shade400,
                               Colors.lightGreen, // Lighteghter green
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'COASTER MMSU',
                      style: TextStyle(
                        fontSize: 36.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
         
         
          Positioned(
            bottom: 20,
            right: MediaQuery.of(context).size.width * 0.01,
            child: const Text(
              '© MMSU coaster 2024 All rights reserved',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HoverButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;

  const HoverButton({Key? key, required this.child, this.onPressed})
      : super(key: key);

  @override
  _HoverButtonState createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  double _buttonHeight = 50.0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _buttonHeight = 70.0; // Increase height on hover
        });
      },
      onExit: (_) {
        setState(() {
          _buttonHeight = 50.0; // Reset height on exit
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: _buttonHeight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightGreen,
                        Colors.green.shade900, // Dark green
                        Colors.green.shade400,
                               Colors.lightGreen, // Lighteighter blue
            ],
          ),
        ),
        child: TextButton(
          onPressed: widget.onPressed,
          child: widget.child,
        ),
      ),
    );
  }
}
