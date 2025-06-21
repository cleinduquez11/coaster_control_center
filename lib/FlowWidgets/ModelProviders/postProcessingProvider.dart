import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:coaster_control_center/provider/cfg.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:convert';
import 'dart:io';
import 'package:latlong2/latlong.dart';
import 'package:xml/xml.dart';
// Example usage

class PostProcessingProvider with ChangeNotifier {
  String model_output_file = "";
  String model_output_file1 = " ";
  int modelLength = 0;
  bool isPlotted = false;
  String v_min = "-1";
  String v_max = "7";
  String colorMap = "jet";
  String plotStyle = "colored contour plot";
  String mods = "";
  String loading = " ";
  LatLng bound1 = LatLng(2.0525927337113665, 107.03514716442793);
  LatLng bound2 = LatLng(2.0525927337113665, 107.03514716442793);
  LatLng center = LatLng(2.0525927337113665, 107.03514716442793);
  double zoom = 7;

  final modelOutputFile = TextEditingController();
  final vMinController = TextEditingController();
  final vMaxController = TextEditingController();
  final colorMapController = TextEditingController();
  final modsController = TextEditingController();
    final plotStyleController = TextEditingController();
  Future<List<FileSystemEntity>> scanDirectory(
      String path, String extension) async {
    Directory dir = Directory(path);
    if (!await dir.exists()) {
      print("Directory does not exist.");
      return [];
    }

    return dir
        .list()
        .where((entity) => entity is File && entity.path.endsWith(extension))
        .toList();
  }

  void getModelOutputMap() async {
    String curDir = Directory.current.path;
    await windowManager
        .setAlignment(Alignment.center); // Center the Flutter window
    // String curDir =  Directory.current.path;
    // final result = await FilePicker.platform.getDirectoryPath(
    // dialogTitle: 'Select Model XML', lockParentWindow: true);
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom, // Use custom to specify allowed extensions
      allowedExtensions: ['nc'], // Allow only .xml files (case-insensitive)
      dialogTitle: "Select Model Output File(.nc)",
    );

    // print(result!.files.first.name);

    if (result != null) {
      // fileName = result.files.first.name;
      // modelDirectory.text = result.paths.first.toString();

      // String selectedFileName = result.files.first.name;
      String selectedFilePath = result.files.first.path.toString();

      model_output_file = p.dirname(selectedFilePath);
      model_output_file1 = p.dirname(selectedFilePath);

      modelOutputFile.text = selectedFilePath;

      print(model_output_file);
      notifyListeners();

      // String directoryPath = "C:/path/to/your/directory"; // Change this to your target directory
      String extension = ".png"; // Change this to the desired file extension

      List<FileSystemEntity> files =
          await scanDirectory("$model_output_file1\\raw\\", extension);

      if (files.isEmpty) {
        print(
            "No files with the extension '$extension' found in $model_output_file1");
        isPlotted = false;
        notifyListeners();
      } else {
        isPlotted = true;
        notifyListeners();
      }
    }
  }

  void setMapAttributes() async {
    String curDir = Directory.current.path;
    String modelsPath = '$curDir${sndPath}flow\\models\\models.json';
    final modelListfile1 = File(modelsPath);
    if (await modelListfile1.exists()) {
      String jsonString1 = await modelListfile1.readAsString();

      List<dynamic> decoded1 = jsonDecode(jsonString1);
      print(decoded1);
      print(mods);
      decoded1.forEach(
        (element) {
          if (element['name'] == mods) {
            center = LatLng(element['position']['lat'],
                element['position']['long'] as double);
            bound1 = LatLng(element['extents']['southWest'][0],
                element['extents']['southWest'][1] as double);
            bound2 = LatLng(element['extents']['northEast'][0],
                element['extents']['northEast'][1]);
            zoom = element['zoom'];

            print("Center: $center");
            print("Bound1: $bound1");
            print("Bound2: $bound2");
            print("Zoom: $zoom");
            // print(bound1);

            notifyListeners();
          } else {}
        },
      );
    }
  }

  void visualizeResults() async {
    String curDir = Directory.current.path;

    print("Output directory: " + model_output_file);
    print("vMin: " + v_min);
    print("vMax: " + v_max);
    print("ColorMap: " + colorMap);

    String filePath = '$curDir${sndPath}flow\\script\\run.json';
    final modelListfile = File(filePath);

    if (await modelListfile.exists()) {
      String jsonString = await modelListfile.readAsString();
      dynamic decoded = jsonDecode(jsonString);

      // Update JSON contents with new values
      decoded['post_processing']["output_file"] = model_output_file;
      decoded['post_processing']["v_min"] = v_min;
      decoded['post_processing']["v_max"] = v_max;
      decoded['post_processing']["color_map"] = colorMap;
      decoded['post_processing']["plot_style"] = plotStyle;

      // Write updated content back to the file
      await modelListfile
          .writeAsString(jsonEncode(decoded, toEncodable: (e) => e.toString()));

      loading = 'loading';
      notifyListeners();

      // await File('$curDir${sndPath}flow\\script\\runVisualizeChecker.txt')
      //     .writeAsString(' ');

      print("Updated run.json successfully!");
      // String file = "$curDir${sndPath}flow\\models\\$model_name\\$model_name.xml";
      // String modelDirectory = "$curDir${sndPath}flow\\models\\$model_name\\";
      // ['/c', 'cd $modelDirectory && run_dimr $model_name.xml && cd $curDir && python "$curDir${sndPath}flow\\script\\delftPlotter.py"'],
      var process = await Process.start(
        'cmd',

        ['/c', 'python', '$curDir${sndPath}flow\\script\\runVisualize.py'],
        // mode: ProcessStartMode.normal,
        includeParentEnvironment: true,

        mode: ProcessStartMode.detached,
        // runInShell: true,
      );

      // Timer.periodic(const Duration(seconds: 1), (timer) async {
      //   String curDir = Directory.current.path;
      //   String filePath =
      //       '$curDir${sndPath}flow\\script\\runVisualizeChecker.txt';
      //   File file = File(filePath);

      //   String c = await file.readAsString();

      //   if (c == 'finished') {
      //     loading = " ";
      //     print("Plotting Complete");
      //     timer.cancel();
      //     notifyListeners();
      //   }
      // });
    } else {
      print("run.json file not found!");
    }
  }
}
