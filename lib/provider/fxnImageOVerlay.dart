import 'dart:convert';
import 'dart:io';
import 'package:latlong2/latlong.dart';
import 'package:coaster_control_center/provider/cfg.dart';

Future<Map<String, dynamic>> LoadImages(String path) async {
  // int currentIndex = 0;
  // bool isPlaying = true;
  // int length = 0;

  // bool _isStarted = false;
  //  late DirProvider dirProvider;
  List<String> overlayImages = [];
  String curDir = Directory.current.path;
  String? startDate;
  int? length;
  String? tName;
  // String runJsonPath = '$curDir${sndPath}flow\\script\\run.json';
  String runJsonPath = '$path\\config.json';
  final runJsonFile = File(runJsonPath);

  final contents = await runJsonFile.readAsString();
  final data = json.decode(contents);

  String hisJsonFilePath = '$path\\raw\\utils\\his.json';
  final hisJsonfile = File(hisJsonFilePath);

  final hisContents = await hisJsonfile.readAsString();
  final his = json.decode(hisContents);

  // print("His: $his");

  startDate = data['start_date'];
  length = data['length'];
  tName = data['t_name'];

  final dir = Directory('$path\\raw');
  if (await dir.exists()) {
    final imageFiles =
        dir.listSync().where((item) => item.path.endsWith('.png')).toList();
    overlayImages = imageFiles.map((item) => item.path).toList();
  }

  // return overlayImages;

  return {
    'overlayImages': overlayImages,
    'startDate': startDate,
    'length': length,
    'tName': tName,
    'his': his
  };
}

Future<Map<String, dynamic>> LoadRawImages(String path, String mods) async {
  List<String> overlayImages = [];

  // Load image paths
  final dir = Directory("$path\\raw\\");
  if (await dir.exists()) {
    final imageFiles =
        dir.listSync().where((item) => item.path.endsWith('.png')).toList();
    overlayImages = imageFiles.map((item) => item.path).toList();
  }

  // Load map attributes
  LatLng? center;
  LatLng? bound1;
  LatLng? bound2;
  double? zoom;

  String curDir = Directory.current.path;
  String modelsPath = '$curDir${sndPath}flow\\models\\models.json';
  final modelListFile = File(modelsPath);

  String? startDate;
  int? length;
  String? tName;
  // String runJsonPath = '$curDir${sndPath}flow\\script\\run.json';
  // String runJsonPath = '$path\\utils\\config.json';

  String runJsonPath = '$path\\config.json';
  final runJsonFile = File(runJsonPath);
  // final runJsonFile = File(runJsonPath);

  final contents = await runJsonFile.readAsString();
  final data = json.decode(contents);

  String hisJsonFilePath = '$path\\raw\\utils\\his.json';
  final hisJsonfile = File(hisJsonFilePath);

  final hisContents = await hisJsonfile.readAsString();
  final his = json.decode(hisContents);

  print("His: $his");

  startDate = data['start_date'];
  length = data['length'];
  tName = data['t_name'];
  if (await modelListFile.exists()) {
    String jsonString = await modelListFile.readAsString();
    List<dynamic> decoded = jsonDecode(jsonString);

    for (var element in decoded) {
      if (element['name'] == mods) {
        center = LatLng(
          element['position']['lat'],
          element['position']['long'].toDouble(),
        );
        bound1 = LatLng(
          element['extents']['southWest'][0],
          element['extents']['southWest'][1].toDouble(),
        );
        bound2 = LatLng(
          element['extents']['northEast'][0],
          element['extents']['northEast'][1].toDouble(),
        );
        zoom = element['zoom'].toDouble();
        break;
      }
    }
  }

  // print(overlayImages);

  return {
    'overlayImages': overlayImages,
    'length': length,
    'center': center,
    'bound1': bound1,
    'bound2': bound2,
    'zoom': zoom,
    'startDate': startDate,
    'tName': tName,
    'his': his
  };
}

Future<List<String>> LoadModels() async {
  String curDir = Directory.current.path;

  List<String> models = [];

  String modelsPath = '$curDir${sndPath}flow\\models\\models.json';
  final modelListfile1 = File(modelsPath);
  if (await modelListfile1.exists()) {
    String jsonString1 = await modelListfile1.readAsString();

    List<dynamic> decoded1 = jsonDecode(jsonString1);
    // print(decoded1);

    models = decoded1.map((e) => e['name'].toString()).toList();
    // print(models);
  }
  return models;
}
