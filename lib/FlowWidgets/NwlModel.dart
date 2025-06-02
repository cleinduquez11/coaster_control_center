import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:coaster_control_center/Components/Hoverbutton.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/FlowConfigFileProvider.dart';
import 'package:coaster_control_center/FlowWidgets/ModelConfigDialog.dart';

class NwlModel extends StatefulWidget {
  final String modelName;
  // final List<String> overlayImages;
  //     final int length;
  //     final String url;

  const NwlModel({super.key, required this.modelName});
  @override
  State<NwlModel> createState() => NwlModelState();
}

class NwlModelState extends State<NwlModel> {
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

                if (_currentIndex == _overlayImages.indexOf(_overlayImages.last)) {
            _stopSlideshow();
          _isPlaying = false;
      }
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
      } else if (event.logicalKey == LogicalKeyboardKey.escape) {
        Navigator.pop(context);
      }
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    RawKeyboard.instance.removeListener(
        _handleKeyPress); // Remove listener to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FMF = Provider.of<FlowConfigFileProvider>(context);
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
                        const LatLng(22.007964930440476, 122.34829938507778)),
                    opacity: 0.75,
                    // imageProvider:
                    imageProvider: AssetImage(_overlayImages[1]),
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
            left: 20,
            // right: 20,
            child: Card(
              // margin: EdgeInsets.symmetric(horizontal: 800),
              elevation: 8,
              color: Colors.white.withOpacity(0.9),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.modelName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      """\t\t\t\t\t\t\t\t\t\t\tThe NWL Domain primarily covers Region 1 of the Philippines,
encompassing the provinces of Ilocos Norte, Ilocos Sur, La Union, and Pangasinan. 
""",
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            // left: 20,
            bottom: 50,
            right: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16), // Ad
                Row(
                  // mainAxisAlignment: MainAxisAlignment,  // Change as per need
                  children: [
                    Center(
                      child: HoverElevatedButtonIcon(
                        primaryColor: Colors.blue.shade900,
                        hoverColor: Colors.blue.shade400,
                        onPressed: () {
                          ModelConfigDialog(context, widget.modelName);
                          // your action
                        },
                        label: 'Configure Model',
                        icon: Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                      ),
                    ),
                               SizedBox(width: 20,),
                    FMF.isSaved
                        ?
                        // mainAxisAlignment: MainAxisAlignment,  // Change as per need
       
                        Center(
                            child: HoverElevatedButtonIcon(
                              primaryColor: Colors.green,
                              hoverColor: Colors.greenAccent,
                              onPressed: () {
                                // ModelConfigDialog(context, widget.modelName);
                                // your action
                              },
                              label: 'Run',
                              icon: Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
