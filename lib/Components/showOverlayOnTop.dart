

import 'package:flutter/material.dart';

// void showTopSnackBar(BuildContext context, String message, Color color) {
//   final overlay = Overlay.of(context);
//   final overlayEntry = OverlayEntry(
//     builder: (context) => Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Stack(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.40,right:  MediaQuery.of(context).size.width *0.40,top: 40),
//             child: Positioned(
//               top: 20, // Adjust this for positioning
//               left: 16,
//               right: 16,
//               child: Material(
                
//                 color: Colors.transparent,
//                 child: Container(
//                   padding: EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: color, // Background color
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(Icons.check_circle, color: Colors.white),
//                       SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           message,
//                           style: TextStyle(color: Colors.white, fontSize: 16),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );

//   overlay.insert(overlayEntry);

//   // Remove after a delay
//   Future.delayed(Duration(seconds: 3), () {
//     overlayEntry.remove();
//   });
// }


// void showTopSnackBar(BuildContext context, String message, Color color) {
//   final overlay = Overlay.of(context);
//   final overlayEntry = OverlayEntry(
//     builder: (context) => Positioned(
//       top: MediaQuery.of(context).size.width * 0.5, // Position near the top
//       left: MediaQuery.of(context).size.width * 0.4, // Centered horizontally
//       right: MediaQuery.of(context).size.width * 0.4,
//       child: Material(
//         color: Colors.transparent,
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//           decoration: BoxDecoration(
//             color: color,  // Background color
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
//           ),
//           child: Center(
//             child: Text(
//               message,
//               style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//       ),
//     ),
//   );

//   // Insert the overlay entry
//   overlay.insert(overlayEntry);

//   // Remove the overlay after 3 seconds
//   Future.delayed(Duration(seconds: 3), () {
//     overlayEntry.remove();
//   });
// }



// import 'package:flutter/material.dart';

void showTopSnackBar(BuildContext context, String message, Color color) {
  final overlay = Overlay.of(context);
  final animationController = AnimationController(
    vsync: Navigator.of(context),
    duration: Duration(milliseconds: 500),
  );

  final animation = Tween<Offset>(
    begin: Offset(0, -1), // Start off-screen
    end: Offset(0, 0), // Slide to normal position
  ).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));

  final opacityAnimation = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(animationController);

  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 120, // Adjust top position
      left: MediaQuery.of(context).size.width * 0.4,
      right: MediaQuery.of(context).size.width * 0.4,
      child: Material(
        color: Colors.transparent,
        child: SlideTransition(
          position: animation,
          child: FadeTransition(
            opacity: opacityAnimation,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: color, // Background color
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
              ),
              child: Center(
                child: Text(
                  message,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);
  animationController.forward(); // Start animation

  // Remove the overlay after 3 seconds
  Future.delayed(Duration(seconds: 3), () async {
    await animationController.reverse(); // Animate out
    overlayEntry.remove();
  });
}

