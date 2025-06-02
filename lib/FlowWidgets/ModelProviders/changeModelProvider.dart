import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:coaster_control_center/Models/Model.dart';
class ChangeModelProvider with ChangeNotifier {
int indx = -999;


Map<String, dynamic> mods = {};

File? currentImageFile;

// LatLngBounds bounds =  LatLngBounds(LatLng(0,0),LatLng(14,120));
LatLngBounds? bounds;


changeModelState(int index, Map<String,dynamic> model, File imgfile, LatLngBounds bnds) {
    indx = index;
    mods = model;
    currentImageFile = imgfile;
    bounds = bnds;
    notifyListeners();

}


}