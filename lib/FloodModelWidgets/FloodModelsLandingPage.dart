import 'dart:io';
import 'package:coaster_control_center/FloodModelWidgets/FloodModelProviders/AddFloodModelProvider.dart';
import 'package:coaster_control_center/FlowWidgets/DelftVisualize.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/postProcessingProvider.dart';
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

class FloodModelLandingPage extends StatefulWidget {
  const FloodModelLandingPage({super.key});

  @override
  State<FloodModelLandingPage> createState() => _FloodModelLandingPageState();
}

class _FloodModelLandingPageState extends State<FloodModelLandingPage>
    with TickerProviderStateMixin {
  late final MapController _mapController;
  late final AnimationController controller;
  // late final List<Map<String, dynamic>> models;

  late Future<List<Map<String, dynamic>>> getFloodModels;

  late List<Map<String, dynamic>> models;
  // late final List<Map<String, dynamic>> modelLists;
  File? _currentImageFile;
  LatLngBounds? _currentImageBounds;
  int indx = -999;
  Map<String, dynamic> mods = {};
  String? selectedModelName;

  @override
  void initState() {
        final AMP = Provider.of<AddFloodModelProvider>(context,listen: false);
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _mapController = MapController();
    getFloodModels = AMP.getModelsJson();
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
    final AMP = Provider.of<AddFloodModelProvider>(context);
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
                        'FLOOD MODELS',
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
          Positioned(
            left: 20,
            bottom: 50,
            right: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16), // Spacing
                RMP.loading != "loading"
                    ? FutureBuilder<List<Map<String, dynamic>>>(
                        future: getFloodModels, // Your async function
                        builder: (context, snapshot) {
                          print(snapshot.data);
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Container();
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 50.0),
                              child: Text(
                                'No models available',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          } else {
                            models = snapshot.data!;

                            return StatefulBuilder(
                              builder: (context, setState) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 4.0),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                              color: Colors.white, width: 1),
                                        ),
                                        child: DropdownButton<String>(
                                          hint: selectedModelName == null
                                              ? Text('Select a model',
                                                  style: TextStyle(
                                                      color: Colors.white))
                                              : Text(
                                                  'Selected Model: $selectedModelName',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                          value: selectedModelName,
                                          dropdownColor: Colors.black,
                                          icon: const Icon(Icons.arrow_drop_up,
                                              color: Colors.white),
                                          isExpanded: false,
                                          underline: SizedBox.shrink(),
                                          items: models.map((model) {
                                            final modelName = model['name'];
                                            return DropdownMenuItem<String>(
                                              value: modelName,
                                              child: Text(modelName,
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            );
                                          }).toList(),
                                          onChanged: (selectedName) {
                              
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        },
                      )
                    : Container(),
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
                  bottom: 50,
                  right: 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16), // Ad
                      Row(
                        // mainAxisAlignment: MainAxisAlignment,  // Change as per need
                        children: [
                          CMP.indx != -999 && RMP.loading != "loading"
                              ? Center(
                                  child: HoverElevatedButtonIcon(
                                    primaryColor: Colors.lightGreen,
                                    hoverColor: Colors.black,
                                    onPressed: () {
                                      ModelConfigDialog(
                                          context, CMP.mods["name"]);
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
                            width: 20,
                          ),

                          FMF.isSaved &&
                                  FMF.runMode == 1 &&
                                  RMP.loading == "init"
                              ?
                              // mainAxisAlignment: MainAxisAlignment,  // Change as per need

                              Center(
                                  child: HoverElevatedButtonIcon(
                                    primaryColor: Colors.lightGreen,
                                    hoverColor: Colors.black,
                                    onPressed: () {
                                      RMP.runDelftModel(CMP.mods["name"]);
                
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
                            width: 20,
                          ),
                          RMP.loading != "loading"
                              ? Center(
                                  child: HoverElevatedButtonIcon(
                                    primaryColor: Colors.lightGreen,
                                    hoverColor: Colors.black,
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
                                                'Add HMS Model',
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

                                                      AMP.getModelJson();

                                                      AMP.runAddModelPy(
                                                          AMP.model_name);

                                                      if (AMP.loading ==
                                                          "loading") {
                                                        Navigator.of(context)
                                                            .push(
                                                                MaterialPageRoute(
                                                          builder: (context) =>
                                                              FloodModelLandingPage(),
                                                        ));
                                                      } else {
                                                        Navigator.of(context)
                                                            .push(
                                                                MaterialPageRoute(
                                                          builder: (context) =>
                                                              FloodModelLandingPage(),
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
                                    label: 'Add Model',
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : Container(),
                         
                        ],
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
