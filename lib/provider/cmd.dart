import 'dart:async';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:coaster_control_center/provider/cfg.dart';
import 'package:coaster_control_center/provider/stateFile.dart';

class CMDProvider with ChangeNotifier {
  String loading = '';
  String topoDir = '';


void reset() {
     loading = '';
   topoDir = '';
   notifyListeners();
}


  void runCmd(topo,path) async {
    loading = 'loading';
    notifyListeners();
       await File('${Directory.current.path}${sndPath}input\\topography\\checker.txt').writeAsString(' ');
  await Process.start(
        'cmd',
        [
          '/c',
          'python',
          '${Directory.current.path}${sndPath}input\\topography\\MakeTopography.py'
        ],
        includeParentEnvironment: true,
        mode: ProcessStartMode.detached);

    Timer.periodic(const Duration(seconds: 1), (timer) async {
      String curDir = Directory.current.path;
      String filePath = '$curDir${sndPath}input\\topography\\checker.txt';

      File file = File(filePath);

      String c = await file.readAsString();

      if (c == 'finished') {
        loading = 'done';
        topoDir = topo + '\\domain1.txt';
          await editBaseMapState('$path\\st\\state.txt', '$path\\output\\topography\\domain1.txt');
      
        print(c);
        print('Successfully Created Topography');
        timer.cancel();
        notifyListeners();
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
  }


  void runCopyCmd(topo,path) async {
    loading = 'loading';
    notifyListeners();
       await File('${Directory.current.path}${sndPath}input\\topography\\checker.txt').writeAsString(' ');
  await Process.start(
        'cmd',
        [
          '/c',
          'python',
          '${Directory.current.path}${sndPath}input\\topography\\CopyTopography.py'
        ],
        includeParentEnvironment: true,
        mode: ProcessStartMode.detached);

    Timer.periodic(const Duration(seconds: 1), (timer) async {
      String curDir = Directory.current.path;
      String filePath = '$curDir${sndPath}input\\topography\\checker1.txt';

      File file = File(filePath);

      String c = await file.readAsString();

      if (c == 'finished') {
        loading = 'done';
        topoDir = topo + '\\domain1.txt';
          await editBaseMapState('$path\\st\\state.txt', '$path\\output\\topography\\domain1.txt');
      
        print(c);
        print('Successfully Created Topography');
        timer.cancel();
        notifyListeners();
      }

       else {
        print('not yet finish');
      }
    });
  }


}


