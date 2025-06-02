import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class Visualization extends StatefulWidget {
  @override
  State<Visualization> createState() => VisualizationState();
}

class VisualizationState extends State<Visualization> {
  late Timer _timer;
  int _currentIndex = 0;
  bool _isPlaying = true;
  bool _controlsVisible = true;
  bool back = false;

  // List<String> _overlayImages = List.generate(186, (index) => 'lib/Assets/images/${index + 1}.png');

    List<String> _overlayImages = List.generate(186, (index) => 'http://localhost/images/${index + 1}.png');

  @override
  void initState() {
    super.initState();
    _startSlideshow();
    // Initialize RawKeyboardListener to listen to key events
    RawKeyboard.instance.addListener(_handleKeyPress);
  }

  void _startSlideshow() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _overlayImages.length;
      });
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
      } else if (event.logicalKey == LogicalKeyboardKey.f11) {
        setState(() {
          _controlsVisible = !_controlsVisible;
        });
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
    return 
    Scaffold(
         backgroundColor: Colors.black,
      body: Stack(
        children: [
          
                   Positioned(
            right: 300,
            top:50,
            child: IconButton(
              
              onPressed:() {
                // imgoverlay.loadImagesFromDirectory('${dir.dir}\\output\\swan\\raw');
            
            
            
                Navigator.pop(context);
            
                
                //  _loadImagesFromDirectory('${dir.dir}\\output\\swan\\raw');
                // _isStarted = true;
              },
              iconSize: 40,
              color: Colors.red,
              icon: Icon(Icons.close),
            ),
          ),
          FlutterMap(
            options: MapOptions(
  
              crs: Epsg4326(),
              backgroundColor: Colors.black12,
              interactionOptions: InteractionOptions(
                  pinchMoveThreshold: 1, pinchMoveWinGestures: 7),
              initialCenter: LatLng(12.8797, 123.7740),
              initialZoom: 6.5,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    // 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}.png',
                    'https://api.mapbox.com/styles/v1/pcborja/clt6utkbc00g801raamfl71ab/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoicGNib3JqYSIsImEiOiJjbG5sZm9weGIxYzg4MmxtbmpqYjd2YXIxIn0.LmH0x1Rn3NDzJdzq3J6Ayg',
                userAgentPackageName: 'com.example.app',
                subdomains: ['a', 'b', 'c'],
              ),
              OverlayImageLayer(
                overlayImages: [
                  OverlayImage(
                    bounds: LatLngBounds(
                        LatLng(2.0525927337113665, 107.03514716442793),
                        LatLng(28.50509192411439, 135.26960583104557)),
                    opacity: 0.75,
                           imageProvider: NetworkImage(
                        _overlayImages[_currentIndex]),
                    // imageProvider: AssetImage(
                    //     _overlayImages[_currentIndex]),
                    gaplessPlayback: true,
                  ),
                ],
              ),
            ],
          ),
         
         

         
         
         
         
         
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: AnimatedOpacity(
              opacity: _controlsVisible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 200),
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
