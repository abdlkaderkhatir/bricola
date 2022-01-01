import 'package:flutter/material.dart';
import 'package:myfirstapp/components/rating_stars_widget.dart';
import 'package:myfirstapp/constants.dart';
import 'package:myfirstapp/models/comment.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class EmployeComment extends StatefulWidget {


  @override
  _EmployeCommentState createState() => _EmployeCommentState();
}

class _EmployeCommentState extends State<EmployeComment> {

    String id="";
    @override
    initState(){
      getPref();
      super.initState();
    }
    getPref()async{

     SharedPreferences preferences = await SharedPreferences.getInstance();
      // preferences.getInt('value');
      setState(() {
        id=  preferences.getString("id");    
      });
      setState(() {
        
      });
          print(id);
      }
   List<Comment> comments=[];
     

    Future  getRating() async {
    
                  var url = "http://192.168.43.244//werikhedmtk/rating.php";
                  var data = new Map<String, dynamic>();
                                data['id_employerating']=id;
                  print(data.toString());

                  var response= await http.post(url, body: data,);
                  if (response.statusCode == 200) {

                       var result= convert.jsonDecode(response.body) ;

                         comments = List<Comment>.from(
                            result.map((i){
                                return Comment.fromJSON(i);
                            })
                          );

                        return comments;
                   
                  } 
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child:Container(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Container(
                 padding: EdgeInsets.fromLTRB(20, 30, 0, 30),
                 child: Text("Vos Commentaires",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.amber),),
               ),
               
                
               
                        Expanded(
                            child: FutureBuilder(
                                future: getRating(),
                                builder: (BuildContext context,AsyncSnapshot snapshot){
                                if(comments.length==0){
                                  return Center(child:Text("Pas De Commentaires",style: TextStyle(fontSize: 16,color: Colors.white),) );
                                }
                                  if (snapshot.hasData){
                                        return  
                                        ListView.builder(
                                              itemCount: snapshot.data.length,
                                              // itemBuilder: (context,index)=>ProductCard(idexitem: index,nom: snapshot.data[index]['nom'],telephone:snapshot.data[index]['telephone'] ,id: snapshot.data[index]['id'],id_willaya: snapshot.data[index]['id_willaya'],id_commune: snapshot.data[index]['id_commune'],nbtravaille: snapshot.data[index]['nbtravaille'],),
                                              itemBuilder:(context,index)
                                              =>BuildComment(comment: snapshot.data[index],)
                                              ) ;
                                        }
                                       

                                       return Center(child: CircularProgressIndicator(),);
                                    }
                                    
                           ),
                        ),
             ],
           ),
        ) 
      ),
      
    );
  }
}


class BuildComment extends StatelessWidget {
  final Comment comment;
  const BuildComment({
    this.comment,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: kDefaultPadding/2),
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child:   Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                  Row(
                    children: [
                      CircleAvatar(
                          backgroundImage: NetworkImage("http://192.168.43.244//werikhedmtk/upload/${comment.image_client}"),
                          radius: 20,
                          ),
                    SizedBox(width: 10,),
                    Text(comment.reviwer,style:TextStyle(fontSize: 18,fontWeight: FontWeight.w200,color: Colors.white)),
                    ],
                  ),

                  RatingStarsWidget(rating: double.parse(comment.rating),)
                ],),
                Container(
                  padding: EdgeInsets.only(top:5),
                  margin: EdgeInsets.only(left: kDefaultPadding),
                   width: double.infinity,
                  child: Card(
                    child:Padding(
                      padding: const EdgeInsets.only(top:8.0,bottom: 20,left: 10,right: 10),
                      child: Text(comment.comment,style: Theme.of(context).textTheme.bodyText1,),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}