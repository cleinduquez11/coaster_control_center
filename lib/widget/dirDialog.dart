import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coaster_control_center/provider/FIleTopographyProvider.dart';
import 'package:coaster_control_center/provider/cmd.dart';

Future<void> showMyDialog(BuildContext context) async {
 

  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
       final topo = Provider.of<RawTopographyProvider>(context);
       final cmd = Provider.of<CMDProvider>(context);
      return
       AlertDialog(
        title: Text('Start Here',     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
        content: SingleChildScrollView(
          child:ListBody(
            children: <Widget>[
              Row(
                 
                children: [
              Text('Create New File'),
              SizedBox(width: 12,),
              ElevatedButton(onPressed:() async{
               topo.getRawTopography();
               cmd.topoDir = '';
              //  final selected =  await selectFile();
              } , child: Text('file',
              
              ) ),
             
                ],
              ),
               topo.fileName!= ''? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                   Padding(
                     padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                     child: Text(topo.fileName, style: TextStyle(fontSize: 12, color: Colors.pink),),
                   ),
                 ],
               ):Container()
             
            ],
          ),
        ),
        // actions:<Widget>[
        //    topo.fileName!= ''?TextButton(
        //     child: const Text('Run'),
        //     onPressed: () {
        //       cmd.runCmd(dir.topoDir,dir.dir);
        //     },
        //   ): Container()
        // ],
      );
   
   
   
   
   
    },
  );
}