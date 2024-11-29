import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorers/Screens/Matches/Matches.dart';
import 'package:scorers/Widget/BottomNav.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;


  final List<Widget> _screens = [
    Matches(),
    Matches(),
    Matches(),
    Matches(),
    Matches()
  ];

  // Handle tab change
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: _selectedIndex, onItemTapped: _onItemTapped),

    );
  }
}
