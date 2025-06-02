


import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FancyLoading extends StatelessWidget {
  const FancyLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      width:  MediaQuery.of(context).size.width * 0.30,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
        
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitChasingDots(
            color: Colors.deepPurple,
            size: 65,
          ),
          Text('Processing...')
        ],
      ),
    );
  }
}