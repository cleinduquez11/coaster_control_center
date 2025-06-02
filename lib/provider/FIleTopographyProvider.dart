import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:coaster_control_center/provider/cfg.dart';
import 'package:window_manager/window_manager.dart';

class RawTopographyProvider with ChangeNotifier {
  String fileName = '';
  String fileName1 = '';

  void reset() {
    fileName = '';
    fileName1 = '';
    notifyListeners();
  }

  Future getRawTopography() async {
      await windowManager.setAlignment(Alignment.center); // Center the Flutter window
    String curDir = Directory.current.path;
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    // print(result!.files.first.name);

    if (result != null) {
      fileName = result.files.first.name;
      String p = result.files.first.path.toString();

      // await  File('lib/Assets/input/topography/${result.files.first}');

      // print(Directory.current.path);

      await File('$curDir${sndPath}input/topography/topo.txt').writeAsString(p);
      // print(result.files.first.path);
      // await new File('${result.toString()}/wd.txt').writeAsString('WorkDir ${result.toString()}');
      notifyListeners();
    }
  }

  Future importDomain() async {
    String curDir = Directory.current.path;
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    // print(result!.files.first.name);

    if (result != null) {
      fileName1 = result.files.first.name;
      String p = result.files.first.path.toString();

      // await  File('lib/Assets/input/topography/${result.files.first}');

      // print(Directory.current.path);

      await File('$curDir${sndPath}input/topography/topo.txt').writeAsString(p);
      // print(result.files.first.path);
      // await new File('${result.toString()}/wd.txt').writeAsString('WorkDir ${result.toString()}');
      notifyListeners();
    }
  }
}
