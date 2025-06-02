// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coaster_control_center/provider/DirProvider.dart';
import 'package:coaster_control_center/provider/FIleTopographyProvider.dart';
import 'package:coaster_control_center/provider/TyphoonFileProvider.dart';
import 'package:coaster_control_center/provider/cmd.dart';
import 'package:coaster_control_center/provider/configFileProvider.dart';
import 'package:coaster_control_center/provider/disasterProvider.dart';
import 'package:coaster_control_center/provider/imgcmd.dart';
import 'package:coaster_control_center/provider/plotCMDProvider.dart';
import 'package:coaster_control_center/provider/showOverlayGridProvider.dart';
import 'package:coaster_control_center/provider/swanCMDProvider.dart';
import 'package:coaster_control_center/provider/swanConfigProvider.dart';
import 'package:coaster_control_center/provider/typhoonCmd.dart';
import 'package:coaster_control_center/provider/vidcmd.dart';
// import 'package:swan/provider/FIleTopographyProvider.dart';
// import 'package:swan/provider/cmd.dart';
// import 'package:swan/provider/plotProvider.dart';
import 'package:coaster_control_center/provider/windEstimation.dart';
import 'package:coaster_control_center/viewMap.dart';
import 'package:coaster_control_center/widget/loading.dart';

Future<void> plotDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
        final plt = Provider.of<PlotProvider>(context);
        final img = Provider.of<ImgProvider>(context);
            final dir = Provider.of<DirProvider>(context);
            final vid = Provider.of<VidProvider>(context);
      return 
        plt.loading == 'done' || img.loading == 'done' || vid.loading == 'done' || dir.isPLotAvailable? 
     AlertDialog(
          title: Text(
            'Data Visualized',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          content: SingleChildScrollView(
              child: Center(
            child: Text('Plotted Images are located in ${dir.isPLotAvailable?dir.plotPath: plt.plotDir}'),
          )),
          actions: [
                     ElevatedButton(
                onPressed: () {
                  plt.reset();
                  dir.plotReset();
                  img.reset();
                  vid.reset();
                  Navigator.of(context).pop();
                  plotDialog(context);
                  
                    // plt.plot(dir.dir);
                },
                child: Text('Plot again')),

      
          ])

          :
            plt.loading == 'loading' || img.loading == 'loading' || vid.loading == 'loading'?
     AlertDialog(
        backgroundColor: Colors.green[400],
          title: Text(
            'Processing data Visualization',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          content: SingleChildScrollView(
              child: Center(
            child: Center(child: FancyLoading()),
          )),
          )

:

      AlertDialog(
          title: Text(
            'Data Visualization',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          content: SingleChildScrollView(
              child: Center(
            child: Text('How do you want to save your results?'),
          )),
          actions: [
                     ElevatedButton(
                onPressed: () {
                    plt.plot(dir.dir);
                },
                child: Text('Graphs')),

            ElevatedButton(
                onPressed: () {
        
                    img.plot(dir.dir);
                },
                child: Text('Images')),
            ElevatedButton(
                onPressed: () {
                    vid.plot(dir.dir);
                  // Navigator.of(context).pop();
                },
                child: Text('Video'))
          ]);
    },
  );


}
