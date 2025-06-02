import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

// Terminal Provider
class TerminalProvider with ChangeNotifier {
  final StreamController<String> _outputStreamController = StreamController<String>.broadcast();
  final ScrollController scrollController = ScrollController();
  final List<String> _outputLogs = [];

  Stream<String> get outputStream => _outputStreamController.stream;

  TerminalProvider() {
    _startProcess();
  }

  void _startProcess() async {
    Process process = await Process.start('ping', ['google.com']);

    process.stdout.transform(SystemEncoding().decoder).listen((output) {
      _outputLogs.add(output);
      _outputStreamController.add(_outputLogs.join('\n')); // Send entire log for StreamBuilder
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _outputStreamController.close();
    scrollController.dispose();
    super.dispose();
  }
}

// Main App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Terminal UI")),
        body: Center(
          child: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () => showTerminalDialog(context),
                child: const Text("Open Terminal"),
              );
            }
          ),
        ),
      ),
    );
  }
}

// CMD-Style UI
void showTerminalDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return ChangeNotifierProvider(
        create: (_) => TerminalProvider(),
        child: const TerminalDialog(),
      );
    },
  );
}

class TerminalDialog extends StatelessWidget {
  const TerminalDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final terminalProvider = Provider.of<TerminalProvider>(context, listen: false);

    return Dialog(
      backgroundColor: Colors.black,
      child: Container(
        width: 600,
        height: 400,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Command Prompt",
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
