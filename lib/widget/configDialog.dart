import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:coaster_control_center/provider/DirProvider.dart';
import 'package:coaster_control_center/provider/configFileProvider.dart';

Future<void> showConfigurationDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      final cnfg = Provider.of<ConfigFileProvider>(context);
      final dir = Provider.of<DirProvider>(context);

      final _formKey = GlobalKey<FormState>();
      return dir.isConfig || cnfg.configDir != ''?
          AlertDialog(
              title: Text(
                'Configuration file',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              content: SizedBox(
                width: 550,
                height: 240,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 40,
                              ),
                              TextFormField(
                                initialValue:  dir.isConfig?  dir.ncols: cnfg.ncols,
                                readOnly: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Columns value';
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
                                    border: OutlineInputBorder(),
                                    labelText: 'Number of Columns'),
                                onChanged: (value) {
                                  // cnfg.getCols(value);
                                },
                                // controller: cnfg.ncolsController,
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              TextFormField(
                                initialValue:  dir.isConfig? dir.xo : cnfg.X,
                                readOnly: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter X0 value';
                                  }
                                  return null;
                                },
                                inputFormatters: <TextInputFormatter>[
                                  // for below version 2 use this
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r"[0-9.-]")),
                                  // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  // for version 2 and greater youcan also use this
                                  // FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'X0'),
                                onChanged: (value) {
                                  print(value);
                                },
                                // controller: cnfg.xllcornerController,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ////Enter Rows Field

                    
                              ////Enter UTM-Zone
                              TextFormField(
                                initialValue: dir.isConfig?  dir.utm : cnfg.utm,
                                readOnly: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter UTM Zone value';
                                  }
                                  return null;
                                },
                                inputFormatters: <TextInputFormatter>[
                                  // for below version 2 use this
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r"[0-9.-]")),
                                  // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  // for version 2 and greater youcan also use this
                                  // FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'UTM Zone'),
                                onChanged: (value) {
                                  print(value);
                                },
                                // controller: cnfg.utmController,
                              ),
                            ],
                          ),
                        ),

                        //Enter Columns Field
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 40,
                              ),

                              TextFormField(
                                initialValue:  dir.isConfig? dir.nrows : cnfg.nrows ,
                                readOnly: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Rows value';
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
                                    border: OutlineInputBorder(),
                                    labelText: 'Number of Rows'),
                                onChanged: (value) {
                                  print(value);
                                },
                                // controller: cnfg.nrowsController,
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              ////Enter YLL corner Field
                              TextFormField(
                                initialValue:  dir.isConfig?  dir.yo: cnfg.Y ,
                                readOnly: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Y0 value';
                                  }
                                  return null;
                                },
                                inputFormatters: <TextInputFormatter>[
                                  // for below version 2 use this
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r"[0-9.-]")),
                                  // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  // for version 2 and greater youcan also use this
                                  // FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Y0'),
                                onChanged: (value) {
                                  print(value);
                                },
                                // controller: cnfg.yllcornerController,
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              ////Enter CellSize Field
                              TextFormField(
                                initialValue:  dir.isConfig? dir.cellsize : cnfg.cellSize ,
                                readOnly: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter CellSize value';
                                  }
                                  return null;
                                },
                                inputFormatters: <TextInputFormatter>[
                                  // for below version 2 use this
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r"[0-9.-]")),
                                  // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  // for version 2 and greater youcan also use this
                                  // FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'CellSize'),
                                onChanged: (value) {
                                  print(value);
                                },
                                // controller: cnfg.cellSizeController,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // print(cnfg.ncolsController.text);
                      },
                      child: Text('Close')),
                  ElevatedButton(
                      onPressed: () {
                        cnfg.reset();
                        dir.configreset();
                        dir.basemapReset();
                        dir.tropicalCycloneReset();
                        dir.windReset();
                        dir.swanReset();
                        dir.plotReset();
                        Navigator.of(context).pop();
                        showConfigurationDialog(context);
                        // print(cnfg.ncolsController.text);
                      },
                      child: Text('New'))
                ])
    
    
    :

        
          AlertDialog(
              title: Text(
                'Create Configuration file',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              content: SizedBox(
                width: 550,
                height: 240,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 40,
                              ),
                              TextFormField(
                                // initialValue: dir.ncols,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Columns value';
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
                                    border: OutlineInputBorder(),
                                    labelText: 'Number of Columns'),
                                onChanged: (value) {
                                  // cnfg.getCols(value);
                                },
                                controller: cnfg.ncolsController,
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              ////Enter Rows Field
                              TextFormField(
                                // initialValue:   dir.xo,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter X0 value';
                                  }
                                  return null;
                                },
                                inputFormatters: <TextInputFormatter>[
                                  // for below version 2 use this
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r"[0-9.-]")),
                                  // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  // for version 2 and greater youcan also use this
                                  // FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'X0'),
                                onChanged: (value) {
                                  print(value);
                                },
                                controller: cnfg.xllcornerController,
                              ),

                              ///
                              SizedBox(
                                height: 20,
                              ),

                              ////Enter UTM-Zone
                              TextFormField(
                                // initialValue: dir.utm,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter UTM Zone value';
                                  }
                                  return null;
                                },
                                inputFormatters: <TextInputFormatter>[
                                  // for below version 2 use this
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r"[0-9.-]")),
                                  // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  // for version 2 and greater youcan also use this
                                  // FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'UTM Zone'),
                                onChanged: (value) {
                                  print(value);
                                },
                                controller: cnfg.utmController,
                              ),
                            ],
                          ),
                        ),

                        ////Enter Columns Field
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 40,
                              ),
                              TextFormField(
                                // initialValue: dir.nrows,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Rows value';
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
                                    border: OutlineInputBorder(),
                                    labelText: 'Number of Rows'),
                                onChanged: (value) {
                                  print(value);
                                },
                                controller: cnfg.nrowsController,
                              ),

                              SizedBox(
                                height: 20,
                              ),

                              ////Enter YLL corner Field
                              TextFormField(
                                // initialValue: dir.yo,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Y0 value';
                                  }
                                  return null;
                                },
                                inputFormatters: <TextInputFormatter>[
                                  // for below version 2 use this
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r"[0-9.-]")),
                                  // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  // for version 2 and greater youcan also use this
                                  // FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Y0'),
                                onChanged: (value) {
                                  print(value);
                                },
                                controller: cnfg.yllcornerController,
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              ////Enter CellSize Field
                              TextFormField(
                              
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter CellSize value';
                                  }
                                  return null;
                                },
                                inputFormatters: <TextInputFormatter>[
                                  // for below version 2 use this
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r"[0-9.-]")),
                                  // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  // for version 2 and greater youcan also use this
                                  // FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'CellSize'),
                                onChanged: (value) {
                                  print(value);
                                },
                                controller: cnfg.cellSizeController,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                  ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Config File Created')),
                          );
                          cnfg.getVals(dir.dir);
                          // dir.isConfig = true;
                        
                        }
                        // print(cnfg.ncolsController.text);
                      },
                      icon: Icon(Icons.send),
                      label: Text('Submit'))
                ]);
         
    },
  );
}
