import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:coaster_control_center/provider/cfg.dart';

class NestFileProvider with ChangeNotifier {
  String fileName = '';
  String p = '-';

  Future getFile() async {
      String curDir =  Directory.current.path;
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    // print(result!.files.first.name);

    if (result != null) {
      fileName = result.files.first.name;
      p = result.files.first.path.toString();
      notifyListeners();
      // String command =
      //     'xcopy ${p}  ${Directory.current.path}\\lib\\Assets\\input\\swan\\for_area02.nest';
      await File('$curDir${sndPath}input\\wind_estimation\\swan\\nesting.txt')
          .writeAsString(p.toString());
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
}
