import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:myfirstapp/components/products_screen.dart';
import 'package:myfirstapp/constants.dart';
import 'package:myfirstapp/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State {
  var resposne;
  final _formKey = GlobalKey();
  String email, password;
  bool isLoading=false;
  TextEditingController _emailController=new TextEditingController();
  TextEditingController _passwordController=new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  
  // getPref() async{

  //    SharedPreferences preferences = await SharedPreferences.getInstance();
  //     // preferences.getInt('value');
  //     preferences.getString("name");
  //     // preferences.getString("email");
  //     preferences.getString("id");

  //     // if(preferences.getInt('value')!=0 && preferences.getString("name")!=null && preferences.getString("email")!=null && preferences.getString("id")!=null){
  //     //   Navigator.pushReplacementNamed(context, "/product");
  //     // }

  // }
  @override
  void initState(){
    //  getPref();   
    super.initState();
  }


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
                    "Sign In",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: 27,
                            color: Colors.black,
                            letterSpacing: 1)),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                   SvgPicture.asset("images/asset/login.svg",
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
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderSide: BorderSide()),
                              // enabledBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue)),
                              // focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue[900])),
                              hintText: "Nom",
                              hintStyle: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            onSaved: (val) {
                              email = val;
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            controller: _passwordController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderSide: BorderSide()),
                              // enabledBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue)),
                              // focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlue[900])),
                              hintText: "Numero",
                              hintStyle: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            onSaved: (val) {
                              email = val;
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Stack(
                            children: [
                              RaisedButton(
                                onPressed: () {
                                  if(isLoading)
                                    {
                                      return null;
                                    }
                                  if(_emailController.text.isEmpty||_passwordController.text.isEmpty)
                                  {
                                    _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("Please Fill all fileds")));
                                    return null;
                                  }
                                  
                                  login(_emailController.text,_passwordController.text);
                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return 
                                                      
                                                          AlertDialog(
                                                  // title: Text('Faild Please try again',style: TextStyle(fontSize: 18),),
                                                  content: Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets.only(right: 10),
                                                          child: CircularProgressIndicator()),
                                                         Container(child: Text('Loading ...')),
                                                      ],
                                                    ),
                                                    // height: MediaQuery.of(context).size.height/2.5,
                                                
                                                  ),
                                                  // actions: <Widget>[
                                                  //   new FlatButton(
                                                  //     onPressed: () {
                                                  //       Navigator.of(context, rootNavigator: true)
                                                  //           .pop(false); // dismisses only the dialog and returns false
                                                  //     },
                                                  //     child: Text('No'),
                                                  //   ),
                                                  //   FlatButton(
                                                  //     onPressed: () {
                                                  //       Navigator.of(context, rootNavigator: true)
                                                  //           .pop(true); // dismisses only the dialog and returns true
                                                  //     },
                                                  //     child: Text(''),
                                                  //   ),
                                                  // ],
                                      );
                                    },
                                  );
                                  // Navigator.pushReplacementNamed(context, "/product");
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
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUp()));
               
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

  login(nom,numero) async
  {

    var url = "http://192.168.43.244/werikhedmtk/login.php";
     var data = new Map<String, dynamic>();
                  data['nom'] = nom;
                  data['numero'] = numero;
    print(data.toString());


    var response= await http.post(url, body: data,);
    if (response.statusCode == 200) {

      

     resposne=convert.jsonDecode(response.body);

      if(resposne['status']=="success")
        {
          savePref(resposne['nom'],resposne['id']);
          Navigator.of(context).pop();
          // Navigator.pushReplacementNamed(context, '/product');
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>ProductsScreen()));
        }

      else{

            Navigator.of(context).pop();
             return showDialog(
                      context: context,
                      builder: (context) {
                        return 
                      
                           AlertDialog(
                              // title: Text('Faild Please try again',style: TextStyle(fontSize: 18),),
                              content: Container(
                                // height: MediaQuery.of(context).size.height/2.5,
                                  child: Text('fail please try again '),
                              ),
                              // actions: <Widget>[
                              //   new FlatButton(
                              //     onPressed: () {
                              //       Navigator.of(context, rootNavigator: true)
                              //           .pop(false); // dismisses only the dialog and returns false
                              //     },
                              //     child: Text('No'),
                              //   ),
                              //   FlatButton(
                              //     onPressed: () {
                              //       Navigator.of(context, rootNavigator: true)
                              //           .pop(true); // dismisses only the dialog and returns true
                              //     },
                              //     child: Text(''),
                              //   ),
                              // ],
                   );
                },
              );
      }
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("Please Try again")));
    }


  }
  savePref(String name, String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
          preferences.setString("name", name);
          preferences.setString("id", id);  
      });

  }
}