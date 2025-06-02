
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';

class Gettyphoonprovider with ChangeNotifier {
  bool typExist1 = false;
  bool typExist = false;
  String message = "";
  Map<String, dynamic> files = {};

  getRawTyphoon(String path) async {
    // Make an HTTP GET request to fetch the directory listing
    final response = await http.get(Uri.parse(path));
    // Uri.parse(path)
    if (response.statusCode == 200) {
      // Assume the response body contains a JSON array of file paths
      files = jsonDecode(response.body);
      notifyListeners();

      // print(files);

      // Filter the list to only include .png files
      // overlayImages = files.where((file) => file.endsWith('.png')).cast<String>().toList();
      // print("true");
      // return files;
    } else {
      // Handle the error
      throw Exception('Failed to load directory');
    }
  }

  isTypExist(String path) async {
    typExist1 = false;
    typExist = false;
    notifyListeners();
    try {
      final response = await http.get(Uri.parse(path));
      // Uri.parse(path)
      if (response.statusCode == 200) {
        //  typExist1 = true;
        //            notifyListeners();
        // Assume the response body contains a JSON array of file paths
        message = jsonDecode(response.body)['message'];
        //  List<dynamic>  rawData = jsonDecode(response.body)['RawData'];
        if (message == "Okay") {
          // print("true");
          typExist = true;
          notifyListeners();
        }
      } else {
        typExist1 = true;
        notifyListeners();
        // Handle the error
        // throw Exception('Failed to load directory');
      }
    } catch (e) {
      typExist1 = true;
      notifyListeners();
    }
  }
}
