import 'dart:async' show Future;
import 'dart:io';

import 'package:coaster_control_center/provider/cfg.dart';

Future<List<String>> readLinesFromFile(String filePath) async {
  try {
    final file = File(filePath);
    final content = await file.readAsLines();
    return content;
  } catch (e) {
    // Handle errors (e.g., file not found)
    print("Error reading file: $e");
    return [];
  }
}

Future<String> readFromFile(String filePath) async {
  try {
    final file = File(filePath);
    final content = await file.readAsString();
    return content;
  } catch (e) {
    // Handle errors (e.g., file not found)
    print("Error reading file: $e");
    return '';
  }
}

Future<bool> checkStateFileExists(String directoryPath) async {
  try {
    final directory = Directory(directoryPath);
    if (await directory.exists()) {
   final file = File('${directory.path}/state.txt');
      if (await file.exists()) {
        return true;
      }
      else {
        return false;
      }
    
    } else {
      print("Directory does not exist: $directoryPath");
      return false;
    }
  } catch (e) {
    print("Error checking for file: $e");
    return false;
  }
}



Future<bool> checkFileExists(String filePath) async {
  try {
     final file = File(filePath);
    // final directory = Directory(directoryPath);
    if ( await file.exists()) {
     print('$filePath Exist');
      return true;
    } else {
      print('$filePath not Exist');
      // print("Directory does not exist: $directoryPath");
      return false;
    }
  } catch (e) {
    print("Error checking for file: $e");
    return false;
  }
}


Future<void> editDirState(String filePath, String newLine) async {
  // List newList = [];

  try {
    final file = File(filePath);
    if (await file.exists()) {
      final lines = await file.readAsLines();

      lines[0] = newLine;

      String newList = '';

      newList =
          '${lines[0].toString()}\n${lines[1].toString()}\n${lines[2].toString()}\n${lines[3].toString()}\n${lines[4].toString()}\n${lines[5].toString()}\n${lines[6].toString()}';

      file.writeAsString(newList);

      print("Dir State edited successfully!");
    } else {
      print("File does not exist: $filePath");
    }
  } catch (e) {
    print("Error editing file: $e");
  }
}

Future<void> editConfigState(String filePath, String newLine) async {
  // List newList = [];

  try {
    final file = File(filePath);
    if (await file.exists()) {
      final lines = await file.readAsLines();

      lines[1] = newLine;

      String newList = '';

        newList =
          '${lines[0].toString()}\n${lines[1].toString()}\n${lines[2].toString()}\n${lines[3].toString()}\n${lines[4].toString()}\n${lines[5].toString()}\n${lines[6].toString()}';
      file.writeAsString(newList);

      print("Dir State edited successfully!");
    } else {
      print("File does not exist: $filePath");
    }
  } catch (e) {
    print("Error editing file: $e");
  }
}

Future<void> editBaseMapState(String filePath, String newLine) async {
  // List newList = [];

  try {
    final file = File(filePath);
    if (await file.exists()) {
      final lines = await file.readAsLines();

      lines[2] = newLine;

      String newList = '';

        newList =
          '${lines[0].toString()}\n${lines[1].toString()}\n${lines[2].toString()}\n${lines[3].toString()}\n${lines[4].toString()}\n${lines[5].toString()}\n${lines[6].toString()}';

      file.writeAsString(newList);

      print("Dir State edited successfully!");
    } else {
      print("File does not exist: $filePath");
    }
  } catch (e) {
    print("Error editing file: $e");
  }
}

Future<void> editTropicalCycloneState(String filePath, String newLine) async {
  // List newList = [];

  try {
    final file = File(filePath);
    if (await file.exists()) {
      final lines = await file.readAsLines();

      lines[3] = newLine;

      String newList = '';

       newList =
          '${lines[0].toString()}\n${lines[1].toString()}\n${lines[2].toString()}\n${lines[3].toString()}\n${lines[4].toString()}\n${lines[5].toString()}\n${lines[6].toString()}';

      file.writeAsString(newList);

      print("Dir State edited successfully!");
    } else {
      print("File does not exist: $filePath");
    }
  } catch (e) {
    print("Error editing file: $e");
  }
}





Future<void> copyRqmntsWind() async {
  // List newList = [];

  try {
   
     String curDir = Directory.current.path;

          //  await File('$curDir${sndPath}input\\wind_estimation\\\\checker1.txt').writeAsString(' ');
   await Process.start(
        'cmd',
        [
          '/c',
          'python',
          '$curDir${sndPath}input\\wind_estimation\\topo\\for\\tr.py'
        ],
        includeParentEnvironment: true,
        mode: ProcessStartMode.normal);
      print("Copied Wind Estimation requirements");
 
  } catch (e) {
    print("Error copying File file: $e");
  }
}



Future<void> copyRqmntsSwan() async {
  // List newList = [];

  try {
   
     String curDir = Directory.current.path;

          //  await File('$curDir${sndPath}input\\wind_estimation\\\\checker1.txt').writeAsString(' ');
   await Process.start(
        'cmd',
        [
          '/c',
          'python',
          '$curDir${sndPath}input\\wind_estimation\\swan\\tr.py'
        ],
        includeParentEnvironment: true,
        mode: ProcessStartMode.normal);
      print("Copied Swan requirements");
 
  } catch (e) {
    print("Error copying File file: $e");
  }
}


Future<void> copyRqmntsPlot() async {
  // List newList = [];

  try {
   
     String curDir = Directory.current.path;

          //  await File('$curDir${sndPath}input\\wind_estimation\\\\checker1.txt').writeAsString(' ');
   await Process.start(
        'cmd',
        [
          '/c',
          'python',
          '$curDir${sndPath}input\\wind_estimation\\swan\\plot_tr.py'
        ],
        includeParentEnvironment: true,
        mode: ProcessStartMode.normal);
      print("Copied Plot Requirements");
 
  } catch (e) {
    print("Error copying File file: $e");
  }
}



Future<void> editWindState(String filePath, String newLine) async {
  // List newList = [];

  try {
    final file = File(filePath);
    if (await file.exists()) {
      final lines = await file.readAsLines();

      lines[4] = newLine;

      String newList = '';

    newList =
          '${lines[0].toString()}\n${lines[1].toString()}\n${lines[2].toString()}\n${lines[3].toString()}\n${lines[4].toString()}\n${lines[5].toString()}\n${lines[6].toString()}';

      file.writeAsString(newList);

      print("Dir State edited successfully!");
    } else {
      print("File does not exist: $filePath");
    }
  } catch (e) {
    print("Error editing file: $e");
  }
}

Future<void> editSwanState(String filePath, String newLine) async {
  // List newList = [];

  try {
    final file = File(filePath);
    if (await file.exists()) {
      final lines = await file.readAsLines();

      lines[5] = newLine;

      String newList = '';

      newList =
          '${lines[0].toString()}\n${lines[1].toString()}\n${lines[2].toString()}\n${lines[3].toString()}\n${lines[4].toString()}\n${lines[5].toString()}\n${lines[6].toString()}';

      file.writeAsString(newList);

      print("Dir State edited successfully!");
    } else {
      print("File does not exist: $filePath");
    }
  } catch (e) {
    print("Error editing file: $e");
  }
}

Future<void> editPlotState(String filePath, String newLine) async {
  // List newList = [];

  try {
    final file = File(filePath);
    if (await file.exists()) {
      final lines = await file.readAsLines();

      lines[6] = newLine;

      String newList = '';

      newList =
          '${lines[0].toString()}\n${lines[1].toString()}\n${lines[2].toString()}\n${lines[3].toString()}\n${lines[4].toString()}\n${lines[5].toString()}\n${lines[6].toString()}';
      file.writeAsString(newList);

      print("Dir State edited successfully!");
    } else {
      print("File does not exist: $filePath");
    }
  } catch (e) {
    print("Error editing file: $e");
  }
}





/// Deletes a file at the given path.
Future<bool> deleteFile(String filePath) async {
  try {
    final file = File(filePath);
    await file.delete();
    return true;
  } catch (e) {
    // Handle error (e.g., file not found)
    print("Error deleting file: $e");
    return false;
  }
}

/// Deletes a directory at the given path recursively.
Future<bool> deleteDirectory(String directoryPath) async {
  try {
    final dir = Directory(directoryPath);
    await dir.delete(recursive: true);
    return true;
  } catch (e) {
    // Handle error (e.g., directory not found)
    print("Error deleting directory: $e");
    return false;
  }
}
