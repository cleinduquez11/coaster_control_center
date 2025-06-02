import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:coaster_control_center/Components/terminalDialog.dart';
import 'package:coaster_control_center/provider/cfg.dart';
import 'package:intl/intl.dart';
import 'package:xml/xml.dart';
import 'package:latlong2/latlong.dart';

class RunModelProvider with ChangeNotifier {
  String loading = "init";
  String outputText = "";
  List outputList = [];
  String outDir = " ";
  LatLng bound1 = LatLng(2.0525927337113665, 107.03514716442793);
  LatLng bound2 = LatLng(2.0525927337113665, 107.03514716442793);
  LatLng center = LatLng(2.0525927337113665, 107.03514716442793);
  double zoom = 7;

  final StreamController<String> _outputStreamController =
      StreamController<String>.broadcast();
  final ScrollController scrollController = ScrollController();
  final List<String> _outputLogs = [];
  Stream<String> get outputStream => _outputStreamController.stream;

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  reset() {
    loading = "init";
    outDir = " ";
    notifyListeners();
    print(loading);
  }

  void runDelftModel(String model_name) async {
    String curDir = Directory.current.path;
    // outDir = "loading";
    loading = 'loading';
    notifyListeners();

    await File('$curDir${sndPath}flow\\script\\runModelChecker.txt')
        .writeAsString(' ');

    String runName = "Running ${model_name} model";

    // String file = "$curDir${sndPath}flow\\models\\$model_name\\$model_name.xml";
    // String modelDirectory = "$curDir${sndPath}flow\\models\\$model_name\\";
    // ['/c', 'cd $modelDirectory && run_dimr $model_name.xml && cd $curDir && python "$curDir${sndPath}flow\\script\\delftPlotter.py"'],
    var process = await Process.start(
      'cmd',

      [
        '/c',
        'title $runName && python',
        '$curDir${sndPath}flow\\script\\runDelftModel.py'
      ],
      // mode: ProcessStartMode.normal,
      includeParentEnvironment: true,

      mode: ProcessStartMode.detached,
      // runInShell: true,
    );

    // process.stdout.transform(SystemEncoding().decoder).listen((output) {
    //   loading = 'loading';
    //   notifyListeners();
    //   // print('Output: $output');
    //   _outputLogs.add(output);
    //   _outputStreamController
    //       .add(_outputLogs.join('\n')); // Send entire log for StreamBuilder
    //   _scrollToBottom();
    // });

    // print(process.pid);

    // int exitCode = await process.exitCode;
    // if (exitCode == 0) {
    //      loading = "init";
    //   print('Process completed successfully!');
    //       print("loading: $loading");
    //   // loading = "exit";
    //   print('Process completed successfully!');
    //   notifyListeners();
    // } else {
    //   print('Process failed with exit code: $exitCode');
    // }

    Timer.periodic(const Duration(seconds: 1), (timer) async {
      String curDir = Directory.current.path;
      String filePath = '$curDir${sndPath}flow\\script\\runModelChecker.txt';
      File file = File(filePath);

      String c = await file.readAsString();

      if (c == 'finished') {
        String curDir = Directory.current.path;
        String filePath = '$curDir${sndPath}flow\\script\\run.json';
        final modelListfile = File(filePath);
        List<Map<String, dynamic>> data = [];
        if (await modelListfile.exists()) {
          String jsonString = await modelListfile.readAsString();

          dynamic decoded = jsonDecode(jsonString);
          print(decoded);

          outDir = "${decoded['output_directory']}\\raw\\";
          loading = "init";
          print(c);
          print('Model Processing Completed');
          timer.cancel();
          notifyListeners();
          String modelsPath = '$curDir${sndPath}flow\\models\\models.json';
          final modelListfile1 = File(modelsPath);
          if (await modelListfile1.exists()) {
            String jsonString1 = await modelListfile1.readAsString();

            List<dynamic> decoded1 = jsonDecode(jsonString1);
            print(decoded1); 

            decoded1.forEach(
              (element) {
                if (element['name'] == decoded['model_name']) {
                  center = LatLng(element['position']['lat'],
                      element['position']['long'] as double);
                  bound1 = LatLng(element['extents']['southWest'][0],
                      element['extents']['southWest'][1] as double);
                  bound2 = LatLng(element['extents']['northEast'][0],
                      element['extents']['northEast'][1]);
                  zoom = element['zoom'];
                  print(center);
                  print(bound1);
                  print(bound2);
                  print(zoom);
                  notifyListeners();
                } else {}
              },
            );
          }
        }
      }
    });

// print(_outputLogs);
    // // Listen to stdout and stderr to capture output
    // process.stdout.transform(SystemEncoding().decoder).listen((output) {
    //   print('Output: $output');
    //   // outputList.add(output);

    //   // showTerminalDialog(context, outputStream)
    //   // outputText = output;
    //   // notifyListeners();
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

  void runDelftOutputPlotter() {}

  void runDelftAutomationModel(String model_name) async {
    String curDir = Directory.current.path;

    // await File('$curDir${sndPath}flow\\script\\copyFilesChecker.txt')
    //     .writeAsString(' ');

    var process = await Process.start(
      'cmd',
      ['/c', 'python $curDir${sndPath}flow\\script\\automateModel.py'],
      includeParentEnvironment: true,
      mode: ProcessStartMode.normal,
    );

    process.stdout.transform(SystemEncoding().decoder).listen((output) {
      loading = 'loading';
      notifyListeners();
      // print('Output: $output');
      _outputLogs.add(output);
      _outputStreamController
          .add(_outputLogs.join('\n')); // Send entire log for StreamBuilder
      _scrollToBottom();
    });

    print(process.pid);

    process.stderr.transform(SystemEncoding().decoder).listen((error) {
      print('Error: $error');
    });

    int exitCode = await process.exitCode;
    if (exitCode == 0) {
      loading = "init";
      print('Process completed successfully!');
      print("loading: $loading");
      notifyListeners();
    } else {
      print('Process failed with exit code: $exitCode');
    }

// print(_outputLogs);
    // // Listen to stdout and stderr to capture output
    // process.stdout.transform(SystemEncoding().decoder).listen((output) {
    //   print('Output: $output');
    //   // outputList.add(output);

    //   // showTerminalDialog(context, outputStream)
    //   // outputText = output;
    //   // notifyListeners();
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

  @override
  void dispose() {
    _outputStreamController.close();
    scrollController.dispose();
    super.dispose();
  }
}
