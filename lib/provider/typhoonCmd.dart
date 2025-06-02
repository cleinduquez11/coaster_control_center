import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:coaster_control_center/provider/cfg.dart';
import 'package:coaster_control_center/provider/stateFile.dart';

class TyphoonCMDProvider with ChangeNotifier {
  String loading = '';
  String typhoonDir = '';


void reset() {
     loading = '';
   typhoonDir = '';

   notifyListeners();
}

  void runTyphoonCmd(path) async {
    String curDir = Directory.current.path;
    loading = 'loading';
    notifyListeners();
    await Process.start(
        'cmd',
        [
          '/c',
          'title Estimating Wind && python',
          '$curDir${sndPath}input\\typhoon\\makeWindInput.py'
        ],
        includeParentEnvironment: true,
        mode: ProcessStartMode.normal);



        
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      String curDir = Directory.current.path;
      String filePath = '$curDir${sndPath}input\\typhoon\\checker.txt';

      File file = File(filePath);

      String c = await file.readAsString();

      if (c == 'finished') {
          loading = 'done';
        typhoonDir = path + '\\output\\typhoon\\isewan.prn';
           editTropicalCycloneState('$path\\st\\state.txt', '$path\\output\\typhoon\\isewan.prn');
        // File('$path\\st\\state.txt').writeAsString('\n$path\\output\\typhoon\\isewan.prn', mode: FileMode.append);
        notifyListeners();
        print('Run Successfully');
        timer.cancel();
      }

      else if(c == 'error') {
                loading = 'error';
        // topoDir = topo + '\\domain1.txt';
        //   await editBaseMapState('$path\\st\\state.txt', '$path\\output\\topography\\domain1.txt');
      
        print(c);
        print('Error Occurred');
        timer.cancel();
        notifyListeners();
      }
      
      
       else {
        print('not yet finish');
      }
    });

    // await result.stdout.forEach((element) {
    //   print(element);
    // });
    // await result.stdout.transform(utf8.decoder).forEach(print);
    // await result.stderr.transform(utf8.decoder).forEach(print);


    // result.exitCode.then((value) {
    //   if (value == 0) {
    //     loading = 'done';
    //     typhoonDir = path + '\\output\\typhoon\\isewan.prn';
    //        editTropicalCycloneState('$path\\st\\state.txt', '$path\\output\\typhoon\\isewan.prn');
    //     // File('$path\\st\\state.txt').writeAsString('\n$path\\output\\typhoon\\isewan.prn', mode: FileMode.append);
    //     notifyListeners();
    //     print('Run Successfully');
    //   }
    // });
  }
}
