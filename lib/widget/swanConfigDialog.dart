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
import 'package:intl/intl.dart'; 
Future<void> showSwanConfigDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      final swcnfg = Provider.of<SwanConfigFileProvider>(context);
        final cnfg = Provider.of<ConfigFileProvider>(context);
        final nf = Provider.of<NestFileProvider>(context);
        final scmd = Provider.of<SwanCMDProvider>(context);
        final dir = Provider.of<DirProvider>(context);
      //   final startDateController = TextEditingController(text: '');
      // final endDateController = TextEditingController(text: '');


      final _formKey1 = GlobalKey<FormState>();
      return 
      
       scmd.loading == 'loading'? 
      AlertDialog(
          backgroundColor: Colors.green[400],
        title: const Text('Simulating Waves based on Wind parameters',    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
        content: const SingleChildScrollView(
          child: Center(child: FancyLoading(),)
        ),
        actions: []
      )
      :   scmd.loading == 'done'  || dir.isSwanAvailable   ? 
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
           ElevatedButton(
            child: const Text('Close'),
            onPressed: () {
                 Navigator.of(context).pop();
            
            //  Navigator.of(context).pop();
            //  wnd.loading = '';
            },
          ),
           ElevatedButton(
            child: const Text('New'),
            onPressed: () {
              dir.plotReset();
              dir.swanReset();
              
              Navigator.of(context).pop();
              showSwanConfigDialog(context); 

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
                key: _formKey1,
                child: Column(
                  children: [
                      const SizedBox(height: 40,),
                      
                   
                        const Text('Calculation Area Setting', style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24
                        ),),  
                       const SizedBox(height: 20,),
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
                        return '* Start date required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'ex. 20151012.000000',
                      border: OutlineInputBorder(),
                      labelText: 'Start Date',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () async {
                          DateTime? pickedDate = await _selectDate(context);
                          TimeOfDay? pickedTime = await _selectTime(context);

                          if (pickedDate != null && pickedTime != null) {
                            DateTime combinedDateTime = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                            String formattedDate = _formatDateTime(combinedDateTime);
                            swcnfg.startTimeController.text = formattedDate;
                          }
                        },
                      ),
                    ),
                    controller: swcnfg.startTimeController,
                    readOnly: true,
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
                                        hintText: '60' ,
                                  
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
                                         // End Date Field (with DateTimePicker)
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '* End date required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'ex. 20151012.000000',
                      border: OutlineInputBorder(),
                      labelText: 'End Date',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () async {
                          DateTime? pickedDate = await _selectDate(context);
                          TimeOfDay? pickedTime = await _selectTime(context);

                          if (pickedDate != null && pickedTime != null) {
                            DateTime combinedDateTime = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                            String formattedDate = _formatDateTime(combinedDateTime);
                            swcnfg.endTimeController.text = formattedDate;
                          }
                        },
                      ),
                    ),
                    controller: swcnfg.endTimeController,
                    readOnly: true,
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
                                        hintText: '60' ,
                                  
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
                                        hintText: '300',
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
                                        hintText: '600',
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
                 
                      
  const SizedBox(height: 40,),
                    Accordion(
                      // mainAxisSize: MainAxisSize.min,
                      items: [
                        
                       AccordionItem(title:   nf.p != '-'?Text('Parent File: ${nf.p}', style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.red[300]
                       ) ,) :const Text('Input Parent Nesting File') ,
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
                                  } , child: const Text('Select Parent Nesting File',
                                  
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
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please enter NX value';
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
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please enter DX value';
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
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please enter NY value';
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
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please enter DY value';
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
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please enter XLLcorner value';
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
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please enter YLL corner value';
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
                     ),
                                  
                        //Nesting Setting (Setting 2)
                                  
                                 AccordionItem(title: Text('General Parameters'), content: 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            
                            ////Column 1
                            Expanded(
                              child: Column(
                                
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                         
                                         //Column 1
              
                        //Water Level
                          Tooltip(
                              message: '''Increase in water level that is constant in space and time can be given with
this option, [level] is the value of this increase (in m). For a variable water
level reference is made to the commands INPGRID and READINP.
Default: [level]=0.09''',
                            child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        // readOnly: true,
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
                                            labelText: 'Water Level'
                                            ),
                                            // initialValue: '0.09',
                                        // onChanged: (value) {
                                        //   // cnfg.getCols(value);
                                        // },
                                        controller: swcnfg.levelController,
                                      ),
                                    ),
                          ),
                       
                            
                            //MaxErr
                               Tooltip(
                                message: '''
1 : warnings,
2 : errors (possibly automatically repaired or repairable by SWAN),
3 : severe errors.''',
                                 child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        // readOnly: true,
                                        // valiator: (value) {
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
                                            labelText: 'maxerr'
                                            ),
                                            // initialValue: '3',
                                        // onChanged: (value) {
                                        //   // cnfg.getCols(value);
                                        // },
                                        controller: swcnfg.maxerrController,
                                      ),
                                    ),
                               ),

                                        //hsrerr
                               Tooltip(
                                message: '''the relative difference between the user imposed significant wave height and the
significant wave height computed by SWAN (anywhere along the computational
grid boundary) above which a warning will be given. This relative difference
is the difference normalized with the user provided significant wave height. This
warning will be given for each boundary grid point where the problem occurs
(with its x− and y−index number of the computational grid). The cause of the
difference is explained in Section 2.6.3. To supress these warnings (in particular
for nonstationary computations), set [hsrerr] at a very high value or use
command OFF BNDCHK.
Default: [hsrerr] = 0.10.''',
                                 child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        // readOnly: true,
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
                                            labelText: 'hsrerr'
                                            ),
                                            // initialValue: '0.1',
                                        // onChanged: (value) {
                                        //   // cnfg.getCols(value);
                                        // },
                                        controller: swcnfg.hsrerrController,
                                      ),
                                    ),
                               ),

                                      //prtest
                               Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      // readOnly: true,
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
                                          labelText: 'prtest'
                                          ),
                                          // initialValue: '4',
                                      // onChanged: (value) {
                                      //   // cnfg.getCols(value);
                                      // },
                                      controller: swcnfg.prtestController,
                                    ),
                                  ),

                       
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                                  
                    
                            ////Column 3
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //Column 2
          
                    //Direction of north
                        Tooltip(
                          message: '''
Direction of North with respect to the x−axis (measured counterclockwise);
default [nor]= 90''',
                          child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        // readOnly: true,
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
                                            labelText: 'Nor'
                                            ),
                                            // initialValue: '90',
                                        // onChanged: (value) {
                                        //   // cnfg.getCols(value);
                                        // },
                                        controller: swcnfg.norController,
                                      ),
                                    ),
                        ),

                                   //Gravity
                               Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      // readOnly: true,
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
                                          labelText: 'Gravity'
                                          ),
                                          // initialValue: '9.81',
                                      // onChanged: (value) {
                                      //   // cnfg.getCols(value);
                                      // },
                                      controller: swcnfg.gravController,
                                    ),
                                  ),

                                        //pwtail
                               Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      // readOnly: true,
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
                                          labelText: 'pwtail'
                                          ),
                                          // initialValue: '5',
                                      // onChanged: (value) {
                                      //   // cnfg.getCols(value);
                                      // },
                                      controller: swcnfg.pwtailController,
                                    ),
                                  ),

                        Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child:Container()
                                  ),
                       
                       
                  
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ////Column4
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //Column 3
                 
                      //DepMin
                               Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      // readOnly: true,
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
                                          labelText: 'depmin'
                                          ),
                                          // initialValue: '0.01',
                                      // onChanged: (value) {
                                      //   // cnfg.getCols(value);
                                      // },
                                      controller: swcnfg.depminController,
                                    ),
                                  ),

                                   //rho
                               Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      // readOnly: true,
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
                                          labelText: 'Rho'
                                          ),
                                          // initialValue: '1025',
                                      // onChanged: (value) {
                                      //   // cnfg.getCols(value);
                                      // },
                                      controller: swcnfg.rhoController,
                                    ),
                                  ),

                                    //froudmax
                               Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      // readOnly: true,
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
                                          labelText: 'froudmax'
                                          ),
                                          // initialValue: '0.8',
                                      // onChanged: (value) {
                                      //   // cnfg.getCols(value);
                                      // },
                                      controller: swcnfg.froudmaxController,
                                    ),
                                  ),

                        Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child:Container()
                                  ),
                       
                       
                      
                                ],
                              ),
                            ),

                                 SizedBox(
                              width: 20,
                            ),
                            ////Column4
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //Column 4
                

                         //MaxMes
                               Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      // readOnly: true,
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
                                          labelText: 'maxmes'
                                          ),
                                          // initialValue: '200',
                                      // onChanged: (value) {
                                      //   // cnfg.getCols(value);
                                      // },
                                      controller: swcnfg.maxmesController,
                                    ),
                                  ),
                                   //inRhog
                               Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      // readOnly: true,
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
                                          labelText: 'inrhog'
                                          ),
                                          // initialValue: '0',
                                      // onChanged: (value) {
                                      //   // cnfg.getCols(value);
                                      // },
                                      controller: swcnfg.inrhogController,
                                    ),
                                  ),
                                      //printf
                               Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      // readOnly: true,
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
                                          labelText: 'printf'
                                          ),
                                          // initialValue: '4',
                                      // onChanged: (value) {
                                      //   // cnfg.getCols(value);
                                      // },
                                      controller: swcnfg.printfController,
                                    ),
                                  ),
                        Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child:Container()
                                  ),
                       
                      
                                ],
                              ),
                            ),
                          ],
                        ),  
                     )
                                  
                    
                      ],
                      // initiallyExpanded: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton.icon(
                onPressed: () {
                  if (_formKey1.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    // Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('SWAN Config File Created')),
                    );
                   dir.isConfig? swcnfg.getVals(dir.ncols, dir.nrows, dir.xo, dir.yo, dir.cellsize,  nf.p): swcnfg.getVals(cnfg.ncols,cnfg.nrows,cnfg.X,cnfg.Y,cnfg.cellSize,nf.p);
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
Future<DateTime?> _selectDate(BuildContext context) async {
  return await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );
}

Future<TimeOfDay?> _selectTime(BuildContext context) async {
  return await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
}

// Format the DateTime to the required string format: 20151012.HHmmss
String _formatDateTime(DateTime dateTime) {
  final DateFormat formatter = DateFormat('yyyyMMdd.HHmmss');
  return formatter.format(dateTime);
}