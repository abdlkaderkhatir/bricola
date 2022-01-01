import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myfirstapp/constants.dart';
import 'package:myfirstapp/employe_home.dart';
import 'package:myfirstapp/home.dart';

import 'components/products_screen.dart';
class Intro extends StatefulWidget {
 
  @override
  _IntroState createState() => _IntroState();
}


 

class _IntroState extends State<Intro> {
  
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 6);
    return new Timer(duration, () {
    // Navigator.pushReplacement(context, MaterialPageRoute( builder: (context) => ProductsScreen()));
    Navigator.pushReplacement(context, MaterialPageRoute( builder: (context) => Home()));  
  });   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color:kPrimaryColor ,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Image.asset("images/asset/logo1.png",height: 100,width: 250,fit: BoxFit.cover,),
          ],
        ),
      ),
    );
  }
}