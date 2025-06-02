import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:coaster_control_center/Components/Hoverbutton.dart';
import 'package:coaster_control_center/FloodModelWidgets/FloodModelsLandingPage.dart';
import 'package:coaster_control_center/IntegratedModelWidgets/IntegratedModelLandingPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:coaster_control_center/Components/terminalDialog.dart';
import 'package:coaster_control_center/FlowWidgets/FutureWidgetsSelector.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/getModelsProvider.dart';
import 'package:coaster_control_center/FlowWidgets/ModelsDashbboard.dart';
import 'package:coaster_control_center/SSI/SSI_RUN.dart';
import 'package:coaster_control_center/VisLandingPage.dart';
import 'package:coaster_control_center/sandboxDelftVisualize.dart';
import 'package:coaster_control_center/viewMap.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late Timer _timer;
  int _currentIndex = 0;
  bool _isPlaying = true;

  List<String> _overlayImages =
      List.generate(187, (index) => 'lib/Assets/images/${index + 1}.png');

  @override
  void initState() {
    super.initState();
    _startSlideshow();
  }

  void _startSlideshow() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_isPlaying) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % _overlayImages.length;
        });
      }

      if (_currentIndex == _overlayImages.indexOf(_overlayImages.last)) {
        _stopSlideshow();
        _isPlaying = false;
      }
    });
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _stopSlideshow() {
    _timer.cancel();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final GMP = Provider.of<GetModelsProvider>(context, listen: false);
        final SSI = Provider.of<RUNSSI>(context);
    // GMP.getModels();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              center: LatLng(12.8797, 129.7740),
              zoom: 6.5,
              backgroundColor: Colors.black12,
              interactionOptions: InteractionOptions(
                flags: InteractiveFlag.none, // Disable all interactions
              ),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}.png',
                userAgentPackageName: 'com.example.app',
                subdomains: ['a', 'b', 'c'],
              ),
              OverlayImageLayer(
                overlayImages: [
                  OverlayImage(
                    bounds: LatLngBounds(

                       const LatLng(1.9569864744105252, 107.06969387974584),
                  const LatLng(28.511519508771496, 135.16198886630536),


                  //    const LatLng(1.9569864744105252, 107.06969387974584),
                  // const LatLng(28.511519508771496, 135.16198886630536),
                    ),
                    opacity: 0.75,
                    imageProvider: AssetImage(_overlayImages[_currentIndex]),
                    gaplessPlayback: true,
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.07,
            top: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'coaster',
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
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
                      'COASTER MMSU',
                      style: TextStyle(
                        fontSize: 48.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        """              Coastal Engineering\n        and Management Research \n          and Development Center""",
                        speed: const Duration(milliseconds: 100),
                      ),
                    ],
                    totalRepeatCount: 1,
                    pause: const Duration(milliseconds: 1000),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  ),
                ),
                const SizedBox(height: 200),
                HoverElevatedButtonIcon(
                       padding: EdgeInsets.fromLTRB(8,8,20,12),
                     icon: Icon(Icons.tsunami_sharp, color: Colors.white,),
                    primaryColor: Colors.blue,
                                    hoverColor: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LMap(),
                    ));
                    // Handle Simulation Area button press
                  },
                  label: 
                    'WAVES Simulation Area',
                  
                ),
                const SizedBox(height: 20),
                HoverElevatedButtonIcon(
                  padding: EdgeInsets.fromLTRB(8,8,14,8),

                  icon: Icon(Icons.water,color: Colors.white,),
                    primaryColor: Colors.blue,
                                    hoverColor: Colors.black,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const FutureWidgetSelector()

                        // FlowLandingPage()

                        ));
                    // Handle Simulation Area button press
                  },
                  label: 
                    'FLOW Simulation Area'),
         
                const SizedBox(height: 20),
                HoverElevatedButtonIcon(
                   padding: EdgeInsets.fromLTRB(8,8,14,8),

                  icon: Icon(Icons.flood_outlined, color: Colors.white,),
                    primaryColor: Colors.blue,
                                    hoverColor: Colors.black,
                  onPressed: () {
                          //  showTerminalDialog(context);
                    // SSI.runSSI();
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FloodModelLandingPage(),));
                    // Handle Visualization Area button press
                  },
                  label: 
                    'Flood Simulation Area',
                
                ),

                                const SizedBox(height: 20),
                HoverElevatedButtonIcon(
                   padding: EdgeInsets.fromLTRB(8,8,14,8),

                  icon: Icon(Icons.air_outlined, color: Colors.white,),
                    primaryColor: Colors.blue,
                                    hoverColor: Colors.black,
                  onPressed: () {
                          //  showTerminalDialog(context);
                    SSI.runSSI();
                    //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const VisLandingPage(),));
                    // Handle Visualization Area button press
                  },
                  label: 
                    'Storm Surge Analysis',
                
                ),
                                const SizedBox(height: 20),
                HoverElevatedButtonIcon(
                   padding: EdgeInsets.fromLTRB(8,8,14,8),

                  icon: Icon(Icons.settings_input_antenna_sharp, color: Colors.white,),
                    primaryColor: Colors.blue,
                                    hoverColor: Colors.black,
                  onPressed: () {
             
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const IntegratedModelLandingPage(),
                    ));
                    // Handle Visualization Area button press
                  },
                  label: 
                    'Integrated Model',
     
                ),
                const SizedBox(height: 20),
                HoverElevatedButtonIcon(
                   padding: EdgeInsets.fromLTRB(8,8,14,8),

                  icon: Icon(Icons.smart_display_outlined, color: Colors.white,),
                    primaryColor: Colors.blue,
                                    hoverColor: Colors.black,
                  onPressed: () {
             
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const VisLandingPage(),
                    ));
                    // Handle Visualization Area button press
                  },
                  label: 
                    'Visualization Area',
     
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: MediaQuery.of(context).size.width * 0.01,
            child: const Text(
              '© MMSU coaster 2024 All rights reserved',
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

class HoverButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;

  const HoverButton({Key? key, required this.child, this.onPressed})
      : super(key: key);

  @override
  _HoverButtonState createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  double _buttonHeight = 50.0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _buttonHeight = 70.0; // Increase height on hover
        });
      },
      onExit: (_) {
        setState(() {
          _buttonHeight = 50.0; // Reset height on exit
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: _buttonHeight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade900, // Dark blue
              Colors.blue.shade400, // Lighter blue
            ],
          ),
        ),
        child: TextButton(
          onPressed: widget.onPressed,
          child: widget.child,
        ),
      ),
    );
  }
}
