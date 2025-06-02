
    // ignore_for_file: unnecessary_new, duplicate_ignore, unnecessary_string_escapes
    
  // import 'dart:io';


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:file_picker/file_picker.dart';

Future selectWorkingDirectory() async { 
  // String from = 'C:\\Users\\HP\\Desktop\\Test Environment\\Pandas tut\\test8Data\\MakeTopography.py';
  // String to = 'C:\\Users\\HP\\Desktop\\Swan_dir\\input\\topography';
  await windowManager.setAlignment(Alignment.center); // Center the Flutter window


      final result = await FilePicker.platform.getDirectoryPath();
    if (result == null) return; 
     await new File('lib/Assets/wd.txt').writeAsString('${result.toString()}');
     await new File('lib/Assets/input/topography/wd.txt').writeAsString('${result.toString()}');
         await new File('lib/Assets/input/typhoon/wd.txt').writeAsString('${result.toString()}');
    //  // ignore: unnecessary_new
   
    //  await new Directory('${result.toString()}/input').create(recursive: true);
    //  await Directory('lib/Assets/input/topography').create(recursive: true);
    //   await new Directory('lib/Assets//input/typhoon').create(recursive: true);
     await new Directory('${result.toString()}/output').create(recursive: true);
    //     await new File('${result.toString()}\\input\\topography\\topo.txt').writeAsString('TopoDir ${result.toString()}\\input\\topography\\MakeTopography.py');
    //  await Process.run('copy',[ from, to ],runInShell: true);

     return result.toString();

  } 



  
Future selectFile() async { 

      final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    // if (result == null) return; 
    //  await new File('${result.toString()}/wd.txt').writeAsString('WorkDir ${result.toString()}');
    //  // ignore: unnecessary_new
    //  await new Directory('${result.toString()}/input').create(recursive: true);
    //  await Directory('${result.toString()}/input/topography').create(recursive: true);
    //   await new Directory('${result.toString()}/input/typhoon').create(recursive: true);
    //  await new Directory('${result.toString()}/output').create(recursive: true);

    //  return result.toString();
    return result;

  } 

