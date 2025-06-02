import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coaster_control_center/provider/DirProvider.dart';
import 'package:coaster_control_center/provider/FIleTopographyProvider.dart';
// import 'package:swan/provider/FIleTopographyProvider.dart';
import 'package:coaster_control_center/provider/TyphoonFileProvider.dart';
import 'package:coaster_control_center/provider/cmd.dart';
import 'package:coaster_control_center/provider/swanCMDProvider.dart';
// import 'package:swan/provider/cmd.dart';
// import 'package:swan/provider/plotProvider.dart';
import 'package:coaster_control_center/provider/typhoonCmd.dart';
import 'package:coaster_control_center/provider/windEstimation.dart';
import 'package:coaster_control_center/widget/loading.dart';

Future<void> typhoonDialog(BuildContext context) async {
 

  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      //  final topo = Provider.of<RawTopographyProvider>(context);
      //  final cmd = Provider.of<CMDProvider>(context);
       final dir = Provider.of<DirProvider>(context);
      //  final plt = Provider.of<plotProvider>(context);
       final tpd = Provider.of<TyphoonCMDProvider>(context);
        final tp = Provider.of<TyphoonProvider>(context);
      final topo = Provider.of<RawTopographyProvider>(context);
       final cmd = Provider.of<CMDProvider>(context);
 
    final wnd = Provider.of<WindEstimationCMDProvider>(context);
    final scmd = Provider.of<SwanCMDProvider>(context);


      return 

           tpd.loading == 'error' || tp.error != ''? 
      AlertDialog(
        title: Text('Error reading file',    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
        content: SingleChildScrollView(
          child: Center(child: Row(
            children: [
                 Icon(Icons.error, color: Colors.red, size: 50),
                    SizedBox(width: 20,),
                    Text('Error encountered while processing,\nmake sure you have the correct data to proceed',  style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w300),)
            ],
          ))
        ),
        actions: [
           ElevatedButton(
                      child: const Text('Ok'),
                      onPressed: () {
                        tpd.reset();
                        tp.reset();
                                  // cmd.loading == '';
                        Navigator.of(context).pop();
                        typhoonDialog(context);
                        // showMyDialog(context);
                        //  Navigator.of(context).pop();

                        //  cmd.loading = '';
                      },
                    ),
        ]
      ):
     tpd.loading == 'loading'? 
      AlertDialog(
          backgroundColor: Colors.green[400],
        title: Text('Generating Typhoon',    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
        content: SingleChildScrollView(
          child: Center(child: FancyLoading(),)
        ),
        actions: []
      )
      :   tpd.loading == 'done' || dir.isTropicalCycloneAvailable ?
        AlertDialog(
        title: Text('Successfully Generated Typhoon',     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
        content: SingleChildScrollView(
          child:ListBody(
            children: <Widget>[
              Row(
                 
                children: [
              Text('File is Saved as isewan.prn'),
              SizedBox(width: 12,),
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
        actions:<Widget>[
           ElevatedButton(
            child: const Text('Close'),
            onPressed: () {
                 Navigator.of(context).pop();
            
            //  Navigator.of(context).pop();
            //  tpd.loading = '';
            },
          ),
           ElevatedButton(
            child: const Text('New'),
            onPressed: () {
              Navigator.of(context).pop();
              //       tpd.typhoonDir = ' ';
              //  tpd.loading = ' ';
              //  tp.tcDir = ' ';
               tpd.reset();
               tp.reset();
                     topo.reset();
              cmd.reset();
              wnd.reset();
              scmd.reset();
              dir.tropicalCycloneReset();
      
              dir.windReset();

              dir.swanReset();
              dir.plotReset();
                typhoonDialog(context);
          
              // showMyDialog(context);
            },
          ),
          //   TextButton(
          //   child: const Text('QuickShow'),
          //   onPressed: () {
          //   //  plt.quickplot();
          //   },
          // )
        ],
      )
      :
       AlertDialog(
        title: Text('Generate Typhoon',     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
        content: SingleChildScrollView(
          child:ListBody(
            children: <Widget>[
              Row(
                 
                children: [
              Text('Input typhoon track(.csv)'),
              SizedBox(width: 12,),
              ElevatedButton(onPressed:() async{
              //  topo.getRawTopography();
              // tpd.runTyphoonCmd(dir.dir);
              tp.getTyphoonCsv();
               tpd.typhoonDir = '';
              //  final selected =  await selectFile();
              } , child: Text('file',
              
              ) ),
             
                ],
              ),
               tp.tcDir!= ''? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                   Padding(
                     padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                     child: Text(tp.tcDir, style: TextStyle(fontSize: 12, color: Colors.pink),),
                   ),
                 ],
               ):Container()
             
            ],
          ),
        ),
        actions:<Widget>[
           tp.fileName!= ''?ElevatedButton(
            child: const Text('Run'),
            onPressed: () {
              tpd.runTyphoonCmd(dir.dir);
            },
          ): Container()
        ],
      );
   
   
   
   
   
    },
  );
}