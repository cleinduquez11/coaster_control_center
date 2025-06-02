import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:coaster_control_center/provider/cfg.dart';
import 'package:coaster_control_center/provider/stateFile.dart';

class SwanCMDProvider with ChangeNotifier {
  String loading = '';
  String swanDir = '';


void reset() {
    loading = '';
   swanDir = '';
}
  void runSwanCmd(path) async {
    String curDir = Directory.current.path;
    loading = 'loading';
    
    notifyListeners();
           await File('$curDir${sndPath}input\\wind_estimation\\swan\\checker.txt').writeAsString(' ');
   await Process.start(
        'cmd',
        [
          '/c',
          'title Running SWAN model && python',
          '$curDir${sndPath}input\\wind_estimation\\swan\\run.py'
        ],
        includeParentEnvironment: true,
        mode: ProcessStartMode.detached);

    // await result.stdout.forEach((element) {
    //   print(element);
    // });

    Timer.periodic(const Duration(seconds: 1), (timer) async {
      String curDir = Directory.current.path;
      String filePath = '$curDir${sndPath}input\\wind_estimation\\swan\\checker.txt';

      File file = File(filePath);

      String c = await file.readAsString();

      if (c == 'finished') {
        loading = 'done';
         swanDir = path + '\\output\\swan\\out.mat';
         
          editSwanState('$path\\st\\state.txt', '$path\\output\\swan\\out.mat');
        // topoDir = path + '\\domain1.txt';
        print(c);
        print('Successfully Perform SWAN Computations');
        timer.cancel();
        notifyListeners();
      } 
      
    });
  }

  //     await result.stdout
  //   .transform(utf8.decoder)
  //   .forEach(print);
  //          await result.stderr
  //   .transform(utf8.decoder)
  //   .forEach(print);

  //         result.exitCode.then((value) {
  //           if (value == 0) {
  //           loading = 'done';
  //             // swanDir = path + '\\output\\typhoon\\isewan.prn';
  //             notifyListeners();
  //           print('Run Successfully');

  //         }
  //         }

  //         );

  // }
}
