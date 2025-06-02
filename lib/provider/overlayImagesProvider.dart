import 'dart:io';

import 'package:flutter/material.dart';

class ImageOverlayProvider with ChangeNotifier {
  int currentIndex = 0;
  bool isPlaying = true;
  int length = 0;

  // bool _isStarted = false;
  //  late DirProvider dirProvider;
  List<String> overlayImages = [];

  void loadImagesFromDirectory(String path) async {
    final dir = Directory(path);
    if (await dir.exists()) {
      final imageFiles = dir.listSync().where((item) => item.path.endsWith('.png')).toList();
        overlayImages = imageFiles.map((item) => item.path).toList();
               notifyListeners();
        length = overlayImages.length;

            notifyListeners();
    } 

   
    } 

  }

//   void startSlideshow() {
//    Timer.periodic(const Duration(milliseconds: 100), (timer) {
//       if (isPlaying) {
//           currentIndex = (currentIndex + 1) % overlayImages.length;
//           notifyListeners();
 
//       }

//       // setState(() {
//       //   _currentIndex = (_currentIndex + 1) % _overlayImages.length;
//       // });
//     });
//   }

//   void togglePlayPause() {

//       isPlaying = !isPlaying;
//       notifyListeners();
 
//   }
// }
