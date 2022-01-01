import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myfirstapp/components/rating_widget.dart';
import 'package:myfirstapp/constants.dart';
import 'package:myfirstapp/details/body.dart';
import 'package:myfirstapp/models/employe.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
  
class DetailsScreen extends StatefulWidget {
  // const DetailsScreen({ Key? key }) : super(key: key);
    final Employe employe;
    // final String willaya;
    const DetailsScreen({Key key, this.employe}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

 String name="";
 String id="";
 String image="";
 int rat=0;
  final _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
 TextEditingController _commentController=new TextEditingController();

 @override
  void initState() {
    geetRating();
    getPref();
    super.initState();
  }

  getPref() async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
    
       name= preferences.getString("name");
       id=preferences.getString("id");
       image=preferences.getString("image");
        
      });
      print(image);
  }

  comment(id_employe,id_client,rating,reviwer,comment,image)async{

    print("Calling");
    var url = "http://192.168.43.244//werikhedmtk/rating.php";
    var data = new Map<String, dynamic>();
                  data['id_employe'] = id_employe;
                  data['id_client'] =id_client;
                  data['rating'] = rating;
                  data['reviwer'] = reviwer;
                  data['comment'] = comment;
                  data['image'] = image;
    print(data.toString());

    var response= await http.post(url, body: data,);
    // if (response.statusCode == 200) {

    //   // var resposne= convert.jsonDecode(response.body) ;
    //   // if(resposne['status']=="1")
    //   //   {
    //   //     Navigator.pushReplacementNamed(context, "/product");
    //   //   }
    // } 


  }



    double _rating=0 ;
   String count =" ";


    geetRating() async {
         print("Calling");
              
                  var url = "http://192.168.43.244//werikhedmtk/rating.php";
                  var data = new Map<String, dynamic>();
                                data['id_employeforcount']=widget.employe.id;
                  print(data.toString());

                  var response= await http.post(url, body: data,);
                  if (response.statusCode == 200) {

                 var resposne= convert.jsonDecode(response.body) ;
                    setState(() {
                   count=resposne[0]["0"]["count(*)"];
                   int total=resposne[0]["total"];
                   setState(() {  
                   _rating=(total/int.parse(count));
                   });
                     });

                  } 

                  //  print (_rating);

      }







        

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation:0 ,
        leading: IconButton(
          padding: EdgeInsets.only(left:kDefaultPadding),
          icon:Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },),
        title: Text("Back".toUpperCase(),style: Theme.of(context).textTheme.bodyText2,),
        centerTitle: false,
        // actions: [
        //   IconButton(icon: Icon(Icons.shopping_bag), onPressed: (){})
        // ],
      ),
      body:Body(employe:widget.employe,count:count,rating: _rating,) ,
      floatingActionButton: FloatingActionButton(
             child: Icon(Icons.comment_outlined),
             backgroundColor: Colors.orange,
             onPressed: (){

              return showDialog(
                      context: context,
                      builder: (context) {
                        return 
                        SingleChildScrollView(
                          child:
                           Container(
                             child: AlertDialog(
                              title: Text('Comment a été votre Experience ?',style: TextStyle(fontSize: 18),),
                              content: Container(
                                // height: MediaQuery.of(context).size.height/2.5,
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 10,),
                                      RatingWidget((rating){
                                        setState(() {
                                          rat=rating;
                                        });
                                      }),
                                      SizedBox(height: 10,),
                                      TextFormField(
                                         controller: _commentController,
                                           minLines: 6, // any number you need (It works as the rows for the textarea)
                                          keyboardType: TextInputType.multiline,
                                          maxLength: 1000,
                                          maxLines: null,
                                          decoration: InputDecoration(
                                        hintText: "Ecrire ici ..",
                                        hintStyle: TextStyle(color: Colors.black),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.all(new Radius.circular(25.0))),
                                        // labelStyle: TextStyle(color: Colors.white)
                                        ),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                         ),
                                      ),

                                      SizedBox(height: 10,),

                                      // Text("Hello World"),

                                      Container(
                                        decoration: BoxDecoration(
                                          color: kSecondryColor,
                                          borderRadius: BorderRadius.circular(20)
                                        ),
                                        child: FlatButton(
                                            onPressed: () 
                                            // async
                                            {
                                               if(_commentController.text.isEmpty)
                                                  {
                                                    _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("SVP Ecrire qlq chose")));
                                                    return;
                                                  }
                                              comment(widget.employe.id,id,rat.toString(), name,_commentController.text,"user.jpg");
                                              // sleep(const Duration(seconds: 3));
                                              setState(() {  
                                                 geetRating();
                                              });
                                              // sleep(const Duration(seconds: 2));
                                              Navigator.of(context).pop(false); // dismisses only the dialog and returns false
                                            },
                                            child: Text('Send',style: TextStyle(color: Colors.black),),
                                          ),
                                      ),

                                      ],
                                  ),
                                                              ),
                             
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
                          ),
                           )
                        );
                      },
                      );


             },),
    );
  }
}
