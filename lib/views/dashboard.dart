
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:statisticalcorona/provider/case_provider.dart';
import 'package:statisticalcorona/views/homescreen.dart';
import 'package:statisticalcorona/views/mapscreen.dart';
import 'package:statisticalcorona/views/newsscreen.dart';
import 'package:statisticalcorona/widget/card_detail.dart';
import 'package:statisticalcorona/widget/card_info.dart';


class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int currentIndex = 0 ;
  List<Widget> listTab = [
    HomeScreen(),
    MapScreen(),
    NewsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: listTab,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 5.0,
        unselectedItemColor: Colors.grey[500],
        selectedItemColor: Color(0xff8e61f3),
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          _buildBottomNavigationBarItem(Icons.home),
          _buildBottomNavigationBarItem(Icons.map),
          _buildBottomNavigationBarItem(Icons.receipt)
        ],
      ),
    );
  }
}
_buildBottomNavigationBarItem(IconData iconData){
  return BottomNavigationBarItem(
    icon: Icon(iconData),
    title: Text("")
  );
}