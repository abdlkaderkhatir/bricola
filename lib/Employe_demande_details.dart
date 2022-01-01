import 'package:flutter/material.dart';
import 'package:myfirstapp/constants.dart';
import 'package:myfirstapp/models/embouche.dart';

class EmployeDemandeDetails extends StatelessWidget {
  // const EmployeDemandeDetails({ Key? key }) : super(key: key);
  final Embouche embouche;

  const EmployeDemandeDetails({Key key, this.embouche}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    // alignment: Alignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*0.25,
                        decoration: BoxDecoration(
                          color: kTextColor,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50),
                          )
                          ),
                      ),

                      Positioned(
                        top: 50,
                        left: 0,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          alignment:Alignment.centerLeft ,
                        width: 300,
                        height: MediaQuery.of(context).size.height*0.07,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight:Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          )
                          ),
                          child: Row(
                            children: [
                              IconButton(icon:Icon(Icons.arrow_back,color:Colors.black),onPressed: (){
                                Navigator.of(context).pop();}, ),
                              Text("Demende Embouche",style: TextStyle(fontSize: 20,color: kTextColor),),
                            ],
                          ),
                      ),
                      )
                    ],
                  ),


                  
                  Container(
                    margin: EdgeInsets.only(left: 16,right: 16),
                    height:MediaQuery.of(context).size.height*0.49,
                    // decoration: BoxDecoration(color: Colors.amber),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                        children: [
                          Material(
                            child: Container(
                                height:250,
                                decoration: BoxDecoration(color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(
                                  color:Colors.grey[600].withOpacity(0.3),
                                  offset: Offset(-10,10),
                                  blurRadius: 20,
                                  spreadRadius: 4)]),
                            ),
                          ),
                           Positioned(
                                    // top: 80,
                                    left: 0,
                             child: Container(
                                            // padding: EdgeInsets.all(8),
                                            margin: EdgeInsets.only(left:8,bottom: 10),
                                            alignment:Alignment.center,
                                            width:200,
                                            height: MediaQuery.of(context).size.height*0.4+30,
                                            decoration: BoxDecoration(
                                              color: Colors.blue[900],
                                              borderRadius: BorderRadius.circular(20),
                                              image:DecorationImage(
                                                fit:BoxFit.fill,
                                                image: NetworkImage("http://192.168.43.244//werikhedmtk/upload/${embouche.image}"),
                                              )
                                              ),
                                              // child: Text("Click ici",style: TextStyle(fontSize: 20,color: Colors.white),),
                                          ),
                          
                             ),
                             Positioned(
                              //  top:120,
                               right: 0,
                               child:Container(
                                 padding: EdgeInsets.all(8),
                                 height:250 ,
                                 width: MediaQuery.of(context).size.width-250,
                                //  color: Colors.amber,
                                 child:ListView(
                                  //  crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Text("heel"),
                                      Text(embouche.titre,style: TextStyle(fontSize: 20,color: kTextColor),),
                                      Container(padding: EdgeInsets.only(left:10,right: 10),child: Divider(color: Colors.grey,)),
                                      Text(embouche.discription,style: TextStyle(fontSize: 16,color:Colors.grey),),
                                    ],
                                 )
                               )
                             )

                        ],  

                    ) ,
                  ),
                 

              

                ],

        ),
    );
  }
}