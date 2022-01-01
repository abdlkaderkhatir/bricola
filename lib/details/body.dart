import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter/material.dart';
import 'package:myfirstapp/components/rating_stars_widget.dart';
import 'package:myfirstapp/components/rating_widget.dart';
import 'package:myfirstapp/constants.dart';
import 'package:myfirstapp/emboucher.dart';
import 'package:myfirstapp/employe_signup.dart';
import 'package:myfirstapp/models/comment.dart';
import 'package:myfirstapp/models/employe.dart';


class Body extends StatefulWidget {
  // const Body({ Key? key }) : super(key: key);
   final Employe employe;
   final String count;
   final double rating;
   const Body({Key key, this.employe,this.rating,this.count}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

 
    @override
   initState(){
     getRating();
    //  geetRating();
     super.initState();

   }


  //  double _rating=0 ;
  //  String count =" ";


  //   geetRating() async {
  //        print("Calling");
  //                 var url = "http://192.168.43.244//werikhedmtk/rating.php";
  //                 var data = new Map<String, dynamic>();
  //                               data['id_employeforcount']=widget.employe.id;
  //                 print(data.toString());

  //                 var response= await http.post(url, body: data,);
  //                 if (response.statusCode == 200) {

  //                var resposne= convert.jsonDecode(response.body) ;
  //                  count=resposne[0]["0"]["count(*)"];
  //                  int total=resposne[0]["total"];
  //                  setState(() {  
  //                  _rating=(total/int.parse(count));
  //                  });

  //                 //  print (_rating);

  //                 } 
  //     }

    List<Comment> comments=[];
     

    Future  getRating() async {
    
                  var url = "http://192.168.43.244//werikhedmtk/rating.php";
                  var data = new Map<String, dynamic>();
                                data['id_employerating']=widget.employe.id;
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
    Size size =MediaQuery.of(context).size;
  
    return Container(
      // child: SingleChildScrollView(
          child:
          Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )
                ),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                        Center(child: ProductPoster(size: size,image: widget.employe.image,)),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding/2),
                          child: Text(widget.employe.nom
                          ,style: Theme.of(context).textTheme.headline6,),
                        ),
                        Text(widget.employe.nbtravaille +' travailes',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: kSecondryColor),),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RatingStarsWidget(rating:widget.rating,),
                            SizedBox(width: 10,),
                            Text( widget.count + " reviwer",style: TextStyle(fontWeight: FontWeight.bold),)
                          ],
                        ),
                  
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.place_outlined),
                            Text("${widget.employe.willaya}, ${widget.employe.commune} ",style: TextStyle(color: kTextLightColor),)
                          ],
                        ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(vertical: kDefaultPadding/2) ,
                        //   child: Text(willaya ,style: TextStyle(color: kTextLightColor),),),
                        SizedBox(height: kDefaultPadding,)

                     ],
                   ),
              ),


                 Container(
                    margin: EdgeInsets.only(top:kDefaultPadding,left: kDefaultPadding,right: kDefaultPadding),
                    padding: EdgeInsets.symmetric(vertical: kDefaultPadding/2),
                    // decoration: BoxDecoration(
                    //   color: kSecondryColor,
                    //   borderRadius: BorderRadius.circular(50)
                    // ),
                    child:
                 Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(

                          child: Container(
                            decoration: BoxDecoration(
                                color: kSecondryColor,
                                borderRadius: BorderRadius.circular(20)
                              ),

                            child: FlatButton.icon(
                              onPressed: () async{
                                  FlutterPhoneDirectCaller.callNumber(widget.employe.telephone);
                               },
                              icon: Icon(Icons.phone_outlined),
                              label: Text("Appele"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            // decoration: BoxDecoration(
                            //    color: kSecondryColor,
                            //     borderRadius: BorderRadius.circular(20)
                            // ),
                          
                            child: OutlineButton(
                              padding: EdgeInsets.all(10),
                              child: Text("Emboucher"),
                              textColor: Colors.white,
                              borderSide: BorderSide(color: Colors.white,width: 2),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              onPressed: (){
                                 Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>Emboucher(employe: widget.employe,)
                                        ));
                              },),
                          ),
                        ),
                      ],
                    ),
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
      // ),
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

class DotsShape extends StatelessWidget {
  const DotsShape({
    Key key, this.isSelected=false, this.filColor,
  }) : super(key: key);
  final bool isSelected;
  final Color filColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding/2.5),
      padding: EdgeInsets.all(3),
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? Colors.grey[200] : Colors.transparent,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: filColor,
          shape: BoxShape.circle
        ),
      ),
    );
  }
}

class ProductPoster extends StatelessWidget {
  final String image;
  const ProductPoster({
    this.image,
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return 
          Container(
            margin: EdgeInsets.symmetric(vertical: kDefaultPadding/10),
            // height:size.width*0.30,
            child: Stack(
              //alignment: Alignment.bottomCenter,
              children: [
                CircleAvatar(
                backgroundImage: NetworkImage("http://192.168.43.244//werikhedmtk/upload/${image}"),
                radius: 70,
                ),
              ],
            ),
          );
  }
}


