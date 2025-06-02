
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';


Future<void> showGlassContainer(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
     return AlertDialog(
      clipBehavior: Clip.hardEdge,
      backgroundColor: Colors.transparent,
       content: GlassmorphicContainer(
         width:200,
         height: 200,
         borderRadius: 0,
         blur: 20,
         alignment: Alignment.center,
         border: 1,
         linearGradient: LinearGradient(
           begin: Alignment.topLeft,
           end: Alignment.bottomRight,
           colors: [
             Color(0xFFffffff).withOpacity(0.1),
             Color(0xFFffffff).withOpacity(0.05),
           ],
         ),
         borderGradient: LinearGradient(
           begin: Alignment.topLeft,
           end: Alignment.bottomRight,
           colors: [
             Color(0xFFffffff).withOpacity(0.5),
             Color((0xFFffffff)).withOpacity(0.5),
           ],
         ),
         child: Text(
         'Hi',
       
         )
       ),
     );
    },
  );
}
