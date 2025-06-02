// import 'dart:async';

// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:provider/provider.dart';
// import 'package:swan/Components/CustomTextField.dart';
// import 'package:swan/Components/GlassDialog.dart';
// import 'package:swan/FlowWidgets/ModelDetail.dart';
// import 'package:swan/FlowWidgets/ModelProviders/AddModelProvider.dart';
// import 'package:swan/FlowWidgets/ModelProviders/FlowConfigFileProvider.dart';
// import 'package:swan/FlowWidgets/ModelProviders/getModelsProvider.dart';
// import 'package:swan/FlowWidgets/NwlModel.dart';
// import 'package:swan/LandingPage.dart';

// import '../Components/Hoverbutton.dart';

// class FlowLandingPage extends StatelessWidget {
//   const FlowLandingPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final _formKey1 = GlobalKey<FormState>();
//     final AMP = Provider.of<AddModelProvider>(context);
//     // final GMP = Provider.of<GetModelsProvider>(context);
//     return 
    
//     Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           FlutterMap(
//             options: const MapOptions(
//               center: LatLng(12.8797, 121.7740), // Centered on the Philippines
//               zoom: 6.5,
//               backgroundColor: Colors.black12,
//               // interactionOptions: InteractionOptions(
//               //   flags: InteractiveFlag.none, // Disable all interactions
//               // ),
//             ),
//             children: [
//               TileLayer(
//                 urlTemplate:
//                     'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}.png',
//                 userAgentPackageName: 'com.example.app',
//                 subdomains: ['a', 'b', 'c'],
//               ),
//               // OverlayImageLayer(
//               //   overlayImages: [
//               //     OverlayImage(
//               //       bounds: LatLngBounds(
//               //         const LatLng(2.0525927337113665, 107.03514716442793),
//               //         const LatLng(28.50509192411439, 135.26960583104557),
//               //       ),
//               //       opacity: 0.75,
//               //       imageProvider: AssetImage(_overlayImages[_currentIndex]),
//               //       gaplessPlayback: true,
//               //     ),
//               //   ],
//               // ),
//             ],
//           ),
//           Positioned(
//             left: 20,
//             top: 30,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Hero(
//                   tag: 'coaster',
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => LandingPage(),
//                       ));
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 10),
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Colors.lightGreen,
//                               Colors.green.shade900, // Dark green
//                               Colors.green.shade400,
//                               Colors.lightGreen,
//                             ]),
//                       ),
//                       child: const Text(
//                         'COASTER FLOW MODELS',
//                         style: TextStyle(
//                           fontSize: 36.0,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // All models will be place here
//           Positioned(
//             left: 20,
//             bottom: 50,
//             right: 20,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Models: ",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 16), // Spacing
//                 FutureBuilder<List<String>>(
//                   future: getModels(), // Your async function
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return Center(child: CircularProgressIndicator());
//                     } else if (snapshot.hasError) {
//                       return Center(
//                         child: Text(
//                           '',
//                           style: TextStyle(color: Colors.red),
//                         ),
//                       );
//                     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                       return Center(
//                         child: Text(
//                           'No models available',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       );
//                     } else {
//                       final models = snapshot.data!;
//                       return SizedBox(
//                         height: 100, // Set a fixed height for the ListView
//                         child: ListView.builder(
//                           scrollDirection:
//                               Axis.horizontal, // Horizontal scrolling
//                           itemCount: models.length,
//                           itemBuilder: (context, index) {
//                             final modelName = models[index]
//                                 .split("\\")
//                                 .last; // Extract the file name
//                             return Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 8.0),
//                               child: Center(
//                                 child: HoverElevatedButtonIcon(
//                                   onPressed: () {
//                                     // Your onPressed action here
//                                   },
//                                   label: modelName,
//                                   icon: Icon(
//                                     Icons.book,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       );
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),

//           AMP.loading == "loading"
//               ? Center(
//                   child: GlassDialog(
//                   width: 1000,
//                   height: 650,
//                   child: AlertDialog(
//                       // shadowColor: Colors.white,

//                       backgroundColor: Colors.transparent,
//                       title: Column(
//                         children: [
//                           CircularProgressIndicator(
//                             color: Colors.green,
//                           ),
//                           Text(
//                             "Adding Model..",
//                             style: TextStyle(
//                                 fontSize: 26,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.white),
//                           )
//                         ],
//                       )),
//                 ))
//               : Positioned(
//                   bottom: 50,
//                   right: MediaQuery.of(context).size.width * 0.01,
//                   child: Center(
//                     child: HoverElevatedButtonIcon(
//                       primaryColor: Colors.green,
//                       hoverColor: Colors.greenAccent,
//                       onPressed: () {
//                         showDialog(
//                           context: context,
//                           barrierDismissible: true,
//                           barrierColor: Colors.black.withOpacity(0.4),
//                           builder: (context) {
//                             return GlassDialog(
//                               width: 1000,
//                               height: 650,
//                               child: AlertDialog(
//                                 // shadowColor: Colors.white,

//                                 backgroundColor: Colors.transparent,
//                                 title: Text(
//                                   'Add Model',
//                                   style: TextStyle(
//                                       fontSize: 26,
//                                       fontWeight: FontWeight.w700,
//                                       color: Colors.white),
//                                 ),
//                                 content: SizedBox(
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.50,
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.50,
//                                   child: SingleChildScrollView(
//                                     child: Form(
//                                       key: _formKey1,
//                                       child: Column(
//                                         children: [
//                                           const SizedBox(
//                                             height: 40,
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           ),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceEvenly,
//                                             children: [
//                                               // Column 1 (Reference Date)
//                                               Expanded(
//                                                 child: Column(
//                                                   children: [
//                                                     StyledTextFormField(
//                                                       isMultiline: false,
//                                                       controller: AMP.modelName,
//                                                       hintText: "",
//                                                       labelText: 'Model Name',
//                                                       icon: Icon(
//                                                         Icons.file_open,
//                                                         color: Colors.white,
//                                                       ),
//                                                       onChanged: (value) {
//                                                         AMP.model_name = value;
//                                                       },
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),

//                                               // Column 2 (Start Date)

//                                               const SizedBox(width: 20),
//                                               // Column 3 (End Date)
//                                               Expanded(
//                                                 child: Column(
//                                                   children: [
//                                                     StyledTextFormField(
//                                                       isMultiline: false,
//                                                       controller:
//                                                           AMP.modelerController,
//                                                       hintText: "",
//                                                       labelText: 'Modeler',
//                                                       icon: Icon(
//                                                         Icons.person,
//                                                         color: Colors.white,
//                                                       ),
//                                                       onChanged: (value) {
//                                                         AMP.modeler = value;
//                                                       },
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           const SizedBox(
//                                             height: 40,
//                                           ),
//                                           StyledTextFormField(
//                                             isMultiline: true,
//                                             controller: AMP.modelDescription,
//                                             hintText: "",
//                                             labelText: 'Model Description',
//                                             icon: Icon(
//                                               Icons.description,
//                                               color: Colors.white,
//                                             ),
//                                             onChanged: (value) {
//                                               AMP.model_description = value;
//                                             },
//                                           ),
//                                           const SizedBox(
//                                             height: 40,
//                                           ),
//                                           const Text(
//                                             'Input Model',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w500,
//                                                 fontSize: 24,
//                                                 color: Colors.white),
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           ),
//                                           StyledTextFormField(
//                                             readOnly: true,
//                                             controller: AMP.modelDirectory,
//                                             isMultiline: false,
//                                             hintText: "",
//                                             onTap: () async {
//                                               AMP.getModelDirectory();
//                                             },
//                                             labelText: AMP.model_directory == ""
//                                                 ? 'Model file'
//                                                 : 'Model',
//                                             icon: Icon(
//                                               Icons.folder,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 actions: [
//                                   ElevatedButton.icon(
//                                     onPressed: () {
//                                       if (_formKey1.currentState!.validate()) {
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(
//                                           SnackBar(
//                                               content: Text(
//                                                   '${AMP.model_name} Config File Created')),
//                                         );
//                                         AMP.getModel();

//                                         AMP.runAddModelPy();
//                                         if (AMP.loading == "loading") {
//                                           Navigator.of(context).push(MaterialPageRoute(builder: (context) => FlowLandingPage(),));
//                                         } else {
//                                           Navigator.of(context).push(MaterialPageRoute(builder: (context) => FlowLandingPage(),));
//                                         }
//                                       }
//                                     },
//                                     icon: const Icon(
//                                       Icons.post_add_outlined,
//                                       color: Colors.black,
//                                     ),
//                                     label: const Text(
//                                       'Add',
//                                       style: TextStyle(color: Colors.black),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         );
//                       },
//                       label: 'Add Model',
//                       icon: Icon(
//                         Icons.add,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),

//           Positioned(
//             bottom: 20,
//             right: MediaQuery.of(context).size.width * 0.01,
//             child: const Text(
//               '© MMSU coaster 2024 All rights reserved',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
 
 
//   }
// }

// class HoverButton extends StatefulWidget {
//   final Widget child;
//   final VoidCallback? onPressed;

//   const HoverButton({Key? key, required this.child, this.onPressed})
//       : super(key: key);

//   @override
//   _HoverButtonState createState() => _HoverButtonState();
// }

// class _HoverButtonState extends State<HoverButton> {
//   double _buttonHeight = 50.0;

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) {
//         setState(() {
//           _buttonHeight = 70.0; // Increase height on hover
//         });
//       },
//       onExit: (_) {
//         setState(() {
//           _buttonHeight = 50.0; // Reset height on exit
//         });
//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         height: _buttonHeight,
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.blue.shade900, // Dark blue
//               Colors.blue.shade400, // Lighter blue
//             ],
//           ),
//         ),
//         child: TextButton(
//           onPressed: widget.onPressed,
//           child: widget.child,
//         ),
//       ),
//     );
//   }
// }
