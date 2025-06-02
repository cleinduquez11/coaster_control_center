import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:coaster_control_center/Components/showOverlayOnTop.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/FlowConfigFileProvider.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/PageViewProvider.dart';
import 'package:coaster_control_center/FlowWidgets/ModelTabs.dart';
import 'package:coaster_control_center/provider/DirProvider.dart';
import 'package:coaster_control_center/provider/configFileProvider.dart';
import 'package:coaster_control_center/provider/nestFileProvider.dart';
import 'package:coaster_control_center/provider/swanCMDProvider.dart';
import 'package:coaster_control_center/provider/swanConfigProvider.dart';
import 'package:coaster_control_center/widget/accordion.dart';
import 'package:coaster_control_center/widget/loading.dart';
import 'package:intl/intl.dart';

Future<void> ModelConfigDialog(BuildContext context, String modelName) async {
  //  final pageControllerProvider = Provider.of<PageControllerProvider>(context);

  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    barrierColor: Colors.black.withOpacity(0.4),
    builder: (BuildContext context) {
      final FMF = Provider.of<FlowConfigFileProvider>(context);
      final _formKey1 = GlobalKey<FormState>();
      final _formKey2 = GlobalKey<FormState>();

      return ModelTabDialog(
          title: "$modelName Configuration File",
          tabs: ModelTabs,
          contents: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.50,
                // height: MediaQuery.of(context).size.height * 0.50,
                // width: MediaQuery.of(context).size.width * 0.50,
                // height: MediaQuery.of(context).size.height * 0.50,
                child: Form(
                  key: _formKey1,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Time Frame',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 3, // Number of columns
                          // shrinkWrap: true,

                          crossAxisSpacing: 10, // Spacing between columns
                          mainAxisSpacing: 5, //
                          childAspectRatio: 6,
                          physics: NeverScrollableScrollPhysics(),

                          padding: EdgeInsets.all(16),
                          children: [
                            TextFormField(
                              // autofocus: true,
                              onTap: () async {
                                DateTime? pickedDate =
                                    await _selectDate(context);
                                TimeOfDay? pickedTime =
                                    await _selectTime(context);

                                if (pickedDate != null && pickedTime != null) {
                                  DateTime combinedDateTime = DateTime(
                                    pickedDate.year,
                                    pickedDate.month,
                                    pickedDate.day,
                                    pickedTime.hour,
                                    pickedTime.minute,
                                  );
                                  String formattedDate =
                                      _formatDate(combinedDateTime);
                                  FMF.referrenceDate.text = formattedDate;
                                }
                              },
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '* required';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always, // Defau
                                labelStyle: TextStyle(color: Colors.white),
                                // hintText: 'ex. 20151012',
                                fillColor: Colors.white,
                                hintStyle: TextStyle(
                                    color: Colors.white, inherit: true),
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                labelText: 'Referrence Date',
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.calendar_today,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    DateTime? pickedDate =
                                        await _selectDate(context);
                                    TimeOfDay? pickedTime =
                                        await _selectTime(context);

                                    if (pickedDate != null &&
                                        pickedTime != null) {
                                      DateTime combinedDateTime = DateTime(
                                        pickedDate.year,
                                        pickedDate.month,
                                        pickedDate.day,
                                        pickedTime.hour,
                                        pickedTime.minute,
                                      );
                                      String formattedDate =
                                          _formatDate(combinedDateTime);
                                      FMF.referrenceDate.text = formattedDate;
                                    }
                                  },
                                ),
                              ),
                              controller: FMF.referrenceDate,
                              readOnly: true,
                            ),
                            TextFormField(
                              onTap: () async {
                                DateTime? pickedDate =
                                    await _selectDate(context);
                                TimeOfDay? pickedTime =
                                    await _selectTime(context);

                                if (pickedDate != null && pickedTime != null) {
                                  DateTime combinedDateTime = DateTime(
                                    pickedDate.year,
                                    pickedDate.month,
                                    pickedDate.day,
                                    pickedTime.hour,
                                    pickedTime.minute,
                                  );
                                  String formattedDate =
                                      _formatDateTime(combinedDateTime);
                                  FMF.tStart.text = formattedDate;
                                }
                              },
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '* required';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always, // Defau
                                labelStyle: TextStyle(color: Colors.white),
                                // hintText: 'ex. 20151012.000000',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                labelText: 'Start time',
                                fillColor: Colors.white,
                                hintStyle: TextStyle(
                                    color: Colors.white, inherit: true),
                                focusColor: Colors.white,
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.calendar_today,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    DateTime? pickedDate =
                                        await _selectDate(context);
                                    TimeOfDay? pickedTime =
                                        await _selectTime(context);

                                    if (pickedDate != null &&
                                        pickedTime != null) {
                                      DateTime combinedDateTime = DateTime(
                                        pickedDate.year,
                                        pickedDate.month,
                                        pickedDate.day,
                                        pickedTime.hour,
                                        pickedTime.minute,
                                      );
                                      String formattedDate =
                                          _formatDateTime(combinedDateTime);
                                      FMF.tStart.text = formattedDate;
                                    }
                                  },
                                ),
                              ),
                              controller: FMF.tStart,
                              readOnly: true,
                            ),
                            TextFormField(
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic),
                              onTap: () async {
                                DateTime? pickedDate =
                                    await _selectDate(context);
                                TimeOfDay? pickedTime =
                                    await _selectTime(context);

                                if (pickedDate != null && pickedTime != null) {
                                  DateTime combinedDateTime = DateTime(
                                    pickedDate.year,
                                    pickedDate.month,
                                    pickedDate.day,
                                    pickedTime.hour,
                                    pickedTime.minute,
                                  );
                                  String formattedDate =
                                      _formatDateTime(combinedDateTime);
                                  FMF.tStop.text = formattedDate;
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '* required';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always, // Defau
                                // hintText: 'ex. 20151012.000000',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                labelText: 'End time',
                                fillColor: Colors.white,
                                hintStyle: TextStyle(
                                    color: Colors.white, inherit: true),
                                focusColor: Colors.white,
                                labelStyle: TextStyle(color: Colors.white),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.calendar_today,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    DateTime? pickedDate =
                                        await _selectDate(context);
                                    TimeOfDay? pickedTime =
                                        await _selectTime(context);

                                    if (pickedDate != null &&
                                        pickedTime != null) {
                                      DateTime combinedDateTime = DateTime(
                                        pickedDate.year,
                                        pickedDate.month,
                                        pickedDate.day,
                                        pickedTime.hour,
                                        pickedTime.minute,
                                      );
                                      String formattedDate =
                                          _formatDateTime(combinedDateTime);
                                      FMF.tStop.text = formattedDate;
                                    }
                                  },
                                ),
                              ),
                              controller: FMF.tStop,
                              readOnly: true,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  FMF.dt_user = "300";
                                  // return '* Referrence date required';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                FMF.dt_user = value;
                              },

                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic),
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always, // Defau
                                labelStyle: TextStyle(color: Colors.white),
                                hintText: 'default: 300',
                                fillColor: Colors.white,
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12),
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                labelText: 'User Time Step',
                                suffixIcon: Icon(
                                  Icons.timer,
                                  color: Colors.white,
                                ),
                              ),
                              controller: FMF.dtUser,
                              // readOnly: true,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  FMF.dt_init = "1";
                                  // return '* Referrence date required';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                FMF.dt_init = value;
                              },

                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic),
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always, // Defau
                                labelStyle: TextStyle(color: Colors.white),
                                hintText: 'default: 1',
                                fillColor: Colors.white,
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12),
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                labelText: 'Initial Time Step',
                                suffixIcon: Icon(
                                  Icons.timer,
                                  color: Colors.white,
                                ),
                              ),
                              controller: FMF.dtInit,
                              // readOnly: true,
                            ),
                            TextFormField(
                              onChanged: (value) {
                                FMF.dt_nodal = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  FMF.dt_nodal = "21600";
                                  // return '* Referrence date required';
                                }
                                return null;
                              },

                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic),
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always, // Defau
                                labelStyle: TextStyle(color: Colors.white),
                                hintText: 'default: 21600',
                                fillColor: Colors.white,
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12),
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                labelText: 'Nodal Time Step',
                                suffixIcon: Icon(
                                  Icons.timer,
                                  color: Colors.white,
                                ),
                              ),
                              controller: FMF.dtNodal,
                              // readOnly: true,
                            ),
                            TextFormField(
                              // enabled: true,
                              // expands: true,
                              // autofocus: true,

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  FMF.dt_max = "30";
                                  // return '* Referrence date required';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                FMF.dt_max = value;
                              },

                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic),
                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior
                                    .always, // Default behavior
                                labelStyle: TextStyle(color: Colors.white),
                                hintText: 'default: 30',
                                fillColor: Colors.white,
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12),
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                labelText: 'Max Time Step',
                                suffixIcon: Icon(
                                  Icons.timer,
                                  color: Colors.white,
                                ),
                              ),
                              controller: FMF.dtMax,
                              // readOnly: true,
                            ),
                            TextFormField(
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  FMF.t_zone = "0";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always, // Defau
                                labelStyle: TextStyle(color: Colors.white),
                                hintText: 'default: 0',
                                fillColor: Colors.white,
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12),
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                labelText: 'Time Zone',
                                suffixIcon: const Icon(
                                  Icons.place_sharp,
                                  color: Colors.white,
                                ),
                              ),
                              controller: FMF.tZone,
                              // readOnly: true,
                            ),
                            TextFormField(
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  FMF.t_unit = "S";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always, // Defau
                                labelStyle: TextStyle(color: Colors.white),
                                hintText: 'default: S',
                                fillColor: Colors.white,
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12),
                                focusColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                labelText: 'Time Unit',
                                suffixIcon: const Icon(
                                  Icons.timer,
                                  color: Colors.white,
                                ),
                              ),
                              controller: FMF.tUnit,
                              // readOnly: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'External Forcing',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return '* Output directory required';
                          //   }
                          //   return null;
                          // },
                          controller: FMF.spwFile,
                          onTap: () async {
                            //  topo.getRawTopography();
                            // tpd.runTyphoonCmd(dir.dir);
                            FMF.getSpiderWebFile(modelName);
                            //  final selected =  await selectFile();
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            floatingLabelBehavior:
                                FloatingLabelBehavior.always, // Defau
                            labelStyle: TextStyle(color: Colors.white),
                            // hintText: 'default: 300',
                            fillColor: Colors.white,
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: 12),
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: FMF.q == "-"
                                ? 'Select Typhoon Track File'
                                : 'Typhoon Track file',
                            suffixIcon: Icon(
                              Icons.folder,
                              color: Colors.white,
                            ),
                          ),
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 12,
                              fontStyle: FontStyle.italic),

                          // readOnly: true,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      
                                         const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return '* Output directory required';
                          //   }
                          //   return null;
                          // },
                          controller: FMF.disFile,
                          onTap: () async {
                            //  topo.getRawTopography();
                            // tpd.runTyphoonCmd(dir.dir);
                            FMF.getDischargeFile();
                            //  final selected =  await selectFile();
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            floatingLabelBehavior:
                                FloatingLabelBehavior.always, // Defau
                            labelStyle: TextStyle(color: Colors.white),
                            // hintText: 'default: 300',
                            fillColor: Colors.white,
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: 12),
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: FMF.dis == "-"
                                ? 'Select Discharge File'
                                : 'Discharge file',
                            suffixIcon: Icon(
                              Icons.folder,
                              color: Colors.white,
                            ),
                          ),
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 12,
                              fontStyle: FontStyle.italic),

                          // readOnly: true,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Outputs',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '* Output directory required';
                            }
                            return null;
                          },
                          controller: FMF.outDir,
                          onTap: () async {
                            //  topo.getRawTopography();
                            // tpd.runTyphoonCmd(dir.dir);
                            FMF.getFile();
                            //  final selected =  await selectFile();
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            floatingLabelBehavior:
                                FloatingLabelBehavior.always, // Defau
                            labelStyle: TextStyle(color: Colors.white),
                            // hintText: 'default: 300',
                            fillColor: Colors.white,
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: 12),
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: FMF.p == "-"
                                ? 'Select Output Directory'
                                : 'Output Directory',
                            suffixIcon: Icon(
                              Icons.folder,
                              color: Colors.white,
                            ),
                          ),
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 12,
                              fontStyle: FontStyle.italic),

                          // readOnly: true,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 40.0, bottom: 16, right: 16),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              if (_formKey1.currentState!.validate()) {
                                showTopSnackBar(
                                    context, '$modelName Config File Created', Colors.green);

                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(
                                    
                                //     behavior: SnackBarBehavior
                                //         .floating, // Allows positioning
                                //     margin: EdgeInsets.only(
                                //         top: 50,
                                //         left: 16,
                                //         right: 16), // Higher position
                                //     padding: EdgeInsets.symmetric(
                                //         horizontal: 20,
                                //         vertical: 16), // Add padding
                                //     backgroundColor:
                                //         Colors.green, // Make it green
                                //     content: Text(
                                //       '$modelName Config File Created',
                                //       style: TextStyle(
                                //           color: Colors.white,
                                //           fontWeight: FontWeight.bold),
                                //     ),
                                //   ),
                                // );
                                FMF.getVals(modelName, FMF.p.toString());

                                // FMF.readMDU(modelName);
                                Navigator.of(context).pop();
                              }
                            },
                            icon: const Icon(
                              Icons.save,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Save',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    top: 70, left: 16, right: 16, bottom: 4),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.50,
                    // height: MediaQuery.of(context).size.height * 0.50,
                    // width: MediaQuery.of(context).size.width * 0.50,
                    // height: MediaQuery.of(context).size.height * 0.50,
                    child: Form(
                      key: _formKey2,
                      child: Column(children: [
                        const Text(
                          'Directory for Spider Web Files',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Spider Web directory required';
                              }
                              return null;
                            },
                            controller: FMF.spwFileAutomate,
                            onTap: () async {
                              //  topo.getRawTopography();
                              // tpd.runTyphoonCmd(dir.dir);
                              FMF.getSpiderFileAutomate();
                              // FMF.getFile();
                              //  final selected =  await selectFile();
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always, // Defau
                              labelStyle: TextStyle(color: Colors.white),
                              // hintText: 'default: 300',
                              fillColor: Colors.white,
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12),
                              focusColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              labelText: FMF.r == "-"
                                  ? 'Select Spider Web Directory'
                                  : 'SpiderWeb Directory',
                              suffixIcon: Icon(
                                Icons.folder,
                                color: Colors.white,
                              ),
                            ),
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 12,
                                fontStyle: FontStyle.italic),

                            // readOnly: true,
                          ),
                        ),
                        const SizedBox(
                          height: 130,
                        ),
                        const Text(
                          'Outputs',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Output directory required';
                              }
                              return null;
                            },
                            controller: FMF.outDirAutomate,
                            onTap: () async {
                              //  topo.getRawTopography();
                              // tpd.runTyphoonCmd(dir.dir);

                              FMF.getFileAutomate();
                              //  final selected =  await selectFile();
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always, // Defau
                              labelStyle: TextStyle(color: Colors.white),
                              // hintText: 'default: 300',
                              fillColor: Colors.white,
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12),
                              focusColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              labelText: FMF.s == "-"
                                  ? 'Select Output Directory'
                                  : 'Output Directory',
                              suffixIcon: Icon(
                                Icons.folder,
                                color: Colors.white,
                              ),
                            ),
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 12,
                                fontStyle: FontStyle.italic),

                            // readOnly: true,
                          ),
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 40.0, bottom: 16, right: 16),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                if (_formKey2.currentState!.validate()) {
                                  showTopSnackBar(context,
                                      '$modelName Automation File Created', Colors.orangeAccent);
                                  FMF.getValsAutomate(modelName);



                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(
                                //     behavior: SnackBarBehavior
                                //         .floating, // Allows positioning
                                //     margin: EdgeInsets.only(
                                //         top: 50,
                                //         left: 16,
                                //         right: 16), // Higher position
                                //     padding: EdgeInsets.symmetric(
                                //         horizontal: 20,
                                //         vertical: 16), // Add padding
                                //     backgroundColor:
                                //         Colors.green, // Make it green
                                //     content: Text(
                                //       '$modelName Automation File Created',
                                //       style: TextStyle(
                                //           color: Colors.white,
                                //           fontWeight: FontWeight.bold),
                                //     ),
                                //   ),
                                // );


                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   SnackBar(
                                  //       behavior: SnackBarBehavior
                                  //           .floating, // Allows positioning
                                  //       margin: EdgeInsets.only(
                                  //           top: 20, left: 16, right: 16),
                                  //       content: Text(
                                  //           '$modelName Automation File Created')),
                                  // );

                                  // FMF.readMDU(modelName);
                                  Navigator.of(context).pop();
                                }
                              },
                              icon: const Icon(
                                Icons.save,
                                color: Colors.black,
                              ),
                              label: const Text(
                                'Save',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ))),
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
  final DateFormat formatter = DateFormat('yyyyMMddHHmmss');
  return formatter.format(dateTime);
}

// Format the DateTime to the required string format: 20151012.HHmmss
String _formatDate(DateTime dateTime) {
  final DateFormat formatter = DateFormat('yyyyMMdd');
  return formatter.format(dateTime);
}
