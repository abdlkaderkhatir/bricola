import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfirstapp/Edit_profile.dart';
import 'package:myfirstapp/client_demande.dart';
import 'package:myfirstapp/components/Profile_widget.dart';
import 'package:myfirstapp/components/number_widget.dart';
import 'package:myfirstapp/constants.dart';
import 'package:myfirstapp/employe_signup.dart';
import 'package:myfirstapp/models/client.dart';
import 'package:myfirstapp/models/employe.dart';
import 'package:myfirstapp/models/user.dart';
import 'package:myfirstapp/util/pref.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class  ClientProfile extends StatefulWidget {
 
  String id;
  ClientProfile({this.id});
  

  @override
  _ClientProfileState createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {

  String name="";
  String id="";
  String telephone="",willaya="",commune="",image="";
  Client client =new Client(image: "",willaya: "",commune: "",telephone: "",nom: "",id: "");

  // getPref()async{


  //    SharedPreferences preferences = await SharedPreferences.getInstance();
  //     setState(() {
  //           name= preferences.getString("name");
  //           id=preferences.getString("id");     
  //     });


  // }

  getClient() async{
    
      var url = "http://192.168.43.244//werikhedmtk/list_employe.php";
      var data = new Map<String, dynamic>();
                  data['current_id_client'] = widget.id;
      // print(selectedcat);
      var response= await http.post(url, body: data,); 
      var result= convert.jsonDecode(response.body) ;

      client=Client.fromJSON(result);
       setState(() {
         id=result['id'];
         name=result['nom'];
         willaya=result["willaya"];
         telephone=result['telephone'];
         commune=result['commune'];
         image=result['image'];
       });
            
      print(client);
      // return employe;

  }
  @override
  void initState() {
    // getPref();
    getClient();
    // TODO: implement initState
    super.initState();
  }


  // User user=UserPreferences().myUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(icon:Icon(Icons.logout,color: Colors.black),
          onPressed: () async {
             SharedPreferences preferences = await SharedPreferences.getInstance();
              preferences.remove("name");
              preferences.remove("id");
              // preferences.commit();
               Navigator.pushReplacementNamed(context, '/clientoremploye');
          },),
        ],
      ),
      body: Column(
        children: [
          ProfileWidget(
            imagePath: image=="" ? "http://192.168.43.244//werikhedmtk/upload/user.jpg" : "http://192.168.43.244//werikhedmtk/upload/${client.image}",
            onClicked: (){
               Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditProfile()),
                  );
            },
            isEdit:false,
          ),
           const SizedBox(height: 24),
              buildName(client),
           const SizedBox(height: 48),
              // buildAbout(user),
                       Container(margin:EdgeInsets.symmetric(horizontal: 40),child: Divider(color: Colors.grey,thickness: 1,)),

             Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     FlatButton(onPressed: (){

                       
                     },child:Container(
                       padding: EdgeInsets.all(10),
                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                       border: Border.all(color: Colors.black)
                       ),
                       child: Text("Modifier les Information",style: TextStyle(fontSize: 18,color: Colors.black),)),),
                       SizedBox(height: 20,),
                     FlatButton(onPressed: (){
                       Navigator.of(context).push(
                         MaterialPageRoute(builder:(context)=>ClientDemande(id:id))
                       );
                     },child:Container(
                       padding: EdgeInsets.all(10),
                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                       border: Border.all(color: Colors.black)
                       ),
                       child: Text("Voir Vos Demandes",style: TextStyle(fontSize: 18,color: Colors.black),)),),
                       SizedBox(height: 20,),
                    //  FlatButton(onPressed: (){},child:Container(
                    //    padding: EdgeInsets.all(10),
                    //    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                    //    border: Border.all(color: Colors.black),
                    //    ),
                    //    child: Text("Se deconecter",style: TextStyle(fontSize: 18,color: Colors.black),)),),
             
                   ]
                ),
              ),
            
      ],
      ),
      );


  }

  Widget buildName(Client client) => Column(
        children: [
          Text(
            client.nom,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,color: Colors.black)
          ),
          const SizedBox(height: 4),
          Text(
            client.telephone,
            style: TextStyle(color: Colors.black),
          ),
           const SizedBox(height: 4),
           Text(
            client.willaya+", " +client.commune,
            style: TextStyle(color: Colors.black),
          ),
        ],
      );

  // Widget buildUpgradeButton() => ButtonWidget(
  //       text: 'Upgrade To PRO',
  //       onClicked: () {},
  //     );

  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              user.about,
              style: TextStyle(fontSize: 16, height: 1.4,color: Colors.white),
            ),
          ],
        ),
      );
}