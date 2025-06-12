import 'dart:io';
import 'package:coaster_control_center/FlowWidgets/DelftVisualize.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/postProcessingProvider.dart';
import 'package:coaster_control_center/IntegratedModelWidgets/IntegratedModelProviders/IntegratedModelProvider.dart';
import 'package:coaster_control_center/provider/fxnImageOVerlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:coaster_control_center/BoundaryConditions/BC_RUN.dart';
import 'package:coaster_control_center/Components/AnimatedMap.dart';
import 'package:coaster_control_center/Components/CustomTextField.dart';
import 'package:coaster_control_center/Components/GlassDialog.dart';
import 'package:coaster_control_center/Components/Hoverbutton.dart';
import 'package:coaster_control_center/Components/terminalDialog.dart';

import 'package:coaster_control_center/FlowWidgets/ModelConfigDialog.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/FlowConfigFileProvider.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/RunModelProvider.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/changeModelProvider.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/getModelsProvider.dart';
import 'package:coaster_control_center/FlowWidgets/SelectCenters.dart';
import 'package:coaster_control_center/LandingPage.dart';

class IntegratedModelLandingPage extends StatefulWidget {
  const IntegratedModelLandingPage({super.key});

  @override
  State<IntegratedModelLandingPage> createState() => _IntegratedModelLandingPageState();
}

class _IntegratedModelLandingPageState extends State<IntegratedModelLandingPage>
    with TickerProviderStateMixin {
  late final MapController _mapController;
  late final AnimationController controller;
  // late final List<Map<String, dynamic>> models;

  late Future<List<Map<String, dynamic>>> getModels;

  late List<Map<String, dynamic>> models;
  // late final List<Map<String, dynamic>> modelLists;
  File? _currentImageFile;
  LatLngBounds? _currentImageBounds;
  int indx = -999;
  Map<String, dynamic> mods = {};
  String? selectedModelName;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _mapController = MapController();
    getModels = getModelsJson();
  }

  /// Function to animate the map to a new position and zoom level
  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final camera = _mapController.camera;
    final latTween = Tween<double>(
        begin: camera.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: camera.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: camera.zoom, end: destZoom);

    final controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    final animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      _mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  void _onMapEvent(MapEvent event) {
    if (event is MapEventMoveEnd || event is MapEventScrollWheelZoom) {
      final center = _mapController.camera.center;
      final zoom = _mapController.camera.zoom;
      print(
          "Current center: Latitude = ${center.latitude}, Longitude = ${center.longitude}, Zoom Level = $zoom");
    }
  }

  final TextEditingController _colorMapController = TextEditingController();

  final TextEditingController _modsController = TextEditingController();
  String? _selectedColorMap;
  String? _selectedMods;
  final List<String> colormaps = [
    'jet',
    'viridis',
    'plasma',
    'inferno',
    'magma',
    'cividis',
    'coolwarm',
    'twilight'
  ]; // Add more colormaps as needed

  @override
  Widget build(BuildContext context) {
    final _formKey1 = GlobalKey<FormState>();
    final AMP = Provider.of<IntegratedModelProvider>(context);
    final CMP = Provider.of<ChangeModelProvider>(context);
    final FMF = Provider.of<FlowConfigFileProvider>(context);
    final RMP = Provider.of<RunModelProvider>(context);
    final BC = Provider.of<RUNBC>(context);
    final PP = Provider.of<PostProcessingProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AnimatedMap(
              controller: controller,
              onMapEvent: _onMapEvent,
              mapController: _mapController,
              imageFile: CMP.currentImageFile,
              bounds: CMP.bounds),
        
          Positioned(
            left: MediaQuery.of(context).size.width * 0.03,
            top: MediaQuery.of(context).size.height * 0.025,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'coaster',
                  child: GestureDetector(
                    onTap: () {
                      RMP.reset();

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LandingPage(),
                      ));

                      CMP.currentImageFile = _currentImageFile;
                      CMP.bounds = _currentImageBounds;
                      CMP.indx = -999;
                      CMP.mods = {};
                      PP.loading = " ";
                      PP.isPlotted = false;
                      FMF.isSaved = false;
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.lightGreen,
                              Colors.green.shade900, // Dark green
                              Colors.green.shade400,
                              Colors.lightGreen,
                            ]),
                      ),
                      child: const Text(
                        'COASTER INTEGRATED MODEL',
                        style: TextStyle(
                          fontSize: 36.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        
          AMP.loading == "loading"
              ? Center(
                  child: GlassDialog(
                  width: 1000,
                  height: 650,
                  child: AlertDialog(
                      // shadowColor: Colors.white,

                      backgroundColor: Colors.transparent,
                      title: Column(
                        children: [
                          CircularProgressIndicator(
                            color: Colors.green,
                          ),
                          Text(
                            "Adding Model..",
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          )
                        ],
                      )),
                ))
              : Positioned(
                  // left: 20,
                  top: MediaQuery.of(context).size.height * 0.05,
                  right: MediaQuery.of(context).size.width * 0.01,
                  child: Column(
                    // mainAxisAlignment: MainAxi
                    //sAlignment,  // Change as per need
                     mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CMP.indx != -999 && RMP.loading != "loading"
                          ? Center( 
                              child: HoverElevatedButtonIcon(
                                primaryColor: Colors.lightGreen,
                                hoverColor: Colors.black,
                                // primaryColor: Colors.blue.shade900,
                                // hoverColor: Colors.blue.shade400,
                                onPressed: () {
                                  ModelConfigDialog(
                                      context, CMP.mods["name"]);
                                  // ModelConfigDialog(
                                  //     context, CMP.mods["name"]);
                                  // your action
                                },
                                label: 'Configure Model',
                                icon: Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: 20,
                      ),
                  
                      FMF.isSaved &&
                              FMF.runMode == 1 &&
                              RMP.loading == "init"
                          ?
                          // mainAxisAlignment: MainAxisAlignment,  // Change as per need
                  
                          Center(
                              child: HoverElevatedButtonIcon(
                                // primaryColor: Colors.red,
                                // hoverColor: Colors.orange,
                                primaryColor: Colors.lightGreen,
                                hoverColor: Colors.black,
                                onPressed: () {
                                  RMP.runDelftModel(CMP.mods["name"]);
                                  // showTerminalDialog(context,
                                  //     "Running ${CMP.mods["name"]} model");
                                  // showTerminalDialog(context, RMP.outputList);
                                  // ModelConfigDialog(context, widget.modelName);
                                  // your action
                                },
                                label: 'Run',
                                icon: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : FMF.isSaved &&
                                  FMF.runMode == 1 &&
                                  RMP.loading == "loading"
                              ? Center(
                                  child: HoverElevatedButtonIcon(
                                    primaryColor: Colors.red,
                                    hoverColor: Colors.orange,
                                    onPressed: () {
                                      // RMP.runDelftAutomationModel( CMP.mods["name"]);
                                      showTerminalDialog(context,
                                          "Running ${CMP.mods["name"]} Model");
                                      // RMP.runDelftModel( CMP.mods["name"]);
                                      // ModelConfigDialog(context, widget.modelName);
                                      // your action
                                    },
                                    label: 'Running Model...',
                                    icon: Icon(
                                      Icons.pause,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : FMF.isSaved &&
                                      FMF.runMode == 2 &&
                                      RMP.loading == "init"
                                  ? Center(
                                      child: HoverElevatedButtonIcon(
                                        primaryColor: Colors.pink,
                                        hoverColor: Colors.purple,
                                        onPressed: () {
                                          RMP.runDelftAutomationModel(
                                              CMP.mods["name"]);
                                          showTerminalDialog(context,
                                              "Running Automation on ${CMP.mods["name"]} model");
                                          // RMP.runDelftModel( CMP.mods["name"]);
                                          // ModelConfigDialog(context, widget.modelName);
                                          // your action
                                        },
                                        label: 'Run Automation',
                                        icon: Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : FMF.isSaved &&
                                          FMF.runMode == 2 &&
                                          RMP.loading == "loading"
                                      ? Center(
                                          child: HoverElevatedButtonIcon(
                                            primaryColor: Colors.red,
                                            hoverColor: Colors.orange,
                                            onPressed: () {
                                              // RMP.runDelftAutomationModel( CMP.mods["name"]);
                                              showTerminalDialog(context,
                                                  "Running Automation on ${CMP.mods["name"]} model");
                                              // RMP.runDelftModel( CMP.mods["name"]);
                                              // ModelConfigDialog(context, widget.modelName);
                                              // your action
                                            },
                                            label: 'Automating...',
                                            icon: Icon(
                                              Icons.pause,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : Container(),

                  
                      SizedBox(
                        height: 20,
                      ),
                                       Center(
                              child: Tooltip(
                              message: "Select Working Directory",
                              child: HoverElevatedButtonIcon(

                                primaryColor: Colors.blueAccent,
                                hoverColor: Colors.black,
                                onPressed: () {
 AMP.getModelDirectory();
                                },
                                label: "Add Existing or New Project",
                                icon: Icon(
                                  Icons.create_new_folder_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                  
                     SizedBox(
                        height:  MediaQuery.of(context).size.height * 0.07,
                      ),
                      RMP.loading != "loading"
                          ? Center(
                              child: HoverElevatedButtonIcon(
                                primaryColor: Colors.blueAccent,
                                hoverColor: Colors.black,
                                // primaryColor: Colors.green,
                                // hoverColor: Colors.greenAccent,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    barrierColor:
                                        Colors.black.withOpacity(0.4),
                                    builder: (context) {
                                      return GlassDialog(
                                        width: 1000,
                                        height: 750,
                                        child: AlertDialog(
                                          // shadowColor: Colors.white,
                  
                                          backgroundColor:
                                              Colors.transparent,
                                          title: Text(
                                            'Integrated Model Configuration File',
                                            style: TextStyle(
                                                fontSize: 26,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white),
                                          ),
                                          content: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.50,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.50,
                                            child: SingleChildScrollView(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(
                                                        18.0),
                                                child: Form(
                                                  key: _formKey1,
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 40,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          // Column 1 (Reference Date)
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                StyledTextFormField(
                                                                  isFilled:
                                                                      false,
                                                                  isFloating:
                                                                      true,
                                                                  isMultiline:
                                                                      false,
                                                                  controller:
                                                                      AMP.modelName,
                                                                  hintText:
                                                                      "",
                                                                  labelText:
                                                                      'Model Name',
                                                                  icon:
                                                                      Icon(
                                                                    Icons
                                                                        .file_open,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  onChanged:
                                                                      (value) {
                                                                    AMP.model_name =
                                                                        value;
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                  
                                                          // Column 2 (Start Date)
                  
                                                          const SizedBox(
                                                              height: 20),
                                                          // Column 3 (End Date)
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                StyledTextFormField(
                                                                  isFilled:
                                                                      false,
                                                                  isFloating:
                                                                      true,
                                                                  isMultiline:
                                                                      false,
                                                                  controller:
                                                                      AMP.modelerController,
                                                                  hintText:
                                                                      "",
                                                                  labelText:
                                                                      'Modeler',
                                                                  icon:
                                                                      Icon(
                                                                    Icons
                                                                        .person,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  onChanged:
                                                                      (value) {
                                                                    AMP.modeler =
                                                                        value;
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 40,
                                                      ),
                                                      StyledTextFormField(
                                                        isFilled: false,
                                                        isFloating: true,
                                                        isMultiline: true,
                                                        controller: AMP
                                                            .modelDescription,
                                                        hintText: "",
                                                        labelText:
                                                            'Model Description',
                                                        icon: Icon(
                                                          Icons.description,
                                                          color:
                                                              Colors.white,
                                                        ),
                                                        onChanged: (value) {
                                                          AMP.model_description =
                                                              value;
                                                        },
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      const Text(
                                                        'Presentation Setting',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                            fontSize: 24,
                                                            color: Colors
                                                                .white),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          // Column 1 (Reference Date)
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                StyledTextFormField(
                                                                  isFilled:
                                                                      false,
                                                                  isFloating:
                                                                      true,
                                                                  isMultiline:
                                                                      false,
                                                                  controller:
                                                                      AMP.centerLatTextController,
                                                                  hintText:
                                                                      "",
                                                                  labelText:
                                                                      'Center Latitude',
                                                                  icon:
                                                                      Icon(
                                                                    Icons
                                                                        .location_on_outlined,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  onChanged:
                                                                      (value) {
                                                                    AMP.centerLat =
                                                                        value;
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                  
                                                          // Column 2 (Start Date)
                  
                                                          const SizedBox(
                                                              width: 20),
                                                          // Column 3 (End Date)
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                StyledTextFormField(
                                                                  isFilled:
                                                                      false,
                                                                  isFloating:
                                                                      true,
                                                                  isMultiline:
                                                                      false,
                                                                  controller:
                                                                      AMP.centerLonTextController,
                                                                  hintText:
                                                                      "",
                                                                  labelText:
                                                                      'Center Longitude',
                                                                  icon:
                                                                      Icon(
                                                                    Icons
                                                                        .location_on_outlined,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  onChanged:
                                                                      (value) {
                                                                    AMP.centerLon =
                                                                        value;
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 20),
                                                          // Column 3 (End Date)
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                StyledTextFormField(
                                                                  isFilled:
                                                                      false,
                                                                  isFloating:
                                                                      true,
                                                                  isMultiline:
                                                                      false,
                                                                  controller:
                                                                      AMP.centerZoomTextController,
                                                                  hintText:
                                                                      "",
                                                                  labelText:
                                                                      'Center Zoom Level',
                                                                  icon:
                                                                      Icon(
                                                                    Icons
                                                                        .zoom_in,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  onChanged:
                                                                      (value) {
                                                                    AMP.centerZoom =
                                                                        value;
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 20),
                                                          Expanded(
                                                              child: Column(
                                                            children: [
                                                              ElevatedButton
                                                                  .icon(
                                                                onPressed:
                                                                    () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(
                                                                    MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          SelectCenters(),
                                                                    ),
                                                                  );
                                                                  print(
                                                                      "Generating Center");
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .add_link_rounded,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                label: Text(
                                                                  'Generate',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                ),
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .blue, // Button background color
                                                                  foregroundColor:
                                                                      Colors
                                                                          .white, // Text/icon color when pressed
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical:
                                                                          12,
                                                                      horizontal:
                                                                          20),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(8), // Rounded corners
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ))
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      const Text(
                                                        'Input Model',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                            fontSize: 24,
                                                            color: Colors
                                                                .white),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      StyledTextFormField(
                                                        isFilled: false,
                                                        isFloating: true,
                                                        readOnly: true,
                                                        controller: AMP
                                                            .modelDirectory,
                                                        isMultiline: false,
                                                        hintText: "",
                                                        onTap: () async {
                                                          AMP.getModelDirectory();
                                                        },
                                                        labelText:
                                                            AMP.model_directory ==
                                                                    ""
                                                                ? 'Model file'
                                                                : 'Model',
                                                        icon: Icon(
                                                          Icons.folder,
                                                          color:
                                                              Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                if (_formKey1.currentState!
                                                    .validate()) {
                                                  // ScaffoldMessenger.of(context)
                                                  //     .showSnackBar(
                                                  //   SnackBar(
                                                  //       content: Text(
                                                  //           '${AMP.model_name} Config File Created')),
                                                  // );
                  
                                                  AMP.getModelJson();
                  
                                                  AMP.runAddModelPy(
                                                      AMP.model_name);
                  
                                                  // AMP.changeWorkingDirXML(AMP.model_name);
                  
                                                  // AMP.clearModel();
                                                  // AMP.clearModel();
                  
                                                  if (AMP.loading ==
                                                      "loading") {
                                                    Navigator.of(context)
                                                        .push(
                                                            MaterialPageRoute(
                                                      builder: (context) =>
                                                          IntegratedModelLandingPage(),
                                                    ));
                                                  } else {
                                                    Navigator.of(context)
                                                        .push(
                                                            MaterialPageRoute(
                                                      builder: (context) =>
                                                          IntegratedModelLandingPage(),
                                                    ));
                                                  }
                                                }
                                              },
                                              icon: const Icon(
                                                Icons.post_add_outlined,
                                                color: Colors.black,
                                              ),
                                              label: const Text(
                                                'Add',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                label: 'Integrated Model Configuration File',
                                icon: Icon(
                                  Icons.settings_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Container(),
                      // FMF.isSaved
                      //     ?
                      //     // mainAxisAlignment: MainAxisAlignment,  // Change as per need
                  
                      //     Center(
                      //         child: HoverElevatedButtonIcon(
                      //           primaryColor: Colors.green,
                      //           hoverColor: Colors.greenAccent,
                      //           onPressed: () {
                      //             // ModelConfigDialog(context, widget.modelName);
                      //             // your action
                      //           },
                      //           label: 'Run',
                      //           icon: Icon(
                      //             Icons.play_arrow,
                      //             color: Colors.white,
                      //           ),
                      //         ),
                      //       )
                      //     : Container()
                      SizedBox(
                        height:  MediaQuery.of(context).size.height * 0.07,
                      ),
                      HoverElevatedButtonIcon(
                        primaryColor: Colors.blueAccent,
                        hoverColor: Colors.black,
                        // primaryColor: Colors.blueAccent,
                        // hoverColor: Colors.black,
                        onPressed: () {
                          BC.runBC();
                        },
                        label: 'Add Data Source',
                        icon: Icon(
                          Icons.animation_sharp,
                          color: Colors.white,
                        ),
                      ),
                     
                     
                      SizedBox(
                        height:  MediaQuery.of(context).size.height * 0.07
                      ),
                  
                      RMP.outDir != " " || PP.loading != " " || PP.isPlotted
                          ? Center(
                              child: Tooltip(
                              message: "Enter the visualization area",
                              child: HoverElevatedButtonIcon(
                                primaryColor: Colors.blueAccent,
                                hoverColor: Colors.black,
                                onPressed: () {
                                  // imgoverlay.loadImagesFromDirectory('${dir.dir}\\output\\swan\\raw');
                  
                                  LoadImages(RMP.outDir).then(
                                    (value) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DelftVisualization(
                                              bound1: RMP.bound1,
                                              bound2: RMP.bound2,
                                              center: RMP.center,
                                              zoom: RMP.zoom,
                                              overlayImages: value,
                                              length: value.length,
                                              url: RMP.outDir,
                                            ),
                                          ));
                                    },
                                  );
                  
                                  //  _loadImagesFromDirectory('${dir.dir}\\output\\swan\\raw');
                                  // _isStarted = true;
                                },
                                label: "Select FLOW model (DELFT)",
                                icon: Icon(
                                  Icons.movie_creation_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ))
                          : Center(
                              child: Tooltip(
                              message: "Enter the visualization area",
                              child: HoverElevatedButtonIcon(
                                primaryColor: Colors.blueAccent,
                                hoverColor: Colors.black,
                                onPressed: () {
                                  // imgoverlay.loadImagesFromDirectory('${dir.dir}\\output\\swan\\raw');
                  
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    barrierColor:
                                        Colors.black.withOpacity(0.4),
                                    builder: (context) {
                                      return GlassDialog(
                                        width: 1000,
                                        height: 650,
                                        child: AlertDialog(
                                          // shadowColor: Colors.white,
                  
                                          backgroundColor:
                                              Colors.transparent,
                                          title: Text(
                                            'Visualize Model Results',
                                            style: TextStyle(
                                                fontSize: 26,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white),
                                          ),
                                          content: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.50,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.50,
                                            child: SingleChildScrollView(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(
                                                        18.0),
                                                child: Form(
                                                  key: _formKey1,
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 40,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          // Column 1 (Reference Date)
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                const Text(
                                                                  'Model Output file',
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight
                                                                          .w500,
                                                                      fontSize:
                                                                          24,
                                                                      color:
                                                                          Colors.white),
                                                                ),
                                                                const SizedBox(
                                                                  height:
                                                                      20,
                                                                ),
                                                                StyledTextFormField(
                                                                  isFilled:
                                                                      false,
                                                                  isFloating:
                                                                      true,
                                                                  readOnly:
                                                                      true,
                                                                  controller:
                                                                      PP.modelOutputFile,
                                                                  isMultiline:
                                                                      false,
                                                                  hintText:
                                                                      "",
                                                                  onTap:
                                                                      () async {
                                                                    PP.getModelOutputMap();
                                                                    // AMP.getModelDirectory();
                                                                  },
                                                                  labelText: PP.model_output_file ==
                                                                          ""
                                                                      ? 'Model Output file'
                                                                      : 'Model',
                                                                  icon:
                                                                      Icon(
                                                                    Icons
                                                                        .folder,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height:
                                                                      20,
                                                                ),
                                                                DropdownButtonFormField<
                                                                    String>(
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(0.6),
                                                                    fontSize:
                                                                        12,
                                                                    fontStyle:
                                                                        FontStyle.italic,
                                                                  ),
                                                                  dropdownColor:
                                                                      Colors
                                                                          .black,
                                                                  value:
                                                                      _selectedMods,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelText:
                                                                        'Select Model',
                                                                    labelStyle:
                                                                        TextStyle(color: Colors.white),
                                                                    prefixIcon:
                                                                        Icon(
                                                                      Icons
                                                                          .archive_outlined,
                                                                      color:
                                                                          Colors.white,
                                                                    ),
                                                                    border:
                                                                        OutlineInputBorder(),
                                                                  ),
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                            null ||
                                                                        value.isEmpty) {
                                                                      return "* Model selection required";
                                                                    }
                                                                  },
                                                                  items: models
                                                                      .map(
                                                                          (mod) {
                                                                    return DropdownMenuItem<
                                                                        String>(
                                                                      value:
                                                                          mod['name'],
                                                                      child:
                                                                          Text(
                                                                        mod['name'],
                                                                        style:
                                                                            TextStyle(color: Colors.white),
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                                  onChanged:
                                                                      (value) {
                                                                        PP.mods =
                                                                          value ?? "";
                                                                    setState(
                                                                        () {
                  
                                                                      _selectedMods =
                                                                          value;
                                                                      _modsController.text =
                                                                          value ?? "";
                                                                      PP.mods =
                                                                          value ?? "";
                                                                      PP.modsController.text =
                                                                          value!;
                                                                    });
                                                                  },
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      const Text(
                                                        'Post Processing Settings',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                            fontSize: 24,
                                                            color: Colors
                                                                .white),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          // Column 1 (Reference Date)
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                StyledTextFormField(
                                                                  validator:
                                                                      (p0) {
                                                                    if (p0 ==
                                                                            null ||
                                                                        p0
                                                                            .isEmpty) {
                                                                      return null;
                                                                    } else if (!RegExp(r'^-?\d+(\.\d+)?$').hasMatch(
                                                                        p0)) {
                                                                      return 'Only numbers are allowed';
                                                                    } else if (double.parse(PP.v_max) <
                                                                        double.parse(p0)) {
                                                                      return 'Unacceptable Value';
                                                                    }
                                                                    return null; // Valid input
                                                                  },
                                                                  isFilled:
                                                                      false,
                                                                  isFloating:
                                                                      true,
                                                                  isMultiline:
                                                                      false,
                                                                  controller:
                                                                      PP.vMinController,
                                                                  hintText:
                                                                      "",
                                                                  labelText:
                                                                      'VMIN',
                                                                  icon:
                                                                      Icon(
                                                                    Icons
                                                                        .zoom_out,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  onChanged:
                                                                      (value) {
                                                                    PP.v_min =
                                                                        value;
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                  
                                                          // Column 2 (Start Date)
                  
                                                          const SizedBox(
                                                              width: 20),
                                                          // Column 3 (End Date)
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                StyledTextFormField(
                                                                  validator:
                                                                      (p0) {
                                                                    if (p0 ==
                                                                            null ||
                                                                        p0
                                                                            .isEmpty) {
                                                                      return null;
                                                                    } else if (!RegExp(r'^-?\d+(\.\d+)?$').hasMatch(
                                                                        p0)) {
                                                                      return 'Only numbers are allowed';
                                                                    } else if (double.parse(PP.v_min) >
                                                                        double.parse(p0)) {
                                                                      return 'Unacceptable Value';
                                                                    }
                                                                    return null; // Valid input
                                                                  },
                                                                  isFilled:
                                                                      false,
                                                                  isFloating:
                                                                      true,
                                                                  isMultiline:
                                                                      false,
                                                                  controller:
                                                                      PP.vMaxController,
                                                                  hintText:
                                                                      "",
                                                                  labelText:
                                                                      'VMAX',
                                                                  icon:
                                                                      Icon(
                                                                    Icons
                                                                        .zoom_in,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  onChanged:
                                                                      (value) {
                                                                    PP.v_max =
                                                                        value;
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 20),
                                                          // Column 3 (End Date)
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                DropdownButtonFormField<
                                                                    String>(
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(0.6),
                                                                    fontSize:
                                                                        12,
                                                                    fontStyle:
                                                                        FontStyle.italic,
                                                                  ),
                                                                  dropdownColor:
                                                                      Colors
                                                                          .black,
                                                                  value:
                                                                      _selectedColorMap,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelText:
                                                                        'Color Map',
                                                                    labelStyle:
                                                                        TextStyle(color: Colors.white),
                                                                    prefixIcon:
                                                                        Icon(
                                                                      Icons
                                                                          .color_lens,
                                                                      color:
                                                                          Colors.white,
                                                                    ),
                                                                    border:
                                                                        OutlineInputBorder(),
                                                                  ),
                                                                  items: colormaps
                                                                      .map(
                                                                          (colormap) {
                                                                    return DropdownMenuItem<
                                                                        String>(
                                                                      value:
                                                                          colormap,
                                                                      child:
                                                                          Text(
                                                                        colormap,
                                                                        style:
                                                                            TextStyle(color: Colors.white),
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                                  onChanged:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      _selectedColorMap =
                                                                          value;
                                                                      _colorMapController.text =
                                                                          value ?? "";
                                                                      PP.colorMap =
                                                                          value ?? "";
                                                                      PP.colorMapController.text =
                                                                          value!;
                                                                    });
                                                                  },
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                if (_formKey1.currentState!
                                                    .validate()) {
                                                        PP.setMapAttributes();
                                                  if (PP.isPlotted) {
                  
                                                  LoadRawImages(PP.model_output_file1, PP.mods).then((value) {
                                                     Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      DelftVisualization(
                                                                bound1: value['bound1'],
                                                                bound2: value['bound2'],
                                                                center: value['center'],
                                                                zoom:
                                                                    value['zoom'],
                                                                overlayImages:
                                                                    value['overlayImages'],
                                                                length: value['overlayImages'].length,
                                                                url: PP
                                                                    .model_output_file1,
                                                              ),
                                                            ));
                                                  },);
                  
                  
                                                    // LoadImages(PP
                                                    //         .model_output_file1)
                                                    //     .then(
                                                    //   (value) {
                                                    //     Navigator.push(
                                                    //         context,
                                                    //         MaterialPageRoute(
                                                    //           builder:
                                                    //               (context) =>
                                                    //                   DelftVisualization(
                                                    //             bound1: PP
                                                    //                 .bound1,
                                                    //             bound2: PP
                                                    //                 .bound2,
                                                    //             center: PP
                                                    //                 .center,
                                                    //             zoom:
                                                    //                 PP.zoom,
                                                    //             overlayImages:
                                                    //                 value,
                                                    //             length: value
                                                    //                 .length,
                                                    //             url: PP
                                                    //                 .model_output_file1,
                                                    //           ),
                                                    //         ));
                                                    //   },
                                                    // );
                                                  } else {
                                                    PP.visualizeResults();
                                                  }
                  
                                                  if (AMP.loading ==
                                                      "loading") {
                                                    Navigator.of(context)
                                                        .push(
                                                            MaterialPageRoute(
                                                      builder: (context) =>
                                                          IntegratedModelLandingPage(),
                                                    ));
                                                  } else {
                                                    Navigator.of(context)
                                                        .push(
                                                            MaterialPageRoute(
                                                      builder: (context) =>
                                                          IntegratedModelLandingPage(),
                                                    ));
                                                  }
                                                }
                                              },
                                              icon: const Icon(
                                                Icons.chevron_right_sharp,
                                                color: Colors.black,
                                              ),
                                              label: const Text(
                                                'Go',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                  
                                  // LoadImages(RMP.outDir).then(
                                  //   (value) {
                                  //     Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               DelftVisualization(
                                  //             bound1: RMP.bound1,
                                  //             bound2: RMP.bound2,
                                  //             center: RMP.center,
                                  //             zoom: RMP.zoom,
                                  //             overlayImages: value,
                                  //             length: value.length,
                                  //             url: RMP.outDir,
                                  //           ),
                                  //         ));
                                  //   },
                                  // );
                  
                                  //  _loadImagesFromDirectory('${dir.dir}\\output\\swan\\raw');
                                  // _isStarted = true;
                                },
                                label:  "Select FLOW model (DELFT)",
                                icon: Icon(
                                  Icons.water,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                                         SizedBox(
                        height:  MediaQuery.of(context).size.height * 0.07,
                      ),
                      HoverElevatedButtonIcon(
                        primaryColor: Colors.blueAccent,
                        hoverColor: Colors.black,
                        // primaryColor: Colors.blueAccent,
                        // hoverColor: Colors.black,
                        onPressed: () {
                          BC.runBC();
                        },
                        label: 'Select FLOOD model (HMS)',
                        icon: Icon(
                          Icons.animation_sharp,
                          color: Colors.white,
                        ),
                      ),
                     

                     SizedBox(
                        height:  MediaQuery.of(context).size.height * 0.07,
                      ),
                      HoverElevatedButtonIcon(
                        primaryColor: Colors.blueAccent,
                        hoverColor: Colors.black,
                        // primaryColor: Colors.blueAccent,
                        // hoverColor: Colors.black,
                        onPressed: () {
                          BC.runBC();
                        },
                        label: 'Configure API Connection',
                        icon: Icon(
                          Icons.link,
                          color: Colors.white,
                        ),
                      ),
                   
                    ],
                  ),
                ),
          Positioned(
            bottom: 20,
            right: MediaQuery.of(context).size.width * 0.01,
            child: Text(
              '© MMSU coaster ${DateTime.now().year.toString()} All rights reserved',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
