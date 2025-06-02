// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coaster_control_center/provider/DirProvider.dart';
import 'package:coaster_control_center/provider/FIleTopographyProvider.dart';
import 'package:coaster_control_center/provider/TyphoonFileProvider.dart';
import 'package:coaster_control_center/provider/cmd.dart';
import 'package:coaster_control_center/provider/configFileProvider.dart';
import 'package:coaster_control_center/provider/disasterProvider.dart';
import 'package:coaster_control_center/provider/plotCMDProvider.dart';
import 'package:coaster_control_center/provider/showOverlayGridProvider.dart';
import 'package:coaster_control_center/provider/swanCMDProvider.dart';
import 'package:coaster_control_center/provider/swanConfigProvider.dart';
import 'package:coaster_control_center/provider/typhoonCmd.dart';
// import 'package:swan/provider/FIleTopographyProvider.dart';
// import 'package:swan/provider/cmd.dart';
// import 'package:swan/provider/plotProvider.dart';
import 'package:coaster_control_center/provider/windEstimation.dart';
import 'package:coaster_control_center/viewMap.dart';
import 'package:coaster_control_center/widget/loading.dart';

Future<void> confirmReset(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      //  final topo = Provider.of<RawTopographyProvider>(context);
      //  final cmd = Provider.of<CMDProvider>(context);
      // final grd = Provider.of<ShowOverlayGridProvider>(context);
      final dir = Provider.of<DirProvider>(context);
      final cmd = Provider.of<CMDProvider>(context);
      final tc = Provider.of<TyphoonCMDProvider>(context);
      final cnfg = Provider.of<ConfigFileProvider>(context);
      final wnd = Provider.of<WindEstimationCMDProvider>(context);
      final scmd = Provider.of<SwanCMDProvider>(context);
      final plt = Provider.of<PlotProvider>(context);
      final topo = Provider.of<RawTopographyProvider>(context);
      final tp = Provider.of<TyphoonProvider>(context);
      final swn = Provider.of<SwanConfigFileProvider>(context);
             final dis = Provider.of<DisasterTypeProvider>(context);

      return AlertDialog(
          title: Text(
            'Reset Simulation',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          content: SingleChildScrollView(
              child: Center(
            child: Text('All progress will be reset, do you wish to continue?'),
          )),
          actions: [
            ElevatedButton(
                onPressed: () {
                  dir.reset();
                  cnfg.reset();
                  cmd.reset();
                  tc.reset();
                  wnd.reset();
                  scmd.reset();
                  plt.reset();
                  topo.reset();
                  tp.reset();
                  swn.reset();
                  dis.reset();

// plt

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LMap(),
                      ),
                      (route) => false);
                },
                child: Text('Yes')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('No'))
          ]);
    },
  );
}
