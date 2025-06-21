import 'dart:async';
import 'dart:io';
import 'package:coaster_control_center/BoundaryConditions/BC_RUN.dart';
import 'package:coaster_control_center/Components/showOverlayOnTop.dart';
import 'package:coaster_control_center/FlowWidgets/FutureWidgetsSelector.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/AddModelProvider.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/FlowConfigFileProvider.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/RunModelProvider.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/changeModelProvider.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/postProcessingProvider.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:file_selector/file_selector.dart';

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

  const DelftVisualization(
      {super.key,
      required this.his,
      required this.overlayImages,
      required this.length,
      required this.url,
      required this.startDate,
      required this.bound1,
      required this.bound2,
      required this.center,
      required this.tName,
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
    // int cur = widget.length -1;
    oI = List.generate(
        widget.length, (index) => '${widget.url}\\raw\\$index.png');
    // oI = widget.overlayImages;
    super.initState();
    _startSlideshow();
    // Initialize RawKeyboardListener to listen to key events
    RawKeyboard.instance.addListener(_handleKeyPress);
  }

  String getFormattedDateTime() {
    final DateTime initialDate = DateTime.parse(widget.startDate);
    final DateTime updatedDate =
        initialDate.add(Duration(hours: _currentIndex));
    final DateFormat formatter =
        DateFormat('MMMM d, yyyy hh:mm a'); // 12-hour format with AM/PM
    return formatter.format(updatedDate);
  }

  void _startSlideshow() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.overlayImages.length;
        getFormattedDateTime();
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

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const FutureWidgetSelector()));
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
                    bounds: LatLngBounds(widget.bound1, widget.bound2),
                    opacity: 0.75,
                    // imageProvider:
                    imageProvider: FileImage(File(oI[_currentIndex])),
                    // imageProvider: AssetImage(
                    //     _overlayImages[_currentIndex]),
                    gaplessPlayback: true,
                  ),
                ],
              ),
              MarkerLayer(
                markers: List.generate(
                  widget.his['outputs'].length,
                  (index) {
                    final station = widget.his['outputs'][index];
                    return Marker(
                      point: LatLng(station['lat'], station['lon']),
                      width: 40,
                      height: 40,
                      child: IconButton(
                        icon: const Icon(Icons.remove_red_eye_outlined,
                            color: Colors.white, size: 15),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => Dialog(
                              backgroundColor: Colors.black87,
                              child: SizedBox(
                                width: 950,
                                height: 700,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Station: ${station['station']} (Lat: ${station['lat']}, Lon: ${station['lon']})',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          const Spacer(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton.icon(
                                                onPressed: () async {
                                                  final waterLevels =
                                                      List<double>.from(station[
                                                          'waterlevel']);
                                                  final DateTime initialDate =
                                                      DateTime.parse(
                                                          widget.startDate);

                                                  final List<_ChartData>
                                                      chartData = List.generate(
                                                    waterLevels.length,
                                                    (i) => _ChartData(
                                                        initialDate.add(
                                                            Duration(hours: i)),
                                                        waterLevels[i]),
                                                  );

                                                  bool isSaved =
                                                      await downloadCsv(
                                                          chartData,
                                                          station['station']
                                                              .toString());
                                                  Navigator.of(context).pop();
                                                  // final directory =
                                                  //     await getApplicationDocumentsDirectory();
                                                  // final path =
                                                  //     '${directory.path}/water_level_data.csv';
                                                  // final file = File(path);
                                                  // await file.writeAsString(csv);
                                                  if (isSaved) {
                                                    showTopSnackBar(
                                                        context,
                                                        'CSV downloaded',
                                                        Colors.green);
                                                  } else {
                                                    showTopSnackBar(
                                                        context,
                                                        'Failed to Download CSV',
                                                        Colors.red);
                                                  }
                                                },
                                                icon: Icon(Icons.download),
                                                label: Text('Download CSV'),
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.cyan),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            icon: const Icon(Icons.close,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: buildWaterLevelChart(context,
                                            station, widget.startDate)),
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
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Typhoon ${widget.tName}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    getFormattedDateTime(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            right: 60,
            bottom: 60,
            child: Center(
                child: Tooltip(
              message: "Post to Coaster Website",
              child: ElevatedButton.icon(
                onPressed: () {
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
            )),
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
                    color:
                        Colors.black.withOpacity(0.2), // 20% transparent white
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white
                          .withOpacity(0.5), // 50% transparent border
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

          //           Positioned(
          //   top: 700,
          //   left: 20,
          //   child: Column(
          //     children: List.generate(6, (index) {
          //       return Row(
          //         children: [
          //           Container(
          //             width: 20,
          //             height: 20,
          //             color: getJetColormap()[index],
          //           ),
          //           const SizedBox(width: 5),
          //           Text(
          //             '${6 - index}m',
          //             style: const TextStyle(color: Colors.white, fontSize: 16),
          //           ),
          //         ],
          //       );
          //     }),
          //   ),
          // ),

          Positioned(
            top: 300,
            right: 20,
            child: SizedBox(
              width: 90, // set your desired width
              height: 300, // set your desired height
              child: Image(
                image: FileImage(File('${widget.url}/raw/utils/colorbar.png')),
                fit: BoxFit.fill, // optional: to fill the box
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

  Widget buildWaterLevelChart(BuildContext context,
      Map<String, dynamic> stationData, String startDate) {
    final waterLevels = List<double>.from(stationData['waterlevel']);
    final DateTime initialDate = DateTime.parse(startDate);

    final List<_ChartData> chartData = List.generate(
      waterLevels.length,
      (i) => _ChartData(initialDate.add(Duration(hours: i)), waterLevels[i]),
    );

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          SizedBox(
            width: 850,
            height: 550,
            child: SfCartesianChart(
              backgroundColor: Colors.transparent,
              primaryXAxis: DateTimeAxis(
                title: AxisTitle(
                  text: 'Date',
                  textStyle: TextStyle(color: Colors.white),
                ),
                dateFormat: DateFormat('MM/dd/yyyy hh:mm a'),
                intervalType: DateTimeIntervalType.hours,
                interval: 6,
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                labelRotation: -45,
                axisLine: AxisLine(color: Colors.white),
                majorGridLines: MajorGridLines(color: Colors.white24),
              ),
              primaryYAxis: NumericAxis(
                title: AxisTitle(
                  text: 'Water Level (m)',
                  textStyle: TextStyle(color: Colors.white),
                ),
                labelStyle: TextStyle(color: Colors.white),
                axisLine: const AxisLine(color: Colors.white),
                majorGridLines: const MajorGridLines(color: Colors.white24),
                plotBands: <PlotBand>[
                  PlotBand(
                    isVisible: true,
                    start: 0,
                    end: 0,
                    borderColor: Colors.redAccent,
                    borderWidth: 2,
                    dashArray: <double>[4, 3],
                    textStyle: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                    verticalTextAlignment: TextAnchor.start,
                    horizontalTextAlignment: TextAnchor.end,
                  ),
                ],
              ),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                format: 'point.x : point.y m',
              ),
              series: <CartesianSeries<_ChartData, DateTime>>[
                SplineSeries<_ChartData, DateTime>(
                  dataSource: chartData,
                  xValueMapper: (_ChartData data, _) => data.time,
                  yValueMapper: (_ChartData data, _) => data.level,
                  name: 'Water Level',
                  color: Colors.cyanAccent,
                  splineType: SplineType.natural,
                  width: 2,
                  markerSettings: const MarkerSettings(isVisible: false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// Generates CSV from chartData
  Future<bool> downloadCsv(
      List<_ChartData> chartData, String stationName) async {
    final csvData = const ListToCsvConverter().convert([
      ['Date', 'Water Level (m)'],
      ...chartData.map((e) => [
            DateFormat('MM/dd/yyyy hh:mm a').format(e.time),
            e.level.toStringAsFixed(2),
          ]),
    ]);

    String? outputPath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save Water Level Data',
      fileName: '${stationName}_water_level.csv',
    );

    if (outputPath != null) {
      final file = File('$outputPath.csv');
      await file.writeAsString(csvData);
      return true;
    }
    return false;
  }
}

class _ChartData {
  final DateTime time;
  final double level;
  _ChartData(this.time, this.level);
}
