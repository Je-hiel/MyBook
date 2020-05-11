import 'package:flutter/material.dart';
import 'package:mybook/constants.dart';
import 'package:mybook/models/user.dart';
import 'package:mybook/services/auth_service.dart';
import 'package:mybook/services/http_service.dart';
import 'package:provider/provider.dart';
import 'main_drawer.dart';

// The main pages of the app are children of this widget. This bottom nav bar
// preserves the scrolling position of the user on each page.
class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<
      ScaffoldState>(); // Used to open the drawer from other widgets in the tree.
  HttpService _hs = HttpService();
  AuthService _auth = AuthService();
  User _user;
  int _selectedIndex = 0; // Defaults to homepage.

  // Sets the selected index to the index of the page to be displayed.
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

  // Loads the user from the user id stored on the device.
  void loadUser() async {
    _user = await _hs.getUser(_auth.getUID());
  }

  // Ensures that loadUser is called and completed before the widget is built.
  @override
  void initState() {
    loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<User>(
            create: (_) =>
                _user), // Provides the signed in user to widgets in the tree.
        Provider<GlobalKey<ScaffoldState>>(
            create: (_) =>
                scaffoldKey), // Provides the scaffold key to widgets in the tree.
      ],
      child: Scaffold(
        key: scaffoldKey,
        drawer: MainDrawer(),
        body: PageStorage(
          // Stores the scroll position on each page.
          child: bottomNavBarPages[_selectedIndex],
          bucket: bucket,
        ),
        bottomNavigationBar: GestureDetector(
          onDoubleTap: _onItemDoubleTapped,
          child: BottomNavigationBar(
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey[700],
            onTap: _onItemTapped,
            items: bottomNavBarItems,
            currentIndex: _selectedIndex,
          ),
        ),
      ),
    );
  }
}
