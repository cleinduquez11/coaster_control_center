import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:coaster_control_center/provider/cfg.dart';





class plotProvider with ChangeNotifier {

  void quickplot() async {
    String curDir = Directory.current.path;
            Process result = await Process.start('cmd',['/c','python','$curDir${sndPath}Auxi\\plot.py'],includeParentEnvironment: true,mode: ProcessStartMode.normal);

              await result.stdout
    .transform(utf8.decoder)
    .forEach(print);
           await result.stderr
    .transform(utf8.decoder)
    .forEach(print);
      
        

          result.exitCode.then((value) {
            if (value == 0) {

              notifyListeners();
            print('Run Successfully');
            
          }
          }
      

          );
  }
  
}