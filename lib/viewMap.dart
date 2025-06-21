
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

// import 'package:flutter_map_leaflet/flutter_map_leaflet.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:coaster_control_center/LandingPage.dart';
import 'package:coaster_control_center/provider/DirProvider.dart';
import 'package:coaster_control_center/provider/cmd.dart';
import 'package:coaster_control_center/provider/configFileProvider.dart';
import 'package:coaster_control_center/provider/fxnImageOVerlay.dart';
import 'package:coaster_control_center/provider/plotCMDProvider.dart';
import 'package:coaster_control_center/provider/swanCMDProvider.dart';
import 'package:coaster_control_center/provider/typhoonCmd.dart';
import 'package:coaster_control_center/provider/windEstimation.dart';
import 'package:coaster_control_center/sandboxVisualize.dart';
import 'package:coaster_control_center/widget/configDialog.dart';
import 'package:coaster_control_center/widget/dialog.dart';
import 'package:coaster_control_center/widget/plotDialog.dart';
import 'package:coaster_control_center/widget/postToServerDialog.dart';
import 'package:coaster_control_center/widget/swanConfigDialog.dart';
import 'package:coaster_control_center/widget/typhoonDialog.dart';
import 'package:coaster_control_center/widget/windEstimationDialog.dart';
import 'package:coaster_control_center/provider/vidcmd.dart';
import 'package:coaster_control_center/provider/imgcmd.dart';

class LMap extends StatelessWidget {
  const LMap({super.key});

  @override
  Widget build(BuildContext context) {
    final dir = Provider.of<DirProvider>(context);
    final cmd = Provider.of<CMDProvider>(context);
    final tc = Provider.of<TyphoonCMDProvider>(context);
    final cnfg = Provider.of<ConfigFileProvider>(context);
    final wnd = Provider.of<WindEstimationCMDProvider>(context);
    final scmd = Provider.of<SwanCMDProvider>(context);
    final plt = Provider.of<PlotProvider>(context);

       final img = Provider.of<ImgProvider>(context);
            final vid = Provider.of<VidProvider>(context);

            

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [

          FlutterMap(
            options: const MapOptions(
              // crs: Epsg4326(),
              backgroundColor: Colors.black12,
          
              interactionOptions: InteractionOptions(
                  pinchMoveThreshold: 1, pinchMoveWinGestures: 7),
              initialCenter: LatLng(12.8797, 121.7740),
              initialZoom: 6.5,
          
              // onTap: (tapPosition, point) {
              //   print('${tapPosition.relative!.dx}  ${tapPosition.relative!.dy} ');
              // },
            ),
            children: [
                  
              
                TileLayer(
          
                urlTemplate:
                    // 'http://10.40.2.79/eyy/{z}/{x}_{y}.png',
                    // 'https://server.arcgisonline.com/arcgis/rest/services/Elevation/World_Hillshade_Dark/MapServer/tile/{z}/{y}/{x}.png',
                    // 'https://server.arcgisonline.com/arcgis/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}.png',
                    // 'https://server.arcgisonline.com/arcgis/rest/services/World_Terrain_Base/MapServer/tile/{z}/{y}/{x}.png',
                    // 'https://server.arcgisonline.com/arcgis/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}.png',
                    // 'https://server.arcgisonline.com/arcgis/rest/services/NatGeo_World_Map/MapServer/tile/{z}/{y}/{x}.png' ,
                    'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}.png',
                userAgentPackageName: 'com.example.app',
                subdomains: ['a', 'b', 'c'],
              ),
          
//                           OverlayImageLayer(
          
//             overlayImages: imgoverlay.overlayImages.isEmpty
//                     ? [] : [
//  OverlayImage(
//                 //  (Latitude: 2.0085192044005806, Longitude: 107.89216035615144)
//                 //  (Latitude: 28.544117073671917, Longitude: 136.22492546159555)
//                 // bounds: LatLngBounds(LatLng(-0.0666666666670004, 105.9833333333280052), LatLng(31.0749999987539951 ,138.9499999986759917)),
          
//           // (Latitude: 2.0085192044005806, Longitude: 101.89216035615145)
//           // (Latitude: 28.544117073671917, Longitude: 130.22492546159555)
          
          
//           // (Latitude: 2.0526027337113666, Longitude: 107.93514716442793)
//           // (Latitude: 28.583095536338977, Longitude: 136.2802841055767)
          
          
//           // (Latitude: 2.0526027337113666, Longitude: 107.93514716442793)
//           // (Latitude: 28.50510192411439, Longitude: 136.16960583104557)
//                 // bounds: LatLngBounds(LatLng(2.0085192044005806, 107.89216035615144), LatLng(28.544117073671917 ,136.22492546159555)),
//             bounds: LatLngBounds(LatLng(2.0525927337113665, 107.03514716442793), LatLng(28.50509192411439 ,135.26960583104557)),
//                 opacity: 0.75,
          
//                 // opacity: 0.75,
//                 imageProvider: MemoryImage(imgoverlay.overlayImages[imgoverlay.currentIndex]),
//                 gaplessPlayback: true,

          
//                 // imageProvider: AssetImage('lib/Assets/000069.png'),
//               )
         
         
//             ],
//           ),
           
           
            ],
          ),

                    Positioned(
            bottom: 20,
            right: 20,
            child: Text(
             '© MMSU coaster ${DateTime.now().year.toString()} All rights reserved',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.03,
            top: MediaQuery.of(context).size.height * 0.025,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LandingPage(),));
              },
              child: Hero(
                tag: 'coaster',
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                      Colors.lightGreen,
                        Colors.green.shade900, // Dark green
                        Colors.green.shade400,
                               Colors.lightGreen, // Lighter green
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'COASTER WAVE MODELS',
                      style: TextStyle(
                        fontSize: 36.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          //                      scmd.swanDir != '' || dir.isSwanAvailable
          //     ? Positioned(
          //   left: MediaQuery.of(context).size.width * 0.12,
          //   bottom: MediaQuery.of(context).size.height * 0.025,
          //   child: Center(
          //     child:ElevatedButton.icon(
                
          //       onPressed:imgoverlay.togglePlayPause,
          //       label: Text(imgoverlay.isPlaying ?'Pause': 'Play'),
          //       icon: Icon(imgoverlay.isPlaying  ? Icons.pause : Icons.play_arrow),
          //     )
          //   ),
          // ):Container(),


                               scmd.swanDir != '' || dir.isSwanAvailable
              ? Positioned(
            left: 20,
            bottom: 20,
            child: Center(
              child:Tooltip(
                message: "Enter the visualization area",
                child: ElevatedButton.icon(
                  
                  onPressed:() {
                    // imgoverlay.loadImagesFromDirectory('${dir.dir}\\output\\swan\\raw');
                
                    LoadImages('${dir.dir}\\output\\swan\\raw').then((value) {
                         Navigator.push(context, MaterialPageRoute(builder: (context) => SandBoxVisualization(overlayImages: value['overlayImages'],length: value.length, url: dir.dir,),));
                    },);
                
                 
                    
                
                    
                    //  _loadImagesFromDirectory('${dir.dir}\\output\\swan\\raw');
                    // _isStarted = true;
                  },
                  label: Text('Visualize Results'),
                  icon: Icon(Icons.sim_card),
                ),
              )
            ),
          ):Container(),

                                         scmd.swanDir != '' || dir.isSwanAvailable
              ? 
              Positioned(
            left: 220,
            bottom: 20,
            child: Center(
              child:Tooltip(
                message: "Post to Coaster Website",
                child: ElevatedButton.icon(
                  
                  onPressed:() {
                    // imgoverlay.loadImagesFromDirectory('${dir.dir}\\output\\swan\\raw');
                    showPostToServerDialog(context);
                    // LoadImages('${dir.dir}\\output\\swan\\raw').then((value) {
                    //      Navigator.push(context, MaterialPageRoute(builder: (context) => SandBoxVisualization(overlayImages: value,length: value.length, url: dir.dir,),));
                    // },);
                
                 
                    
                
                    
                    //  _loadImagesFromDirectory('${dir.dir}\\output\\swan\\raw');
                    // _isStarted = true;
                  },
                  label: Text('Send to Server'),
                  icon: Icon(Icons.network_wifi),
                ),
              )
            ),
          )
          
          :Container(),

          Positioned(
            right: 20,
            top: 100,
            child: Tooltip(
              message: dir.dir != '' ? 'Domain Project' : 'Create New File',
              preferBelow: false,
              child: Center(
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: dir.dir != ''
                          ? MaterialStatePropertyAll(Colors.green[400])
                          : MaterialStatePropertyAll(Colors.deepPurple[50])),
                  icon: Icon(dir.dir != '' ? Icons.check : Icons.add),
                  onPressed: () async {
                    // final newDir = await selectWorkingDirectory();
                    dir.Dir();

                    //   cnfg.ncols = dir.ncols;
                    //  cnfg.nrows = dir.nrows;
                    // cnfg.X = dir.xo;
                    // cnfg.Y = dir.yo;
                    // cnfg.cellSize = dir.cellsize;
                    //  writeCounter(123);
                  },
                  // onHover: (value) {
                  //     dir.
                  // },
                  label: Text(
                    dir.dir != '' ? 'Dir: ${dir.dir}' : 'Setup Domain',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
          dir.dir != ''
              // || dir.isConfig
              ? Positioned(
                  right: 20,
                  top: 160,
                  child: Tooltip(
                    preferBelow: false,
                    message: cnfg.configDir != '' || dir.isConfig
                        ? 'Configuration File'
                        : 'Generate Configuration File',
                    child: Center(
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor: cnfg.configDir != '' ||
                                    dir.isConfig
                                ? MaterialStatePropertyAll(Colors.green[400])
                                : MaterialStatePropertyAll(
                                    Colors.deepPurple[50])),
                        icon: Icon(cnfg.configDir != '' || dir.isConfig
                            ? Icons.check
                            : Icons.tune_outlined),
                        onPressed: () {
                          //  showMyDialog(context);
                          showConfigurationDialog(context);
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => Topography()));
                        },
                        label: Text(
                          cnfg.configDir != '' || dir.isConfig
                              // ? 'File: ${cnfg.configDir}'
                              ? 'Config File Ready'
                              : 'Generate Configuration File',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          cnfg.configDir != '' || dir.isConfig
              //  &&
              // dir.isBaseMapAvailable
              ? Positioned(
                  right: 20,
                  top: 220,
                  child: Tooltip(
                    preferBelow: false,
                    message: cmd.topoDir != '' || dir.isBaseMapAvailable
                        ? 'Bathymetric/Topographic data'
                        : 'Generate a topographic data either from Noaa/Gebco',
                    child: Center(
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor: cmd.loading == 'loading'
                                ? MaterialStatePropertyAll(Colors.orange[600])
                                : cmd.loading == 'done' ||
                                        dir.isBaseMapAvailable
                                    ? MaterialStatePropertyAll(
                                        Colors.green[400])
                                    : MaterialStatePropertyAll(
                                        Colors.deepPurple[50])),
                        onPressed: () {
                          showMyDialog(context);
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => Topography()));
                        },
                        icon: Icon(cmd.loading == 'loading'
                            ? Icons.stop_circle
                            : cmd.loading == 'done' || dir.isBaseMapAvailable
                                ? Icons.check
                                : Icons.terrain),
                        label: Text(
                          cmd.loading == 'loading'
                              ? 'Generating Base Map'
                              : cmd.loading == 'done' || dir.isBaseMapAvailable
                                  // ? 'File: ${cmd.topoDir}'
                                  ? 'Base Map Ready'
                                  : 'Generate Base Map',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          cmd.topoDir != '' ||
                  // dir.isConfig &&
                  dir.isBaseMapAvailable
              // &&
              // dir.isTropicalCycloneAvailable
              ? Positioned(
                  right: 20,
                  top: 280,
                  child: Tooltip(
                    preferBelow: false,
                    message: tc.typhoonDir != '' ||
                            dir.isTropicalCycloneAvailable
                        ? 'Typhoon Data'
                        : 'Generate a typhoon track, speed and wave propagation',
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor: tc.typhoonDir != '' ||
                                  dir.isTropicalCycloneAvailable
                              ? MaterialStatePropertyAll(Colors.green[400])
                              : MaterialStatePropertyAll(
                                  Colors.deepPurple[50])),
                      onPressed: () {
                        typhoonDialog(context);
                      },
                      icon: Icon(
                          tc.typhoonDir != '' || dir.isTropicalCycloneAvailable
                              ? Icons.check
                              : Icons.thunderstorm),
                      label: Text(
                        tc.typhoonDir != '' || dir.isTropicalCycloneAvailable
                            // ? 'TC File: ${tc.typhoonDir}'
                            ? 'Typhoon Ready'
                            : 'Tropical Cyclone',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                )
              : Container(),
          tc.typhoonDir != '' ||
                  // dir.isConfig &&
                  // dir.isBaseMapAvailable &&
                  dir.isTropicalCycloneAvailable
              //&&
              // dir.isWindAvailable
              ? Positioned(
                  right: 20,
                  top: 340,
                  child: Tooltip(
                    preferBelow: false,
                    message: wnd.windDir != '' || dir.isWindAvailable
                        ? 'Wind Output'
                        : 'Generate computational Analysis on Typhoon and Topographic data',
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor: wnd.windDir != '' ||
                                  dir.isWindAvailable
                              ? MaterialStatePropertyAll(Colors.green[400])
                              : wnd.loading == 'loading'
                                  ? MaterialStatePropertyAll(Colors.orange[600])
                                  : MaterialStatePropertyAll(
                                      Colors.deepPurple[50])),
                      onPressed: () {
                        windEstimationDialog(context);
                        // wnd.runWindEstimationCmd();
                      },
                      icon: Icon(wnd.windDir != '' || dir.isWindAvailable
                          ? Icons.check
                          : wnd.loading == 'loading'
                              ? Icons.stop_circle
                              : Icons.air),
                      label: Text(
                        wnd.loading == 'loading'
                            ? 'Performing Wind Estimations'
                            : wnd.loading == 'done' || dir.isWindAvailable
                                ? 'Wind Estimated'
                                : 'Wind Estimations',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                )
              : Container(),
          wnd.windDir != '' || dir.isWindAvailable
              ? 
              Positioned(
                  right: 20,
                  top: 400,
                  child: Tooltip(
                    preferBelow: false,
                    message: scmd.swanDir != '' || dir.isSwanAvailable
                        ? 'Wave Output'
                        : 'Simulate Wave',
                    child: Center(
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor: scmd.loading == 'loading'
                                ? MaterialStatePropertyAll(Colors.orange[600])
                                : scmd.loading == 'done' || dir.isSwanAvailable
                                    ? MaterialStatePropertyAll(
                                        Colors.green[400])
                                    : MaterialStatePropertyAll(
                                        Colors.deepPurple[50])),
                        onPressed: () {
                          // showSwanConfigDialog(context);
                          showSwanConfigDialog(context);
                        },
                        icon: Icon(scmd.swanDir != '' || dir.isSwanAvailable
                            ? Icons.check
                            : scmd.loading == 'loading'
                                ? Icons.stop_circle
                                : Icons.tsunami_sharp),
                        label: Text(
                          scmd.loading == 'loading'
                              ? 'Simulating Waves'
                              : scmd.loading == 'done' || dir.isSwanAvailable
                                  ? 'Waves Simulated'
                                  : 'Waves Simulation',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          scmd.swanDir != '' || dir.isSwanAvailable
              ? Positioned(
                  right: 20,
                  top: 460,
                  child: Tooltip(
                    preferBelow: false,
                    message: plt.loading == 'loading' || img.loading == 'loading' || vid.loading == 'loading'
                        ? 'Simulating Waves'
                        : plt.loading == 'done' || dir.isPLotAvailable || img.loading == 'done' || vid.loading == 'done'
                            ? 'Images Generated'
                            : 'Generate Images',
                    child: Center(
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor: plt.loading == 'loading' || img.loading == 'loading' || vid.loading == 'loading'
                                ? MaterialStatePropertyAll(Colors.orange[600])
                                : plt.loading == 'done' || dir.isPLotAvailable || img.loading == 'done' || vid.loading == 'done'
                                    ? MaterialStatePropertyAll(
                                        Colors.green[400])
                                    : MaterialStatePropertyAll(
                                        Colors.deepPurple[50])),
                        onPressed: () {
                          plotDialog(context);
                          // plt.plot(dir.dir);
                          // print('Plot');
                        },
                        icon: Icon(plt.loading == 'loading' || img.loading == 'loading' || vid.loading == 'loading'
                            ? Icons.stop_circle
                            : plt.loading == 'done' || dir.isPLotAvailable || img.loading == 'done' || vid.loading == 'done'
                                ? Icons.check
                                : Icons.poll_outlined),
                        label: Text(
                          plt.loading == 'loading' || img.loading == 'loading' || vid.loading == 'loading'
                              ? 'Plotting'
                              : plt.loading == 'done' || dir.isPLotAvailable || img.loading == 'done' || vid.loading == 'done'
                                  ? 'Images Generated'
                                  : 'Plot',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),

      // floatingActionButton: MenuButton(),
    );
  }
}
