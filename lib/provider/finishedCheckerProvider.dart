import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:coaster_control_center/provider/cfg.dart';

class CheckerProvider with ChangeNotifier {
  String fileName = '';

  void startCheck() async {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      String curDir = Directory.current.path;
      String filePath = '$curDir${sndPath}input\\topography\\checker.txt';

      File file = File(filePath);

      String c = await file.readAsString();

      if (c == 'finished') {
        print(c);
        print('run is finished');
        timer.cancel();
      } else {
        print('not yet finish');
      }
    });
  }
}
