
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coaster_control_center/provider/DirProvider.dart';
// import 'package:swan/provider/TyphoonFileProvider.dart';
import 'package:coaster_control_center/provider/cmd.dart';
import 'package:coaster_control_center/provider/configFileProvider.dart';
import 'package:coaster_control_center/provider/plotCMDProvider.dart';
import 'package:coaster_control_center/provider/swanCMDProvider.dart';
import 'package:coaster_control_center/provider/typhoonCmd.dart';
import 'package:coaster_control_center/provider/windEstimation.dart';
import 'package:coaster_control_center/viewMap.dart';
import 'package:coaster_control_center/widget/configDialog.dart';
// import 'package:swan/provider/FileProvider.dart';
import 'package:coaster_control_center/widget/dialog.dart';
import 'package:coaster_control_center/widget/swanConfigDialog.dart';
import 'package:coaster_control_center/widget/typhoonDialog.dart';
import 'package:coaster_control_center/widget/windEstimationDialog.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final dir = Provider.of<DirProvider>(context);
    final cmd = Provider.of<CMDProvider>(context);
    final tc = Provider.of<TyphoonCMDProvider>(context);
     final cnfg = Provider.of<ConfigFileProvider>(context);
     final wnd = Provider.of<WindEstimationCMDProvider>(context);
     final scmd = Provider.of<SwanCMDProvider>(context);
     final plt = Provider.of<PlotProvider>(context);
    

    double spacing = 30;
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        title: Text(
          'S W A N',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.deepPurple
          ),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Column(
              children: [
                Tooltip(
                  message: 'Create New File',
                  preferBelow: false,
                  child: Center(
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: dir.dir != ''?MaterialStatePropertyAll(Colors.green[400]):MaterialStatePropertyAll(Colors.deepPurple[50])
                      ),
                      icon: Icon(Icons.file_open_rounded),
                      
                      onPressed: () async {
                        // final newDir = await selectWorkingDirectory();
                        dir.Dir();
                        //  writeCounter(123);
                      },
                      label: Text(
                        'New Domain',
                        style: TextStyle(fontSize: 18,
                        
                        ),
                      ),
                    ),
                  ),
                ),
                dir.dir != ''
                    ? Text(
                        'Dir: ${dir.dir}',
                        style: TextStyle(fontSize: 10, color: Colors.pink),
                      )
                    : Container(),
              ],
            ),
        
          ////////OpenMap
            ///
            SizedBox(height: spacing,),
                 dir.dir != ''? 
                 Column(
             
              children: [
                Tooltip(
                  preferBelow: false,
                  message: 'Open Map',
                  child: Center(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.map),
                      onPressed: () {
                      //  showMyDialog(context);
                      // ViewMap();
                           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>         LMap()),
            );
                      // showConfigurationDialog(context);
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => Topography()));
                      },
                      label: Text(
                        'Open Map',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
               
              ],
            )
            : Container(),
             
            SizedBox(height: spacing,),
             
        
        
            ////////CREATE CONFIGURATION FILE
            ///
            SizedBox(height: spacing,),
                 dir.dir != ''? 
                 Column(
             
              children: [
                Tooltip(
                  preferBelow: false,
                  message: 'Generate Configuration File',
                  child: Center(
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:  cnfg.configDir != ''?MaterialStatePropertyAll(Colors.green[400]):MaterialStatePropertyAll(Colors.deepPurple[50])
                      ),
                      icon: Icon(Icons.settings),
                      onPressed: () {
                      //  showMyDialog(context);
                      showConfigurationDialog(context);
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => Topography()));
                      },
                      label: Text(
                        'Create Configuration File',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                  cnfg.configDir != ''
                      ? Center(
                        child: Text(
                            'File: ${cnfg.configDir}',
                            style: TextStyle(fontSize: 10, color: Colors.pink),
                          ),
                      )
                      : Container(),
              ],
            )
            : Container(),
             
            SizedBox(height: spacing,),
             
        
            ////////MAKE TOPOGRAPHY 
             cnfg.configDir != ''?
             Column(
             
              children: [
                Tooltip(
                  preferBelow: false,
                  message: 'Generate a topographic data either from Noaa/Gebco',
                  child: Center(
                    child: ElevatedButton(
                        style: ButtonStyle(
                        backgroundColor:   cmd.topoDir != ''?MaterialStatePropertyAll(Colors.green[400]):MaterialStatePropertyAll(Colors.deepPurple[50])
                      ),
                      onPressed: () {
                       showMyDialog(context);
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => Topography()));
                      },
                      child: Text(
                        'Make Topography',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                 cmd.topoDir != ''
                      ? Center(
                        child: Text(
                            'File: ${cmd.topoDir}',
                            style: TextStyle(fontSize: 10, color: Colors.pink),
                          ),
                      )
                      : Container(),
              ],
            )
            : Container(),
             
             //////MAKE TYPHOON
                       SizedBox(height: spacing,),
               cmd.topoDir != ''?Column(
                children: [
                  Tooltip(
                  preferBelow: false,
                  message: 'Generate a typhoon track, speed and wave propagation',
                  child: ElevatedButton(
                       style: ButtonStyle(
                        backgroundColor:   tc.typhoonDir!= ''?MaterialStatePropertyAll(Colors.green[400]):MaterialStatePropertyAll(Colors.deepPurple[50])
                      ),
                   
                    onPressed: () {
                       typhoonDialog(context);
                    },
                    child: Text(
                      'Make Typhoon',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                            ),
                              tc.typhoonDir!= ''
                      ? Text(
                          'TC File: ${tc.typhoonDir}',
                          style: TextStyle(fontSize: 10, color: Colors.pink),
                        )
                      : Container(),
                ],
              ): Container(),
            
        
              // ///////// Perforn Wind estimations
                        SizedBox(height: spacing,),
               tc.typhoonDir != ''?  
               
               Tooltip(
              preferBelow: false,
              message: 'Generate computational Analysis on Typhoon and Topographic data',
              child: ElevatedButton(
                   style: ButtonStyle(
                        backgroundColor:    wnd.windDir != ''?MaterialStatePropertyAll(Colors.green[400]):wnd.loading == 'loading'?  MaterialStatePropertyAll(Colors.orange[50]) : MaterialStatePropertyAll(Colors.deepPurple[50])
                      ),
                onPressed: () {
                  windEstimationDialog(context);
                  // wnd.runWindEstimationCmd();
                },
                child: Text(
                  wnd.loading != 'loading'? 'Performing Computations':'Perform Computations',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
            :Container()
            ,
              wnd.windDir != ''
                      ? Center(
                        child: Text(
                            'File: ${wnd.windDir}',
                            style: TextStyle(fontSize: 10, color: Colors.pink),
                          ),
                      )
                      : Container(),
                
                
                          SizedBox(height: spacing,),
                ///////// perfrom SWAN computations
             wnd.windDir != ''?
             
             Tooltip(
              preferBelow: false,
              message:
                  'Start Interpolating the typhoon data in the topographic data',
              child: Center(
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:     scmd.swanDir != ''?MaterialStatePropertyAll(Colors.green[400]):MaterialStatePropertyAll(Colors.deepPurple[50])
                      ),
                  onPressed: () {
                    
                    showSwanConfigDialog(context);
                  },
                  child: Text(
                    'Start Swan',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            )
            : Container()
            ,
                scmd.swanDir != ''
                      ? Center(
                        child: Text(
                            'File: ${scmd.swanDir}',
                            style: TextStyle(fontSize: 10, color: Colors.pink),
                          ),
                      )
                      : Container(),
                  
        
            SizedBox(height: spacing,),
            ////Plot Data
              scmd.swanDir != ''?
              Tooltip(
              preferBelow: false,
              message:
                  'Plot data',
              child: Center(
                child: ElevatedButton(
                     style: ButtonStyle(
                        backgroundColor:      plt.plotDir != ''?MaterialStatePropertyAll(Colors.green[400]):MaterialStatePropertyAll(Colors.deepPurple[50])
                      ),
                  onPressed: () {
                    plt.plot(dir.dir);
                    print('Plot');
                  },
                  child: Text(
                    'Plot',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            )
            : Container()
            ,
             plt.plotDir != ''
                      ? Center(
                        child: Text(
                            'File: ${plt.plotDir}',
                            style: TextStyle(fontSize: 10, color: Colors.pink),
                          ),
                      )
                      : Container(),
          ],
        ),
      ),
    );
  }
}
