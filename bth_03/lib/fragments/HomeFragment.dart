import 'package:bth_03/screen/storeScreen.dart';
import 'package:bth_03/utils/ColorString.dart';
import 'package:flutter/material.dart';

class HomeFragment extends StatefulWidget {
  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Padding(
          padding: EdgeInsets.only(left: 250),
          child: Text(
            'Store',
            style: TextStyle(fontSize: 26),
          ),
        ),
        backgroundColor: color_primary,
        automaticallyImplyLeading: false,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.filter_alt_outlined)),
              IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.notifications_none_outlined,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      body: StoreScreen(),
    );
  }
}
