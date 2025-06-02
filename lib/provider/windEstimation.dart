import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:coaster_control_center/provider/cfg.dart';
import 'package:coaster_control_center/provider/stateFile.dart';

class WindEstimationCMDProvider with ChangeNotifier {
  String loading = '';
  String windDir = '';


void reset() {
    loading = '';
   windDir = '';
   notifyListeners();

}

  void runWindEstimationCmd(path) async {
    String curDir = Directory.current.path;
    // String pat = 'lib/Assets/input/wind_estimation/topo/for';
    loading = 'loading';
    notifyListeners();
    // await Process.start('cd',[pat]);
    await Process.start(
        'cmd',
        [
          '/c',
          'python',
          '$curDir${sndPath}input\\wind_estimation\\topo\\for\\run.py'
        ],
        includeParentEnvironment: true,
        mode: ProcessStartMode.detached);
    // final result = await Process.run('cmd',['/c','python','${Directory.current.path}\\lib\\Assets\\input\\wind_estimation\\topo\\for\\tr.py'],includeParentEnvironment: true,);

    // print(result.stderr);

    Timer.periodic(const Duration(seconds: 1), (timer) async {
      // String curDir = Directory.current.path;
      String filePath =
          '$curDir${sndPath}input\\wind_estimation\\topo\\for\\checker.txt';

      File file = File(filePath);

      String c = await file.readAsString();

      if (c == 'finished') {
        loading = 'done';
        windDir = path + '\\output\\wind\\SWAN-WIND-DATA01.txt';
           editWindState('$path\\st\\state.txt', '$path\\output\\wind\\SWAN-WIND-DATA01.txt');
        // topoDir = path + '\\domain1.txt';
        print(c);
        print('Successfully Perform Computations');
        timer.cancel();
        notifyListeners();
      }
      else if (c == 'finished') {
          loading = 'error';
        // windDir = path + '\\output\\wind\\SWAN-WIND-DATA01.txt';
        //    editWindState('$path\\st\\state.txt', '$path\\output\\wind\\SWAN-WIND-DATA01.txt');
        // topoDir = path + '\\domain1.txt';
        print(c);
        print('Successfully Perform Computations');
        timer.cancel();
        notifyListeners();
      }
      // else {
      //   print('not yet finish');
      // }
    });

    //       loading ='done';
    //  notifyListeners();
    //   print(result);

    //   if (result.stdout != '') {
    //        loading ='done';
    //  notifyListeners();
    //    print(result.stdout);
    //   }

    // if (result.stdout ) {
    //    loading ='done';
    //    notifyListeners();
    //      print(result.stdout);
    // }

    // if (result.exitCode == 0) {
    //   loading = 'done';
    //   windDir = path + '\\output\\typhoon\\isewan.prn';
    //   notifyListeners();
    //   print(result.stdout);
    // }
  }
}
