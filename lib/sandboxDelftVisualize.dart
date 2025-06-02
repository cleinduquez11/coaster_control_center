import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class SandBoxDelftVisualization extends StatefulWidget {
    // final List<String> overlayImages;
    //     final int length;
    //     final String url;

  const SandBoxDelftVisualization({super.key});
  @override
  State<SandBoxDelftVisualization> createState() => SandBoxDelftVisualizationState();
}

class SandBoxDelftVisualizationState extends State<SandBoxDelftVisualization> {
  late Timer _timer;
  int _currentIndex = 0;
  bool _isPlaying = true;
  bool _controlsVisible = true;
  // late List<String> oI;
  List<String> _overlayImages =
      List.generate(186, (index) => 'lib/Assets/raw/${index}.png');
  @override
  void initState() {

    // oI = widget.overlayImages;
    super.initState();
    _startSlideshow();
    // Initialize RawKeyboardListener to listen to key events
    RawKeyboard.instance.addListener(_handleKeyPress);
  }

  void _startSlideshow() {
    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _overlayImages.length;
      });


    //           if (_currentIndex == oI.indexOf(oI.last)) {
    //       _stopSlideshow();
    //     _isPlaying = false;
    // }
    });


  }

  void _stopSlideshow() {
    _timer.cancel();
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _stopSlideshow();
      } else {
        _startSlideshow();
      }
      _isPlaying = !_isPlaying;
    });
  }

  void _seekTo(double value) {
    setState(() {
      _currentIndex = value.toInt();
    });
  }

  void _onSliderChangeStart(double value) {
    _stopSlideshow();
  }

  void _onSliderChangeEnd(double value) {
    if (_isPlaying) {
      _startSlideshow();
    }
  }

  void _handleKeyPress(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.space) { 
        _togglePlayPause();
      } else if (event.logicalKey == LogicalKeyboardKey.enter) {
        setState(() {
          _controlsVisible = !_controlsVisible;
        });
      }
       else if (event.logicalKey == LogicalKeyboardKey.escape) {
            Navigator.pop(context);
      }
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    RawKeyboard.instance.removeListener(_handleKeyPress); // Remove listener to prevent memory leaks
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
              backgroundColor: Colors.black12,
              interactionOptions: InteractionOptions(
                  pinchMoveThreshold: 1, pinchMoveWinGestures: 7),
              initialCenter: LatLng(12.8797, 123.7740),
              initialZoom: 6.5,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}.png',
                userAgentPackageName: 'com.example.app',
                subdomains: ['a', 'b', 'c'],
              ),
              OverlayImageLayer(
                overlayImages: [
                  OverlayImage(
                    bounds: LatLngBounds(
                     const LatLng(15.262854858772348, 117.31149188602119),
                        const LatLng(22.007964930440476,122.34829938507778)),
                    opacity: 0.75,
                    // imageProvider: 
                           imageProvider:  AssetImage(_overlayImages[_currentIndex]),
                    gaplessPlayback: true,
                    // imageProvider: AssetImage(
                    //     _overlayImages[_currentIndex]),

                  ),
                ],
              ),
            ],
          ),

          Positioned(
  top: 20,
  right: 20,
  child: IconButton(
    icon: const Icon(Icons.close, color: Colors.white, size: 30),
    onPressed: () => Navigator.pop(context),
    tooltip: 'Close',
  ),
),

          Positioned(
            top: 30,
            left: 50,
            child: AnimatedOpacity(
              opacity: _controlsVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                           Text("ENTER",
                           style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700
                           ),
                           ),
                          SizedBox(width: 10,),
                            Text("- Fullscreen",
                           style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,

                           ),
                           ),
                                                     SizedBox(width: 40,),
                                                     Text("ARROW LEFT",
                           style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700
                           ),
                           ),

                              SizedBox(width: 10,),
                            Text("- Rewind",
                           style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,

                           ),
                           )
                    ],
                  ),
                                   Row(
                    children: [
                           Text("ESC",
                           style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700
                           ),
                           ),
                          SizedBox(width: 10,),
                            Text("- Exit",
                           style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,

                           ),
                           ),
                              SizedBox(width: 125,),
                                                     Text("ARROW RIGHT",
                           style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700
                           ),
                           ),

                              SizedBox(width: 10,),
                            Text("- SEEK",
                           style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,

                           ),
                           )
                    ],
                  ),

                                                     Row(
                    children: [
                           Text("SPACE",
                           style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700
                           ),
                           ),
                          SizedBox(width: 10,),
                            Text("- Play/Pause",
                           style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,

                           ),
                           ),
                             
                    ],
                  ),
                   
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: AnimatedOpacity(
              opacity: _controlsVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Column(
                children: [
                  Slider(
                    value: _currentIndex.toDouble(),
                    min: 0,
                    max: (_overlayImages.length - 1).toDouble(),
                    onChanged: (value) => _seekTo(value),
                    onChangeStart: (value) => _onSliderChangeStart(value),
                    onChangeEnd: (value) => _onSliderChangeEnd(value),
                  ),
                  FloatingActionButton(
                    onPressed: _togglePlayPause,
                    child: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
