import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:coaster_control_center/provider/cfg.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:convert';
import 'dart:io';

import 'package:xml/xml.dart';
// Example usage

class AddModelProvider with ChangeNotifier {
  String model_name = "";
  String model_description = "";
  String model_resolution = "";
  String model_topometry = "";
  String model_boundary_condition = "";
  String model_events = "";
  String model_timestep = "";
  String model_directory = "";
  String modelFileConfig = "";
  String modeler = "";
  bool complete = false;


    // 'continuous shade',
    // 'colored contour plot'

  String v_min = "-1";
  String v_max = "7";
  String colorMap = "jet";
  String plotStyle = "colored contour plot";
  final vMinController = TextEditingController();
  final vMaxController = TextEditingController();
  final colorMapController = TextEditingController();
    final plotStyleController = TextEditingController();
  // double centerLat = 12.8797;
  // double centerLon = 121.7740;
  // double centerZoom = 6.5;

  String centerLat = "12.8797";
  String centerLon = "121.7740";
  String centerZoom = "6.5";

  bool isSaved = false;

  String loading = "";

  final modelName = TextEditingController();
  final modelDescription = TextEditingController();
  final modelResolution = TextEditingController();
  final modelTopometry = TextEditingController();
  final modelBoundaryCondition = TextEditingController();
  final modelEvents = TextEditingController();
  final modelTimeStep = TextEditingController();
  final modelDirectory = TextEditingController();
  final modelerController = TextEditingController();

  final centerLatTextController = TextEditingController();
  final centerLonTextController = TextEditingController();
  final centerZoomTextController = TextEditingController();

  Future getModelDirectory() async {
    await windowManager
        .setAlignment(Alignment.center); // Center the Flutter window
    // String curDir =  Directory.current.path;
    // final result = await FilePicker.platform.getDirectoryPath(
    // dialogTitle: 'Select Model XML', lockParentWindow: true);
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom, // Use custom to specify allowed extensions
      allowedExtensions: ['xml'], // Allow only .xml files (case-insensitive)
      dialogTitle: "Select an XML File",
    );

    // print(result!.files.first.name);

    if (result != null) {
      // fileName = result.files.first.name;
      // modelDirectory.text = result.paths.first.toString();

      // String selectedFileName = result.files.first.name;
      String selectedFilePath = result.files.first.path.toString();

      model_directory = p.dirname(selectedFilePath);

      modelDirectory.text = selectedFilePath;

      print(model_directory);
      notifyListeners();
    }
  }

  void clearModel() {
    model_name = "";
    model_description = "";
    model_directory = "";
    modelFileConfig = "";
    modeler = "";
    complete = false;
    centerLat = "";
    centerLon = "";
    centerZoom = "";
    notifyListeners();
  }

  void getPresentationSetting(String lat, String lon, String zoomLvl) {
    centerLat = lat;
    centerLon = lon;
    centerZoom = zoomLvl;

    centerLatTextController.text = lat;
    centerLonTextController.text = lon;
    centerZoomTextController.text = zoomLvl;
    // centerLat = centerLatTextController.text;
    // centerLon = centerLonTextController.text;
    // centerZoom = centerZoomTextController.text;

    print(
        "CenterLat: ${centerLat}, CenterLon: ${centerLon}, Center Zoom: ${centerZoom}");
    notifyListeners();
  }

  void changeWorkingDirXML(String mdName) async {
    String curDir = Directory.current.path;
    loading = 'loading';

    String absPath = "$curDir$sndPath" + "flow\\models\\$mdName";
    String modelWorkingDir =
        "$curDir$sndPath" + "flow\\models\\$mdName\\dflowfm";
    final Directory directory = Directory(absPath);

    print(directory);

    if (directory.existsSync()) {
      // List all `.xml` files
      final xmlFiles = directory
          .listSync()
          .where((file) =>
              file is File && file.path.toLowerCase().endsWith('.xml'))
          .toList();

      if (xmlFiles.isNotEmpty) {
        String originalFilePath = xmlFiles[0].path;
        String fileName = originalFilePath.split("\\").last;
        File originalFile = File(originalFilePath);

        if (originalFile.existsSync()) {
          List<String> lst = await originalFile.readAsLines();

          print(lst.join('\n'));
          final document = XmlDocument.parse(lst.join('\n'));

          final workingDirElement =
              document.findAllElements('workingDir').first;

          // Print the original value
          print('Original workingDir: ${workingDirElement.text}');

          // Change the text value of 'workingDir'
          // final newWorkingDir = '/new/path';
          workingDirElement.innerText = modelWorkingDir;

          // Generate a new file name by appending "_updated"
          String newFileName = fileName.replaceFirst(fileName, '$mdName.xml');
          String newFilePath =
              originalFilePath.replaceFirst(fileName, newFileName);

          // Save the updated XML to the new file
          File updatedFile = File(newFilePath);
          await updatedFile.writeAsString(document.toXmlString(pretty: true));

          if (fileName != newFileName) {
            await originalFile.delete();
          }

          // Print confirmation
          print('Updated XML saved as: $newFilePath');
        }
      } else {
        print("No XML files found in the directory.");
      }
    } else {
      print("The directory does not exist.");
    }

    notifyListeners();
  }

  void runAddModelPy(String mdName) async {
    String curDir = Directory.current.path;
    loading = 'loading';

    notifyListeners();
    await File('$curDir${sndPath}flow\\script\\copyFilesChecker.txt')
        .writeAsString(' ');
    await Process.start(
      'cmd', ['/c', 'python', '$curDir${sndPath}flow\\script\\copyModel.py'],
      includeParentEnvironment: true,

      //  mode: ProcessStartMode.detached,
      runInShell: true,
    );

    // await result.stdout.forEach((element) {
    //   print(element);
    // });

    Timer.periodic(const Duration(seconds: 1), (timer) async {
      String curDir = Directory.current.path;
      String filePath = '$curDir${sndPath}flow\\script\\copyFilesChecker.txt';

      File file = File(filePath);

      String c = await file.readAsString();

      if (c == 'finished') {
        changeWorkingDirXML(mdName);
        loading = 'done';
        print(c);
        print('Successfully Added Model');
        timer.cancel();
        notifyListeners();
      }
    });
  }

  void getModelJson() async {
    String curDir = Directory.current.path;
    model_name = modelName.text;
    model_description = modelDescription.text;
    modeler = modelerController.text; // Replace with your TextEditingController

    v_min = (double.parse(vMinController.text) - 1).toString();
    v_max = double.parse(vMaxController.text).toString();
    colorMap = colorMapController.text;
    plotStyle = plotStyleController.text;

    final modelListFile = File('$curDir${sndPath}flow\\models\\models.json');
    final modelConfigFile =
        File('$curDir${sndPath}flow\\script\\copy_config.json');

    // Check if the files exist, if not, create them
    if (!await modelConfigFile.exists()) {
      await modelConfigFile.create(recursive: true);
      await modelListFile.writeAsString(jsonEncode({}));
    }

    if (!await modelListFile.exists()) {
      await modelListFile.create(recursive: true);
      await modelListFile
          .writeAsString(jsonEncode([])); // Initialize with an empty array
    }

    // Create model configuration data
    Map<String, dynamic> modelConfig = {
      "directory": model_directory,
      "name": model_name,
      "modeler": modeler,
      "description": model_description
    };

    await modelConfigFile.writeAsString(jsonEncode(modelConfig));
    print('Created model configuration file for $model_name');

    // Read existing JSON data from the model list file
    List<dynamic> existingData = [];
    if (await modelListFile.exists()) {
      String fileContent = await modelListFile.readAsString();
      existingData = jsonDecode(fileContent);
    }

    // New model entry
    Map<String, dynamic> newEntry = {
      "path": '$curDir${sndPath}flow\\models\\$model_name',
      "name": model_name,
      "modeler": modeler,
      "description": model_description,
      "resolution": model_resolution,
      "bed_level": model_topometry,
      "events": model_events,
      "boundary_condition": model_boundary_condition,
      "timestep": model_timestep,
      "position": {
        "lat": double.parse(centerLat), // Define these variables in your class
        "long": double.parse(centerLon)
      },
      "image": null,
      "extents": {
        "southWest": [null, null],
        "northEast": [null, null],
      },
  "post_processing": {
        "v_min": double.parse(v_min),
        "v_max": double.parse(v_max),
        "color_map": colorMap,
        "plot_style": plotStyle
  },
      "zoom": double.parse(centerZoom)
    };

    // Check for duplicate entry
    bool isDuplicate =
        existingData.any((entry) => entry["path"] == newEntry["path"]);

    if (isDuplicate) {
      print('Directory already exists in the file. Skipping addition.');
    } else {
      // Add new entry to the JSON file
      existingData.add(newEntry);
      await modelListFile.writeAsString(jsonEncode(existingData),
          mode: FileMode.write);

      print('Directory added successfully.');

      StreamController<bool> fileWriteController = StreamController<bool>();

      // Listen to the stream
      fileWriteController.stream.listen((isComplete) {
        if (isComplete) {
          // callback;
          // complete = true;
          // model_name = "";
          // model_description = "";
          // model_directory = "";
          // modelFileConfig = "";
          // modeler = "";
          // complete = false;
          // centerLat = "";
          // centerLon = "";
          // centerZoom = "";

          modelName.text = "";
          modelDescription.text = "";
          modelDirectory.text = "";
          modelerController.text = "";
          modelResolution.text = "";
          modelTopometry.text = "";
          modelEvents.text = "";
          modelBoundaryCondition.text = "";
          modelTimeStep.text = "";
          vMinController.text = "";
          vMaxController.text = "";
          colorMapController.text = "";
          plotStyleController.text = "";


          centerLatTextController.text = "";
          centerLonTextController.text = "";
          centerZoomTextController.text = "";

          notifyListeners();
          // Perform additional actions here if necessary
        }
      });

      try {
        // Write to the file asynchronously
        await modelListFile.writeAsString(jsonEncode(existingData),
            mode: FileMode.write);

        // Notify the listener that the process is done
        fileWriteController.add(true);
      } catch (e) {
        print("Error writing to file: $e");
        fileWriteController.add(false); // Notify if there's an error
      } finally {
        // Close the stream controller to prevent memory leaks
        await fileWriteController.close();
      }
    }

    notifyListeners();
  }

  void getModel() async {
    String curDir = Directory.current.path;
    model_name = modelName.text;

    model_description = modelDescription.text;
    modeler = modelerController.text;

    final modelListfile = File('$curDir$sndPath\\flow\\models\\mods.lst');
    final modelConfigFileState =
        File('$curDir$sndPath\\flow\\script\\copy.cnfg');

    // Check if the file exists, if not, create it
    if (!await modelConfigFileState.exists()) {
      await modelConfigFileState.create(recursive: true);
    }

    if (!await modelListfile.exists()) {
      await modelListfile.create(recursive: true);
    }

    modelFileConfig = '''
DIR,NAME,MOD,DESC
$model_directory,$model_name,$modeler,$model_description
''';

    isSaved = true;

    String dir_path = '$curDir$sndPath' + 'flow\\models\\' + '$model_name';
    String newEntry = '$curDir$sndPath' +
        'flow\\models\\' +
        '$model_name' +
        ',$model_name,$modeler,$model_description,$centerLat,$centerLon,$centerZoom,,,,,';

    // Read the content of the file
    List<String> lines = [];
    if (await modelListfile.exists()) {
      lines = await modelListfile.readAsLines();
    }

    // Check if the new directory already exists in the file
    bool isDuplicate =
        lines.any((line) => line.split(",")[0].contains('$dir_path'));

    if (isDuplicate) {
      print('Directory already exists in the file. Skipping addition.');
    } else {
      // Append the new entry to the file
      await modelListfile.writeAsString(newEntry, mode: FileMode.append);
      print('Directory added successfully.');
    }

    // await modelListfile.writeAsString(
    //     '\n$curDir$sndPath' + 'flow\\models\\' + '$model_name' + ',$model_name,$modeler,$model_description,$centerLat,$centerLon,$centerZoom',
    //     mode: FileMode.append);

    await modelConfigFileState.writeAsString(modelFileConfig);
    print('Created Model File for $model_name');
    notifyListeners();
  }
}
