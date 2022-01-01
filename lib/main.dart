import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfirstapp/Employe_profile.dart';
import 'package:myfirstapp/client_demande.dart';
import 'package:myfirstapp/client_profile.dart';
import 'package:myfirstapp/components/image.dart';
import 'package:myfirstapp/components/products_screen.dart';
import 'package:myfirstapp/constants.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:myfirstapp/emboucher.dart';
import 'package:myfirstapp/employe_home.dart';
import 'package:myfirstapp/employe_signup.dart';
import 'package:myfirstapp/home.dart';
import 'package:myfirstapp/intro.dart';
import 'package:myfirstapp/signin.dart';
import 'package:myfirstapp/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'client_or_employe.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State {

  var  _loginuser,_loginid,_loginemail, _loginStatus=0;
   
  @override
  void initState() {
   
    getPref();
    super.initState();

  }



   getPref() async{

     SharedPreferences preferences= await SharedPreferences.getInstance();
     setState(() {
       
        //  _loginStatus=  preferences.getInt("value");
        //  _loginuser=  preferences.getString("name");
     });
        // print(preferences.getString("name"));


    
      //  preferences.remove("value");
      //  preferences.remove("name");
       
  
   }
  
  @override
  Widget build(BuildContext context) {
    setState(() {}); 
    // print("${_loginStatus} and ${_loginuser} and ${_loginid} ");

    return MaterialApp(
      title: 'HBH',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        // scaffoldBackgroundColor: Colors.red,
        primaryColor: kPrimaryColor,
        accentColor: kPrimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:ProductsScreen(),
    
      debugShowCheckedModeBanner: false,
      routes: {
        // '/signin': (BuildContext context) => new SignIn(),
        // '/signup': (BuildContext context) => new SignUp(),
        '/home': (BuildContext context) => new Home(),
        // '/product': (context) => new ProductsScreen(),
        '/employesignup':(BuildContext context) => new EmployeSignup(),
        '/employehome':(BuildContext context) => new EmployeHome(),
        '/clientoremploye':(BuildContext context) => new ClientOrEmploye(),
        '/clientprofile':(BuildContext context) => new ClientProfile(),
        '/clientdemande':(BuildContext context) => new ClientDemande(),
        '/main':(context)=>MyApp(),
      },
    );
  }

}





