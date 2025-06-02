import 'dart:async';
import 'dart:io';
import 'package:coaster_control_center/BoundaryConditions/BC_RUN.dart';
import 'package:coaster_control_center/FlowWidgets/FutureWidgetsSelector.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/AddModelProvider.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/FlowConfigFileProvider.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/RunModelProvider.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/changeModelProvider.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/postProcessingProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class DelftVisualization extends StatefulWidget {
  final List<String> overlayImages;
  final int length;
  final String url;
  final LatLng bound1;
  final LatLng bound2;
  final LatLng center;
  final double zoom;

  const DelftVisualization(
      {super.key,
      required this.overlayImages,
      required this.length,
      required this.url,
      required this.bound1,
      required this.bound2,
      required this.center,
      required this.zoom});
  @override
  State<DelftVisualization> createState() => DelftVisualizationState();
}

class DelftVisualizationState extends State<DelftVisualization> {
  late Timer _timer;
  int _currentIndex = 0;
  bool _isPlaying = true;
  bool _controlsVisible = true;
  late List<String> oI;

  @override
  void initState() {
      
    print('Image length: ${widget.length}');
                      print(widget.center);
                  print(widget.bound1);
                  print(widget.bound2);
                  print(widget.zoom);
    oI = List.generate(
        widget.length, (index) => '${widget.url}$index.png');
    // oI = widget.overlayImages;
    super.initState();
    _startSlideshow();
    // Initialize RawKeyboardListener to listen to key events
    RawKeyboard.instance.addListener(_handleKeyPress);
  }

  void _startSlideshow() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.overlayImages.length;
      });

      if (_currentIndex == oI.indexOf(oI.last)) {
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
      final _formKey1 = GlobalKey<FormState>();
    final AMP = Provider.of<AddModelProvider>(context, listen: false);
    final CMP = Provider.of<ChangeModelProvider>(context, listen: false);
    final FMF = Provider.of<FlowConfigFileProvider>(context, listen: false);
    final RMP = Provider.of<RunModelProvider>(context, listen: false);
    final BC = Provider.of<RUNBC>(context, listen: false);
    final PP = Provider.of<PostProcessingProvider>(context, listen: false);
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.space) {
        _togglePlayPause();
      } else if (event.logicalKey == LogicalKeyboardKey.enter) {
        setState(() {
          _controlsVisible = !_controlsVisible;
        });
      } else if (event.logicalKey == LogicalKeyboardKey.escape) {
         RMP.reset();
                      CMP.indx = -999;
                      CMP.mods = {};
                      PP.loading = " ";
                      PP.isPlotted = false;
                      FMF.isSaved = false;

        Navigator.push(context, MaterialPageRoute(builder: (context) =>
         const FutureWidgetSelector()));
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


    List<Color> getJetColormap() {
    // Simulating "jet" colormap with 6 colors (for wave heights 1-6)
    return [
      Color.fromARGB(255, 93, 12, 1),
      Color(0xffff1e00),
       Color(0xffff9400),
      Color.fromARGB(255, 180, 201, 16), // Red
      Color.fromARGB(255, 115, 241, 197), // Yellow // Green
      Color(0xff0080ff), // Cyan // Dark Blue
    ];

  }

  @override
  Widget build(BuildContext context) {
        final AMP = Provider.of<AddModelProvider>(context);
    final CMP = Provider.of<ChangeModelProvider>(context);
    final FMF = Provider.of<FlowConfigFileProvider>(context);
    final RMP = Provider.of<RunModelProvider>(context);
    final BC = Provider.of<RUNBC>(context);
    final PP = Provider.of<PostProcessingProvider>(context);
      
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              backgroundColor: Colors.black12,
              interactionOptions: InteractionOptions(
                  pinchMoveThreshold: 1, pinchMoveWinGestures: 7),
              initialCenter: widget.center,
              initialZoom: widget.zoom,
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
                      widget.bound1,
                      widget.bound2),
                    opacity: 0.75,
                    // imageProvider:
                    imageProvider: FileImage(File(oI[_currentIndex])),
                    // imageProvider: AssetImage(
                    //     _overlayImages[_currentIndex]),
                    gaplessPlayback: true,
                  ),
                ],
              ),
            ],
          ),

          
            Positioned(
            right: 60,
            bottom: 60,
            child: Center(
              child:Tooltip(
                message: "Post to Coaster Website",
                child: ElevatedButton.icon(
                  
                  onPressed:() {
                    // imgoverlay.loadImagesFromDirectory('${dir.dir}\\output\\swan\\raw');
                    // showPostToServerDialog(context);
                    // LoadImages('${dir.dir}\\output\\swan\\raw').then((value) {
                    //      Navigator.push(context, MaterialPageRoute(builder: (context) => SandBoxVisualization(overlayImages: value,length: value.length, url: dir.dir,),));
                    // },);
                
                 
                    
                
                    
                    //  _loadImagesFromDirectory('${dir.dir}\\output\\swan\\raw');
                    // _isStarted = true;
                  },
                  label: Text('Send to Server'),
                  icon: Icon(Icons.network_wifi),
                ),
              )
            ),
          ),
        Positioned(
            bottom: 10,
            left: 50,
            child: AnimatedOpacity(
              opacity: _controlsVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2), // 20% transparent white
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color:
                          Colors.white.withOpacity(0.5), // 50% transparent border
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "ENTER",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "- Fullscreen",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            "ARROW LEFT",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "- Rewind",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "ESC",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 10,
                          ), 
                          Text(
                            "- Exit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            width: 90,
                          ),
                          Text(
                            "ARROW RIGHT",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "- SEEK",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "SPACE",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "- Play/Pause",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

                    Positioned(
            top: 700,
            left: 20,
            child: Column(
              children: List.generate(6, (index) {
                return Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      color: getJetColormap()[index],
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${6 - index}m',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                );
              }),
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
                    max: (oI.length - 1).toDouble(),
                    onChanged: (value) => _seekTo(value),
                    onChangeStart: (value) => _onSliderChangeStart(value),
                    onChangeEnd: (value) => _onSliderChangeEnd(value),
                  ),
                  FloatingActionButton(
                    onPressed: _togglePlayPause,
                    child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
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
