import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myfirstapp/components/products_screen.dart';
import 'package:myfirstapp/constants.dart';
import 'package:myfirstapp/employe_signup.dart';
import 'package:myfirstapp/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State {
   final _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
   String _selectedRegion="Adrar";
   String _selectedcategorie;
   String _selectedSecond;
   List<Willaya> _listWillaya=[];
   List<Commune> _list=[];
   String name,number;



  TextEditingController _nameController=new TextEditingController();
  TextEditingController _numberController=new TextEditingController();



  
   @override
  void initState()  {
   
    setState(() { 

       getListAPW();
         getList(_selectedRegion);
    });
  }

   getListAPW() async {
            //192.168.43.244
            // 192.168.1.39
            var url = "http://192.168.43.244//werikhedmtk/wilaya_comune.php";
            var response = await http.get(url);
  
      
            var result = convert.jsonDecode(response.body) ;
            //Serialisable from json to model
            _listWillaya = List<Willaya>.from(
              result.map((i){
                  return Willaya.fromJSON(i);
              })
            );
            
            print(_listWillaya);
           
            getList(_selectedRegion);

  
          setState(() {}); 
          setState(() {}); 
   }
   getList(String com) async {

          //  setState(() { });

            var url = "http://192.168.43.244//werikhedmtk/commune.php";
            var data = new Map<String,dynamic>();
            // if(_selectedRegion != null){
            data['willaya']=com;
            
                var response = await http.post(url,body:data);
                // if (response.statusCode == 200) {
                  var result = convert.jsonDecode(response.body) ;
                  //Serialisable from json to model
                  _list = List<Commune>.from(
                    result.map((i){
                              return Commune.fromJSON(i);
                    })
                  );
                // }
            // }      
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
       body: SingleChildScrollView(
      child: SafeArea(
         child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(left: kDefaultPadding,right: kDefaultPadding),
           child:
              Container(
                //color: Colors.amber,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                   Text(
                       "Sign Up",
                        style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: 27,
                            color: Colors.black,
                            letterSpacing: 1)),
                    ),

                    SizedBox(height: 40,),
                                Form(
                                  key: _formKey,
                                  child: 
                                      Column(
                                        children: [
                                   TextFormField(
                                      controller: _nameController,
                                      onSaved: (val){
                                        name=val;
                                      },
                                      decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.person_outlined,color: Colors.blue,),
                                      labelText: "Name",
                                      border:OutlineInputBorder(
                                        borderSide: BorderSide(color:Colors.blueGrey),
                                      ), 
                                  ),
                                ),
                                 SizedBox(height: 20,),   
                                TextFormField(
                                  controller: _numberController,
                                  onSaved: (val){
                                    number=val;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.smartphone_outlined,color: Colors.blue,),
                                      labelText: "Number",
                                      border:OutlineInputBorder(
                                        borderSide: BorderSide(color:Colors.blueGrey),
                                      ), 
                                  ),
                                ),
                                SizedBox(height: 20,),
                               
                                 DropdownButtonFormField(
                                        value: _selectedRegion,
                                        items:_listWillaya
                                            .map(( region) => DropdownMenuItem<String>(
                                                child: Text(region.nom), value: region.nom))
                                            .toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            _selectedRegion = newValue;
                                            _selectedSecond=null;
                                            getListAPW();
                                           getList(_selectedRegion);
                                          });
                                        },
                                        decoration: InputDecoration(
                                        
                                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                                          filled: true,
                                          fillColor: Colors.grey[200],
                                          labelText: "Willaya",
                                          enabledBorder: OutlineInputBorder(
                                             borderSide: BorderSide(color:Colors.blueGrey),
                                          )
                                          ),
                                        
                                      ),
                                
                                SizedBox(height: 20,),
                                _addSecondDropdown(),
                                SizedBox(height: 30,),

                                  GestureDetector(
                                      onTap: (){
                                        
                                              if(_nameController.text.isEmpty)
                                              {
                                                _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("Please Enter Name")));
                                                return;
                                              }
                                              // if(!reg.hasMatch(_emailController.text))
                                              // {
                                              //   _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("Enter Valid Email")));
                                              //   return;
                                              // }
                                              if(_numberController.text.length<10 || _numberController.text.isEmpty)
                                              {
                                                _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("Please Enter Valid Number")));
                                                return;
                                              }
                                              if(_selectedRegion.isEmpty){
                                                 _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("Please Enter la willaya")));
                                                return;
                                              }
                                              if(_selectedSecond.isEmpty){
                                                 _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("Please Enter la commune")));
                                                return;
                                              }
                                             
                                             signup(_nameController.text,_numberController.text,_selectedRegion,_selectedSecond);

                                      },
                                     child: Container(
                                       alignment: Alignment.center,
                                       width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.blue[900],
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Text("CREATE ACCOUNT",style: TextStyle(color: Colors.white),),
                                      ),
                                    ),

                                      ],)
                                  ),
                                  SizedBox(height: 30,),

                    GestureDetector(
                      onTap: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>SignIn()));
                       
                      },
                      child: Text(
                        "Already have an account?",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                decoration: TextDecoration.underline,
                                letterSpacing: 0.5)),
                      ),
                    )
                  ],
                ),
              ),
        ),
      ),
    ));

  } 
 Widget _addSecondDropdown() {
   setState(() {}); 
    return _selectedRegion != null
        ? Container(
          // margin: EdgeInsets.only(top:kDefaultPadding/2),
         
                  child: DropdownButtonFormField(
                    value: _selectedSecond,
                    items: _list
                        .map((region) => DropdownMenuItem<String>(
                            child: Text(region.nom_com), value: region.nom_com))
                        .toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedSecond = newValue;
                      });
                    },
                    decoration: InputDecoration(
                       contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                                          filled: true,
                                          fillColor: Colors.grey[200],
                                          labelText: "Commune",
                                           enabledBorder: OutlineInputBorder(
                                           borderSide: BorderSide(color:Colors.blueGrey),
                                        )
                     
                    ),),
        )
        : Container(); // Return an empty Container instead.
  }

  signup(name,number,willaya,commune) async
  {
    // setState(() {
    //   isLoading=true;

    // });
    print("Calling");
    var url = "http://192.168.43.244//werikhedmtk/signup.php";
    var data = new Map<String, dynamic>();
                  data['nom'] = name;
                  data['number'] =number;
                  data['willaya'] = willaya;
                  data['commune'] = commune;
    print(data.toString());

    var response= await http.post(url, body: data,);
    if (response.statusCode == 200) {

      // setState(() {
      //   isLoading=false;
      // });
      var resposne= convert.jsonDecode(response.body) ;
      if(resposne['status']=="1")
        {
          // print(" User name ${resposne['name']} and email ${resposne['email']} and id  ${resposne['id']} ");
          savePref(resposne['name'],resposne['id'],resposne['image']);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>ProductsScreen()));
        }
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("Please Try again")));
    }
     

  }

  savePref(String name, String id,String image) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
      preferences.setString("name", name);
      preferences.setString("id", id);
      preferences.setString("image", image);
        
      });

  }
}