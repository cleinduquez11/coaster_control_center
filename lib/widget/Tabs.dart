
import 'package:flutter/material.dart';



List<Widget> myTabs = [
  Tab(text: 'Create Base Map'),
  Tab(text: 'Import Base Map'),
];

List<Widget> myContents = [
  // Content for Tab 1 (e.g., Text, Form, etc.)
  Text('Content of Tab 1'),
  // Content for Tab 2 (e.g., Text, Form, etc.)
  Text('Content of Tab 2'),
];





List<Widget> baseMapTabWidgets = [
  // Content for Tab 1 (e.g., Text, Form, etc.)
  Text('Content of Tab 1'),
  // Content for Tab 2 (e.g., Text, Form, etc.)
  Text('Content of Tab 2'),
];



class TabDialog extends StatefulWidget {
  final String title;
  // final List<Widget> actions;
  final List<Widget> tabs; // List of tab widgets
  final List<Widget> contents; // List of content widgets corresponding to tabs

  const TabDialog({Key? key, required this.title, required this.tabs, required this.contents}) : super(key: key);

  @override
  _TabDialogState createState() => _TabDialogState();
}

class _TabDialogState extends State<TabDialog> with SingleTickerProviderStateMixin {
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
      child: Container(
        // Set desired dimensions for the dialog
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.height * 0.32,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Text(widget.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700
              ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            TabBar(
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
            // Stack(
            //   children: 
            //   widget.actions,
            // )
          ],
        ),
      ),
    );
  }
}
