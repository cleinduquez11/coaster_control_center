import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:coaster_control_center/provider/cfg.dart';
import 'package:intl/intl.dart';
import 'package:xml/xml.dart';

class RUNSSI with ChangeNotifier {
String loading = "";

void runSSI() async {
   String curDir = Directory.current.path;
    loading = 'loading';


  String inputfile = """
@echo off
title Storm Surge Identifier

REM Set CMD window size (width x height) and position (left, top)
mode con: cols=80 lines=25


REM Activate the Conda environment
call conda activate coaster_py_env

REM Run the Python script
python "%CD%\\${sndPath}SSI\\part1_edited_auto_mode.py"

REM Pause to view the output
pause

""";


    await File('$curDir${sndPath}SSI\\RUN Storm Surge Identifier.bat')
        .writeAsString(inputfile);


    // await File('$curDir${sndPath}flow\\script\\copyFilesChecker.txt')
    //     .writeAsString(' ');

var process = await Process.start(
    'cmd',
    [
      '/c',
      '$curDir${sndPath}SSI\\RUN Storm Surge Identifier.bat'
    ],
    // runInShell: true,
            includeParentEnvironment: true,
        mode: ProcessStartMode.detached,
        runInShell: true,
    // includeParentEnvironment: true,
  // mode: ProcessStartMode.detached,
  );

  // Listen to stdout and stderr to capture output
  // process.stdout.transform(SystemEncoding().decoder).listen((output) {
  //   print('Output: $output');
  // });

  // process.stderr.transform(SystemEncoding().decoder).listen((error) {
  //   print('Error: $error');
  // });

  // // Wait for the process to complete
  // int exitCode = await process.exitCode;
  // if (exitCode == 0) {
  //   print('Process completed successfully!');
  // } else {
  //   print('Process failed with exit code: $exitCode');
  // }

  // print('Done');

}


}