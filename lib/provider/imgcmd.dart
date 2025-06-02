import 'dart:async';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:coaster_control_center/provider/cfg.dart';

class ImgProvider with ChangeNotifier {
  String loading = '';
  String plotDir = '';


void reset() {
     loading = '';
   plotDir = '';
}

  void plot(path) async {
     loading = 'loading';
     String curDir = Directory.current.path;
    
    notifyListeners();
           await File('$curDir${sndPath}input\\wind_estimation\\swan\\checker2.txt').writeAsString(' ');
   await Process.start(
        'cmd',
        [
          '/c',
          'python',
          '$curDir${sndPath}input\\wind_estimation\\swan\\img.py'
        ],
        includeParentEnvironment: true,
        mode: ProcessStartMode.detached);

    // await result.stdout.forEach((element) {
    //   print(element);
    // });

    Timer.periodic(const Duration(seconds: 1), (timer) async {
      String curDir = Directory.current.path;
      String filePath = '$curDir${sndPath}input\\wind_estimation\\swan\\checker2.txt';

      File file = File(filePath);

      String c = await file.readAsString();

      if (c == 'finished') {
        loading = 'done';
         plotDir = path + '\\output\\swan\\snapshot';
          //  editPlotState('$path\\st\\state.txt', '$path\\output\\swan\\snapshot\\000001.jpg');
        // topoDir = path + '\\domain1.txt';
        print(c);
        print('Successfully Created Plot');
        timer.cancel();
        notifyListeners();
      } 
      
    });
    
  }
}
