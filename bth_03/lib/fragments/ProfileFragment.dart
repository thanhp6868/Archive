import 'package:flutter/material.dart';

import '../utils/ColorString.dart';

class ProfileFragment extends StatefulWidget {

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: Padding(
            padding: EdgeInsets.only(left: 250),
            child: Text(
              'Profile',
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
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 20, bottom: 30),
          child: Stack(
            
            children: [
              Container(
                
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text("Test"),
                       
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}