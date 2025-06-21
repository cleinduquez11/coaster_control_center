import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DelftVisualization extends StatefulWidget {
  final dynamic his;
  final List<String> overlayImages;
  final int length;
  final String url;
  final String startDate;
  final LatLng bound1;
  final LatLng bound2;
  final LatLng center;
  final double zoom;
  final String tName;

  const DelftVisualization({
    super.key,
    required this.his,
    required this.overlayImages,
    required this.length,
    required this.url,
    required this.startDate,
    required this.bound1,
    required this.bound2,
    required this.center,
    required this.tName,
    required this.zoom,
  });

  @override
  State<DelftVisualization> createState() => _DelftVisualizationState();
}

class _DelftVisualizationState extends State<DelftVisualization> {
  late Timer _timer;
  int _currentIndex = 0;
  bool _isPlaying = true;
  bool _controlsVisible = true;
  late List<String> oI;
    // late List<dynamic> his;

  @override
  void initState() {
    oI = List.generate(
      widget.length,
      (index) => '${widget.url}\\raw\\$index.png',
    );
    super.initState();
    _startSlideshow();
    RawKeyboard.instance.addListener(_handleKeyPress);
  }

  String getFormattedDateTime() {
    final DateTime initialDate = DateTime.parse(widget.startDate);
    final DateTime updatedDate = initialDate.add(Duration(hours: _currentIndex));
    final DateFormat formatter = DateFormat('MMMM d, yyyy hh:mm a');
    return formatter.format(updatedDate);
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
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.space) {
        _togglePlayPause();
      } else if (event.logicalKey == LogicalKeyboardKey.enter) {
        setState(() {
          _controlsVisible = !_controlsVisible;
        });
      } else if (event.logicalKey == LogicalKeyboardKey.escape) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    RawKeyboard.instance.removeListener(_handleKeyPress);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final his = widget.his;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: widget.center,
              initialZoom: widget.zoom,
              interactionOptions: const InteractionOptions(pinchZoomWinGestures: 5),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              OverlayImageLayer(
                overlayImages: [
                  OverlayImage(
                    bounds: LatLngBounds(widget.bound1, widget.bound2),
                    opacity: 0.7,
                    imageProvider: FileImage(File(oI[_currentIndex])),
                  )
                ],
              ),
              MarkerLayer(
                markers: List.generate(
                  his['outputs'].length,
                  (index) {
                    final station = his['outputs'][index];
                    return Marker(
                      point: LatLng(station['lat'], station['lon']),
                      width: 40,
                      height: 40,
                      child: IconButton(
                        icon: const Icon(Icons.location_on, color: Colors.red, size: 30),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => Dialog(
                              backgroundColor: Colors.black87,
                              child: SizedBox(
                                width: 600,
                                height: 400,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Station: ${station['station']}',
                                            style: const TextStyle(color: Colors.white, fontSize: 16),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () => Navigator.of(context).pop(),
                                            icon: const Icon(Icons.close, color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(child: buildWaterLevelChart(station)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
           
           
            ],
          ),

          Positioned(
            top: 20,
            left: 20,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Typhoon ${widget.tName}',
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(getFormattedDateTime(),
                      style: const TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              children: [
                Slider(
                  value: _currentIndex.toDouble(),
                  min: 0,
                  max: (oI.length - 1).toDouble(),
                  onChanged: _seekTo,
                  onChangeStart: _onSliderChangeStart,
                  onChangeEnd: _onSliderChangeEnd,
                ),
                FloatingActionButton(
                  onPressed: _togglePlayPause,
                  child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWaterLevelChart(Map<String, dynamic> stationData) {
    final waterLevels = List<double>.from(stationData['waterlevel']);
    final List<_ChartData> chartData = List.generate(
      waterLevels.length,
      (i) => _ChartData(i, waterLevels[i]),
    );

    return SfCartesianChart(
      backgroundColor: Colors.transparent,
      primaryXAxis: NumericAxis(title: AxisTitle(text: 'Hour')),
      primaryYAxis: NumericAxis(title: AxisTitle(text: 'Water Level (m)')),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries<dynamic, dynamic>>[
        LineSeries<_ChartData, int>(
          dataSource: chartData,
          xValueMapper: (_ChartData data, _) => data.hour,
          yValueMapper: (_ChartData data, _) => data.level,
          name: 'Water Level',
          color: Colors.cyanAccent,
          markerSettings: const MarkerSettings(isVisible: false),
        )
      ],
    );
  }
}

class _ChartData {
  final int hour;
  final double level;
  _ChartData(this.hour, this.level);
}
