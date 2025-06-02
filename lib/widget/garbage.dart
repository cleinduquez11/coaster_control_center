import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:coaster_control_center/provider/DirProvider.dart';
import 'package:coaster_control_center/provider/configFileProvider.dart';
import 'package:coaster_control_center/provider/nestFileProvider.dart';
import 'package:coaster_control_center/provider/swanCMDProvider.dart';
import 'package:coaster_control_center/provider/swanConfigProvider.dart';
import 'package:coaster_control_center/widget/accordion.dart';
import 'package:coaster_control_center/widget/loading.dart';

Future<void> showSwanConfigDialogTest(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      final swcnfg = Provider.of<SwanConfigFileProvider>(context);
        final cnfg = Provider.of<ConfigFileProvider>(context);
        final nf = Provider.of<NestFileProvider>(context);
        final scmd = Provider.of<SwanCMDProvider>(context);
        final dir = Provider.of<DirProvider>(context);
  

      final _formKey = GlobalKey<FormState>();
      return 
      
       scmd.loading == 'loading'? 
      const AlertDialog(
        title: Text('Simulating Waves based on Wind parameters',    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
        content: SingleChildScrollView(
          child: Center(child: FancyLoading(),)
        ),
        actions: []
      )
      :   scmd.loading == 'done'? 
      AlertDialog(
        title: const Text('Successfully Performed SWAN',     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
        content: const SingleChildScrollView(
          child:ListBody(
            children: <Widget>[
              Row(
                 
                children: [
              Text('File is Saved as out.mat'),
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
           TextButton(
            child: const Text('Exit'),
            onPressed: () {
                 Navigator.of(context).pop();
            
            //  Navigator.of(context).pop();
            //  wnd.loading = '';
            },
          ),
           TextButton(
            child: const Text('New'),
            onPressed: () {
              Navigator.of(context).pop();
               
              //   tpd.typhoonDir = '';
              //  tpd.loading = '';
              // showMyDialog(context);
            },
          ),
            TextButton(
            child: const Text('QuickShow'),
            onPressed: () {
            //  plt.quickplot();
            },
          )
        ],
      ):
     
     
     
     
      AlertDialog(
          title: const Text(
            'Swan Configuration File',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.50,
            height: MediaQuery.of(context).size.height * 0.50,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Accordion(
                  // mainAxisSize: MainAxisSize.min,
                  items: [

                    AccordionItem(
                    title:  const Text('Calculation Area Setting'),  
                    content:   
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ////Column 1
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter Start Date';
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
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    // helperText: '20151012.000000',
                                    hintText: 'ex. 20151012.000000',
                                    labelText: 'Start Time'),
                                onChanged: (value) {
                                  // cnfg.getCols(value);
                                },
                                controller: swcnfg.startTimeController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Tout_Pl value';
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
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    // helperText: '20151012.000000',
                                    // hintText: 'ex. ' ,
              
                                    labelText: 'tout_pl'),
                                onChanged: (value) {
                                  // cnfg.getCols(value);
                                },
                                controller: swcnfg.toutPLTimeController,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
              
                        ////Column 2
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter End Time value';
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
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'ex. 20151021.000000',
                                    labelText: 'End Time'),
                                onChanged: (value) {
                                  // cnfg.getCols(value);
                                },
                                controller: swcnfg.endTimeController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter TOUT value';
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
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    // helperText: '20151012.000000',
                                    // hintText: 'ex. ' ,
              
                                    labelText: 'tout_po'),
                                onChanged: (value) {
                                  // cnfg.getCols(value);
                                },
                                controller: swcnfg.toutPOController,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ////Column 3
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Calc Time Interval value';
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
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Calculation Time Interval'),
                                onChanged: (value) {
                                  // cnfg.getCols(value);
                                },
                                controller: swcnfg.calcTimeInterval,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ////Column4
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter WindSpeed Time Interval value';
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
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Wind Speed input Time Interval'),
                                  
                                onChanged: (value) {
                                  // cnfg.getCols(value);
                                },
                                controller: swcnfg.windSpeedTimeController,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
      
                   AccordionItem(title:const Text('Input Nesting File') , content:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ////Column 1
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                        
                              Container()
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
              
                        ////Column 2
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                ElevatedButton(onPressed:() async{
              //  topo.getRawTopography();
              // tpd.runTyphoonCmd(dir.dir);
                              nf.getFile();
              //  final selected =  await selectFile();
              } , child: const Text('Select Nest file',
              
              ) ),
             nf.p != '-'?Text(nf.p, style: const TextStyle(fontSize: 12, color: Colors.pink),): Container(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ////Column 3
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                Container()
                            ],
                          ),

                        ),
                        const SizedBox(
                          width: 20,
                        ),
            
                      ],
                    ),
              ),
                   
                    AccordionItem(title: const Text('Setting of Child Area'), content: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ////Column 1
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter NX value';
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
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    // helperText: '20151012.000000',
                                    hintText: '',
                                    labelText: 'NX'),
                                onChanged: (value) {
                                  // cnfg.getCols(value);
                                },
                                controller: swcnfg.nrowsChildController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter DX value';
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
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    // helperText: '20151012.000000',
                                    // hintText: 'ex. ' ,
              
                                    labelText: 'dx'),
                                onChanged: (value) {
                                  // cnfg.getCols(value);
                                },
                                controller: swcnfg.dxChildController,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
              
                        ////Column 2
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter NY value';
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
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: '',
                                    labelText: 'NY'),
                                onChanged: (value) {
                                  // cnfg.getCols(value);
                                },
                                controller:swcnfg.ncolsChildController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter DY value';
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
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    // helperText: '20151012.000000',
                                    // hintText: 'ex. ' ,
              
                                    labelText: 'dy'),
                                onChanged: (value) {
                                  // cnfg.getCols(value);
                                },
                                controller: swcnfg.dyChildController,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ////Column 3
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter XLLcorner value';
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
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'X0'),
                                onChanged: (value) {
                                  // cnfg.getCols(value);
                                },
                                controller: swcnfg.xllcornerChildController,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ////Column4
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter YLL corner value';
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
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Y0'),
                                onChanged: (value) {
                                  // cnfg.getCols(value);
                                },
                                controller: swcnfg.yllcornerChildController,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
          ),

          AccordionItem(title: const Text('Setting of time series output points for arbitrary points'), content: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        
                        ////Column 1
                        Expanded(
                          child: Column(
                            
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                     
                                  const Text(
                      'Name of Point',
                      style:  TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                       for(var i = 1; i < 15; i++)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  readOnly: true,
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return 'Please enter Columns value';
                                  //   }
                                  //   return null;
                                  // },
                                  inputFormatters: <TextInputFormatter>[
                                    // for below version 2 use this
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r"[0-9.-]")),
                                    // for version 2 and greater youcan also use this
                                    // FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      // helperText: '20151012.000000',
                                      // hintText: 'ex. 20151012.000000',
                                      // labelText: 'Start Time'
                                      ),
                                      initialValue: '$i',
                                  // onChanged: (value) {
                                  //   // cnfg.getCols(value);
                                  // },
                                  // controller: cnfg.ncolsController,
                                ),
                              ),
               
                        
                     
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
              
                
                        ////Column 3
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                                  const Text(
                      'X',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                     for(var i = 0; i < 14; i++)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return 'Please enter Calc Time Interval value';
                                  //   }
                                  //   return null;
                                  // },
                                  inputFormatters: <TextInputFormatter>[
                                    // for below version 2 use this
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r"[0-9.-]")),
                                    // for version 2 and greater youcan also use this
                                    // FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      // labelText: 'Calculation Time Interval'
                                      ),
                                  onChanged: (value) {
                                    // cnfg.getCols(value);
                                  },
                                  controller: swcnfg.xControllers[i],
                                ),
                              ),
                      
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ////Column4
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                                  const Text(
                      'Y',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                     for(var i = 0; i < 14; i++)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return 'Please enter WindSpeed Time Interval value';
                                  //   }
                                  //   return null;
                                  // },
                                  inputFormatters: <TextInputFormatter>[
                                    // for below version 2 use this
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r"[0-9.-]")),
                                    // for version 2 and greater youcan also use this
                                    // FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      // labelText: 'Wind Speed input Time Interval'
                                      ),
                                  onChanged: (value) {
                                    // cnfg.getCols(value);
                                  },
                                  controller: swcnfg.yControllers[i],
                                ),
                              ),
                                      
                            ],
                          ),
                        ),
                      ],
                    ),  
                 )
              
                    //Nesting Setting (Setting 2)
              
        
                
                  ],
                  // initiallyExpanded: true,
                ),
              ),
            ),
          ),
          actions: [
            TextButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    // Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('SWAN Config File Created')),
                    );
                    print(dir.ncols);
                    swcnfg.getVals( dir.isConfig?dir.ncols:cnfg.ncols,  dir.isConfig?dir.nrows:cnfg.nrows,  dir.isConfig?dir.xo: cnfg.X, dir.isConfig?dir.yo:cnfg.Y, dir.isConfig?dir.cellsize: cnfg.cellSize,nf.p);
                    scmd.runSwanCmd(dir.dir);

                    // cnfg.getVals(dir.dir);
                  }
                  // print(cnfg.ncolsController.text);
                },
                icon: const Icon(Icons.play_circle_outline_outlined),
                label: const Text('Run'))
          ]);
    
    
    },
  );
}
