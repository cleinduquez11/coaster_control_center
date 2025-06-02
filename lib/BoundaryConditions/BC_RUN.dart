import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:coaster_control_center/provider/cfg.dart';
import 'package:intl/intl.dart';
import 'package:xml/xml.dart';

class RUNBC with ChangeNotifier {
String loading = "";

void runBC() async {
   String curDir = Directory.current.path;
    loading = 'loading';

    // print(curDir);

    // await File('$curDir${sndPath}flow\\script\\copyFilesChecker.txt')
    //     .writeAsString(' ');

var process = await Process.start(
    'cmd',
    [
      '/c',
      'title Generate Boundary Conditions && python $curDir${sndPath}BoundaryConditions\\get_boundary_conditions_for_fm.py'
    ],
    runInShell: true,
            includeParentEnvironment: true,
        // mode: ProcessStartMode.normal,
        // runInShell: true,
    // includeParentEnvironment: true,
  mode: ProcessStartMode.detached,
  );


  // process.stdout.transform(SystemEncoding().decoder).listen((output) {
  //   print('Output: $output');
  // });

  // process.stderr.transform(SystemEncoding().decoder).listen((error) {
  //   print('Error: $error');
  // });

  // // // Wait for the process to complete
  // int exitCode = await process.exitCode;
  // if (exitCode == 0) {
  //   print('Process completed successfully!');
  // } else {
  //   print('Process failed with exit code: $exitCode');
  // }

  // print('Done');

}


}