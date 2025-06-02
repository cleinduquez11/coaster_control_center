import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:coaster_control_center/provider/DirProvider.dart';
import 'package:coaster_control_center/provider/disasterProvider.dart';
// import 'package:swan/provider/FIleTopographyProvider.dart';
// import 'package:swan/provider/cmd.dart';
// import 'package:swan/provider/plotProvider.dart';
import 'package:coaster_control_center/provider/windEstimation.dart';
import 'package:coaster_control_center/widget/loading.dart';

Future<void> windEstimationDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
       final _formKey = GlobalKey<FormState>();
      //  final topo = Provider.of<RawTopographyProvider>(context);
      //  final cmd = Provider.of<CMDProvider>(context);
      final disasterTypeProvider = Provider.of<DisasterTypeProvider>(context);
      final descriptionProvider = Provider.of<DescriptionProvider>(context);
      final dir = Provider.of<DirProvider>(context);
        final dis = Provider.of<DisasterTypeProvider>(context);
      //  final plt = Provider.of<plotProvider>(context);
      final wnd = Provider.of<WindEstimationCMDProvider>(context);
      return
       wnd.loading == 'error'
          ? AlertDialog(
               title: Text('Error while processing',    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
        content: SingleChildScrollView(
          child: Center(child: Row(
            children: [
                 Icon(Icons.error, color: Colors.red, size: 50),
                    SizedBox(width: 20,),
                    Text('Error encuntered while processing,\nmake sure you have the correct data to proceed',  style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w300),)
            ],
          ))
        ),
        actions: [
           ElevatedButton(
                      child: const Text('Ok'),
                      onPressed: () {
              
                        wnd.reset();
                                  // cmd.loading == '';
                        Navigator.of(context).pop();
                        windEstimationDialog(context);
                        // showMyDialog(context);
                        //  Navigator.of(context).pop();

                        //  cmd.loading = '';
                      },
                    ),
        ]
              )

              :
      
       wnd.loading == 'loading'
          ? AlertDialog(
              backgroundColor: Colors.green[400],
              title: const Text(
                'Performing Wind Estimation',
                style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              content: const SingleChildScrollView(
                  child: Center(
                child: FancyLoading(),
              )),
              actions: [])
          : wnd.loading == 'done' || dir.isWindAvailable   
              ? AlertDialog(
                  title: const Text(
                    'Successfully Estimated Wind Paramaters',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  content: const SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Row(
                          children: [
                            Text('File is Saved as SWAN-WIND-DATA01.txt'),
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
                        // wnd.loading = '';
                      },
                    ),
                    ElevatedButton(
                      child: const Text('New'),
                      onPressed: () {
                        Navigator.of(context).pop();
                            windEstimationDialog(context);
                            wnd.reset();
                            dis.reset();
                            dir.windReset();
                            dir.swanReset();
                            dir.plotReset();
                            // wnd.loading = '';
                        //   tpd.typhoonDir = '';
                        //  tpd.loading = '';
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
              : AlertDialog(
                  title: const Text(
                    'Perform Wind Estimations',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  content: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: ListBody(
                          children: <Widget>[
                        
                                 const Text('Calculation Time Interval'),
                            TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Calc-Time';
                                      }
                                      return null;
                                    },
                                    inputFormatters: <TextInputFormatter>[
                                      // for below version 2 use this
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r"[0-9.-]")),
                                      // for version 2 and greater youcan also use this
                                      // FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(
                                    //     // border: OutlineInputBorder(),
                                    //     // helperText: '20151012.000000',
                                        hintText: '60' ,
                                      
                                        // labelText: 'Calculation Time Interval(s)'
                                        
                                        ),
                                    onChanged: (value) {
                                      // cnfg.getCols(value);
                                    },
                                    controller: disasterTypeProvider.ctiController,
                                  ),
                                  const SizedBox(height: 30,),
                             const Text('Computational Analysis'),
                            DropdownButtonFormField<DisasterType>(
                              // padding: EdgeInsets.all(8),
                              value: disasterTypeProvider.selectedDisasterType,
                              items: disasterTypes
                                  .map((type) => DropdownMenuItem(
                        
                                        value: type,
                                        child: Text(type.name),
                                      ))
                                  .toList(),
                                validator: (value) {
                                      if (value == null || value.name.isEmpty) {
                                        return 'Please Select Computational Analysis';
                                      }
                                      return null;
                                    },
                              onChanged: (type) => {
                                disasterTypeProvider.selectDisasterType(type!),
                                descriptionProvider
                                    .updateDescription(type.description),
                              },
                        
                        
                              // hint: const Text('Select Computational Analysis'),
                              dropdownColor: const Color.fromARGB(255, 193, 230, 199), // Dark greenish background
                              iconEnabledColor: Colors.white, // White icon color
                              iconDisabledColor:
                                  Colors.white30, // Light gray disabled icon color
                              iconSize: 24.0,
                        // Adjust icon size as needed
                            ),
                            // SizedBox(height: 20,),
                        
                          ],
                        ),
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text('Run'),
                      onPressed: () {
           if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    // Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('SWAN Config File Created')),
                    );
                    disasterTypeProvider.windSubmit();
                    wnd.runWindEstimationCmd(dir.dir);

                    // cnfg.getVals(dir.dir);
                  }

                      
                        // tpd.runTyphoonCmd(dir.dir);
                      },
                    )
                  ],
                );
    },
  );
}
