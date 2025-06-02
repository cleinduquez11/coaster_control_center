import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:coaster_control_center/provider/cfg.dart';
import 'package:coaster_control_center/provider/stateFile.dart';

// import 'package:flutter/services.dart' show rootBundle;
class DirProvider with ChangeNotifier {
  //Directory initializer
  String dir = '';
  String topoDir = '';
  String typhoonDir = '';
  String cur_dir = '';

  //Config File initializer
  bool isConfig = false;
  String configPath = '';

  String ncols = '';
  String nrows = '';
  String utm = '';
  String xo = '';
  String yo = '';
  String cellsize = '';

  //Base map initializer

  bool isBaseMapAvailable = false;
  String baseMapPath = '';

  //Tropical Cyclone initializer

  bool isTropicalCycloneAvailable = false;
  String tropicalCyclonePath = '';

  //Wind Estimation initializer

  bool isWindAvailable = false;
  String windPath = '';



    //Swan Estimation initializer

  bool isSwanAvailable = false;
  String swanPath = '';


      //Plot Estimation initializer

  bool isPLotAvailable = false;
  String plotPath = '';

// @override
// void dispose() {
//       dir = '';
//      topoDir = '';
//      typhoonDir = '';
//      cur_dir = '';
//     // TODO: implement dispose
//     super.dispose();
//   }

  void reset() {
    dir = '';
    topoDir = '';
    typhoonDir = '';
    cur_dir = '';
  }

  void configreset() {
    ncols = '';
    nrows = '';
    utm = '';
    xo = '';
    yo = '';
    cellsize = '';
    isConfig = false;
    configPath = '';
    notifyListeners();
  }

  void basemapReset() {
    isBaseMapAvailable = false;
    baseMapPath = '';

    notifyListeners();
  }

  void tropicalCycloneReset() {
    isTropicalCycloneAvailable = false;
    tropicalCyclonePath = '';

    notifyListeners();
  }

  void windReset() {
    isWindAvailable = false;
    windPath = '';
    notifyListeners();
  }
  void swanReset() {
    isSwanAvailable = false;
    swanPath = '';
    notifyListeners();
  }

    void plotReset() {
    isPLotAvailable = false;
    plotPath = '';
    notifyListeners();
  }




  void Dir() async {
      // final cnfg = Provider.of<ConfigFileProvider>(context);
    // await rootBundle.load(key)
    final result = await FilePicker.platform.getDirectoryPath(
        dialogTitle: 'Select Working Directory', lockParentWindow: true);
    if (result == null) return;

    final stateAvailable =
        await checkStateFileExists('${result.toString()}\\st\\');

    // print(stateAvailable);
    if (stateAvailable) {
      final lst =
          await readLinesFromFile('${result.toString()}\\st\\state.txt');

          print(lst);

//Config File Handler
      checkFileExists(lst[1]).then((isAvailable) {
        if (isAvailable) {
          isConfig = true;
          configPath = lst[1];
          notifyListeners();
          readLinesFromFile(configPath).then((value) {
            ncols = value[1].split('\t')[0];
            nrows = value[1].split('\t')[1];
            utm = value[1].split('\t')[2];
            xo = value[1].split('\t')[3];
            yo = value[1].split('\t')[4];
            cellsize = value[1].split('\t')[5];
      
            notifyListeners();
            // print(value[1].split('\t')[1]);
          });
          // notifyListeners();
        } else {
          isConfig = false;
          notifyListeners();
        }
      });

//Base Map Handler
      checkFileExists(lst[2]).then((isAvailable) {
        if (isAvailable) {
          isBaseMapAvailable = true;
          baseMapPath = lst[2];
          notifyListeners();
          // readLinesFromFile(baseMapPath).then((value) {

          //     ncols = value[1].split('\t')[0];
          //     nrows = value[1].split('\t')[1];
          //     utm = value[1].split('\t')[2];
          //     xo = value[1].split('\t')[3];
          //     yo = value[1].split('\t')[4];
          //     cellsize = value[1].split('\t')[5];
          //     notifyListeners();
          //     // print(value[1].split('\t')[1]);
          // });
          // notifyListeners();
        } else {
          isBaseMapAvailable = false;
          notifyListeners();
        }
      });

      //Tropical Cyclone Handler
      checkFileExists(lst[3]).then((isAvailable) {
        if (isAvailable) {
          isTropicalCycloneAvailable = true;
          tropicalCyclonePath = lst[3];
          notifyListeners();
             copyRqmntsWind();
          // readLinesFromFile(baseMapPath).then((value) {

          //     ncols = value[1].split('\t')[0];
          //     nrows = value[1].split('\t')[1];
          //     utm = value[1].split('\t')[2];
          //     xo = value[1].split('\t')[3];
          //     yo = value[1].split('\t')[4];
          //     cellsize = value[1].split('\t')[5];
          //     notifyListeners();
          //     // print(value[1].split('\t')[1]);
          // });
          // notifyListeners();
        } else {
          isTropicalCycloneAvailable = false;
          notifyListeners();
        }
      });

      //Wind Estimation Handler

      checkFileExists(lst[4]).then((isAvailable) {
        // print('Checking Files');
        if (isAvailable) {
          // print(isAvailable);
          isWindAvailable = true;
          // print('Wind Available? : $isAvailable');
          windPath = lst[4];
          notifyListeners();
          copyRqmntsSwan();
       
          // readLinesFromFile(baseMapPath).then((value) {

          //     ncols = value[1].split('\t')[0];
          //     nrows = value[1].split('\t')[1];
          //     utm = value[1].split('\t')[2];
          //     xo = value[1].split('\t')[3];
          //     yo = value[1].split('\t')[4];
          //     cellsize = value[1].split('\t')[5];
          //     notifyListeners();
          //     // print(value[1].split('\t')[1]);
          // });
          // notifyListeners();
        } else {
          isWindAvailable = false;
          // print('not available');
          notifyListeners();
        }
      });


        //SWAN Handler

      checkFileExists(lst[5]).then((isAvailable) {
        if (isAvailable) {
          isSwanAvailable = true;
          swanPath = lst[5];
          notifyListeners();
          copyRqmntsPlot();

       
          // readLinesFromFile(baseMapPath).then((value) {

          //     ncols = value[1].split('\t')[0];
          //     nrows = value[1].split('\t')[1];
          //     utm = value[1].split('\t')[2];
          //     xo = value[1].split('\t')[3];
          //     yo = value[1].split('\t')[4];
          //     cellsize = value[1].split('\t')[5];
          //     notifyListeners();
          //     // print(value[1].split('\t')[1]);
          // });
          // notifyListeners();
        } else {
          isSwanAvailable = false;
          notifyListeners();
        }
      });



        
      checkFileExists(lst[6]).then((isAvailable) {
        if (isAvailable) {
          isPLotAvailable = true;
          plotPath = 'C:\\Users\\HP\\Desktop\\Try11\\output\\swan\\snapshot' ;
          notifyListeners();


       
          // readLinesFromFile(baseMapPath).then((value) {

          //     ncols = value[1].split('\t')[0];
          //     nrows = value[1].split('\t')[1];
          //     utm = value[1].split('\t')[2];
          //     xo = value[1].split('\t')[3];
          //     yo = value[1].split('\t')[4];
          //     cellsize = value[1].split('\t')[5];
          //     notifyListeners();
          //     // print(value[1].split('\t')[1]);
          // });
          // notifyListeners();
        } else {
          isSwanAvailable = false;
          notifyListeners();
        }
      });


    } else {
      isConfig = false;
      isBaseMapAvailable = false;
      isTropicalCycloneAvailable = false;
      isWindAvailable = false;
      isSwanAvailable =false;
      isPLotAvailable = false;

      notifyListeners();
      await Directory('${result.toString()}/st').create(recursive: true);
      await File('${result.toString()}\\st\\state.txt').writeAsString(
          "${result.toString()}\nCF\nBMF\nTCF\nWF\nSWF\nPF",
          mode: FileMode.write);
    }

    // final configAvailable = await readLinesFromFile('${result.toString()}\\st\\state.txt');

    //  await editConfigState('${result.toString()}\\st\\state.txt', 'edited');

// final lst1 = await readLinesFromFile('${result.toString()}\\st\\state.txt');
//        print(lst1);

    // final lst = await readLinesFromFile('${result.toString()}\\input\\config\\state.txt');

    // print("States: $lst");
    String curDir = Directory.current.path;

    //  notifyListeners();
    print(curDir);
    print(result);

    //use this directory for release
    //  await new File(cur_dir + '\\data\\flutter_assets\\lib\\Assets\\input\\topography\\wd.txt').writeAsString('${result.toString()}');

    await File('$curDir${sndPath}input\\topography\\wd.txt')
        .writeAsString(result.toString());
    await File('$curDir${sndPath}input\\typhoon\\wd.txt')
        .writeAsString(result.toString());
    // await new File('lib/Assets/input/typhoon/wd.txt').writeAsString('${result.toString()}');
    //  await new File('lib/Assets/input/config/wd.txt').writeAsString('${result.toString()}');
    await File('$curDir${sndPath}input\\config\\wd.txt')
        .writeAsString(result.toString());
    await File('$curDir${sndPath}input\\config\\wd.txt')
        .writeAsString(result.toString());
    //  await new File('lib/Assets/input/wind_estimation/wd.txt').writeAsString('${result.toString()}');
    await File('$curDir${sndPath}input\\wind_estimation\\wd.txt')
        .writeAsString(result.toString());
    //  await new File('lib/Assets/input/wind_estimation/swan/wd.txt').writeAsString('${result.toString()}');
    await File('$curDir${sndPath}input\\wind_estimation\\swan\\wd.txt')
        .writeAsString(result.toString());

    //  // ignore: unnecessary_new

    //  await new Directory('${result.toString()}/input').create(recursive: true);
    //  await Directory('lib/Assets/input/topography').create(recursive: true);
    //   await new Directory('lib/Assets//input/typhoon').create(recursive: true);\

    await Directory('${result.toString()}/output/topography')
        .create(recursive: true);
    await Directory('${result.toString()}/output/typhoon')
        .create(recursive: true);
    await Directory('${result.toString()}/input/config')
        .create(recursive: true);
    // await Directory('${result.toString()}/output/config').create(recursive: true);
    await Directory('${result.toString()}/output/wind').create(recursive: true);
    await Directory('${result.toString()}/output/swan').create(recursive: true);
    // await Directory('${result.toString()}/input/config').create(recursive: true);
    // await File('${result.toString()}\\input\\config\\data.txt').writeAsString("");

    dir = result;
    topoDir = '${result.toString()}\\output\\topography';
    typhoonDir = '${result.toString()}\\output\\typhoon';
    notifyListeners();
  }
}
