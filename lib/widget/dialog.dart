import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coaster_control_center/provider/DirProvider.dart';
import 'package:coaster_control_center/provider/FIleTopographyProvider.dart';
import 'package:coaster_control_center/provider/cmd.dart';
import 'package:coaster_control_center/provider/plotProvider.dart';
import 'package:coaster_control_center/provider/swanCMDProvider.dart';
import 'package:coaster_control_center/provider/swanConfigProvider.dart';
import 'package:coaster_control_center/provider/windEstimation.dart';
import 'package:coaster_control_center/widget/Tabs.dart';
import 'package:coaster_control_center/widget/loading.dart';

Future<void> showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    // useSafeArea: true,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      final topo = Provider.of<RawTopographyProvider>(context);
      final cmd = Provider.of<CMDProvider>(context);
      final dir = Provider.of<DirProvider>(context);
      final plt = Provider.of<plotProvider>(context);

      final wnd = Provider.of<WindEstimationCMDProvider>(context);
      final scmd = Provider.of<SwanCMDProvider>(context);


      Provider.of<SwanConfigFileProvider>(context);
      return 
      
      
      cmd.loading == 'error'
          ? AlertDialog(
            backgroundColor: Colors.green[400],
              title: const Text(
                'Error in Generating Base Map',
                style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              content: const SingleChildScrollView(
                  child: Center(
                child: Row(
                  children: [
                    Icon(Icons.error, color: Colors.red, size: 50),
                    SizedBox(width: 20,),
                    Text('Error encountered while processing,\nmake sure you have the correct data to proceed',  style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w300),)
                  ],
                ),
              )),
              actions: [
                         ElevatedButton(
                      child: const Text('Ok'),
                      onPressed: () {
                        cmd.reset();
                                  // cmd.loading == '';
                        Navigator.of(context).pop();
              
                        showMyDialog(context);
                        //  Navigator.of(context).pop();

                        //  cmd.loading = '';
                      },
                    ),
              ])
              :
      cmd.loading == 'loading'
          ? AlertDialog(
              backgroundColor: Colors.green[400],
            
            
              title: Text(
                'Generating Topography',
                style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              content: SingleChildScrollView(
                  child: Center(
                child: FancyLoading(),
              )),
              actions: [])
          : cmd.loading == 'done' || dir.isBaseMapAvailable
              ? AlertDialog(
                
                  title: const Text(
                    'Successfully Generated Topography',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  content: const SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Row(
                          children: [
                            Text('File is Saved as domain1.txt'),
                            SizedBox(
                              width: 12,
                            ),
                            // ElevatedButton(onPressed:() async{
                            //  topo.getRawTopography();
                            // //  final selected =  await selectFile();
                            // } , child: Text('file',

                            // ) ),
                          ],
                        ),
                        //  topo.fileName!= ''? Column(
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //    children: [
                        //      Padding(
                        //        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        //        child: Text(topo.fileName, style: TextStyle(fontSize: 12, color: Colors.pink),),
                        //      ),
                        //    ],
                        //  ):Container()
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();

                        //  Navigator.of(context).pop();

                        //  cmd.loading = '';
                      },
                    ),
                    ElevatedButton(
                      child: const Text('New'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        showMyDialog(context);
                        //   cmd.topoDir = '';
                        topo.reset();
                        cmd.reset();
                        wnd.reset();
                        scmd.reset();
                        dir.basemapReset();
                        dir.tropicalCycloneReset();
                        dir.windReset();
                        dir.swanReset();
                        dir.plotReset();
                        // showMyDialog(context);
                      },
                    ),
                    ElevatedButton(
                      child: const Text('QuickShow'),
                      onPressed: () {
                        plt.quickplot();
                      },
                    )
                  ],
                )
              : TabDialog(
                  title: 'Generate Base Map',
                  tabs: myTabs,
                  contents: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          const Text('Input raw gebco/noaa: '),
                          const SizedBox(
                            width: 12,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                topo.getRawTopography();
                                cmd.topoDir = '';
                                //  final selected =  await selectFile();
                              },
                              child: const Text(
                                'file',
                              )),
                              topo.fileName != ''
                          ? Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: Text(
                              topo.fileName,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.pink),
                            ),
                          )
                          : Container(),

                          Column(
                     

                            children: [
                              const SizedBox(height: 40,),
                                   topo.fileName != ''
                        ? ElevatedButton(
                            child: const Text('Run'),
                            onPressed: () {
                              cmd.runCmd(dir.topoDir, dir.dir);
                            },
                          )
                        : Container()
                            ],
                          )
                        ],
                      ),
                    ),
                                      Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          const Text('Import domain1.txt'),
                          const SizedBox(
                            width: 12,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                // topo.getRawTopography();
                                topo.importDomain();
                                cmd.topoDir = '';
                                //  final selected =  await selectFile();
                              },
                              child: const Text(
                                'domain file',
                              )),
                              topo.fileName1 != ''
                          ? Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: Text(
                              topo.fileName1,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.pink),
                            ),
                          )
                          : Container(),

                          Column(
                     

                            children: [
                              const SizedBox(height: 40,),
                                   topo.fileName1 != ''
                        ? ElevatedButton(
                            child: const Text('Run'),
                            onPressed: () {
                              cmd.runCopyCmd(dir.topoDir, dir.dir);
                                cmd.topoDir = '';
                            },
                          )
                        : Container()
                            ],
                          )
                        ],
                      ),
                    ),
            
                
                  ],
                  // actions: [
                  //   topo.fileName != ''
                  //       ? ElevatedButton(
                  //           child: const Text('Run'),
                  //           onPressed: () {
                  //             cmd.runCmd(dir.topoDir, dir.dir);
                  //           },
                  //         )
                  //       : Container()
                  // ],
                );

      //  AlertDialog(
      //   title: Text('Generate Topography',     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
      //   content: SingleChildScrollView(
      //     child:ListBody(
      //       children: <Widget>[
      //         Row(

      //           children: [
      //         Text('Input raw gebco/noaa: '),
      //         SizedBox(width: 12,),
      //         ElevatedButton(onPressed:() async{
      //          topo.getRawTopography();
      //          cmd.topoDir = '';
      //         //  final selected =  await selectFile();
      //         } , child: Text('file',

      //         ) ),

      //           ],
      //         ),
      //          topo.fileName!= ''? Column(
      //           crossAxisAlignment: CrossAxisAlignment.end,
      //            children: [
      //              Padding(
      //                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
      //                child: Text(topo.fileName, style: TextStyle(fontSize: 12, color: Colors.pink),),
      //              ),
      //            ],
      //          ):Container()

      //       ],
      //     ),
      //   ),
      //   actions:<Widget>[
      //      topo.fileName!= ''?ElevatedButton(
      //       child: const Text('Run'),
      //       onPressed: () {
      //         cmd.runCmd(dir.topoDir,dir.dir);
      //       },
      //     ): Container()
      //   ],
      // );
    },
  );
}
