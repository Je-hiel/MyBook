import 'package:flutter/material.dart';
import 'package:mybook/constants.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Return to top of list when BottomNavBarItem is double tapped.
  // TODO Try to fix bug that allows a double tap on any BottomNavBarItem to cause the current page to go to the top.
  void _onItemDoubleTapped() {
    switch (_selectedIndex) {
      case 0:
        homeController.animateTo(0,
            duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
        break;
      case 1:
        groupsController.animateTo(0,
            duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
        break;
      case 2:
        searchController.animateTo(0,
            duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
        break;
      case 3:
        messagesController.animateTo(0,
            duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: bottomNavBarPages[_selectedIndex],
        bucket: bucket,
      ),
      bottomNavigationBar: GestureDetector(
        onDoubleTap: _onItemDoubleTapped,
        child: BottomNavigationBar(
          // TODO Select color scheme.
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey[700],
          onTap: _onItemTapped,
          items: bottomNavBarItems,
          currentIndex: _selectedIndex,
        ),
      ),
    );
  }
}
