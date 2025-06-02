

import 'package:flutter/material.dart';

class ShowOverlayGridProvider with ChangeNotifier {
    bool show =false;
    // String windDir = '';

  void toggleGrid(){  
          show =! show;
          notifyListeners();
            print(show);

  }




}