import 'package:flutter/material.dart';

class ResizableSearch extends StatefulWidget {
  final double initialWidth;
  final double initialHeight;
  final TextEditingController controller;

  // Constructor to accept initial width, height, and controller
  ResizableSearch({
    Key? key,
    required this.controller,
    this.initialWidth = 120,
    this.initialHeight = 30,
  }) : super(key: key);

  @override
  _ResizableSearchState createState() => _ResizableSearchState();
}

class _ResizableSearchState extends State<ResizableSearch> {
  late double _width;
  late double _height;

  @override
  void initState() {
    super.initState();
    // Initialize width and height with the passed parameters
    _width = widget.initialWidth;
    _height = widget.initialHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Center( // Center the search widget within its parent
      child: Container(
        width: _width,
        height: _height,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent,
          border: Border.all(color: Colors.grey),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: TextField(
            controller: widget.controller, // Attach the controller
            decoration: InputDecoration(
              hintText: "Search...",
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search), // Changed 'prefix' to 'prefixIcon'
            ),
            // style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

