import 'package:flutter/material.dart';
import 'package:myfirstapp/Employe_demande_details.dart';
import 'package:myfirstapp/constants.dart';
import 'package:myfirstapp/models/embouche.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
class EmployeDemand extends StatefulWidget {
  @override
  _EmployeDemandState createState() => _EmployeDemandState();
}

class _EmployeDemandState extends State<EmployeDemand> {
    String nom=" ";
    String id=" ";
    List<Embouche> demandes=[];

     getPref() async{

     SharedPreferences preferences = await SharedPreferences.getInstance();
      // preferences.getInt('value');
      setState(() {
        nom=  preferences.getString("name");
        // preferences.getString("email");
        id=  preferences.getString("id");
        
      });
      setState(() {
        
      });
      print(nom);
      print(id);
      }


  Future getDemande() async {
  
      var url = "http://192.168.43.244//werikhedmtk/embouche.php";
             var data = new Map<String, dynamic>();
                data['id'] = id ;        
            var response = await http.post(url,body: data);
            var result = convert.jsonDecode(response.body) ;   
            demandes=List<Embouche>.from(
               result.map((i){
                 return Embouche.fromJSON(i);
               })
            );
            return demandes;
  }


  @override
  void initState(){
     getPref();   
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text("Demande Embouche",),
        //  centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Container(
                   height: 100,
                   padding: EdgeInsets.symmetric(vertical: kDefaultPadding/2),
                   margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Text("Bonjour Mr ${nom}",style: TextStyle(fontSize: 18,color: Colors.white),
                  )
                ),
               
            
                  Expanded(
                    child: FutureBuilder(
                    future: getDemande(),
                    builder: (BuildContext context,AsyncSnapshot snapshot){

                        if(demandes.length==0){
                          return Center(child:Text("Ya De Demandes",style: TextStyle(fontSize: 24,color: kPrimaryColor),) );
                        }
                          if(snapshot.hasData){ 
                          return 
                      
                                 ListView.builder(
                                    scrollDirection:Axis.vertical ,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context,index)=> DemmandeCard(embouche: snapshot.data[index],)
          
                      
                                );

                      }
                      return Center(child: CircularProgressIndicator(backgroundColor: Colors.amberAccent,),);

                    }),
                  ),
              
                                  
                       
                
              ]
               ),
          )
          ),
    );
  }
}

class DemmandeCard extends StatelessWidget {
  final Embouche embouche;

  const DemmandeCard({Key key, this.embouche}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
                padding: EdgeInsets.symmetric(vertical: kDefaultPadding/4),
                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding-4),
                child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                              children: [
                                Expanded( child:
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom:8.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right:8.0),
                                          child: Icon(Icons.person_outline_rounded),
                                        ),
                                        Text(embouche.nom_client),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right:8.0),
                                        child: Icon(Icons.place_outlined),
                                      ),
                                      Text(embouche.willaya +", "+embouche.commune),
                                    ],
                                  ),
                                ],)),
                                  Column(
                                    children: [
                                      InkWell(
                                        child: Container(
                                          margin: EdgeInsets.symmetric(horizontal: kDefaultPadding,vertical: kDefaultPadding/2),
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.greenAccent,
                                            borderRadius: BorderRadius.circular(20)
                                          ),
                                          child:Text("Accepter",style:Theme.of(context).textTheme.button)
                                          ,)
                                          ,
                                          onTap: (){},),
                                      InkWell(
                                        child: Container(
                                            padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius: BorderRadius.circular(20)
                                          ),
                                          child:Text("Refuse",style:Theme.of(context).textTheme.button)
                                          ,)
                                          ,
                                          onTap: (){

                                          },),
                                    ],
                                  )
                                  ],
                            ),
                    )
                        ),
              ),

              onTap: (){
                     Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>EmployeDemandeDetails(embouche:embouche,)
                            ));
              },
    );
  }
}


