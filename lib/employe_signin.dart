import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:myfirstapp/constants.dart';
import 'package:myfirstapp/employe_signup.dart';
import 'package:myfirstapp/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';


class EmployeSignIn extends StatefulWidget {
  // const EmployeSignIn({ Key? key }) : super(key: key);

  @override
  _EmployeSignInState createState() => _EmployeSignInState();
}

class _EmployeSignInState extends State<EmployeSignIn> {

 final _formKey = GlobalKey();
  bool isLoading=false;
  TextEditingController _nameController=new TextEditingController();
  TextEditingController _numeroController=new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign In Employe",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: 27,
                            color: Colors.black,
                            letterSpacing: 1)),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                   SvgPicture.asset("images/asset/login1.svg",
                            height: MediaQuery.of(context).size.height * 0.33,
                            alignment: Alignment.center),
                  SizedBox(
                    height: 20,
                  ), 
                  Form(
                    key: _formKey,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                      child: Column(
                        children: [
                          TextFormField(
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            controller: _nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderSide: BorderSide()),
                              // enabledBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue)),
                              // focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue[900])),
                              hintText: "Nom",
                              hintStyle: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            // onSaved: (val) {
                            //   email = val;
                            // },
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            controller: _numeroController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderSide: BorderSide()),
                              // enabledBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue)),
                              // focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue[900])),
                              hintText: "Numero",
                              hintStyle: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            // onSaved: (val) {
                            //   email = val;
                            // },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if(isLoading)
                                    {
                                      return;
                                    }
                                  if(_nameController.text.isEmpty||_numeroController.text.isEmpty)
                                  {
                                    _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("Please Fill all fileds")));
                                    return;
                                  }
                                  
                                  loginEmploye(_nameController.text,_numeroController.text);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 0),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.lightBlue[900]),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    "SUBMIT",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            letterSpacing: 1)),
                                  ),
                                ),
                              ),
                              Positioned(child: (isLoading)?Center(child: Container(height:26,width: 26,child: CircularProgressIndicator(backgroundColor: Colors.green,))):Container(),right: 30,bottom: 0,top: 0,)

                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "OR",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                 
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => EmployeSignup()));
                    },
                    child: Text(
                      "Don't have an account?",
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              decoration: TextDecoration.underline,
                              letterSpacing: 0.5)),
                    ),
                  )
                ],
              ),
            ),
         
      ),
    ));
  }

   loginEmploye(nom,numero) async
  {

    var url = "http://192.168.43.244/werikhedmtk/loginEmploye.php";
     var data = new Map<String, dynamic>();
                  data['nom'] = nom;
                  data['numero'] = numero;
    print(data.toString());


    var response= await http.post(url, body: data,);
    if (response.statusCode == 200) {

      

      var resposne=convert.jsonDecode(response.body);

      if(resposne['status']=="success")
        {
          savePref(resposne['nom'],resposne['id']);
          Navigator.of(context).pushReplacementNamed("/employehome");
        }
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("Please Try again")));
    }


  }
  savePref(String name, String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
          // preferences.setInt("value", value);
          preferences.setString("name", name);
          // preferences.setString("email", email);
          preferences.setString("id", id);   
      });

  }
}