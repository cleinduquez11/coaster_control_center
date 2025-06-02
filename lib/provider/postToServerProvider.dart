import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';

class PostToServerProvider with ChangeNotifier {
  String configJson = "";

  // Function to read .prn file from disk and modify JSON config
  Future<void> createConfigJsonWithPrn(String dir, String name, String length, String center, String prnFilePath, String start, String end) async {
    // Read the .prn file from the provided file path
    File prnFile = File(prnFilePath);

    // Check if the file exists
    if (!await prnFile.exists()) {
      print('Error: .prn file does not exist at path: $prnFilePath');
      return;
    }

    // Read the content of the .prn file
    String prnData = await prnFile.readAsString();

    // Split the lines of the file
    List<String> lines = prnData.split('\n');

    // Parse the relevant data from the .prn file
    List<Map<String, dynamic>> typhoonData = [];
    for (var i = 1; i < lines.length; i++) {
      if (lines[i].trim().isEmpty) continue; // Skip empty lines

      List<String> row = lines[i].trim().split(RegExp(r'\s+'));  // Split by multiple spaces

      // Each row contains:
      // 0: Timestamp, 1: Longitude, 2: Latitude, 3: Pressure (hPa), 4: Wind Speed (knots)
      typhoonData.add({
        "Timestamp": "${start.substring(0,4)}${row[0].substring(2,8)}",
        "Longitude": double.parse(row[1]),
        "Latitude": double.parse(row[2]),
        "Pressure": double.parse(row[3]),
        "Wind": double.parse(row[4]),
      });
    }

    // Path to the config file
    String configFilePath = '$dir\\output\\swan\\raw\\cnfg.json';

    // Read existing config JSON if it exists
    File configFile = File(configFilePath);
    if (await configFile.exists()) {
      String existingConfigContent = await configFile.readAsString();
      Map<String, dynamic> existingConfigJson = jsonDecode(existingConfigContent);

      // Modify the existing JSON with new data
      existingConfigJson['Typhoon'] = name;
      existingConfigJson['url'] = "https://mmsucoaster.xyz/server/Raw/typhoon/$name/";
      existingConfigJson['length'] = length;
        existingConfigJson['center'] = center;
      existingConfigJson['startdate'] = start;
      existingConfigJson['end'] = end;
      existingConfigJson['typhoonData'] = typhoonData;

      // Convert the updated map back to JSON string
      configJson = jsonEncode(existingConfigJson);
    } else {
      // If no config exists, create a new one with the typhoon data
      configJson = jsonEncode({
        "message": "Okay",
        "Typhoon": name,
        "url": "https://mmsucoaster.xyz/server/Raw/typhoon/$name/",
        "length": length,
               "center":center,
        "startdate": start,
        "end": end,
        "typhoonData": typhoonData
      });
    }

    // Write the modified or new config to the file
    await configFile.writeAsString(configJson);
    print('Created or updated config file for raw files at: $configFilePath');
  }
}
