import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:coaster_control_center/provider/cfg.dart';
import 'package:window_manager/window_manager.dart';

class TyphoonProvider with ChangeNotifier {


  String fileName = '';
  String tcDir = '';

  String error = '';

  void reset() {
       fileName = '';
   tcDir = '';
    notifyListeners();
  }


  Future getTyphoonCsv() async {
    String curDir = Directory.current.path;

    try {
        await windowManager.setAlignment(Alignment.center); // Center the Flutter window
          final result = await FilePicker.platform.pickFiles(allowMultiple: false,allowedExtensions: ['csv']);
          
    if (result != null) {
        fileName = result.files.first.name;
        String p = result.files.first.path.toString();
        tcDir = p;
        print(p);
        await File('$curDir${sndPath}input\\typhoon\\typhoon.txt').writeAsString(p);
         notifyListeners();
    }
 
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }

    // print(result!.files.first.name);


  }

       
}