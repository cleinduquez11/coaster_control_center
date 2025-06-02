// import 'dart:io';

// import 'dart:io';

import 'package:coaster_control_center/BoundaryConditions/BC_RUN.dart';
import 'package:coaster_control_center/FloodModelWidgets/FloodModelProviders/AddFloodModelProvider.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/AddModelProvider.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/FlowConfigFileProvider.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/RunModelProvider.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/changeModelProvider.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/postProcessingProvider.dart';
import 'package:coaster_control_center/FlowWidgets/Sandbox/DragUpButtonOverlay.dart';
import 'package:coaster_control_center/IntegratedModelWidgets/IntegratedModelProviders/IntegrateAddFloodModel.dart';
import 'package:coaster_control_center/SSI/SSI_RUN.dart';
import 'package:coaster_control_center/provider/DirProvider.dart';
import 'package:coaster_control_center/provider/FIleTopographyProvider.dart';
import 'package:coaster_control_center/provider/GetTyphoonProvider.dart';
import 'package:coaster_control_center/provider/TyphoonFileProvider.dart';
import 'package:coaster_control_center/provider/cmd.dart';
import 'package:coaster_control_center/provider/configFileProvider.dart';
import 'package:coaster_control_center/provider/disasterProvider.dart';
import 'package:coaster_control_center/provider/fileUploadProvider.dart';
import 'package:coaster_control_center/provider/finishedCheckerProvider.dart';
import 'package:coaster_control_center/provider/imgcmd.dart';
import 'package:coaster_control_center/provider/nestFileProvider.dart';
import 'package:coaster_control_center/provider/overlayImagesProvider.dart';
import 'package:coaster_control_center/provider/plotCMDProvider.dart';
import 'package:coaster_control_center/provider/plotProvider.dart';
import 'package:coaster_control_center/provider/postToServerProvider.dart';
import 'package:coaster_control_center/provider/showOverlayGridProvider.dart';
import 'package:coaster_control_center/provider/swanCMDProvider.dart';
import 'package:coaster_control_center/provider/swanConfigProvider.dart';
import 'package:coaster_control_center/provider/typhoonCmd.dart';
import 'package:coaster_control_center/provider/vidcmd.dart';
import 'package:coaster_control_center/provider/windEstimation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:swan/FlowWidgets/ModelProviders/TabBarProvider.dart';

// import 'package:swan/simulate.dart';
// import 'package:swan/viewMap.dart';
// import 'package:window_manager/window_manager.dart';
// import 'package:window_size/window_size.dart';
// import 'package:window_manager/window_manager.dart';
import 'package:window_manager/window_manager.dart';

import 'LandingPage.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  await windowManager.setFullScreen(true);

//  Size window =  await windowManager.getSize();

//  int tBar =  await windowManager.getTitleBarHeight();

//  window.height -tBar;
  // WindowOptions windowOptions = WindowOptions(
  //   size: const Size(800, 600), // Initial size
  //   center: true,
  //   backgroundColor: Colors.transparent,
  //   skipTaskbar: false,
  //   titleBarStyle: TitleBarStyle.normal,
  // );

//  windowManager.setSize(window,animate: false);
//     await windowManager.maximize();
  await windowManager.setTitleBarStyle(TitleBarStyle.normal); // Hides title bar
  // windowManager.setFullScreen(true);
//   if (Platform.isWindows) {
// WindowManager.instance.setMinimumSize(const Size(100, 100));
//     WindowManager.instance.setMaximumSize(const Size(400, 600));
//   }
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => DirProvider()),
    ChangeNotifierProvider(create: (_) => RawTopographyProvider()),
    ChangeNotifierProvider(create: (_) => CMDProvider()),
    ChangeNotifierProvider(create: (_) => plotProvider()),
    ChangeNotifierProvider(create: (_) => TyphoonProvider()),
    ChangeNotifierProvider(create: (_) => TyphoonCMDProvider()),
    ChangeNotifierProvider(create: (_) => ConfigFileProvider()),
    ChangeNotifierProvider(create: (_) => WindEstimationCMDProvider()),
    ChangeNotifierProvider(create: (_) => ShowOverlayGridProvider()),
    ChangeNotifierProvider(create: (_) => SwanConfigFileProvider()),
    ChangeNotifierProvider(create: (_) => SwanCMDProvider()),
    ChangeNotifierProvider(create: (_) => NestFileProvider()),
    ChangeNotifierProvider(create: (_) => CheckerProvider()),
    ChangeNotifierProvider(create: (_) => PlotProvider()),
    ChangeNotifierProvider(create: (_) => DisasterTypeProvider()),
    ChangeNotifierProvider(create: (_) => DescriptionProvider()),
    ChangeNotifierProvider(create: (_) => ImgProvider()),
    ChangeNotifierProvider(create: (_) => VidProvider()),
    ChangeNotifierProvider(create: (_) => ImageOverlayProvider()),
    ChangeNotifierProvider(create: (_) => Gettyphoonprovider()),
    ChangeNotifierProvider(create: (_) => PostToServerProvider()),
    ChangeNotifierProvider(create: (_) => Fileuploadprovider()),
    ChangeNotifierProvider(create: (_) => FlowConfigFileProvider()),
    ChangeNotifierProvider(create: (_) => AddModelProvider()),
    ChangeNotifierProvider(create: (_) => ChangeModelProvider()),
    ChangeNotifierProvider(create: (_) => RunModelProvider()),
        ChangeNotifierProvider(create: (_) => RUNSSI()),
                ChangeNotifierProvider(create: (_) => RUNBC()),
                   ChangeNotifierProvider(create: (_) => PostProcessingProvider()),
                      ChangeNotifierProvider(create: (_) => IntegrateAddFloodModelProvider()),
                         ChangeNotifierProvider(create: (_) => AddFloodModelProvider()),
            // ChangeNotifierProvider(create: (_) => TabControllerProvider()),

    // ChangeNotifierProvider(create: (_) => GetModelsProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coaster Control Center',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade900, // Dark blue
        ),
        useMaterial3: true,
      ),
      home: LandingPage(),
    );
  }
}
