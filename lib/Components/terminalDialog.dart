// CMD-Style UI

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coaster_control_center/FlowWidgets/ModelProviders/RunModelProvider.dart';



void showTerminalDialog(BuildContext context, String processName) {
  showDialog(
    context: context,
    builder: (context) {
      return TerminalDialog(processName: processName,);
    },
  );
}

class TerminalDialog extends StatelessWidget {
  final String processName;
  const TerminalDialog({super.key, required this.processName});

  @override
  Widget build(BuildContext context) {
    final terminalProvider = Provider.of<RunModelProvider>(context, listen: false);

    return Dialog(
      backgroundColor: Colors.black,
      child: Container( 
        width: 1200,
        height: 600,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
            processName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(color: Colors.white24),
            Expanded(
              child: StreamBuilder<String>(
                stream: terminalProvider.outputStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.greenAccent),
                    );
                  }

                  List<String> outputLines = snapshot.data!.split('\n');

                  return ListView.builder(
                    controller: terminalProvider.scrollController,
                    itemCount: outputLines.length,
                    itemBuilder: (context, index) {
                      return Text(
                        outputLines[index],
                        style: const TextStyle(
                          fontFamily: 'Courier New',
                          color: Colors.greenAccent,
                          fontSize: 14,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const Divider(color: Colors.white24),
          ],
        ),
      ),
    );
  }
}
