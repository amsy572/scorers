import 'package:flutter/material.dart';

// Custom widget for each Champion
class ChampionItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double initialWidth;
  final double initialHeight;

  // Constructor to accept the image URL and name
  ChampionItem({
    required this.imageUrl,
    required this.name,
    this.initialWidth = 35.0, // Default width
    this.initialHeight = 35.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Circular image
        Container(
          width: initialWidth,  // Width of the circle
          height: initialHeight,
          padding: EdgeInsets.all(8),// Height of the circle
          decoration: BoxDecoration(
            color: Color(0xFF1D1D1D),
            shape: BoxShape.circle,
          ),
          child: Center(child: Image.asset(imageUrl),),
        ),
        SizedBox(height: 8.0), // Space between image and text
        // Text underneath the image
        Text(
          name,
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold,color: Colors.white70),
        ),
      ],
    );
  }
}
