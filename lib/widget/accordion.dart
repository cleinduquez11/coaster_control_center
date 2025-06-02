import 'package:flutter/material.dart';

class AccordionItem {
  final Widget title;
  final Widget content;

  const AccordionItem({required this.title, required this.content});
}

class Accordion extends StatefulWidget {
  final List<AccordionItem> items;
  final bool initiallyExpanded;

  const Accordion({required this.items, this.initiallyExpanded = false});

  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
   List<bool> _isExpanded = [];

  @override
  void initState() {
    super.initState();
    _isExpanded = List.filled(widget.items.length, widget.initiallyExpanded);
  }

  void _toggleExpansion(int index) {
    setState(() {
      _isExpanded[index] = !_isExpanded[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Prevent excessive scrolling
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        return ExpansionTile(
          title: item.title,
          onExpansionChanged: (isExpanded) => _toggleExpansion(index),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: item.content,
            ),
          ],
        );
      },
    );
  }
}
