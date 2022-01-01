import 'package:flutter/material.dart';
import 'package:myfirstapp/constants.dart';
import 'package:myfirstapp/employe_signin.dart';
import 'package:myfirstapp/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ClientOrEmploye extends StatefulWidget {
  
  @override
  _ClientOrEmployeState createState() => _ClientOrEmployeState();
}

class _ClientOrEmployeState extends State<ClientOrEmploye> {
String name,id ='';
   getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
       name=   preferences.getString("name");
       id=   preferences.getString("id");  
      });

  }
  @override
  initState(){
    getPref();
    print(name);
    print(id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child:Container(
          child: Column(
              crossAxisAlignment:CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.03,),
              Image.asset("images/asset/logo3.png",height: 200,width: MediaQuery.of(context).size.width-30,fit:BoxFit.cover,),
              Text("Vous étes ?",style:TextStyle(fontSize: 30,),),
              SizedBox(height: MediaQuery.of(context).size.height*0.15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    ChoseCard(title: "Employe",description: "vous proposez un service",),
                    ChoseCard(title: "Client",description: "vous cherchez des services",),
                ],
              )
            ],
          ),
        ) 
        ),
    );
  }
}

class ChoseCard extends StatelessWidget {
  final String title;
  final String description;
  const ChoseCard({
    Key key, this.title, this.description,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
           color:title=="Employe"? Colors.blue[900] : Colors.blue[900],
           borderRadius: BorderRadius.circular(20)
        ),
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(left: 20,right: 20),
        child: FlatButton(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                title=="Employe"? Image.asset("images/asset/employe1.png",height: 150,color: Colors.white,):Image.asset("images/asset/directeur1.png",height: 150,color: Colors.white,),
                Text(title,style:TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.white)),
                Text(description,style: TextStyle(fontSize: 13,color: Colors.white),)
              ],
            ),
           ),
          onPressed: (){
            if(title=="Employe"){
               Navigator.push(context,MaterialPageRoute(builder:(context) => EmployeSignIn()));
            
            }else{
               Navigator.push(context,MaterialPageRoute(builder:(context) => SignIn()));
             

            }
          }, 
        ),
      ),
    );
  }
}