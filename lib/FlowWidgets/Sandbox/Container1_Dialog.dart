  // Dialog(
  //       backgroundColor:
  //           Colors.transparent, // Make the dialog background transparent
  //       child: ClipRRect(
  //         borderRadius:
  //             BorderRadius.circular(15), // Round the corners if desired
  //         child: BackdropFilter(
  //           filter: ImageFilter.blur(
  //               sigmaX: 10.0, sigmaY: 10.0), // Apply the blur effect
  //           child: Container(
  //             width: 1000,
  //             height: 650,
  //             color: Colors.white
  //                 .withOpacity(0.1), // Set opacity to create frosted effect
  //             child: AlertDialog(
  //               // shadowColor: Colors.white,

  //               backgroundColor: Colors.transparent,
  //               title: Text(
  //                 '$modelName Configuration File',
  //                 style: TextStyle(
  //                     fontSize: 26,
  //                     fontWeight: FontWeight.w700,
  //                     color: Colors.white),
  //               ),
  //               content: DefaultTabController(
  //                 length: 2,
  //                 child: Column(
  //                   children: [
  //                     TabBar(tabs: [Tab(text: "Tab 1"), Tab(text: "Tab 2")]),
  //                     Expanded(
  //                       child: TabBarView(children: [
  //                         SingleChildScrollView(
  //                           child: SizedBox(
  //                             width: MediaQuery.of(context).size.width * 0.50,
  //                             height: MediaQuery.of(context).size.height * 0.50,
  //                             // width: MediaQuery.of(context).size.width * 0.50,
  //                             // height: MediaQuery.of(context).size.height * 0.50,
  //                             child: Form(
  //                               key: _formKey1,
  //                               child: Column(
  //                                 children: [
  //                                   const SizedBox(
  //                                     height: 40,
  //                                   ),
  //                                   const Text(
  //                                     'Time Frame',
  //                                     style: TextStyle(
  //                                         fontWeight: FontWeight.w500,
  //                                         fontSize: 24,
  //                                         color: Colors.white),
  //                                   ),
  //                                   const SizedBox(
  //                                     height: 20,
  //                                   ),
  //                                   SizedBox(
  //                                     height: 200,
  //                                     width: 200,
  //                                     child: GridView.count(
  //                                       crossAxisCount: 3, // Number of columns
  //                                       // shrinkWrap: true,
                                                  
  //                                       crossAxisSpacing:
  //                                           10, // Spacing between columns
  //                                       mainAxisSpacing: 10, //
  //                                       childAspectRatio: 5,
  //                                       physics: NeverScrollableScrollPhysics(),
                                                  
  //                                       padding: EdgeInsets.all(16),
  //                                       children: [
  //                                         TextFormField(
  //                                           // autofocus: true,
  //                                           onTap: () async {
  //                                             DateTime? pickedDate =
  //                                                 await _selectDate(context);
  //                                             TimeOfDay? pickedTime =
  //                                                 await _selectTime(context);
                                                  
  //                                             if (pickedDate != null &&
  //                                                 pickedTime != null) {
  //                                               DateTime combinedDateTime =
  //                                                   DateTime(
  //                                                 pickedDate.year,
  //                                                 pickedDate.month,
  //                                                 pickedDate.day,
  //                                                 pickedTime.hour,
  //                                                 pickedTime.minute,
  //                                               );
  //                                               String formattedDate =
  //                                                   _formatDate(combinedDateTime);
  //                                               FMF.referrenceDate.text =
  //                                                   formattedDate;
  //                                             }
  //                                           },
  //                                           style: TextStyle(
  //                                               color:
  //                                                   Colors.white.withOpacity(0.6),
  //                                               fontSize: 12,
  //                                               fontStyle: FontStyle.italic),
  //                                           validator: (value) {
  //                                             if (value == null ||
  //                                                 value.isEmpty) {
  //                                               return '* required';
  //                                             }
  //                                             return null;
  //                                           },
  //                                           decoration: InputDecoration(
  //                                             floatingLabelBehavior:
  //                                                 FloatingLabelBehavior
  //                                                     .always, // Defau
  //                                             labelStyle:
  //                                                 TextStyle(color: Colors.white),
  //                                             // hintText: 'ex. 20151012',
  //                                             fillColor: Colors.white,
  //                                             hintStyle: TextStyle(
  //                                                 color: Colors.white,
  //                                                 inherit: true),
  //                                             focusColor: Colors.white,
  //                                             border: OutlineInputBorder(
  //                                                 borderRadius:
  //                                                     BorderRadius.circular(15)),
  //                                             labelText: 'Referrence Date',
  //                                             suffixIcon: IconButton(
  //                                               icon: const Icon(
  //                                                 Icons.calendar_today,
  //                                                 color: Colors.white,
  //                                               ),
  //                                               onPressed: () async {
  //                                                 DateTime? pickedDate =
  //                                                     await _selectDate(context);
  //                                                 TimeOfDay? pickedTime =
  //                                                     await _selectTime(context);
                                                  
  //                                                 if (pickedDate != null &&
  //                                                     pickedTime != null) {
  //                                                   DateTime combinedDateTime =
  //                                                       DateTime(
  //                                                     pickedDate.year,
  //                                                     pickedDate.month,
  //                                                     pickedDate.day,
  //                                                     pickedTime.hour,
  //                                                     pickedTime.minute,
  //                                                   );
  //                                                   String formattedDate =
  //                                                       _formatDate(
  //                                                           combinedDateTime);
  //                                                   FMF.referrenceDate.text =
  //                                                       formattedDate;
  //                                                 }
  //                                               },
  //                                             ),
  //                                           ),
  //                                           controller: FMF.referrenceDate,
  //                                           readOnly: true,
  //                                         ),
  //                                         TextFormField(
  //                                           validator: (value) {
  //                                             if (value == null ||
  //                                                 value.isEmpty) {
  //                                               FMF.dt_user = "300";
  //                                               // return '* Referrence date required';
  //                                             }
  //                                             return null;
  //                                           },
  //                                           onChanged: (value) {
  //                                             FMF.dt_user = value;
  //                                           },
                                                  
  //                                           style: TextStyle(
  //                                               color:
  //                                                   Colors.white.withOpacity(0.6),
  //                                               fontSize: 12,
  //                                               fontStyle: FontStyle.italic),
  //                                           decoration: InputDecoration(
  //                                             floatingLabelBehavior:
  //                                                 FloatingLabelBehavior
  //                                                     .always, // Defau
  //                                             labelStyle:
  //                                                 TextStyle(color: Colors.white),
  //                                             hintText: 'default: 300',
  //                                             fillColor: Colors.white,
  //                                             hintStyle: TextStyle(
  //                                                 color: Colors.white,
  //                                                 fontStyle: FontStyle.italic,
  //                                                 fontSize: 12),
  //                                             focusColor: Colors.white,
  //                                             border: OutlineInputBorder(
  //                                                 borderRadius:
  //                                                     BorderRadius.circular(15)),
  //                                             labelText: 'User Time Step',
  //                                             suffixIcon: Icon(
  //                                               Icons.timer,
  //                                               color: Colors.white,
  //                                             ),
  //                                           ),
  //                                           controller: FMF.dtUser,
  //                                           // readOnly: true,
  //                                         ),
  //                                         TextFormField(
  //                                           validator: (value) {
  //                                             if (value == null ||
  //                                                 value.isEmpty) {
  //                                               FMF.dt_init = "1";
  //                                               // return '* Referrence date required';
  //                                             }
  //                                             return null;
  //                                           },
  //                                           onChanged: (value) {
  //                                             FMF.dt_init = value;
  //                                           },
                                                  
  //                                           style: TextStyle(
  //                                               color:
  //                                                   Colors.white.withOpacity(0.6),
  //                                               fontSize: 12,
  //                                               fontStyle: FontStyle.italic),
  //                                           decoration: InputDecoration(
  //                                             floatingLabelBehavior:
  //                                                 FloatingLabelBehavior
  //                                                     .always, // Defau
  //                                             labelStyle:
  //                                                 TextStyle(color: Colors.white),
  //                                             hintText: 'default: 1',
  //                                             fillColor: Colors.white,
  //                                             hintStyle: TextStyle(
  //                                                 color: Colors.white,
  //                                                 fontStyle: FontStyle.italic,
  //                                                 fontSize: 12),
  //                                             focusColor: Colors.white,
  //                                             border: OutlineInputBorder(
  //                                                 borderRadius:
  //                                                     BorderRadius.circular(15)),
  //                                             labelText: 'Initial Time Step',
  //                                             suffixIcon: Icon(
  //                                               Icons.timer,
  //                                               color: Colors.white,
  //                                             ),
  //                                           ),
  //                                           controller: FMF.dtInit,
  //                                           // readOnly: true,
  //                                         ),
  //                                         TextFormField(
  //                                           onTap: () async {
  //                                             DateTime? pickedDate =
  //                                                 await _selectDate(context);
  //                                             TimeOfDay? pickedTime =
  //                                                 await _selectTime(context);
                                                  
  //                                             if (pickedDate != null &&
  //                                                 pickedTime != null) {
  //                                               DateTime combinedDateTime =
  //                                                   DateTime(
  //                                                 pickedDate.year,
  //                                                 pickedDate.month,
  //                                                 pickedDate.day,
  //                                                 pickedTime.hour,
  //                                                 pickedTime.minute,
  //                                               );
  //                                               String formattedDate =
  //                                                   _formatDateTime(
  //                                                       combinedDateTime);
  //                                               FMF.tStart.text = formattedDate;
  //                                             }
  //                                           },
  //                                           style: TextStyle(
  //                                               color:
  //                                                   Colors.white.withOpacity(0.6),
  //                                               fontSize: 12,
  //                                               fontStyle: FontStyle.italic),
  //                                           validator: (value) {
  //                                             if (value == null ||
  //                                                 value.isEmpty) {
  //                                               return '* required';
  //                                             }
  //                                             return null;
  //                                           },
  //                                           decoration: InputDecoration(
  //                                             floatingLabelBehavior:
  //                                                 FloatingLabelBehavior
  //                                                     .always, // Defau
  //                                             labelStyle:
  //                                                 TextStyle(color: Colors.white),
  //                                             // hintText: 'ex. 20151012.000000',
  //                                             border: OutlineInputBorder(
  //                                                 borderRadius:
  //                                                     BorderRadius.circular(15)),
  //                                             labelText: 'Start time',
  //                                             fillColor: Colors.white,
  //                                             hintStyle: TextStyle(
  //                                                 color: Colors.white,
  //                                                 inherit: true),
  //                                             focusColor: Colors.white,
  //                                             suffixIcon: IconButton(
  //                                               icon: const Icon(
  //                                                 Icons.calendar_today,
  //                                                 color: Colors.white,
  //                                               ),
  //                                               onPressed: () async {
  //                                                 DateTime? pickedDate =
  //                                                     await _selectDate(context);
  //                                                 TimeOfDay? pickedTime =
  //                                                     await _selectTime(context);
                                                  
  //                                                 if (pickedDate != null &&
  //                                                     pickedTime != null) {
  //                                                   DateTime combinedDateTime =
  //                                                       DateTime(
  //                                                     pickedDate.year,
  //                                                     pickedDate.month,
  //                                                     pickedDate.day,
  //                                                     pickedTime.hour,
  //                                                     pickedTime.minute,
  //                                                   );
  //                                                   String formattedDate =
  //                                                       _formatDateTime(
  //                                                           combinedDateTime);
  //                                                   FMF.tStart.text =
  //                                                       formattedDate;
  //                                                 }
  //                                               },
  //                                             ),
  //                                           ),
  //                                           controller: FMF.tStart,
  //                                           readOnly: true,
  //                                         ),
  //                                         TextFormField(
  //                                           onChanged: (value) {
  //                                             FMF.dt_nodal = value;
  //                                           },
  //                                           validator: (value) {
  //                                             if (value == null ||
  //                                                 value.isEmpty) {
  //                                               FMF.dt_nodal = "21600";
  //                                               // return '* Referrence date required';
  //                                             }
  //                                             return null;
  //                                           },
                                                  
  //                                           style: TextStyle(
  //                                               color:
  //                                                   Colors.white.withOpacity(0.6),
  //                                               fontSize: 12,
  //                                               fontStyle: FontStyle.italic),
  //                                           decoration: InputDecoration(
  //                                             floatingLabelBehavior:
  //                                                 FloatingLabelBehavior
  //                                                     .always, // Defau
  //                                             labelStyle:
  //                                                 TextStyle(color: Colors.white),
  //                                             hintText: 'default: 21600',
  //                                             fillColor: Colors.white,
  //                                             hintStyle: TextStyle(
  //                                                 color: Colors.white,
  //                                                 fontStyle: FontStyle.italic,
  //                                                 fontSize: 12),
  //                                             focusColor: Colors.white,
  //                                             border: OutlineInputBorder(
  //                                                 borderRadius:
  //                                                     BorderRadius.circular(15)),
  //                                             labelText: 'Nodal Time Step',
  //                                             suffixIcon: Icon(
  //                                               Icons.timer,
  //                                               color: Colors.white,
  //                                             ),
  //                                           ),
  //                                           controller: FMF.dtNodal,
  //                                           // readOnly: true,
  //                                         ),
  //                                         TextFormField(
  //                                           // enabled: true,
  //                                           // expands: true,
  //                                           // autofocus: true,
                                                  
  //                                           validator: (value) {
  //                                             if (value == null ||
  //                                                 value.isEmpty) {
  //                                               FMF.dt_max = "30";
  //                                               // return '* Referrence date required';
  //                                             }
  //                                             return null;
  //                                           },
  //                                           onChanged: (value) {
  //                                             FMF.dt_max = value;
  //                                           },
                                                  
  //                                           style: TextStyle(
  //                                               color:
  //                                                   Colors.white.withOpacity(0.6),
  //                                               fontSize: 12,
  //                                               fontStyle: FontStyle.italic),
  //                                           decoration: InputDecoration(
  //                                             floatingLabelBehavior:
  //                                                 FloatingLabelBehavior
  //                                                     .always, // Default behavior
  //                                             labelStyle:
  //                                                 TextStyle(color: Colors.white),
  //                                             hintText: 'default: 30',
  //                                             fillColor: Colors.white,
  //                                             hintStyle: TextStyle(
  //                                                 color: Colors.white,
  //                                                 fontStyle: FontStyle.italic,
  //                                                 fontSize: 12),
  //                                             focusColor: Colors.white,
  //                                             border: OutlineInputBorder(
  //                                                 borderRadius:
  //                                                     BorderRadius.circular(15)),
  //                                             labelText: 'Max Time Step',
  //                                             suffixIcon: Icon(
  //                                               Icons.timer,
  //                                               color: Colors.white,
  //                                             ),
  //                                           ),
  //                                           controller: FMF.dtMax,
  //                                           // readOnly: true,
  //                                         ),
  //                                         TextFormField(
  //                                           style: TextStyle(
  //                                               color:
  //                                                   Colors.white.withOpacity(0.6),
  //                                               fontSize: 12,
  //                                               fontStyle: FontStyle.italic),
  //                                           onTap: () async {
  //                                             DateTime? pickedDate =
  //                                                 await _selectDate(context);
  //                                             TimeOfDay? pickedTime =
  //                                                 await _selectTime(context);
                                                  
  //                                             if (pickedDate != null &&
  //                                                 pickedTime != null) {
  //                                               DateTime combinedDateTime =
  //                                                   DateTime(
  //                                                 pickedDate.year,
  //                                                 pickedDate.month,
  //                                                 pickedDate.day,
  //                                                 pickedTime.hour,
  //                                                 pickedTime.minute,
  //                                               );
  //                                               String formattedDate =
  //                                                   _formatDateTime(
  //                                                       combinedDateTime);
  //                                               FMF.tStop.text = formattedDate;
  //                                             }
  //                                           },
  //                                           validator: (value) {
  //                                             if (value == null ||
  //                                                 value.isEmpty) {
  //                                               return '* required';
  //                                             }
  //                                             return null;
  //                                           },
  //                                           decoration: InputDecoration(
  //                                             floatingLabelBehavior:
  //                                                 FloatingLabelBehavior
  //                                                     .always, // Defau
  //                                             // hintText: 'ex. 20151012.000000',
  //                                             border: OutlineInputBorder(
  //                                                 borderRadius:
  //                                                     BorderRadius.circular(15)),
  //                                             labelText: 'End time',
  //                                             fillColor: Colors.white,
  //                                             hintStyle: TextStyle(
  //                                                 color: Colors.white,
  //                                                 inherit: true),
  //                                             focusColor: Colors.white,
  //                                             labelStyle:
  //                                                 TextStyle(color: Colors.white),
  //                                             suffixIcon: IconButton(
  //                                               icon: const Icon(
  //                                                 Icons.calendar_today,
  //                                                 color: Colors.white,
  //                                               ),
  //                                               onPressed: () async {
  //                                                 DateTime? pickedDate =
  //                                                     await _selectDate(context);
  //                                                 TimeOfDay? pickedTime =
  //                                                     await _selectTime(context);
                                                  
  //                                                 if (pickedDate != null &&
  //                                                     pickedTime != null) {
  //                                                   DateTime combinedDateTime =
  //                                                       DateTime(
  //                                                     pickedDate.year,
  //                                                     pickedDate.month,
  //                                                     pickedDate.day,
  //                                                     pickedTime.hour,
  //                                                     pickedTime.minute,
  //                                                   );
  //                                                   String formattedDate =
  //                                                       _formatDateTime(
  //                                                           combinedDateTime);
  //                                                   FMF.tStop.text =
  //                                                       formattedDate;
  //                                                 }
  //                                               },
  //                                             ),
  //                                           ),
  //                                           controller: FMF.tStop,
  //                                           readOnly: true,
  //                                         ),
  //                                         TextFormField(
  //                                           style: TextStyle(
  //                                               color:
  //                                                   Colors.white.withOpacity(0.6),
  //                                               fontSize: 12,
  //                                               fontStyle: FontStyle.italic),
  //                                           validator: (value) {
  //                                             if (value == null ||
  //                                                 value.isEmpty) {
  //                                               FMF.t_zone = "0";
  //                                             }
  //                                             return null;
  //                                           },
  //                                           decoration: InputDecoration(
  //                                             floatingLabelBehavior:
  //                                                 FloatingLabelBehavior
  //                                                     .always, // Defau
  //                                             labelStyle:
  //                                                 TextStyle(color: Colors.white),
  //                                             hintText: 'default: 0',
  //                                             fillColor: Colors.white,
  //                                             hintStyle: TextStyle(
  //                                                 color: Colors.white,
  //                                                 fontStyle: FontStyle.italic,
  //                                                 fontSize: 12),
  //                                             focusColor: Colors.white,
  //                                             border: OutlineInputBorder(
  //                                                 borderRadius:
  //                                                     BorderRadius.circular(15)),
  //                                             labelText: 'Time Zone',
  //                                             suffixIcon: const Icon(
  //                                               Icons.place_sharp,
  //                                               color: Colors.white,
  //                                             ),
  //                                           ),
  //                                           controller: FMF.tZone,
  //                                           // readOnly: true,
  //                                         ),
  //                                         TextFormField(
  //                                           style: TextStyle(
  //                                               color:
  //                                                   Colors.white.withOpacity(0.6),
  //                                               fontSize: 12,
  //                                               fontStyle: FontStyle.italic),
  //                                           validator: (value) {
  //                                             if (value == null ||
  //                                                 value.isEmpty) {
  //                                               FMF.t_unit = "S";
  //                                             }
  //                                             return null;
  //                                           },
  //                                           decoration: InputDecoration(
  //                                             floatingLabelBehavior:
  //                                                 FloatingLabelBehavior
  //                                                     .always, // Defau
  //                                             labelStyle:
  //                                                 TextStyle(color: Colors.white),
  //                                             hintText: 'default: S',
  //                                             fillColor: Colors.white,
  //                                             hintStyle: TextStyle(
  //                                                 color: Colors.white,
  //                                                 fontStyle: FontStyle.italic,
  //                                                 fontSize: 12),
  //                                             focusColor: Colors.white,
  //                                             border: OutlineInputBorder(
  //                                                 borderRadius:
  //                                                     BorderRadius.circular(15)),
  //                                             labelText: 'Time Unit',
  //                                             suffixIcon: const Icon(
  //                                               Icons.timer,
  //                                               color: Colors.white,
  //                                             ),
  //                                           ),
  //                                           controller: FMF.tUnit,
  //                                           // readOnly: true,
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   const SizedBox(
  //                                     height: 20,
  //                                   ),
  //                                   const Text(
  //                                     'Outputs',
  //                                     style: TextStyle(
  //                                         fontWeight: FontWeight.w500,
  //                                         fontSize: 24,
  //                                         color: Colors.white),
  //                                   ),
  //                                   const SizedBox(
  //                                     height: 20,
  //                                   ),
  //                                   TextFormField(
  //                                     validator: (value) {
  //                                       if (value == null || value.isEmpty) {
  //                                         return '* Output directory required';
  //                                       }
  //                                       return null;
  //                                     },
  //                                     controller: FMF.outDir,
  //                                     onTap: () async {
  //                                       //  topo.getRawTopography();
  //                                       // tpd.runTyphoonCmd(dir.dir);
  //                                       FMF.getFile();
  //                                       //  final selected =  await selectFile();
  //                                     },
  //                                     readOnly: true,
  //                                     decoration: InputDecoration(
  //                                       floatingLabelBehavior:
  //                                           FloatingLabelBehavior.always, // Defau
  //                                       labelStyle:
  //                                           TextStyle(color: Colors.white),
  //                                       // hintText: 'default: 300',
  //                                       fillColor: Colors.white,
  //                                       hintStyle: TextStyle(
  //                                           color: Colors.white,
  //                                           fontStyle: FontStyle.italic,
  //                                           fontSize: 12),
  //                                       focusColor: Colors.white,
  //                                       border: OutlineInputBorder(
  //                                           borderRadius:
  //                                               BorderRadius.circular(15)),
  //                                       labelText: FMF.p == ""
  //                                           ? 'Select Output Directory'
  //                                           : 'Output Directory',
  //                                       suffixIcon: Icon(
  //                                         Icons.folder,
  //                                         color: Colors.white,
  //                                       ),
  //                                     ),
  //                                     style: TextStyle(
  //                                         color: Colors.white.withOpacity(0.6),
  //                                         fontSize: 12,
  //                                         fontStyle: FontStyle.italic),
                                                  
  //                                     // readOnly: true,
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
                        
                        
  //                         ),
  //                        SingleChildScrollView(
  //                       child: SizedBox(
  //                         width: MediaQuery.of(context).size.width * 0.50,
  //                         height: MediaQuery.of(context).size.height * 0.50,
  //                         // width: MediaQuery.of(context).size.width * 0.50,
  //                         // height: MediaQuery.of(context).size.height * 0.50,
  //                         child: Form(
  //                           key: _formKey1,
  //                           child: Column(
  //                             children: [
  //                               const SizedBox(
  //                                 height: 40,
  //                               ),
  //                               const Text(
  //                                 'Time Frame',
  //                                 style: TextStyle(
  //                                     fontWeight: FontWeight.w500,
  //                                     fontSize: 24,
  //                                     color: Colors.white),
  //                               ),
  //                               const SizedBox(
  //                                 height: 20,
  //                               ),
  //                               SizedBox(
  //                                 height: 200,
  //                                 width: 200,
  //                                 child: GridView.count(
  //                                   crossAxisCount: 3, // Number of columns
  //                                   // shrinkWrap: true,
                        
  //                                   crossAxisSpacing:
  //                                       10, // Spacing between columns
  //                                   mainAxisSpacing: 10, //
  //                                   childAspectRatio: 5,
  //                                   physics: NeverScrollableScrollPhysics(),
                        
  //                                   padding: EdgeInsets.all(16),
  //                                   children: [
  //                                     TextFormField(
  //                                       // autofocus: true,
  //                                       onTap: () async {
  //                                         DateTime? pickedDate =
  //                                             await _selectDate(context);
  //                                         TimeOfDay? pickedTime =
  //                                             await _selectTime(context);
                        
  //                                         if (pickedDate != null &&
  //                                             pickedTime != null) {
  //                                           DateTime combinedDateTime =
  //                                               DateTime(
  //                                             pickedDate.year,
  //                                             pickedDate.month,
  //                                             pickedDate.day,
  //                                             pickedTime.hour,
  //                                             pickedTime.minute,
  //                                           );
  //                                           String formattedDate =
  //                                               _formatDate(combinedDateTime);
  //                                           FMF.referrenceDate.text =
  //                                               formattedDate;
  //                                         }
  //                                       },
  //                                       style: TextStyle(
  //                                           color:
  //                                               Colors.white.withOpacity(0.6),
  //                                           fontSize: 12,
  //                                           fontStyle: FontStyle.italic),
  //                                       validator: (value) {
  //                                         if (value == null || value.isEmpty) {
  //                                           return '* required';
  //                                         }
  //                                         return null;
  //                                       },
  //                                       decoration: InputDecoration(
  //                                         floatingLabelBehavior:
  //                                             FloatingLabelBehavior
  //                                                 .always, // Defau
  //                                         labelStyle:
  //                                             TextStyle(color: Colors.white),
  //                                         // hintText: 'ex. 20151012',
  //                                         fillColor: Colors.white,
  //                                         hintStyle: TextStyle(
  //                                             color: Colors.white,
  //                                             inherit: true),
  //                                         focusColor: Colors.white,
  //                                         border: OutlineInputBorder(
  //                                             borderRadius:
  //                                                 BorderRadius.circular(15)),
  //                                         labelText: 'Referrence Date',
  //                                         suffixIcon: IconButton(
  //                                           icon: const Icon(
  //                                             Icons.calendar_today,
  //                                             color: Colors.white,
  //                                           ),
  //                                           onPressed: () async {
  //                                             DateTime? pickedDate =
  //                                                 await _selectDate(context);
  //                                             TimeOfDay? pickedTime =
  //                                                 await _selectTime(context);
                        
  //                                             if (pickedDate != null &&
  //                                                 pickedTime != null) {
  //                                               DateTime combinedDateTime =
  //                                                   DateTime(
  //                                                 pickedDate.year,
  //                                                 pickedDate.month,
  //                                                 pickedDate.day,
  //                                                 pickedTime.hour,
  //                                                 pickedTime.minute,
  //                                               );
  //                                               String formattedDate =
  //                                                   _formatDate(
  //                                                       combinedDateTime);
  //                                               FMF.referrenceDate.text =
  //                                                   formattedDate;
  //                                             }
  //                                           },
  //                                         ),
  //                                       ),
  //                                       controller: FMF.referrenceDate,
  //                                       readOnly: true,
  //                                     ),
  //                                     TextFormField(
  //                                       validator: (value) {
  //                                         if (value == null || value.isEmpty) {
  //                                           FMF.dt_user = "300";
  //                                           // return '* Referrence date required';
  //                                         }
  //                                         return null;
  //                                       },
  //                                       onChanged: (value) {
  //                                         FMF.dt_user = value;
  //                                       },
                        
  //                                       style: TextStyle(
  //                                           color:
  //                                               Colors.white.withOpacity(0.6),
  //                                           fontSize: 12,
  //                                           fontStyle: FontStyle.italic),
  //                                       decoration: InputDecoration(
  //                                         floatingLabelBehavior:
  //                                             FloatingLabelBehavior
  //                                                 .always, // Defau
  //                                         labelStyle:
  //                                             TextStyle(color: Colors.white),
  //                                         hintText: 'default: 300',
  //                                         fillColor: Colors.white,
  //                                         hintStyle: TextStyle(
  //                                             color: Colors.white,
  //                                             fontStyle: FontStyle.italic,
  //                                             fontSize: 12),
  //                                         focusColor: Colors.white,
  //                                         border: OutlineInputBorder(
  //                                             borderRadius:
  //                                                 BorderRadius.circular(15)),
  //                                         labelText: 'User Time Step',
  //                                         suffixIcon: Icon(
  //                                           Icons.timer,
  //                                           color: Colors.white,
  //                                         ),
  //                                       ),
  //                                       controller: FMF.dtUser,
  //                                       // readOnly: true,
  //                                     ),
  //                                     TextFormField(
  //                                       validator: (value) {
  //                                         if (value == null || value.isEmpty) {
  //                                           FMF.dt_init = "1";
  //                                           // return '* Referrence date required';
  //                                         }
  //                                         return null;
  //                                       },
  //                                       onChanged: (value) {
  //                                         FMF.dt_init = value;
  //                                       },
                        
  //                                       style: TextStyle(
  //                                           color:
  //                                               Colors.white.withOpacity(0.6),
  //                                           fontSize: 12,
  //                                           fontStyle: FontStyle.italic),
  //                                       decoration: InputDecoration(
  //                                         floatingLabelBehavior:
  //                                             FloatingLabelBehavior
  //                                                 .always, // Defau
  //                                         labelStyle:
  //                                             TextStyle(color: Colors.white),
  //                                         hintText: 'default: 1',
  //                                         fillColor: Colors.white,
  //                                         hintStyle: TextStyle(
  //                                             color: Colors.white,
  //                                             fontStyle: FontStyle.italic,
  //                                             fontSize: 12),
  //                                         focusColor: Colors.white,
  //                                         border: OutlineInputBorder(
  //                                             borderRadius:
  //                                                 BorderRadius.circular(15)),
  //                                         labelText: 'Initial Time Step',
  //                                         suffixIcon: Icon(
  //                                           Icons.timer,
  //                                           color: Colors.white,
  //                                         ),
  //                                       ),
  //                                       controller: FMF.dtInit,
  //                                       // readOnly: true,
  //                                     ),
  //                                     TextFormField(
  //                                       onTap: () async {
  //                                         DateTime? pickedDate =
  //                                             await _selectDate(context);
  //                                         TimeOfDay? pickedTime =
  //                                             await _selectTime(context);
                        
  //                                         if (pickedDate != null &&
  //                                             pickedTime != null) {
  //                                           DateTime combinedDateTime =
  //                                               DateTime(
  //                                             pickedDate.year,
  //                                             pickedDate.month,
  //                                             pickedDate.day,
  //                                             pickedTime.hour,
  //                                             pickedTime.minute,
  //                                           );
  //                                           String formattedDate =
  //                                               _formatDateTime(
  //                                                   combinedDateTime);
  //                                           FMF.tStart.text = formattedDate;
  //                                         }
  //                                       },
  //                                       style: TextStyle(
  //                                           color:
  //                                               Colors.white.withOpacity(0.6),
  //                                           fontSize: 12,
  //                                           fontStyle: FontStyle.italic),
  //                                       validator: (value) {
  //                                         if (value == null || value.isEmpty) {
  //                                           return '* required';
  //                                         }
  //                                         return null;
  //                                       },
  //                                       decoration: InputDecoration(
  //                                         floatingLabelBehavior:
  //                                             FloatingLabelBehavior
  //                                                 .always, // Defau
  //                                         labelStyle:
  //                                             TextStyle(color: Colors.white),
  //                                         // hintText: 'ex. 20151012.000000',
  //                                         border: OutlineInputBorder(
  //                                             borderRadius:
  //                                                 BorderRadius.circular(15)),
  //                                         labelText: 'Start time',
  //                                         fillColor: Colors.white,
  //                                         hintStyle: TextStyle(
  //                                             color: Colors.white,
  //                                             inherit: true),
  //                                         focusColor: Colors.white,
  //                                         suffixIcon: IconButton(
  //                                           icon: const Icon(
  //                                             Icons.calendar_today,
  //                                             color: Colors.white,
  //                                           ),
  //                                           onPressed: () async {
  //                                             DateTime? pickedDate =
  //                                                 await _selectDate(context);
  //                                             TimeOfDay? pickedTime =
  //                                                 await _selectTime(context);
                        
  //                                             if (pickedDate != null &&
  //                                                 pickedTime != null) {
  //                                               DateTime combinedDateTime =
  //                                                   DateTime(
  //                                                 pickedDate.year,
  //                                                 pickedDate.month,
  //                                                 pickedDate.day,
  //                                                 pickedTime.hour,
  //                                                 pickedTime.minute,
  //                                               );
  //                                               String formattedDate =
  //                                                   _formatDateTime(
  //                                                       combinedDateTime);
  //                                               FMF.tStart.text = formattedDate;
  //                                             }
  //                                           },
  //                                         ),
  //                                       ),
  //                                       controller: FMF.tStart,
  //                                       readOnly: true,
  //                                     ),
  //                                     TextFormField(
  //                                       onChanged: (value) {
  //                                         FMF.dt_nodal = value;
  //                                       },
  //                                       validator: (value) {
  //                                         if (value == null || value.isEmpty) {
  //                                           FMF.dt_nodal = "21600";
  //                                           // return '* Referrence date required';
  //                                         }
  //                                         return null;
  //                                       },
                        
  //                                       style: TextStyle(
  //                                           color:
  //                                               Colors.white.withOpacity(0.6),
  //                                           fontSize: 12,
  //                                           fontStyle: FontStyle.italic),
  //                                       decoration: InputDecoration(
  //                                         floatingLabelBehavior:
  //                                             FloatingLabelBehavior
  //                                                 .always, // Defau
  //                                         labelStyle:
  //                                             TextStyle(color: Colors.white),
  //                                         hintText: 'default: 21600',
  //                                         fillColor: Colors.white,
  //                                         hintStyle: TextStyle(
  //                                             color: Colors.white,
  //                                             fontStyle: FontStyle.italic,
  //                                             fontSize: 12),
  //                                         focusColor: Colors.white,
  //                                         border: OutlineInputBorder(
  //                                             borderRadius:
  //                                                 BorderRadius.circular(15)),
  //                                         labelText: 'Nodal Time Step',
  //                                         suffixIcon: Icon(
  //                                           Icons.timer,
  //                                           color: Colors.white,
  //                                         ),
  //                                       ),
  //                                       controller: FMF.dtNodal,
  //                                       // readOnly: true,
  //                                     ),
  //                                     TextFormField(
  //                                       // enabled: true,
  //                                       // expands: true,
  //                                       // autofocus: true,
                        
  //                                       validator: (value) {
  //                                         if (value == null || value.isEmpty) {
  //                                           FMF.dt_max = "30";
  //                                           // return '* Referrence date required';
  //                                         }
  //                                         return null;
  //                                       },
  //                                       onChanged: (value) {
  //                                         FMF.dt_max = value;
  //                                       },
                        
  //                                       style: TextStyle(
  //                                           color:
  //                                               Colors.white.withOpacity(0.6),
  //                                           fontSize: 12,
  //                                           fontStyle: FontStyle.italic),
  //                                       decoration: InputDecoration(
  //                                         floatingLabelBehavior:
  //                                             FloatingLabelBehavior
  //                                                 .always, // Default behavior
  //                                         labelStyle:
  //                                             TextStyle(color: Colors.white),
  //                                         hintText: 'default: 30',
  //                                         fillColor: Colors.white,
  //                                         hintStyle: TextStyle(
  //                                             color: Colors.white,
  //                                             fontStyle: FontStyle.italic,
  //                                             fontSize: 12),
  //                                         focusColor: Colors.white,
  //                                         border: OutlineInputBorder(
  //                                             borderRadius:
  //                                                 BorderRadius.circular(15)),
  //                                         labelText: 'Max Time Step',
  //                                         suffixIcon: Icon(
  //                                           Icons.timer,
  //                                           color: Colors.white,
  //                                         ),
  //                                       ),
  //                                       controller: FMF.dtMax,
  //                                       // readOnly: true,
  //                                     ),
  //                                     TextFormField(
  //                                       style: TextStyle(
  //                                           color:
  //                                               Colors.white.withOpacity(0.6),
  //                                           fontSize: 12,
  //                                           fontStyle: FontStyle.italic),
  //                                       onTap: () async {
  //                                         DateTime? pickedDate =
  //                                             await _selectDate(context);
  //                                         TimeOfDay? pickedTime =
  //                                             await _selectTime(context);
                        
  //                                         if (pickedDate != null &&
  //                                             pickedTime != null) {
  //                                           DateTime combinedDateTime =
  //                                               DateTime(
  //                                             pickedDate.year,
  //                                             pickedDate.month,
  //                                             pickedDate.day,
  //                                             pickedTime.hour,
  //                                             pickedTime.minute,
  //                                           );
  //                                           String formattedDate =
  //                                               _formatDateTime(
  //                                                   combinedDateTime);
  //                                           FMF.tStop.text = formattedDate;
  //                                         }
  //                                       },
  //                                       validator: (value) {
  //                                         if (value == null || value.isEmpty) {
  //                                           return '* required';
  //                                         }
  //                                         return null;
  //                                       },
  //                                       decoration: InputDecoration(
  //                                         floatingLabelBehavior:
  //                                             FloatingLabelBehavior
  //                                                 .always, // Defau
  //                                         // hintText: 'ex. 20151012.000000',
  //                                         border: OutlineInputBorder(
  //                                             borderRadius:
  //                                                 BorderRadius.circular(15)),
  //                                         labelText: 'End time',
  //                                         fillColor: Colors.white,
  //                                         hintStyle: TextStyle(
  //                                             color: Colors.white,
  //                                             inherit: true),
  //                                         focusColor: Colors.white,
  //                                         labelStyle:
  //                                             TextStyle(color: Colors.white),
  //                                         suffixIcon: IconButton(
  //                                           icon: const Icon(
  //                                             Icons.calendar_today,
  //                                             color: Colors.white,
  //                                           ),
  //                                           onPressed: () async {
  //                                             DateTime? pickedDate =
  //                                                 await _selectDate(context);
  //                                             TimeOfDay? pickedTime =
  //                                                 await _selectTime(context);
                        
  //                                             if (pickedDate != null &&
  //                                                 pickedTime != null) {
  //                                               DateTime combinedDateTime =
  //                                                   DateTime(
  //                                                 pickedDate.year,
  //                                                 pickedDate.month,
  //                                                 pickedDate.day,
  //                                                 pickedTime.hour,
  //                                                 pickedTime.minute,
  //                                               );
  //                                               String formattedDate =
  //                                                   _formatDateTime(
  //                                                       combinedDateTime);
  //                                               FMF.tStop.text = formattedDate;
  //                                             }
  //                                           },
  //                                         ),
  //                                       ),
  //                                       controller: FMF.tStop,
  //                                       readOnly: true,
  //                                     ),
  //                                     TextFormField(
  //                                       style: TextStyle(
  //                                           color:
  //                                               Colors.white.withOpacity(0.6),
  //                                           fontSize: 12,
  //                                           fontStyle: FontStyle.italic),
  //                                       validator: (value) {
  //                                         if (value == null || value.isEmpty) {
  //                                           FMF.t_zone = "0";
  //                                         }
  //                                         return null;
  //                                       },
  //                                       decoration: InputDecoration(
  //                                         floatingLabelBehavior:
  //                                             FloatingLabelBehavior
  //                                                 .always, // Defau
  //                                         labelStyle:
  //                                             TextStyle(color: Colors.white),
  //                                         hintText: 'default: 0',
  //                                         fillColor: Colors.white,
  //                                         hintStyle: TextStyle(
  //                                             color: Colors.white,
  //                                             fontStyle: FontStyle.italic,
  //                                             fontSize: 12),
  //                                         focusColor: Colors.white,
  //                                         border: OutlineInputBorder(
  //                                             borderRadius:
  //                                                 BorderRadius.circular(15)),
  //                                         labelText: 'Time Zone',
  //                                         suffixIcon: const Icon(
  //                                           Icons.place_sharp,
  //                                           color: Colors.white,
  //                                         ),
  //                                       ),
  //                                       controller: FMF.tZone,
  //                                       // readOnly: true,
  //                                     ),
  //                                     TextFormField(
  //                                       style: TextStyle(
  //                                           color:
  //                                               Colors.white.withOpacity(0.6),
  //                                           fontSize: 12,
  //                                           fontStyle: FontStyle.italic),
  //                                       validator: (value) {
  //                                         if (value == null || value.isEmpty) {
  //                                           FMF.t_unit = "S";
  //                                         }
  //                                         return null;
  //                                       },
  //                                       decoration: InputDecoration(
  //                                         floatingLabelBehavior:
  //                                             FloatingLabelBehavior
  //                                                 .always, // Defau
  //                                         labelStyle:
  //                                             TextStyle(color: Colors.white),
  //                                         hintText: 'default: S',
  //                                         fillColor: Colors.white,
  //                                         hintStyle: TextStyle(
  //                                             color: Colors.white,
  //                                             fontStyle: FontStyle.italic,
  //                                             fontSize: 12),
  //                                         focusColor: Colors.white,
  //                                         border: OutlineInputBorder(
  //                                             borderRadius:
  //                                                 BorderRadius.circular(15)),
  //                                         labelText: 'Time Unit',
  //                                         suffixIcon: const Icon(
  //                                           Icons.timer,
  //                                           color: Colors.white,
  //                                         ),
  //                                       ),
  //                                       controller: FMF.tUnit,
  //                                       // readOnly: true,
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                               const SizedBox(
  //                                 height: 20,
  //                               ),
  //                               const Text(
  //                                 'Outputs',
  //                                 style: TextStyle(
  //                                     fontWeight: FontWeight.w500,
  //                                     fontSize: 24,
  //                                     color: Colors.white),
  //                               ),
  //                               const SizedBox(
  //                                 height: 20,
  //                               ),
  //                               TextFormField(
  //                                 validator: (value) {
  //                                   if (value == null || value.isEmpty) {
  //                                     return '* Output directory required';
  //                                   }
  //                                   return null;
  //                                 },
  //                                 controller: FMF.outDir,
  //                                 onTap: () async {
  //                                   //  topo.getRawTopography();
  //                                   // tpd.runTyphoonCmd(dir.dir);
  //                                   FMF.getFile();
  //                                   //  final selected =  await selectFile();
  //                                 },
  //                                 readOnly: true,
  //                                 decoration: InputDecoration(
  //                                   floatingLabelBehavior:
  //                                       FloatingLabelBehavior.always, // Defau
  //                                   labelStyle: TextStyle(color: Colors.white),
  //                                   // hintText: 'default: 300',
  //                                   fillColor: Colors.white,
  //                                   hintStyle: TextStyle(
  //                                       color: Colors.white,
  //                                       fontStyle: FontStyle.italic,
  //                                       fontSize: 12),
  //                                   focusColor: Colors.white,
  //                                   border: OutlineInputBorder(
  //                                       borderRadius:
  //                                           BorderRadius.circular(15)),
  //                                   labelText: FMF.p == ""
  //                                       ? 'Select Output Directory'
  //                                       : 'Output Directory',
  //                                   suffixIcon: Icon(
  //                                     Icons.folder,
  //                                     color: Colors.white,
  //                                   ),
  //                                 ),
  //                                 style: TextStyle(
  //                                     color: Colors.white.withOpacity(0.6),
  //                                     fontSize: 12,
  //                                     fontStyle: FontStyle.italic),
                        
  //                                 // readOnly: true,
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
                  
                       
                       
  //                       ]),
  //                     ),
              
                    
                  
  //                   ],
  //                 ),
  //               ),

  //               actions: [
  //                 ElevatedButton.icon(
  //                   onPressed: () {
  //                     if (_formKey1.currentState!.validate()) {
  //                       ScaffoldMessenger.of(context).showSnackBar(
  //                         SnackBar(
  //                             content: Text('$modelName Config File Created')),
  //                       );
  //                       FMF.getVals(modelName);

  //                       // FMF.readMDU(modelName);
  //                       Navigator.of(context).pop();
  //                     }
  //                   },
  //                   icon: const Icon(
  //                     Icons.save,
  //                     color: Colors.black,
  //                   ),
  //                   label: const Text(
  //                     'Save',
  //                     style: TextStyle(color: Colors.black),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
   