import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tancang/fragment/DanhMucFragment.dart';
import 'package:tancang/fragment/RFHomeFragment.dart';
import 'package:tancang/utils/RFColors.dart';
import 'package:ionicons/ionicons.dart';


class RFHomeScreen extends StatefulWidget {
  static const routeName = '/home';
  int selectedIndex = 0;
  int selectedTabDonHang = 0;

  late bool showDialog = false;
  String contentAlert = '';
  Timer? timer;

  RFHomeScreen({this.selectedIndex = 0});

  @override
  _RFHomeScreenState createState() => _RFHomeScreenState();
}

class _RFHomeScreenState extends State<RFHomeScreen> {
  var _pages = [
    RFHomeFragment(),
    DanhMucFragment(),
    RFHomeFragment(),
  ];
//
//
  Widget _bottomTab() {
    return BottomNavigationBar(
      currentIndex: widget.selectedIndex,
      onTap: _onItemTapped,
      selectedLabelStyle: boldTextStyle(size: 12),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      selectedItemColor: rf_textColor,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Ionicons.dice_outline, size: 22,),
          label: 'Tác nghiệp',
          activeIcon: Icon(Ionicons.dice, color: rf_textColor, size: 22),
        ),
        BottomNavigationBarItem(
          icon: Icon(Ionicons.albums_outline, size: 22), //rf_search.iconImage(),
          label: 'Danh mục',
          activeIcon: Icon(Ionicons.albums, color: rf_textColor, size: 22,)// rf_search.iconImage(iconColor: rf_textColor),
        ),
        BottomNavigationBarItem(
            icon: Icon(Ionicons.person_outline, size: 22), //rf_search.iconImage(),
            label: 'Tài khoản',
            activeIcon: Icon(Ionicons.person, color: rf_textColor, size: 22,)// rf_search.iconImage(iconColor: rf_textColor),
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
    setStatusBarColor(rf_textColor, statusBarIconBrightness: Brightness.light);
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
