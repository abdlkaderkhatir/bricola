import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:myfirstapp/Employe_comment.dart';
import 'package:myfirstapp/Employe_profile.dart';
import 'package:myfirstapp/Employe_demand.dart';
import 'package:myfirstapp/components/nav_bar.dart';

class EmployeHome extends StatefulWidget {
  @override
  _EmployeHomeState createState() => _EmployeHomeState();
}

class _EmployeHomeState extends State<EmployeHome> {
  int _currentIndexs= 1;
  final screen=[EmployeComment(),EmployeDemand(),EmployeProfile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:CurvedNavigationBar(
          key:NavbarKey.getKey() ,
          index: _currentIndexs,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.list, size: 30),
            Icon(Icons.compare_arrows, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _currentIndexs = index;
            });
          },
        ),
      body:screen[_currentIndexs] ,
      
    );
  }
}