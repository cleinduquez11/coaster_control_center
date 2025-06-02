// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:coaster_control_center/provider/cfg.dart';
import 'package:coaster_control_center/provider/stateFile.dart';

class ConfigFileProvider with ChangeNotifier {


  //  final lst = await readLinesFromFile('${result.toString()}\\st\\state.txt');  
//  String curD = Directory.current.path;

  String ncols = '';
  String nrows = '';
  String X = '';
  String Y = '';
  String cellSize = '';
  String configDir = '';
  String utm = '';

  final ncolsController = TextEditingController(text: '');
  final nrowsController = TextEditingController(text: '');
  final xllcornerController = TextEditingController(text: '');
  final yllcornerController = TextEditingController(text: '');
  final cellSizeController = TextEditingController(text: '');
  final utmController = TextEditingController(text: '');

  // @override
  // void dispose() {
  //   // Clear your state here
  //   // For example, set state variables to their initial values
  //   ncols = '';
  //   nrows = '';
  //   X = '';
  //   Y = '';
  //   cellSize = '';
  //   configDir = '';
  //   utm = '';
  //   // Call super.dispose() to ensure that any necessary cleanup is done
  //   super.dispose();
  // }

  void reset() {
    ncols = '';
    nrows = '';
    X = '';
    Y = '';
    cellSize = '';
    configDir = '';
    utm = '';

    ncolsController.clear();
    nrowsController.clear();
    xllcornerController.clear();
    yllcornerController.clear();
    cellSizeController.clear();
    utmController.clear();

    notifyListeners();
  }

  void getVals(path) async {
    String curDir = Directory.current.path;
    ncols = ncolsController.text.toString();
    nrows = nrowsController.text.toString();
    X = xllcornerController.text.toString();
    Y = yllcornerController.text.toString();
    cellSize = cellSizeController.text.toString();
    utm = utmController.text.toString();

    // print(path);

    await File('$curDir${sndPath}input\\config\\data.txt').writeAsString(
        '1\nArea\tDS[m]\tX0[m]\tY0[m]\tNI\tNJ\tParent\n00001\t$cellSize\t$X\t$Y\t$ncols\t$nrows\t-99');

    await File('$curDir${sndPath}input\\topography\\data_config.txt')
        .writeAsString(
            'NI\tNJ\tUTM\tX0\tY0\tCS\n$ncols\t$nrows\t$utm\t$X\t$Y\t$cellSize');

    await File('$curDir${sndPath}input\\config\\data.txt').writeAsString(
        '1\nArea\tDS[m]\tX0[m]\tY0[m]\tNI\tNJ\tParent\n00001\t$cellSize\t$X\t$Y\t$ncols\t$nrows\t-99');

    await File(
            '$curDir${sndPath}input\\wind_estimation\\topo\\01_mtx\\data.txt')
        .writeAsString(
            '1\nArea\tDS[m]\tX0[m]\tY0[m]\tNI\tNJ\tParent\n00001\t$cellSize\t$X\t$Y\t$ncols\t$nrows\t-99');
    await File('$curDir${sndPath}input\\wind_estimation\\topo\\for\\data.txt')
        .writeAsString(
            '1\nArea\tDS[m]\tX0[m]\tY0[m]\tNI\tNJ\tParent\n00001\t$cellSize\t$X\t$Y\t$ncols\t$nrows\t-99');

    // await File(path + '\\output\\config\\data.txt').writeAsString(
    //     '1\nArea\tDS[m]\tX0[m]\tY0[m]\tNI\tNJ\tParent\n00001\t$cellSize\t$X\t$Y\t$ncols\t$nrows\t-99');

        await File('$path\\input\\config\\data_config.txt')
        .writeAsString(
            'NI\tNJ\tUTM\tX0\tY0\tCS\n$ncols\t$nrows\t$utm\t$X\t$Y\t$cellSize');
                    await File('$path\\input\\config\\data_config.txt');
        // .writeAsString(
        //     'NI\tNJ\tUTM\tX0\tY0\tCS\n$ncols\t$nrows\t$utm\t$X\t$Y\t$cellSize');

                await File('$path\\input\\config\\data.txt').writeAsString(
        '1\nArea\tDS[m]\tX0[m]\tY0[m]\tNI\tNJ\tParent\n00001\t$cellSize\t$X\t$Y\t$ncols\t$nrows\t-99');




    configDir = path + '\\input\\config\\data.txt';
      // await File('$path\\st\\state.txt').writeAsString('\n$path\\input\\config\\data.txt', mode: FileMode.append);
      await editConfigState('$path\\st\\state.txt', '$path\\input\\config\\data_config.txt');
      // isConfig = true;
    //  await new File('lib/Assets/input/typhoon/wd.txt').writeAsString('');
    notifyListeners();
    // print(ncols);
  }
}
