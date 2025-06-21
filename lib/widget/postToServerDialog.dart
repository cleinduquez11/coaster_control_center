import 'package:intl/intl.dart'; // For formatting the date
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:coaster_control_center/provider/DirProvider.dart';
import 'package:coaster_control_center/provider/fileUploadProvider.dart';
import 'package:coaster_control_center/provider/fxnImageOVerlay.dart';
import 'package:coaster_control_center/provider/postToServerProvider.dart';
import 'package:coaster_control_center/provider/typhoonCmd.dart';

Future<void> showPostToServerDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      final dir = Provider.of<DirProvider>(context);
      final pts = Provider.of<PostToServerProvider>(context);
      final tpd = Provider.of<TyphoonCMDProvider>(context);
      final fup = Provider.of<Fileuploadprovider>(context);

      final nameController = TextEditingController(text: '');
      final startDateController = TextEditingController(text: '');
      final endDateController = TextEditingController(text: '');

      // Map center related controllers
      final latController = TextEditingController();
      final lonController = TextEditingController();

      // Dropdown options
      String? selectedLocation;
      final _formKey = GlobalKey<FormState>();

      // Latitude and longitude values for the selected locations
      final Map<String, Map<String, double>> locations = {
        'Manila': {'lat': 14.5995, 'lon': 120.9842},
        'Baguio': {'lat': 16.4023, 'lon': 120.5960},
        'Cebu': {'lat': 10.3157, 'lon': 123.8854},
      };

      return AlertDialog(
        title: const Text(
          'Post To Server',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        content: SizedBox(
          width: 550,
          height: 320,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // Typhoon International Name Field
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '* Typhoon International Name required';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Typhoon International Name',
                    ),
                    controller: nameController,
                  ),
                  const SizedBox(height: 20),

                  // Start Date Field (with DateTimePicker)
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
                            startDateController.text = formattedDate;
                          }
                        },
                      ),
                    ),
                    controller: startDateController,
                    readOnly: true,
                  ),
                  const SizedBox(height: 20),

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
                            endDateController.text = formattedDate;
                          }
                        },
                      ),
                    ),
                    controller: endDateController,
                    readOnly: true,
                  ),
                
                
                
                  const SizedBox(height: 20),

                  // Map Center Dropdown
                  DropdownButtonFormField<String>(
                    value: selectedLocation,
                    decoration: const InputDecoration(
                      labelText: 'Map Center',
                      border: OutlineInputBorder(),
                    ),
                    items: ['Manila', 'Baguio', 'Cebu']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      selectedLocation = newValue;
                      if (newValue != null) {
                        // Update lat and lon based on the selected location
                        latController.text = locations[newValue]!['lat'].toString();
                        lonController.text = locations[newValue]!['lon'].toString();
                      }
                    },
                    validator: (value) {
                      if (value == null) {
                        return '* Map center required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Display Lat and Lon (read-only)
                  // TextFormField(
                  //   controller: latController,
                  //   decoration: const InputDecoration(
                  //     labelText: 'Latitude',
                  //     border: OutlineInputBorder(),
                  //   ),
                  //   readOnly: true,
                  // ),
                  // const SizedBox(height: 20),
                  // TextFormField(
                  //   controller: lonController,
                  //   decoration: const InputDecoration(
                  //     labelText: 'Longitude',
                  //     border: OutlineInputBorder(),
                  //   ),
                  //   readOnly: true,
                  // ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Raw files sent to the server successfully')),
                );
                LoadImages('${dir.dir}\\output\\swan\\raw').then((value) {
                  print(dir.tropicalCyclonePath.toString());
                  pts.createConfigJsonWithPrn(
                    dir.dir,
                    nameController.text.toLowerCase(),
                    value.length.toString(),
                    "${ latController.text },${lonController.text }",
                     dir.tropicalCyclonePath,
                    startDateController.text,
                    endDateController.text,
                  );

                  value['overlayImages'].add('${dir.dir}\\output\\swan\\raw\\cnfg.json');
                  fup.uploadFiles(
                    nameController.text,
                    '${dir.dir}\\output\\swan\\raw\\cnfg.json',
                    value,
                  );
                });
              }
            },
            icon: const Icon(Icons.send),
            label: const Text('Submit'),
          ),
        ],
      );
    },
  );
}

// Date and Time pickers
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
