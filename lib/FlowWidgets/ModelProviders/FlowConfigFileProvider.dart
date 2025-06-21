import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:coaster_control_center/provider/cfg.dart';
import 'package:intl/intl.dart';
import 'package:window_manager/window_manager.dart';

class FlowConfigFileProvider with ChangeNotifier {
  String inputfile = '';

  String referrence_date = '';
  String t_start = '';
  String t_stop = '';
  String dt_user = '';
  String dt_nodal = '';
  String dt_init = '';
  String dt_max = '';
  String t_zone = '';
  String t_unit = '';
  String t_name = '';
  bool isSaved = false;
//Computational Area Parameters

  final referrenceDate = TextEditingController(text: "");
  final tName = TextEditingController(text: "");
  final tStart = TextEditingController(text: '');
  final tStop = TextEditingController(text: '');
  final dtUser = TextEditingController(text: '');
  final dtNodal = TextEditingController(text: '');
  final dtInit = TextEditingController(text: '');
  final dtMax = TextEditingController(text: '');
  final tZone = TextEditingController(text: '');
  final tUnit = TextEditingController(text: '');

  final outDir = TextEditingController(text: '');
  final spwFile = TextEditingController(text: '');
  final disFile = TextEditingController(text: '');
  final spwFileAutomate = TextEditingController(text: '');
    final outDirAutomate = TextEditingController(text: '');



  void reset() {
    inputfile = '';

    notifyListeners();
  }


  int runMode = 0;

  // String fileName = '';
  String p = '-';
  String q = '-';
  String dis = '-';
  String r = '-';
  String s = '-';

  String spdwFilePath = '-';
    String disFilePath = '-';

  Future getFile() async {
      await windowManager.setAlignment(Alignment.center); // Center the Flutter window
    // String curDir =  Directory.current.path;
    final result = await FilePicker.platform.getDirectoryPath(
        dialogTitle: 'Select Output Directory', lockParentWindow: true);
    // final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    // print(result!.files.first.name);

    if (result != null) {
      // fileName = result.files.first.name;
      outDir.text = result;
      p = result;
      notifyListeners();

      print(p);
      // String command =
      //     'xcopy ${p}  ${Directory.current.path}\\lib\\Assets\\input\\swan\\for_area02.nest';

      // await File('$curDir${sndPath}input\\wind_estimation\\swan\\nesting.txt')
      //     .writeAsString(p.toString());

      // await  File('lib/Assets/input/topography/${result.files.first}');
      // Process.run(command, []).then((ProcessResult results) {
      //   // Check the exit code to see if the command was successful
      //   if (results.exitCode == 0) {
      //     print('File copied successfully.');
      //   } else {
      //     print('Error occurred: ${results.stderr}');
      //   }
      // }).catchError((error) {
      //   print('Error occurred while executing the command: $error');
      // });
      // print(Directory.current.path);
      //         await File('lib/Assets/input/topography/topo.txt').writeAsString('$p');
      // print(result.files.first.path);
      // await new File('${result.toString()}/wd.txt').writeAsString('WorkDir ${result.toString()}');
    }
  }




  Future getFileAutomate() async {
      await windowManager.setAlignment(Alignment.center); // Center the Flutter window
    // String curDir =  Directory.current.path;
    final result = await FilePicker.platform.getDirectoryPath(
        dialogTitle: 'Select Output Directory', lockParentWindow: true);
    // final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    // print(result!.files.first.name);

    if (result != null) {
      // fileName = result.files.first.name;
      outDirAutomate.text = result;
      s = result;
      notifyListeners();

      print(s);

    }
  }



  
  Future getSpiderFileAutomate() async {
      await windowManager.setAlignment(Alignment.center); // Center the Flutter window
    // String curDir =  Directory.current.path;
    final result = await FilePicker.platform.getDirectoryPath(
        dialogTitle: 'Select Spider Web Directory', lockParentWindow: true);
    // final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    // print(result!.files.first.name);

    if (result != null) {
      // fileName = result.files.first.name;
      spwFileAutomate.text = result;
      r = result;
      notifyListeners();

      print(r);
    }
  }




  Future getSpiderWebFile(String modelName) async {
      await windowManager.setAlignment(Alignment.center); // Center the Flutter window
    // String curDir =  Directory.current.path;
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom, // Use custom to specify allowed extensions
        dialogTitle: 'Select SpiderWebFile',
        lockParentWindow: true,
        allowedExtensions: ["spw"]);
    // final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    // print(result!.files.first.name);

    if (result != null) {
      // fileName = result.files.first.name;
      spwFile.text = result.files.first.name;
      q = result.files.first.name;
      spdwFilePath = result.files.first.path.toString();
      print(q);
      notifyListeners();
      print(result.files.first.path);
  // final sourcePath = result.files.first.path;
  // final destinationPath = '${Directory.current.path}${sndPath}flow\\models\\$modelName\\dflowfm\\$q';

  // // Use `xcopy` with proper arguments
  // Process.run('xcopy', [
  //   sourcePath!,
  //   destinationPath,
  //   '/Y' // Overwrite without prompt
  // ]).then((ProcessResult results) {
  //   if (results.exitCode == 0) {
  //     print('File copied successfully.');
  //   } else {
  //     print('Error occurred: ${results.stderr}');
  //   }
  // }).catchError((error) {
  //   print('Error occurred while executing the command: $error');
  // });
      // print(Directory.current.path);
      //         await File('lib/Assets/input/topography/topo.txt').writeAsString('$p');
      // print(result.files.first.path);
      // await new File('${result.toString()}/wd.txt').writeAsString('WorkDir ${result.toString()}');
    }
  }



  Future getDischargeFile() async {
      await windowManager.setAlignment(Alignment.center); // Center the Flutter window
    // String curDir =  Directory.current.path;
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom, // Use custom to specify allowed extensions
        dialogTitle: 'Select Discharge',
        lockParentWindow: true,
        allowedExtensions: ["bc"]);
    // final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    // print(result!.files.first.name);

    if (result != null) {
      // fileName = result.files.first.name;
      disFile.text = result.files.first.name;
      dis = result.files.first.name;
      disFilePath =  result.files.first.path.toString();
      notifyListeners();

      print(dis);
      // String command =
      //     'xcopy ${p}  ${Directory.current.path}\\lib\\Assets\\input\\swan\\for_area02.nest';

      // await File('$curDir${sndPath}input\\wind_estimation\\swan\\nesting.txt')
      //     .writeAsString(p.toString());

      // await  File('lib/Assets/input/topography/${result.files.first}');
      // Process.run(command, []).then((ProcessResult results) {
      //   // Check the exit code to see if the command was successful
      //   if (results.exitCode == 0) {
      //     print('File copied successfully.');
      //   } else {
      //     print('Error occurred: ${results.stderr}');
      //   }
      // }).catchError((error) {
      //   print('Error occurred while executing the command: $error');
      // });
      // print(Directory.current.path);
      //         await File('lib/Assets/input/topography/topo.txt').writeAsString('$p');
      // print(result.files.first.path);
      // await new File('${result.toString()}/wd.txt').writeAsString('WorkDir ${result.toString()}');
    }
  }


  int calculateSecondsBetweenDates(String date1, String date2) {
    // Parse the input strings into DateTime objects
    final startDate = DateTime.parse(date1);
    final endDate = DateTime.parse(date2);

    //  final formattedStartDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(startDate);

    // Calculate the difference
    final duration = endDate.difference(startDate);

    // Return the difference in seconds
    return duration.inSeconds;
  }

  void readAndUpdateMDU(String model_name, List<String> updatedValues) async {
    //   String curDir = Directory.current.path;
    // File mduFile = File("$curDir$sndPath" + "flow\\models\\$model_name\\dflowfm\\FlowFM.mdu");

    //   if (mduFile.existsSync()) {

    //     List config = await mduFile.readAsLines();
    //     config[12].toString().split("=")[1].split('#')[0] = "eyyy";

    //     print(config);

    //   }

    String curDir = Directory.current.path;
    File mduFile = File(
        "$curDir$sndPath" + "flow\\models\\$model_name\\dflowfm\\FlowFM.mdu");

    if (mduFile.existsSync()) {
      List<String> toBeUpdatedLabel = [
        "Grid",
        "RefDate",
        "Tzone",
        "DtUser",
        "DtNodal",
        "DtMax",
        "DtInit",
        "Tunit",
        "TStart",
        "TStop",
        "OutputDir"
      ];
      List<int> toBeUpdatedLine = [
        10,
        124,
        125,
        126,
        127,
        128,
        129,
        130,
        131,
        132,
        157
      ];

      // Read the file's content
      List<String> config = await mduFile.readAsLines();
      // print('With white Spaces: $config');
      // print('Length With white Spaces: ${config.length}');
      config = config.where((line) => line.trim().isNotEmpty).toList();
      // print('Without white Spaces: $config');
      // print('Length Without white Spaces: ${config.length}');

      for (var i = 0; i < toBeUpdatedLine.length; i++) {
        if (config.length > toBeUpdatedLine[i]) {
          List<String> parts = config[toBeUpdatedLine[i]].split("=");
          if (parts.length > 1) {
            // print(
            //     "${toBeUpdatedLabel[i]}: ${parts[1]}"); //for debugging purposes
            // Update the value before the '#' (comment)
            // String updatedValue = "eyyy";
            parts[1] = " " +
                updatedValues[i].padRight(22) +
                "\t" +
                (parts[1].contains('#')
                    ? parts[1].substring(parts[1].indexOf('#'))
                    : '');
            config[toBeUpdatedLine[i]] = parts.join("=");
          }
        }
      }

      //     for (var i in toBeUpdated) {
      //           if (config.length > i) {
      //   List<String> parts = config[i].split("=");
      //   if (parts.length > 1) {
      //     print("${toBeUpdatedLabel[]}: ${parts[1]}" );
      //     // Update the value before the '#' (comment)
      //     String updatedValue = "eyyy";
      //     parts[1] = " " + updatedValue.padRight(23) + (parts[1].contains('#') ? parts[1].substring(parts[1].indexOf('#')) : '');
      //     config[i] = parts.join("=");
      //   }
      // }
      //     }

      //  print(config[131].split("=")[1].split('#')[0]);
      // Name of the Grid
      // Modify the value on the 13th line (index 12)
      // if (config.length > 10) {
      //   List<String> parts = config[10].split("=");
      //   if (parts.length > 1) {
      //     print("Grid: ${parts[1]}" );
      //     // Update the value before the '#' (comment)
      //     String updatedValue = "eyyy";
      //     parts[1] = " " + updatedValue.padRight(23) + (parts[1].contains('#') ? parts[1].substring(parts[1].indexOf('#')) : '');
      //     config[12] = parts.join("=");
      //   }
      // }

      //     // reference date
      //     // Modify the value on the 13th line (index 12)
      // if (config.length > 124) {
      //   List<String> parts = config[124].split("=");
      //   print(parts);
      //   if (parts.length > 1) {
      //     // Update the value before the '#' (comment)
      //           print("Reference date: ${parts[1]}" );
      //     // String updatedValue = "eyyy";
      //     // parts[1] = " " + updatedValue.padRight(23) + (parts[1].contains('#') ? parts[1].substring(parts[1].indexOf('#')) : '');
      //     // config[12] = parts.join("=");
      //   }
      // }

      //         // Time Zone
      //     // Modify the value on the 13th line (index 12)
      // if (config.length > 125) {
      //   List<String> parts = config[125].split("=");
      //   print(parts);
      //   if (parts.length > 1) {
      //     // Update the value before the '#' (comment)
      //         // print(parts[1]);
      //          print("Time Zone: ${parts[1]}" );
      //     // String updatedValue = "eyyy";
      //     // parts[1] = " " + updatedValue.padRight(23) + (parts[1].contains('#') ? parts[1].substring(parts[1].indexOf('#')) : '');
      //     // config[12] = parts.join("=");
      //   }
      // }

      //             // dtUser
      //     // Modify the value on the 13th line (index 12)
      // if (config.length > 126) {
      //   List<String> parts = config[126].split("=");
      //   print(parts);
      //   if (parts.length > 1) {
      //     // Update the value before the '#' (comment)
      //         // print(parts[1]);
      //           print("dtUser: ${parts[1]}" );
      //     // String updatedValue = "eyyy";
      //     // parts[1] = " " + updatedValue.padRight(23) + (parts[1].contains('#') ? parts[1].substring(parts[1].indexOf('#')) : '');
      //     // config[12] = parts.join("=");
      //   }
      // }

      //     // DtNodal

      //     if (config.length > 127) {
      //   List<String> parts = config[127].split("=");
      //   print(parts);
      //   if (parts.length > 1) {
      //     // Update the value before the '#' (comment)
      //         // print(parts[1]);
      //           print("DtNodal: ${parts[1]}" );
      //     // String updatedValue = "eyyy";
      //     // parts[1] = " " + updatedValue.padRight(23) + (parts[1].contains('#') ? parts[1].substring(parts[1].indexOf('#')) : '');
      //     // config[12] = parts.join("=");
      //   }
      // }

      //     // DtMax

      //     if (config.length > 128) {
      //   List<String> parts = config[128].split("=");
      //   print(parts);
      //   if (parts.length > 1) {
      //     // Update the value before the '#' (comment)
      //         // print(parts[1]);
      //            print("DtMax: ${parts[1]}" );
      //     // String updatedValue = "eyyy";
      //     // parts[1] = " " + updatedValue.padRight(23) + (parts[1].contains('#') ? parts[1].substring(parts[1].indexOf('#')) : '');
      //     // config[12] = parts.join("=");
      //   }
      // }
      //     // DtInit

      //     if (config.length > 129) {
      //   List<String> parts = config[129].split("=");
      //   print(parts);
      //   if (parts.length > 1) {
      //     // Update the value before the '#' (comment)
      //         // print(parts[1]);
      //         print("DtInit: ${parts[1]}" );
      //     // String updatedValue = "eyyy";
      //     // parts[1] = " " + updatedValue.padRight(23) + (parts[1].contains('#') ? parts[1].substring(parts[1].indexOf('#')) : '');
      //     // config[12] = parts.join("=");
      //   }
      // }

      //         // Tunit

      //     if (config.length > 130) {
      //   List<String> parts = config[130].split("=");
      //   print(parts);
      //   if (parts.length > 1) {
      //     // Update the value before the '#' (comment)
      //         // print(parts[1]);
      //          print("Tunit: ${parts[1]}" );
      //     // String updatedValue = "eyyy";
      //     // parts[1] = " " + updatedValue.padRight(23) + (parts[1].contains('#') ? parts[1].substring(parts[1].indexOf('#')) : '');
      //     // config[12] = parts.join("=");
      //   }
      // }

      //         // TStart

      //     if (config.length > 131) {
      //   List<String> parts = config[131].split("=");
      //   print(parts);
      //   if (parts.length > 1) {
      //     // Update the value before the '#' (comment)
      //         // print(parts[1]);
      //          print("TStart: ${parts[1]}" );
      //     // String updatedValue = "eyyy";
      //     // parts[1] = " " + updatedValue.padRight(23) + (parts[1].contains('#') ? parts[1].substring(parts[1].indexOf('#')) : '');
      //     // config[12] = parts.join("=");
      //   }
      // }

      //             // TStop

      //     if (config.length > 132) {
      //   List<String> parts = config[132].split("=");
      //   print(parts);
      //   if (parts.length > 1) {
      //     // Update the value before the '#' (comment)
      //         // print(parts[1]);
      //           print("TStop: ${parts[1]}" );
      //     // String updatedValue = "eyyy";
      //     // parts[1] = " " + updatedValue.padRight(23) + (parts[1].contains('#') ? parts[1].substring(parts[1].indexOf('#')) : '');
      //     // config[12] = parts.join("=");
      //   }
      // }

      // Add a newline before section headers like [geometry]
      List<String> updatedLines = [];
      for (int i = 0; i < config.length; i++) {
        String line = config[i];
        if (line.trim().startsWith('[') && line.trim().endsWith(']')) {
          // If the previous line is not empty, insert a blank line
          if (i > 0 && updatedLines.last.trim().isNotEmpty) {
            updatedLines.add('');
          }
        }
        updatedLines.add(line);
      }

      // Write the updated content back to the file
      await mduFile.writeAsString(updatedLines.join('\n'));

      // print("Updated file content:");
      // print(updatedLines.join('\n'));
          runMode = 1;
          notifyListeners();
    } else {
      // print("File not found.");
    }
  }



  void getValsAutomate(String model_name) async {
    String curDir = Directory.current.path;
     
    // String absPath = "$curDir${sndPath}flow\\models\\$model_name\\dflowfm\\";
    // final Directory directory = Directory(absPath); 


    final modelAutomatinConfigFile = File('$curDir${sndPath}flow\\script\\automate.json');
    // final modelConfigFile =
    //     File('$curDir${sndPath}flow\\script\\copy_config.json');

    // Check if the files exist, if not, create them
    if (!await modelAutomatinConfigFile.exists()) {
      await modelAutomatinConfigFile.create(recursive: true);
      await modelAutomatinConfigFile.writeAsString(jsonEncode({}));
    }

  //  referrence_date = referrenceDate.text.toString();

        Map<String, dynamic> modelAutomationConfig = {
      "model_name": model_name,
      "spdw_directory": spwFileAutomate.text.toString(),
      "output_directory": outDirAutomate.text.toString()

    };

    await modelAutomatinConfigFile.writeAsString(jsonEncode(modelAutomationConfig));
    print('Created model automation configuration file for $model_name located in ${outDirAutomate.text}' );

    isSaved = true;
    runMode = 2;
    notifyListeners();

    //  await mduFile.writeAsString(updatedLines.join('\n'));

  }


Future<void> updateFilenameInExtFile({
  required String extFilePath,
  required String newFilenamePath,
}) async {
  final file = File(extFilePath);

  if (!await file.exists()) {
    throw Exception("File does not exist: $extFilePath");
  }

  final lines = await file.readAsLines();
  final updatedLines = lines.map((line) {
    final trimmed = line.trim();
    if (trimmed.startsWith('FILENAME=')) {
      return 'FILENAME=$newFilenamePath';
    }
    return trimmed;
  }).toList();

  await file.writeAsString(updatedLines.join('\n'));
}



Future<void> updateForcingFileForQuantity({
  required String filePath,
  required String quantityTarget,
  required String newForcingFile,
}) async {
  final file = File(filePath);
  if (!await file.exists()) throw Exception("File not found: $filePath");

  final lines = await file.readAsLines();
  final updatedLines = <String>[];

  bool inBoundaryBlock = false;
  bool matchesQuantity = false;

  for (var line in lines) {
    final trimmedLine = line.trim();

    if (trimmedLine == '[boundary]') {
      inBoundaryBlock = true;
      matchesQuantity = false;
      updatedLines.add(trimmedLine);
      continue;
    }

    if (inBoundaryBlock && trimmedLine.startsWith('quantity=')) {
      matchesQuantity = trimmedLine.split('=').last.trim() == quantityTarget;
      updatedLines.add(trimmedLine);
      continue;
    }

    if (inBoundaryBlock && trimmedLine.startsWith('forcingFile=')) {
      if (matchesQuantity) {
        updatedLines.add('forcingFile=$newForcingFile');
      } else {
        updatedLines.add(trimmedLine);
      }
      continue;
    }

    // Handle any other lines or end of boundary block
    if (trimmedLine.isEmpty || trimmedLine.startsWith('[')) {
      inBoundaryBlock = false;
      matchesQuantity = false;
    }

    updatedLines.add(trimmedLine);
  }

  await file.writeAsString(updatedLines.join('\n'));
}





  void getVals(String model_name, String OutputDir) async {
    String curDir = Directory.current.path;
    String absPath = "$curDir$sndPath" + "flow\\models\\$model_name\\dflowfm\\";
    final Directory directory = Directory(absPath);
    referrence_date = referrenceDate.text.toString();
    t_start = tStart.text.toString();
    t_stop = tStop.text.toString();
    t_name = tName.text.toString();
    // dt_user = dtUser.text.toString();
    // dt_nodal = dtNodal.text.toString();

    String referrenceDateFormatted =
        "${referrence_date.substring(0, 4)}-${referrence_date.substring(4, 6)}-${referrence_date.substring(6, 8)}";
    String startFormatted =
        "${t_start.substring(0, 4)}-${t_start.substring(4, 6)}-${t_start.substring(6, 8)} ${t_start.substring(8, 10)}:${t_start.substring(10, 12)}:${t_start.substring(12, 14)}";
    String endFormatted =
        "${t_stop.substring(0, 4)}-${t_stop.substring(4, 6)}-${t_stop.substring(6, 8)} ${t_stop.substring(8, 10)}:${t_stop.substring(10, 12)}:${t_stop.substring(12, 14)}";

    int t_start_in_seconds =
        calculateSecondsBetweenDates(referrenceDateFormatted, startFormatted);
    int t_stop_in_seconds =
        calculateSecondsBetweenDates(referrenceDateFormatted, endFormatted);


    final modelConfigFile = File('$curDir${sndPath}flow\\script\\run.json');
        if (!await modelConfigFile.exists()) {
      await modelConfigFile.create(recursive: true);
      await modelConfigFile.writeAsString(jsonEncode({}));
    }




        Map<String, dynamic> modelAutomationConfig = {
      "model_name": model_name,
      "output_directory": OutputDir,
      "length": 0,
      't_name': t_name,
      "start_date": startFormatted,
      "post_processing": {
        "output_file":"",
        "v_min": 0,
        "v_max": 3,
        "color_map": "",
        "plot_style": ""
      }

    };

    await modelConfigFile.writeAsString(jsonEncode(modelAutomationConfig));
    print('Created model automation configuration file for $model_name located in ${outDirAutomate.text}' );


    String gridName = '';
    print(directory);
    // String directory = "$curDir$sndPath";

    if (directory.existsSync()) {
      // List all `.nc` files
      final ncFiles = directory
          .listSync()
          .where((file) =>
              file is File && file.path.toLowerCase().endsWith('_net.nc'))
          .toList();
    // Map<String, String> config = {};



      final extFile =  directory.listSync().where((file) => file is File && file.path.toLowerCase().endsWith('flowfm.ext')).cast<File>()
    .first;

await updateFilenameInExtFile(
  extFilePath: extFile.path,
  newFilenamePath: spdwFilePath,
);


      final bndExtFile =  directory.listSync().where((file) => file is File && file.path.toLowerCase().endsWith('flowfm_bnd.ext')).cast<File>()
    .first;

await updateForcingFileForQuantity(
  filePath: bndExtFile.path,
  quantityTarget: 'dischargebnd',
  newForcingFile: disFilePath,
);


      // Print the list of `.nc` files
      // print(ncFiles);
      //       print("Grid Files: ${ncFiles[0].path}");
      //       String fPath = ncFiles[0].path.toString();
      //       print(fPath.split("\\").last);
      gridName = ncFiles[0].path.split("\\").last.toString();
      print("Grid Name: $gridName");
      // for (var file in ncFiles) {
      //   print("Grid Files: ${file.path}");
      //         print("Grid Files: ${file.path.split("\\")[-1]}");
      //   // print(file.path);
      // }
    } else {
      print("The directory does not exist.");
    }


    inputfile = '''
# Generated on 2024-07-22 08:55:48
# Deltares, Plugin D-FLOW FM Version 4.11.0.4098, D-Flow FM Version 1.2.177.142431

[General]
Program                           = D-Flow FM                   # Program name
Version                           = 1.2.177.142431              # FM kernel Version
FileVersion                       = 1.02                        # File format version (do not edit this)
GuiVersion                        = 4.11.0.4098                 # DeltaShell FM suite version
AutoStart                         = 0                           # Autostart simulation after loading MDU (0: no, 1: autostart, 2: autostartstop)
PathsRelativeToParent             = 1                           # Default: 0. Whether or not (1/0) to resolve file names (e.g. inside the *.ext file) relative to their direct parent, instead of to the toplevel MDU working dir

[geometry]
NetFile                           = $gridName                   # Unstructured grid file *_net.nc
BathymetryFile                    =                             # Bathymetry points file *.xyb
DryPointsFile                     =                             # Dry points file *.xyz (third column dummy z values), or dry areas polygon file *.pol (third column 1/-1: inside/outside)
GridEnclosureFile                 =                             # Enclosure polygon file *.pol (third column 1/-1: inside/outside)
WaterLevIniFile                   =                             # Initial water levels sample file *.xyz
LandBoundaryFile                  =                             # Land boundaries file *.ldb, used for visualization
ThinDamFile                       =                             # Polyline file *_thd.pli, containing thin dams
FixedWeirFile                     =                             # Polyline file *_fxw.pliz, containing fixed weirs with rows x, y, crest level, left ground level, right ground level
PillarFile                        =                             # Polyline file *.pliz, containing bridge pillars with rows x, y, drag coefficient and diameter
StructureFile                     =                             # File *.ini containing list of structures (pumps, weirs, gates and general structures)
VertplizFile                      =                             # Vertical layering file *_vlay.pliz with rows x, y, Z, first Z, nr of layers, second Z, layer type
ProflocFile                       =                             # Channel profile location file *_proflocation.xyz with rows x, y, z, profile number ref
ProfdefFile                       =                             # Channel profile definition file *_profdefinition.def with definition for all profile numbers
ProfdefxyzFile                    =                             # Channel profile definition file _profdefinition.def with definition for all profile numbers
Uniformwidth1D                    = 2                           # Uniform width for channel profiles not specified by profloc
ManholeFile                       =                             # File *.ini containing manholes
WaterLevIni                       = 0                           # Initial water level at missing s0 values
Bedlevuni                         = -5                          # Uniform bed level used at missing z values if BedlevType > 2
Bedslope                          = 0                           # Bed slope inclination if BedlevType > 2
BedlevType                        = 3                           # Bathymetry specification (1: at cell centers (from BathymetryFile), 2: at cell interfaces (from BathymetryFile), 3: at nodes, face levels mean of node values, 4: at nodes, face levels min. of node values, 5: at nodes, face levels max. of node values, 6: at cell centers, cell levels mean of node values)
Blmeanbelow                       = -999                        # If not -999d0, below this level the cell center bed level is the mean of surrouding net nodes
Blminabove                        = -999                        # If not -999d0, above this level the cell center bed level is the min. of surrouding net nodes
PartitionFile                     =                             # Domain partition polygon file *_part.pol for parallel run
AngLat                            = 0                           # Angle of latitude S-N, 0: no Coriolis
AngLon                            = 0                           # Angle of longitude E-W, 0: Greenwich, used in solar heat flux computation.
Conveyance2D                      = -1                          # -1: R=HU,0: R=H, 1: R=A/P, 2: K=analytic-1D conv, 3: K=analytic-2D conv
Nonlin2D                          = 0                           # Non-linear 2D volumes, only used if ibedlevtype=3 and Conveyance2D>=1
Sillheightmin                     = 0                           # Weir treatment only if both sills larger than this value
Makeorthocenters                  = 0                           # Switch from circumcentres to orthocentres in geominit (1: yes, 0: no)
Dcenterinside                     = 1                           # Limit cell center (1.0: in cell, 0.0: on c/g)
Bamin                             = 1E-06                       # Minimum grid cell area, in combination with cut cells
OpenBoundaryTolerance             = 3                           # Search tolerance factor between boundary polyline and grid cells, in cell size units
RenumberFlowNodes                 = 1                           # Renumber the flow nodes (1: yes, 0: no)
Kmx                               = 0                           # Maximum number of vertical layers
Layertype                         = 1                           # Vertical layer type (1: all sigma, 2: all z, 3: use VertplizFile)
Numtopsig                         = 0                           # Number of sigma layers in top of z-layer model
SigmaGrowthFactor                 = 1                           # Layer thickness growth factor from bed up
UseCaching                        = 1                           # Use caching of flow model geometry input (1: yes, 0: no)

[numerics]
CFLMax                            = 0.7                         # Maximum Courant number
AdvecType                         = 33                          # Advection type (0: none, 1: Wenneker, 2: Wenneker q(uio-u), 3: Perot q(uio-u), 4: Perot q(ui-u), 5: Perot q(ui-u) without itself, 33: Perot q(uio-u) fast
TimeStepType                      = 2                           # Time step handling (0: only transport, 1: transport + velocity update, 2: full implicit step-reduce, 3: step-Jacobi, 4: explicit)
Limtyphu                          = 0                           # Limiter type for waterdepth in continuity eqn. (0: none, 1: minmod, 2: van Leer, 3: Koren, 4: monotone central)
Limtypmom                         = 4                           # Limiter type for cell center advection velocity (0: none, 1: minmod, 2: van Leer, 3: Koren, 4: monotone central)
Limtypsa                          = 4                           # Limiter type for salinity transport (0: none, 1: minmod, 2: van Leer, 3: Koren, 4: monotone central)
Icgsolver                         = 4                           # Solver type (1: sobekGS_OMP, 2: sobekGS_OMPthreadsafe, 3: sobekGS, 4: sobekGS + Saadilud, 5: parallel/global Saad, 6: parallel/Petsc, 7: parallel/GS)
Maxdegree                         = 6                           # Maximum degree in Gauss elimination
FixedWeirScheme                   = 9                           # Fixed weir scheme (0: None, 6: Numerical, 8: Tabellenboek, 9: Villemonte)
FixedWeirContraction              = 1                           # Fixed weir flow width contraction factor
FixedWeirRelaxationcoef           = 0.6                         # Fixed weir relaxation coefficient for the computation of energy loss (0 <= coefficient <= 1)
Izbndpos                          = 0                           # Position of z boundary (0: Delft3D-FLOW, 1: on net boundary, 2: on specifiend polyline)
Tlfsmo                            = 3600                        # Fourier smoothing time on water level boundaries
Slopedrop2D                       = 0                           # Apply drop losses only if local bed slope > Slopedrop2D, (<=0: no drop losses)
Chkadvd                           = 0.1                         # Check advection terms if depth < chkadvdp, => less setbacks
Teta0                             = 0.55                        # Theta of time integration (0.5 < theta < 1)
Qhrelax                           = 0.01                        # Relaxation on Q-h open boundaries
cstbnd                            = 0                           # Delft3D type velocity treatment near boundaries for small coastal models (1: yes, 0: no)
Maxitverticalforestersal          = 0                           # Forester iterations for salinity (0: no vertical filter for salinity, > 0: max nr of iterations)
Maxitverticalforestertem          = 0                           # Forester iterations for temperature (0: no vertical filter for temperature, > 0: max nr of iterations)
Turbulencemodel                   = 3                           # Turbulence model (0: none, 1: constant, 2: algebraic, 3: k-epsilon, 4: k-tau)
Turbulenceadvection               = 3                           # Turbulence advection (0: none, 3: horizontally explicit and vertically implicit)
AntiCreep                         = 0                           # Include anti-creep calculation (0: no, 1: yes)
Maxwaterleveldiff                 = 0                           # Upper bound on water level changes (<=0: no bounds)
Maxvelocitydiff                   = 0                           # Upper bound on velocity changes (<=0: no bounds)
Epshu                             = 0.0001                      # Threshold water depth for wet and dry cells

[physics]
UnifFrictType                     = 1                           # Uniform friction type (0: Chezy, 1: Manning, 2: White-Colebrook)
UnifFrictCoef                     = 0.023                       # Uniform friction coefficient (0: no friction)
UnifFrictCoef1D                   = 0.023                       # Uniform friction coefficient in 1D links (0: no friction)
UnifFrictCoefLin                  = 0                           # Uniform linear friction coefficient for ocean models (0: no friction)
Umodlin                           = 0                           # Linear friction umod, for ifrctyp=4,5,6
Vicouv                            = 0.1                         # Uniform horizontal eddy viscosity
Dicouv                            = 0.1                         # Uniform horizontal eddy diffusivity
Vicoww                            = 1E-06                       # Uniform vertical eddy viscosity
Dicoww                            = 1E-06                       # Uniform vertical eddy diffusivity
Vicwminb                          = 0                           # Minimum viscosity in prod and buoyancy term
Smagorinsky                       = 0.2                         # Smagorinsky factor in horizontal turbulence
Elder                             = 0                           # Elder factor in horizontal turbulence
Irov                              = 0                           # Wall roughness type (0: free-slip, 1: partial-slip using wall_ks, 2: no-slip)
wall_ks                           = 0                           # Nikuradse roughness for side walls
Rhomean                           = 1000                        # Average water density
Idensform                         = 2                           # Density calculation (0: uniform, 1: Eckart, 2: UNESCO, 3: baroclinic case)
Ag                                = 9.81                        # Gravitational acceleration
TidalForcing                      = 0                           # Tidal forcing, if jsferic = 1 (0: no, 1: yes)
Doodsonstart                      = 55.565                      # TRIWAQ: 55.565, D3D: 57.555
Doodsonstop                       = 375.575                     # TRIWAQ: 375.575, D3D: 275.555
Doodsoneps                        = 0                           # TRIWAQ = 0.0  400 cmps , D3D = 0.03   60 cmps
Salinity                          = 0                           # Include salinity, (0: no, 1: yes)
InitialSalinity                   = 0                           # Uniform initial salinity concentration
Sal0abovezlev                     = -999                        # Vertical level above which salinity is set 0
DeltaSalinity                     = -999                        # for testcases
Backgroundsalinity                = 30                          # Background salinity for eqn. of state
InitialTemperature                = 6                           # Uniform initial water temperature
Secchidepth                       = 2                           # Water clarity parameter
Stanton                           = -1                          # Coefficient for convective heat flux
Dalton                            = -1                          # Coefficient for evaporative heat flux
Backgroundwatertemperature        = 6                           # Background water temperature for eqn. of state
SecondaryFlow                     = 0                           # Secondary flow (0: no, 1: yes)
EffectSpiral                      = 0                           # Weight factor of the spiral flow intensity on transport angle
BetaSpiral                        = 0                           # Weight factor of the spiral flow intensity on flow dispersion stresses
Temperature                       = 0                           # Include temperature (0: no, 1: only transport, 3: excess model of D3D, 5: composite (ocean) model)

[wind]
ICdtyp                            = 2                           # Wind drag coefficient type (1: constant, 2: S&B 2 breakpoints, 3: S&B 3 breakpoints, 4: Charnock constant, 5: Whang)
Cdbreakpoints                     = 0.00063 0.00723             # Wind drag coefficient break points
Windspeedbreakpoints              = 0 100                       # Wind speed break points
Rhoair                            = 1.2                         # Air density
PavBnd                            = 0                           # Average air pressure on open boundaries (only applied if > 0)
PavIni                            = 0                           # Average air pressure for initial water level correction (only applied if > 0)

[waves]
Wavemodelnr                       = 0                           # Wave model nr. (0: none, 1: fetch/depth limited Hurdle-Stive, 2: Young-Verhagen, 3: SWAN)
WaveNikuradse                     = 0.01                        # Wave friction Nikuradse ks c , used in Krone-Swart
Rouwav                            = FR84                        # Friction model for wave induced shear stress
Gammax                            = 1                           # Maximum wave height/water depth ratio

[time]
RefDate                           = $referrence_date            # Reference date [YYYY-MM-DD HH:MM:SS]
Tzone                             = $t_zone                           # Time zone assigned to input time series
DtUser                            = $dt_user                    # Time interval for external forcing update [Dd HH:MM:SS.ZZZ]
DtNodal                           = $dt_nodal                   # Time interval (s) for updating nodal factors in astronomical boundary conditions [Dd HH:MM:SS.ZZZ]
DtMax                             = $dt_max                          # Maximal computation timestep
DtInit                            = $dt_init                           # Initial computation timestep
Tunit                             = $t_unit                           # Time unit for start/stop times (H, M or S)
TStart                            = $t_start_in_seconds         # Start time w.r.t. RefDate (in TUnit)
TStop                             = $t_stop_in_seconds          # Stop  time w.r.t. RefDate (in TUnit)

[restart]
RestartFile                       =                             # Restart netcdf-file, either *_rst.nc or *_map.nc
RestartDateTime                   = 20240518                    # Restart date and time when restarting from *_map.nc [YYYY-MM-DD HH:MM:SS]

[external forcing]
ExtForceFile                      = FlowFM.ext                  # Old format for external forcings file *.ext, link with tim/cmp-format boundary conditions specification
ExtForceFileNew                   = FlowFM_bnd.ext              # New format for external forcings file *.ext, link with bc-format boundary conditions specification

[trachytopes]
TrtRou                            = N                           # Include alluvial and vegetation roughness (trachytopes) (Y: yes, N: no)
TrtDef                            =                             # File (*.ttd) containing trachytope definitions
TrtL                              =                             # File (*.arl) containing distribution of trachytope definitions
DtTrt                             = 60                          # Trachytope roughness update time interval

[output]
WaqInterval                       = 0                           # Interval (in s) between DELWAQ file outputs
Wrishp_crs                        = 0                           # Write shape file for cross section
Wrishp_weir                       = 0                           # Write shape file for weirs
Wrishp_gate                       = 0                           # Write shape file for gates
Wrishp_fxw                        = 0                           # Write shape file for fixed weirs
Wrishp_thd                        = 0                           # Write shape file for thin dams
Wrishp_obs                        = 0                           # Write shape file for observation stations
Wrishp_emb                        = 0                           # Write shape file for embankments
Wrishp_dryarea                    = 0                           # Write shape file for dry area
Wrishp_enc                        = 0                           # Write shape file for enclosure
Wrishp_src                        = 0                           # Write shape file for sources
Wrishp_pump                       = 0                           # Write shape file for pump
OutputDir                         = $p                          # Output directory of map-, his-, rst-, dat- and timings-files, default: DFM_OUTPUT_<modelname>. Set to . for current dir.
WAQOutputDir                      =                             # Output directory of WAQ files, default: DFM_DELWAQ_<modelname>. Set to . for current dir.
FlowGeomFile                      =                             # Flow geometry NetCDF *_flowgeom.nc
ObsFile                           = FlowFM_obs.xyn              # Points file *.xyn with observation stations with rows x, y, station name
CrsFile                           = FlowFM_crs.pli              # Polyline file *_crs.pli defining observation cross sections
HisFile                           =                             # History output file *_his.nc in NetCDF format
HisInterval                       = 3600                        # History output times, given as 'interval' 'start period' 'end period'
XLSInterval                       =                             # Interval between XLS history [Dd HH:MM:SS.ZZZ]
MapFile                           =                             # Map file output file *_map.nc in NetCDF format
MapInterval                       = 3600                        # Map file output times, given as 'interval' 'start period' 'end period'
RstInterval                       = 432000                      # Restart file output times, given as 'interval' 'start period' 'end period'
S1incinterval                     =                             # Interval (m) in incremental file for water levels s1
MapFormat                         = 4                           # Map file format (1: NetCDF, 2: Tecplot, 3: NetCFD and Tecplot)
Wrihis_balance                    = 1                           # Write mass balance totals to his file (1: yes, 0: no)
Wrihis_sourcesink                 = 1                           # Write sources-sinks statistics to his file (1: yes, 0: no)
Wrihis_structure_gen              = 1                           # Write general structure parameters to his file (1: yes, 0: no)
Wrihis_structure_dam              = 1                           # Write dam parameters to his file (1: yes, 0: no)
Wrihis_structure_pump             = 1                           # Write pump parameters to his file (1: yes, 0: no)
Wrihis_structure_gate             = 1                           # Write gate parameters to his file (1: yes, 0: no)
Wrihis_structure_weir             = 1                           # Write weir parameters to his file (1: yes, 0: no)
Wrihis_turbulence                 = 1                           # Write k, eps and vicww to his file (1: yes, 0: no)
Wrihis_wind                       = 1                           # Write wind velocities to his file (1: yes, 0: no)
Wrihis_rain                       = 1                           # Write precipitation to his file (1: yes, 0: no)
Wrihis_temperature                = 1                           # Write temperature to his file (1: yes, 0: no)
Wrihis_heat_fluxes                = 1                           # Write heat fluxes to his file (1: yes, 0: no)
Wrihis_salinity                   = 1                           # Write salinity to his file (1: yes, 0: no)
Wrihis_density                    = 1                           # Write density to his file (1: yes, 0: no)
Wrihis_waterlevel_s1              = 1                           # Write water level to his file (1: yes, 0: no)
Wrihis_waterdepth                 = 0                           # Write water depth to his file (1: yes, 0: no)
Wrihis_velocity_vector            = 1                           # Write velocity vectors to his file (1: yes, 0: no)
Wrihis_upward_velocity_component  = 0                           # Write upward velocity to his file (1: yes, 0: no)
Wrihis_sediment                   = 1                           # Write sediment transport to his file (1: yes, 0: no)
Wrihis_constituents               = 0                           # Write tracers to his file (1: yes, 0: no)
Wrimap_waterlevel_s0              = 1                           # Write water levels of previous time step to map file (1: yes, 0: no)
Wrimap_waterlevel_s1              = 1                           # Write water levels to map file (1: yes, 0: no)
Wrimap_velocity_component_u0      = 1                           # Write velocity component of previous time step to map file (1: yes, 0: no)
Wrimap_velocity_component_u1      = 1                           # Write velocity component to map file (1: yes, 0: no)
Wrimap_velocity_vector            = 1                           # Write cell-center velocity vectors to map file (1: yes, 0: no)
Wrimap_upward_velocity_component  = 1                           # Write upward velocity component on cell interfaces (1: yes, 0: no)
Wrimap_density_rho                = 1                           # Write flow density to map file (1: yes, 0: no)
Wrimap_horizontal_viscosity_viu   = 1                           # Write horizontal viscosity to map file (1: yes, 0: no)
Wrimap_horizontal_diffusivity_diu = 1                           # Write horizontal diffusivity to map file (1: yes, 0: no)
Wrimap_flow_flux_q1               = 1                           # Write flow flux to map file (1: yes, 0: no)
Wrimap_spiral_flow                = 1                           # Write spiral flow to map file (1: yes, 0: no)
Wrimap_numlimdt                   = 1                           # Write the number times a cell was Courant limiting to map file (1: yes, 0: no)
Wrimap_taucurrent                 = 1                           # Write the shear stress to map file (1: yes, 0: no)
Wrimap_chezy                      = 1                           # Write the Chezy roughness to map file (1: yes, 0: no)
Wrimap_turbulence                 = 1                           # Write vicww, k and eps to map-file (1: yes, 0: no)
Wrimap_wind                       = 1                           # Write wind velocities to map file (1: yes, 0: no)
Wrimap_heat_fluxes                = 0                           # Write heat fluxes to map file (1: yes, 0: no)
MapOutputTimeVector               =                             # File (*.mpt) containing fixed map output times w.r.t. RefDate
FullGridOutput                    = 0                           # Full grid output mode (0: compact, 1: full time-varying grid data)
EulerVelocities                   = 0                           # Euler velocities output (0: GLM, 1: Euler velocities)
ClassMapFile                      =                             # Class map file *_clm.nc
WaterlevelClasses                 = 0.0                         # Water level classes
WaterdepthClasses                 = 0.0                         # Water depth classes
ClassMapInterval                  = 0                           # Class output interval [Dd HH:MM:SS.ZZZ]
StatsInterval                     =                             # Interval (in s) between simulation statistics output [Dd HH:MM:SS.ZZZ]
TimingsInterval                   =                             # Timings statistics output interval [Dd HH:MM:SS.ZZZ]
Richardsononoutput                = 1                           # Write Richardson numbers (1: yes, 0: no)

''';
    isSaved = true;
    List<String> updatedValues = [
      gridName,
      referrence_date,
      t_zone,
      dt_user,
      dt_nodal,
      dt_max,
      dt_init,
      t_unit,
      t_start_in_seconds.toString(),
      t_stop_in_seconds.toString(),
      p
    ];

    readAndUpdateMDU(model_name, updatedValues);

    // await File('try.mdu').writeAsString(inputfile);
    print('Created Input File for the Model');
    notifyListeners();
  }






}
