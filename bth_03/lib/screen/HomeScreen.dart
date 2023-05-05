import 'package:bth_03/fragments/FavoritesFragment.dart';
import 'package:bth_03/fragments/HomeFragment.dart';
import 'package:bth_03/fragments/MoreFragment.dart';
import 'package:bth_03/fragments/MyCartFragment.dart';
import 'package:bth_03/fragments/ProfileFragment.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  int selectedIndex = 0;

  late bool showDialog = false;
  String contentAlert = '';

  HomeScreen({this.selectedIndex = 0});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var _pages = [
    HomeFragment(),
    MyCartFragment(),
    FavouritesFragment(),
    ProfileFragment(),
    MoreFragment(),
  ];
   Color rf_textColor = Color(0xFF00ab66);

  Widget _bottomTab() {
    return BottomNavigationBar(
      currentIndex: widget.selectedIndex,
      onTap: _onItemTapped,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      selectedItemColor: rf_textColor,
      type: BottomNavigationBarType.fixed,
      items:  <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.store_outlined, size: 22,),
          label: 'Store',
          activeIcon: Icon(Icons.store, color: rf_textColor, size: 22),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined, size: 22), //rf_search.iconImage(),
          label: 'My Cart',
          activeIcon: Icon(Icons.shopping_bag, color: rf_textColor, size: 22,)// rf_search.iconImage(iconColor: rf_textColor),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline, size: 22), //rf_search.iconImage(),
            label: 'Favoutites',
            activeIcon: Icon(Icons.favorite, color: rf_textColor, size: 22,)// rf_search.iconImage(iconColor: rf_textColor),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 22), //rf_search.iconImage(),
            label: 'Profile',
            activeIcon: Icon(Icons.person, color: rf_textColor, size: 22,)// rf_search.iconImage(iconColor: rf_textColor),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz_rounded, size: 22), //rf_search.iconImage(),
            label: 'More',
            activeIcon: Icon(Icons.more_horiz, color: rf_textColor, size: 22,)// rf_search.iconImage(iconColor: rf_textColor),
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  @override
  void initState() {

    super.initState();
    init();
  }

  void init() async {
    // setStatusBarColor(rf_textColor, statusBarIconBrightness: Brightness.light);

  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      bottomNavigationBar: _bottomTab(),
      body: Center(child: _pages.elementAt(widget.selectedIndex)),
    );
  }
}