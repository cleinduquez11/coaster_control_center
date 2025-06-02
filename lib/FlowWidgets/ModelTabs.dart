import 'dart:ui';

import 'package:flutter/material.dart';

List<Widget> ModelTabs = [
  Tab(text: 'Single Event Run'),
  Tab(text: 'Multiple Events Run'),
];

class ModelTabDialog extends StatefulWidget {
  final String title;
  // final List<Widget> actions;
  final List<Widget> tabs; // List of tab widgets
  final List<Widget> contents; // List of content widgets corresponding to tabs
  // final List<Widget> actions;

  const ModelTabDialog(
      {Key? key,
      required this.title,
      required this.tabs,
      required this.contents})
      : super(key: key);

  @override
  _ModelTabDialogState createState() => _ModelTabDialogState();
}

class _ModelTabDialogState extends State<ModelTabDialog>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            color: Colors.white.withOpacity(0.1),
            // Set desired dimensions for the dialog
            // width: MediaQuery.of(context).size.width * 0.3,
            // height: MediaQuery.of(context).size.height * 0.32,
            width: 1200,
            height: 800,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 24.0, bottom: 4, left: 26),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TabBar(
                  dividerColor: Colors.white,
                  labelStyle: TextStyle(color: Colors.white54),
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  automaticIndicatorColorAdjustment: true,
                  unselectedLabelColor: Colors.white38,
                  controller: _tabController,
                  tabs: widget.tabs,
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: widget.contents,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: Stack(
                //     children:
                //     widget.actions,
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
