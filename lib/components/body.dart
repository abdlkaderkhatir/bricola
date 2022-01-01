import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myfirstapp/constants.dart';
import 'package:myfirstapp/details/details_screen.dart';
import 'package:myfirstapp/employe_signup.dart';
import 'package:myfirstapp/models/employe.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}


class _BodyState extends State<Body> {

  TextEditingController controller = new TextEditingController();
  List<Employe> employes=[];
  List categories=[];
  int selecteditem=0;
  int indexend;
  String selectedcat="Plater & Plafond";
 
  @override
  void initState() {
    super.initState();
  }

 


   Future getCat() async {
     //192.168.43.244

      var url = "http://192.168.43.244//werikhedmtk/categorie.php";
            var response = await http.get(url);
            var result = convert.jsonDecode(response.body) ;   
            categories=List<Categorie>.from(
               result.map((i){
                 return Categorie.fromJSON(i);
               })
            );
            //  print(categories.length);
            return result;
  }
  Future getEmploye() async {

      var url = "http://192.168.43.244//werikhedmtk/list_employe.php";
      var data = new Map<String, dynamic>();
                  data['cat'] = selectedcat;
      print(selectedcat);
      var response= await http.post(url, body: data,); 
      var result= convert.jsonDecode(response.body) ;

       employes = List<Employe>.from(
              result.map((i){
                  return Employe.fromJSON(i);
              })
            );


      // print(employes);
      return employes;

  }
 


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          //search box v1
                  // Container(
                  //     margin: EdgeInsets.all(kDefaultPadding),
                  //     padding: EdgeInsets.symmetric(
                  //       horizontal: kDefaultPadding,
                  //       vertical: kDefaultPadding/4,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       color: Colors.white.withOpacity(0.4),
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //     child: TextField(
                  //       controller: controller ,
                  //       onChanged: onSearchTextChanged,
                  //       style: TextStyle(color:Colors.white),
                  //       decoration: InputDecoration(
                  //         enabledBorder: InputBorder.none,
                  //         focusedBorder: InputBorder.none,
                  //         icon:Icon(Icons.search_outlined),
                  //         hintText: 'Search',
                  //         hintStyle: TextStyle(color:Colors.white)
                  //       ),
                  //     ),
                  //   ),
           Container(
            color: Theme.of(context).primaryColor,
         
            padding: EdgeInsets.all(8), 
            margin: EdgeInsets.symmetric(horizontal: kDefaultPadding/2),    
              child: new Card(
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    controller: controller,
                    decoration: new InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                    controller.clear();
                    onSearchTextChanged('');
                  },),
                ),
              ),
          
          ),
          // CategorieList(),
          //categorie List
          Container(
                margin: EdgeInsets.symmetric(vertical: kDefaultPadding/2),
                height: 30,
                child: FutureBuilder(
                  future: getCat(),
                  builder: (BuildContext context,AsyncSnapshot snapshot){
                    if(snapshot.hasData){
                    return 
                          ListView.builder(
                            scrollDirection:Axis.horizontal ,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context,index)=> GestureDetector(
                              onTap: (){
                                setState(() {

                                  selecteditem=index;
                                  selectedcat=snapshot.data[index]['name'];
                                  // print(selectedcat);
                                  // getEmploye(selectedcat);
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                  left: kDefaultPadding,
                                  
                                  right: index== categories.length-1? kDefaultPadding : 0 ,
                                  ),
                                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                                decoration: BoxDecoration(
                                  color: index==selecteditem ? Colors.white.withOpacity(0.4) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(6)
                                ),
                                child: Text(snapshot.data[index]['name'],
                                style: TextStyle(color: Colors.white),), 
                    ),
                 )
      
                );

          }
          return Center(child: CircularProgressIndicator(backgroundColor: Colors.amberAccent,),);

        }),
        ),
        //end Categorie list
        
          SizedBox(height: kDefaultPadding/2,),
          Expanded(
            child:_searchResult.length != 0 //|| controller.text.isNotEmpty
                ? Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 70),
                      decoration: BoxDecoration(
                        color:kBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft:Radius.circular(40), 
                          topRight:Radius.circular(40),
                        )
                      ),
                    ),
        
                    ListView.builder(
                      itemCount: _searchResult.length,
                      itemBuilder: (context,index)=>ProductCard(idexitem: index,employe:_searchResult[index]),
                      )
                  ],
                ) :
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 70),
                      decoration: BoxDecoration(
                        color:kBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft:Radius.circular(40), 
                          topRight:Radius.circular(40),
                        )
                      ),
                    ),
                    FutureBuilder(
                      future: getEmploye(),
                      builder: (BuildContext context,AsyncSnapshot snapshot){
                      if(employes.length==0){
                        return Center(child:Text("Ya Pas De Employe",style: TextStyle(fontSize: 24,color: kPrimaryColor),) );
                      }
                        if (snapshot.hasData){
                              return  
                              ListView.builder(
                                    itemCount: snapshot.data.length,
                                    // itemBuilder: (context,index)=>ProductCard(idexitem: index,nom: snapshot.data[index]['nom'],telephone:snapshot.data[index]['telephone'] ,id: snapshot.data[index]['id'],id_willaya: snapshot.data[index]['id_willaya'],id_commune: snapshot.data[index]['id_commune'],nbtravaille: snapshot.data[index]['nbtravaille'],),
                                    itemBuilder:(context,index)
                                    => ProductCard(idexitem: index,employe: snapshot.data[index],),
                                    ) ;
                              }
                             

                             return Center(child: CircularProgressIndicator(),);
                          }
                          
                      ),
                   
                  ],
                )
                
          ),
        ],
      ),
    );
  }

  onSearchTextChanged(String text)  {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
     
      employes.forEach((prod) {
      if (prod.nom.toLowerCase().contains(text)  )//|| prod..toLowerCase().contains(text)
       {
       _searchResult.add(prod);
      }
      });
      setState(() {});
  }
    List<Employe> _searchResult = [];
}



class ProductCard extends StatelessWidget {

  
  
  final int idexitem;
  // final String nom,telephone,nbtravaille;
  final Employe employe;
 



  const ProductCard({Key key, this.idexitem, this.employe}) : super(key: key);

  // const ProductCard({Key key, this.idexitem, this.id, this.nbtravaille, this.id_willaya, this.id_commune, this.nom,this.telephone}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size; 
    return Container(
      margin:EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical:kDefaultPadding/4,
      ),
    //  color: Colors.blueAccent,
      height: 160,
      child:InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>DetailsScreen(employe: employe,)
              ));
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            //our background 
            Container(
              height: 136,
              margin: EdgeInsets.only(left: 40),
              decoration: BoxDecoration(
                color: idexitem.isEven? kBleColor : kSecondryColor,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [kDefaultShadow],
              ),
              child: Container(
                margin: EdgeInsets.only(right: 10,left:30),
                decoration: BoxDecoration(
                  color: Colors.white,
                   borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),

            Positioned(
              left:0,
              bottom:8,
              child: CircleAvatar(
                backgroundImage: NetworkImage("http://192.168.43.244//werikhedmtk/upload/${employe.image}"),
                radius: 60,
              ),
            ),

           Positioned(
             bottom:0,
             child: SizedBox(
               height:136,
               width:size.width-260,
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text(employe.nom,style: Theme.of(context).textTheme.button,),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      child: Text(employe.nbtravaille +" travaille",style: Theme.of(context).textTheme.button,),
                    ),
                     Spacer(),

                  ],
                      
                ),
             ),
             ),
           
            

            // our image
            // Positioned(
            //   top: 0,
            //   right: 0,
            // 
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            //     // height: 160,
            //     // width: 200,
            //    child: CircleAvatar(
            //      child: Image.asset("images/asset/background.png"),
            //      radius: 20,
            //    ),
            //   )
            // ),
            // Positioned(
            //    left: 0,
            //   bottom:0,
              
            //   child:SizedBox(
            //     height: 136,
            //   //  width:size.width-200 ,
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Spacer(),
            //         Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            //           child: Text(product.title,style: Theme.of(context).textTheme.button,),
            //         ),
            //         Spacer(),
            //         Container(
            //           padding: EdgeInsets.symmetric(
            //             horizontal: kDefaultPadding*1.5,
            //             vertical: kDefaultPadding/4,
            //           ),
            //           decoration: BoxDecoration(
            //             color:kSecondryColor,
            //             borderRadius: BorderRadius.only(
            //               topRight: Radius.circular(22),
            //               bottomLeft: Radius.circular(22)
            //             )
            //           ),
            //           child: Text("${product.price}da",style: Theme.of(context).textTheme.button,),

            //         )
            //       ],
                      
            //     ), 
            // ))
          ],
        ),
      ),
    );
  }




}

  class Categorie {
    final String id,nom;

     Categorie({this.id, this.nom});

     factory Categorie.fromJSON( Map<String,dynamic> json){
         return Categorie(
           id:json["id"],
           nom:json["name"],
         );
  }

  }