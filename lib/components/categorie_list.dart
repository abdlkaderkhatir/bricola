// import 'package:flutter/material.dart';
// import 'package:myfirstapp/constants.dart';
// import 'dart:convert' as convert;
// import 'package:http/http.dart' as http;

// class CategorieList extends StatefulWidget {
//   @override
//   _CategorieListState createState() => _CategorieListState();
// }

// class _CategorieListState extends State<CategorieList> {
//   int selecteditem=0;
//   List categorie=['All','Plombier','Maçon','Mechanicien','chaufagiste','menaivre'];
//   int indexend;

//    Future getData() async {
//       var url = "http://192.168.1.36//werikhedmtk/categorie.php";
//             var response = await http.get(url);
//             var result = convert.jsonDecode(response.body) ;            
//             return result;
//   }

//   getEmploye(String val) async {
//       var url = "http://192.168.1.36//werikhedmtk/list_employe.php";
//       var data = new Map<String, dynamic>();
//                   data['cat'] = val;
      
//       var response= await http.post(url, body: data,); 
//       var result= convert.jsonDecode(response.body) ;

//   }

//   @override
//   Widget build(BuildContext context) {
//     indexend =categorie.length-1;
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: kDefaultPadding/2),
//       height: 30,
//       child: FutureBuilder(
//         future: getData(),
//         builder: (BuildContext context,AsyncSnapshot snapshot){
//           if(snapshot.hasData){
//            return 
//                 ListView.builder(
//                   scrollDirection:Axis.horizontal ,
//                   itemCount: categorie.length,
//                   itemBuilder: (context,index)=> GestureDetector(
//                     onTap: (){
//                       setState(() {
//                         selecteditem=index;
//                         print(indexend);
//                         print(categorie.length);
//                         getEmploye(snapshot.data[index]['name']);
//                       });
//                     },
//                     child: Container(
//                       alignment: Alignment.center,
//                       margin: EdgeInsets.only(
//                         left: kDefaultPadding,
                        
//                         right: index== indexend ? kDefaultPadding : 0 ,
//                         ),
//                       padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
//                       decoration: BoxDecoration(
//                         color: index==selecteditem ? Colors.white.withOpacity(0.4) : Colors.transparent,
//                         borderRadius: BorderRadius.circular(6)
//                       ),
//                       child: Text(snapshot.data[index]['name'],
//                       style: TextStyle(color: Colors.white),), 
//                     ),
//                  )
      
//                 );

//           }
//           return Center(child: CircularProgressIndicator(backgroundColor: Colors.amberAccent,),);

//         }),
//         );
//   }




// }