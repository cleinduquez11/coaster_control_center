import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:coaster_control_center/provider/cfg.dart';
import 'package:latlong2/latlong.dart';
// Example usage

// class GetModelsProvider with ChangeNotifier {
//    List<String> models = [];

//  Future<List<String>> getModels() async {
//   List<String> models = [];
//   String curDir = Directory.current.path;
//   // String curDir = Directory.current.path;
//   String filePath = '$curDir${sndPath}flow\\models\\mods.lst';

//   File file = File(filePath);

//   models = await file.readAsLines();

//   models = models.sublist(1);
//   // print(models);
//   return models;
//   // print(models);

//   // notifyListeners();
// }
// }

Future<List<Map<String, dynamic>>> getModels() async {
  String curDir = Directory.current.path;
  String filePath = '$curDir${sndPath}flow\\models\\mods.lst';
  final modelListfile = File(filePath);
  List<String> data = [];
  if (await modelListfile.exists()) {
    data = await modelListfile.readAsLines();
  }
  // List data = lines;
  List<Map<String, dynamic>> parsedModels = [];

  // print(data);
  for (var element in data) {
    List dat = element.split(",");
    parsedModels.add(
      {
        'name': dat[1],
        'position': LatLng(double.parse(dat[4]), double.parse(dat[5])),
        'zoom': double.parse(dat[6]),
        'image': dat[9].toString(),
        'extents': {
          'southWest': LatLng(double.parse(dat[8]), double.parse(dat[7])),
          'northEast': LatLng(double.parse(dat[11]), double.parse(dat[10])),
        },
      },
    );
  }

  // data.forEach((element) {
  //       parsedModels.add(
  //             {
  //     'name': element[1],
  //     'position': LatLng( double.parse(element[4]), double.parse(element[5])),
  //     'zoom': double.parse(element[6]),
  //     'image': element[9],
  //     'extents': {
  //       'southWest': LatLng(double.parse(element[8]), double.parse(element[7])),
  //       'northEast': LatLng(double.parse(element[11]),double.parse(element[10])),
  //     },
  //   },

  //       );
  // },);

  // print(data);
  // print(parsedModels);

  // String modelName = data[1];
  // String modeler = data[2];
  // String modelDescription = data[3];
  // String centerLat = data[4];
  // String centerLon = data[5];
  // String centerZoom = data[6];

  return parsedModels;
}

Future<List<Map<String, dynamic>>> getModelsJson() async {
  String curDir = Directory.current.path;
  String filePath = '$curDir${sndPath}flow\\models\\models.json';
  final modelListfile = File(filePath);
  List<Map<String, dynamic>> data = [];
  if (await modelListfile.exists()) {
    String jsonString = await modelListfile.readAsString();

    List<dynamic> decoded = jsonDecode(jsonString);

    // print(decoded);

    decoded.forEach((model) {
      //   data.add(
      //   {
      //     'name': model['name'],
      //     'position': LatLng(double.parse(model['position']['lat']), double.parse(model['position']['long'])),
      //     'zoom': double.parse(model['zoom']),
      //     'image': model['image'],
      //     'extents': {
      //       'southWest': LatLng(double.parse(model['southWest'][0]), double.parse(model['southWest'][1])),
      //       'northEast': LatLng(double.parse(model['northEast'][0]), double.parse(model['northEast'][1])),
      //     },
      //   },
      // );
// \\flow\\models\\

      data.add(
        {
          'name': model['name'],
          'position':
              LatLng(model['position']['lat'], model['position']['long']),
          'zoom': model['zoom'],
          "description": model['description'],
          "resolution": model['resolution'],
          "bed_level": model['bed_level'],
          "events": model['events'],
          "boundary_condition": model['boundary_condition'],
          "timestep": model['timestep'],
          'image': '$curDir${sndPath}flow\\models\\${model['image']}',
          'extents': {
            'southWest': LatLng(model['extents']['southWest'][0],
                model['extents']['southWest'][1]),
            'northEast': LatLng(model['extents']['northEast'][0],
                model['extents']['northEast'][1]),
          },
        },
      );
    });
  }
  // print(data);
  return data;
}

Future<List<Map<String, dynamic>>> getFloodModelsJson() async {
  String curDir = Directory.current.path;
  String filePath = '$curDir${sndPath}flood\\models\\models.json';
  final modelListfile = File(filePath);
  List<Map<String, dynamic>> data = [];
  if (await modelListfile.exists()) {
    String jsonString = await modelListfile.readAsString();
    print(jsonString);

    List<dynamic> decoded = jsonDecode(jsonString);
    print(decoded);

    // print(decoded);

    for (var model in decoded) {
      data.add(
        {
          'name': model['name'],
        },
      );
    }

//     decoded.forEach((model) {

//     //   data.add(
//     //   {
//     //     'name': model['name'],
//     //     'position': LatLng(double.parse(model['position']['lat']), double.parse(model['position']['long'])),
//     //     'zoom': double.parse(model['zoom']),
//     //     'image': model['image'],
//     //     'extents': {
//     //       'southWest': LatLng(double.parse(model['southWest'][0]), double.parse(model['southWest'][1])),
//     //       'northEast': LatLng(double.parse(model['northEast'][0]), double.parse(model['northEast'][1])),
//     //     },
//     //   },
//     // );
// // \\flow\\models\\

//       data.add(
//       {
//         'name': model['name'],
//         'position': LatLng(model['position']['lat'], model['position']['long']),
//         'zoom': model['zoom'],
//         'image':  '$curDir${sndPath}flow\\models\\${model['image']}' ,
//         'extents': {
//           'southWest': LatLng(model['extents']['southWest'][0], model['extents']['southWest'][1]),
//           'northEast': LatLng(model['extents']['northEast'][0], model['extents']['northEast'][1]),
//         },
//       },
//     );

//     });
  }

  // print(data);
  return data;
}

Future<List<Map<String, dynamic>>> getModelsExample() async {
  return [
    {
      'name': 'NWL',
      'position': LatLng(18.360837769285652, 120.86588121742514),
      'zoom': 7.5,
      'image':
          'E:\\COASTER_MMSU_CONTROL_CENTER\\swan_source_code\\lib\\Assets\\flow\\models\\NWL\\dflowfm\\grid.png',
      'extents': {
        'southWest': LatLng(15.262854858772348, 117.31149188602119),
        'northEast': LatLng(22.007964930440476, 122.34829938507778),
      },
    },
    {
      'name': 'Model 2',
      'position': LatLng(13.5000, 122.0000),
      'zoom': 9.0,
      'image': 'assets/images/model2.png',
      'extents': {
        'southWest': LatLng(13.3, 121.8),
        'northEast': LatLng(13.7, 122.2),
      },
    },
  ];
}
