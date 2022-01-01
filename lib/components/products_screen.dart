import 'package:flutter/material.dart';
import 'package:myfirstapp/client_profile.dart';
import 'package:myfirstapp/constants.dart';
import 'package:myfirstapp/components/body.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsScreen extends StatefulWidget {
  // const ProductsScreen({ Key? key }) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String name="";
  String id="";
 
  getPref()async{


     SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
            name= preferences.getString("name");
            id=preferences.getString("id");     
      });
      print(id);
  }
  @override
  void initState() {
    getPref();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: kPrimaryColor,
      appBar: AppBar(
        title: Text("Dashbord"),
        elevation: 0,
        actions: [
          IconButton(icon:Icon(Icons.person_rounded),
           onPressed: () async {
              SharedPreferences preferences = await SharedPreferences.getInstance();
              preferences.remove("name");
              preferences.remove("id");
              preferences.commit();
            Navigator.push(
                    context,
            MaterialPageRoute(
              builder: (context) =>ClientProfile(id: id,)
              ));
           }
          )
        ],
      ),
      body:Body(),

      
    );
  }
}

