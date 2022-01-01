import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:myfirstapp/components/body.dart';
import 'package:myfirstapp/constants.dart';
import 'package:myfirstapp/employe_signin.dart';
import 'package:shared_preferences/shared_preferences.dart';


class EmployeSignup extends StatefulWidget {
  @override
  _EmployeSignupState createState() => _EmployeSignupState();
}

class _EmployeSignupState extends State<EmployeSignup> {

  final _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
   String _selectedRegion="Adrar";
   String _selectedcategorie;
   String _selectedSecond;
   List<Willaya> _listWillaya=[];
   List<Commune> _list=[];
   List<Categorie>  _listjob=[];
   String name,number;


  TextEditingController _nameController=new TextEditingController();
  TextEditingController _numberController=new TextEditingController();

   @override
  void initState()  {
   
    setState(() { 
    getListAPW();
    getJobList();
    getList(_selectedRegion);
    });
  }

   getListAPW() async {
            // setState(() async{
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

            // });
          
            setState(() {});
            setState(() {});

   }
   getList(String com) async {

           setState(() {  });

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
   getJobList() async {

           setState(() { });

            var url = "http://192.168.43.244//werikhedmtk/categorie.php";
           
            
                var response = await http.get(url,);
                // if (response.statusCode == 200) {
                  var result = convert.jsonDecode(response.body) ;
                  //Serialisable from json to model
                  _listjob = List<Categorie>.from(
                    result.map((i){
                              return Categorie.fromJSON(i);
                    })
                  );
                // }
            // }      
   }

   employeSignup(String nom,String number,String willaya,String commune,String job) async {

    var url = "http://192.168.43.244//werikhedmtk/list_employe.php";
    var data = new Map<String, dynamic>();
                  data['nom'] = nom;
                  data['number'] = number;
                  data['willaya'] = willaya;
                  data['commune'] = commune;
                  data['job'] = job;
    print(data.toString());

    var response= await http.post(url, body: data,);
    if (response.statusCode == 200) {


      var resposne= convert.jsonDecode(response.body) ;
      if(resposne['status'] == "1")
        {
          savePref(resposne['name'],resposne['id']);
             Navigator.of(context).pushReplacementNamed("/employehome");
        }
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("Please Try again")));
    }
     
   }
  
  savePref(String name,String id) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
      preferences.setString("name", name);
      preferences.setString("id", id); 
      });

      print(preferences.getString("name"));
      print(preferences.getString("id"));

  }







  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(

           child: SingleChildScrollView(
                       child: Container(
                          margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // SizedBox(height:MediaQuery.of(context).size.height*0.05,),
                                // SvgPicture.asset("images/asset/svg2.svg" ,
                                //     height: MediaQuery.of(context).size.height * 0.33,
                                //     alignment: Alignment.center),
                                SizedBox(height: MediaQuery.of(context).size.height*0.10,),   
                                Text("Create Account",style: TextStyle( color: Colors.blue[900],fontSize:26,fontWeight: FontWeight.w400),),
                                Text("Create a new account",style: TextStyle( color: Colors.grey[350],fontSize:15,fontWeight: FontWeight.w400),),
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
                                SizedBox(height:20,),
                                DropdownButtonFormField(
                                       // hint:Text("Select wilaaya"),
                                        value: _selectedcategorie,
                                        items: _listjob
                                            .map(( region) => DropdownMenuItem<String>(
                                                child: Text(region.nom), value: region.nom))
                                            .toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            _selectedcategorie = newValue;
                                          });
                                        },
                                        decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                                          filled: true,
                                          fillColor: Colors.grey[200],
                                          labelText: "Categories",
                                          enabledBorder: OutlineInputBorder(
                                             borderSide: BorderSide(color:Colors.blueGrey),
                                          )
                                          ),
                                        
                                      ),
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
                                              if(_selectedcategorie.isEmpty){
                                                 _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("Please Enter le travaille")));
                                                return;
                                              }
                                             employeSignup(_nameController.text,_numberController.text,_selectedRegion,_selectedSecond,_selectedcategorie);

                                      },
                                     child: Container(
                                       alignment: Alignment.center,
                                       width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.blue[900],
                                        borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Text("CREATE ACCOUNT",style: TextStyle(color: Colors.white),),
                                      ),
                                    ),

                                     SizedBox(height: 30,),

                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => EmployeSignIn()));
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

                                      ],)
                                  ),
                                
                              ],
                           ),
                        ),         
           ),
      ),
    );
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
 
  }
 class Willaya{
   final String id;
   final String nom;

  Willaya({this.id, this.nom});

  factory Willaya.fromJSON( Map<String,dynamic> json){
         return Willaya(
           id:json["id"],
           nom:json["nom"]
         );
  }
  
 }
 class Commune{
   final String id_co,nom_com,id_willaya;
   Commune({this.id_co,this.nom_com,this.id_willaya});

   factory Commune.fromJSON(Map<String,dynamic>json){
     return Commune(id_co: json["id"],nom_com: json["nom"],id_willaya: json["id_willaya"]);
   }

 }
