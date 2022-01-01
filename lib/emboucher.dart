import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfirstapp/models/employe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'dart:io';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Emboucher extends StatefulWidget {
  final Employe employe;

  const Emboucher({Key key, this.employe}) : super(key: key);

  // const Emboucher({ Key? key }) : super(key: key);

  @override
  _EmboucherState createState() => _EmboucherState();
}

class _EmboucherState extends State<Emboucher> {
  @override
  initState(){
    getPref();
    print(widget.employe.id);
    super.initState();
  }

   File _file;
   String name=" ";
   String id=" ";
   final _formKey = GlobalKey();
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _titreController=new TextEditingController();
  TextEditingController _descriptionController=new TextEditingController();
  
   getPref() async{

    SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
            name= preferences.getString("name");
            id=preferences.getString("id");     
      });
     
  }





 Future pickercamera()async{
   final myfile=await ImagePicker().getImage(source: ImageSource.camera);
   setState(() {
     _file=File(myfile.path);
   });
 }

 Future pickergallery()async{
   final myfile=await ImagePicker().getImage(source: ImageSource.gallery);
   setState(() {
     _file=File(myfile.path);
   });
 }



 Future upload(id_employe,id_client,nom_client,titre,description) async {

   if(_file==null) return ;
   String base64 = convert.base64Encode(_file.readAsBytesSync());
   String imagename=_file.path.split("/").last;
   String image=imagename.substring(0,7)+imagename.substring(12);
    // print(imagename);
    // print(image);
    // print(base64);
    // print(id_employe);
    // print(id_client);
    // print(nom_client);
    // print(titre);
    // print(description);


  
    var url = "http://192.168.43.244//werikhedmtk/embouche.php";
                  var data = new Map<String, dynamic>();
                                data['id_employe']=id_employe;
                                data['id_client']=id_client;
                                data['nom_client']=nom_client;
                                data['imagename']=image;
                                data['base64']=base64;
                                data['titre']=titre;
                                data['description']=description;
           print(data.toString());

         var response= await http.post(url, body: data,);
   
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[300],
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: SingleChildScrollView(
          child: Form(
            key:_formKey ,
            child: Column(
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


                
                // Container(
                //   margin: EdgeInsets.only(left: 16,right: 16),
                //   height:MediaQuery.of(context).size.height*0.49,
                //   // decoration: BoxDecoration(color: Colors.amber),
                //   child: Stack(
                //     alignment: Alignment.bottomCenter,
                //       children: [
                //         Material(
                //           child: Container(
                //               height:250,
                //               decoration: BoxDecoration(color: Colors.white,
                //               borderRadius: BorderRadius.circular(10),
                //               boxShadow: [BoxShadow(
                //                 color:Colors.grey[600].withOpacity(0.3),
                //                 offset: Offset(-10,10),
                //                 blurRadius: 20,
                //                 spreadRadius: 4)]),
                //           ),
                //         ),
                //          Positioned(
                //                   // top: 80,
                //                   left: 0,
                //            child: InkWell(
                //                   child: Container(
                //                           // padding: EdgeInsets.all(8),
                //                           margin: EdgeInsets.only(left:8,bottom: 10),
                //                           alignment:Alignment.center,
                //                           width:200,
                //                           height: MediaQuery.of(context).size.height*0.4+30,
                //                           decoration: BoxDecoration(
                //                             color: Colors.blue[900],
                //                             borderRadius: BorderRadius.circular(20),
                //                             image:DecorationImage(
                //                               fit:BoxFit.fill,
                //                               image: NetworkImage("https://static.remove.bg/remove-bg-web/8be32deab801c5299982a503e82b025fee233bd0/assets/start-0e837dcc57769db2306d8d659f53555feb500b3c5d456879b9c843d1872e7baa.jpg"),
                //                             )
                //                             ),
                //                             // child: Text("Click ici",style: TextStyle(fontSize: 20,color: Colors.white),),
                //                         ),
                //                   onTap: (){
                //                     print("1");
                //                   },
                //                 ),
                //            ),
                //            Positioned(
                //             //  top:120,
                //              right: 0,
                //              child:Container(
                //                padding: EdgeInsets.all(8),
                //                height:250 ,
                //                width: MediaQuery.of(context).size.width-250,
                //               //  color: Colors.amber,
                //                child:ListView(
                //                 //  crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [

                //                     Text("Titre\nkjdhsjhs ",style: TextStyle(fontSize: 20,color: kTextColor),),
                //                     Container(padding: EdgeInsets.only(left:10,right: 10),child: Divider(color: Colors.grey,)),
                //                     Text("Description huhsiuhfuiqhiuhquyfsgusqgyqsqiyuavguyavguyarguygVYZU hbfhbfdjhbsdjfdsb& jhdghgfvjhqdgqdfhjsgfshs",style: TextStyle(fontSize: 16,color:Colors.grey),),
                //                   ],
                //                )
                //              )
                //            )

                //       ],  

                //   ) ,
                // ),
                Container(
                  margin: EdgeInsets.only(left: 16,right: 16,top: 20),
                  height:MediaQuery.of(context).size.height*0.6,
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
                                  top: 10,
                                  right: 0,
                                  left: 0,
                           child: InkWell(
                                  child: Container(
                                          // padding: EdgeInsets.all(8),
                                          margin: EdgeInsets.only(left:8,bottom: 10,right: 8),
                                          alignment:Alignment.center,
                                          width:MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context).size.height*0.3,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[400],
                                            borderRadius: BorderRadius.circular(20),
                                            image:DecorationImage(
                                              fit:BoxFit.fill,
                                              image:_file !=null ?  FileImage(_file,):NetworkImage("https://static.remove.bg/remove-bg-web/8be32deab801c5299982a503e82b025fee233bd0/assets/start-0e837dcc57769db2306d8d659f53555feb500b3c5d456879b9c843d1872e7baa.jpg"),
                                              // NetworkImage("https://static.remove.bg/remove-bg-web/8be32deab801c5299982a503e82b025fee233bd0/assets/start-0e837dcc57769db2306d8d659f53555feb500b3c5d456879b9c843d1872e7baa.jpg"),
                                            )
                                            ),
                                            // child:_file !=null ? Image.file(_file,fit: BoxFit.fill,width:MediaQuery.of(context).size.width,) :Text("Click ici",style: TextStyle(fontSize: 20,color: Colors.white),),
                                        ),
                                  onTap: (){
                                     return showDialog(
                                          context: context,
                                          builder: (context) {
                                               return   AlertDialog(
                                                     title: Text('Comment a été votre Experience ?',style: TextStyle(fontSize: 18),),
                                                     content: Container(
                                                        height: MediaQuery.of(context).size.height*0.2,
                                                        child: Column(children: [
                                                          ListTile(leading: Icon(CupertinoIcons.list_dash),title: Text("Gallery"),onTap: (){pickergallery();
                                                           Navigator.of(context).pop();},),
                                                          ListTile(leading: Icon(Icons.camera),title: Text("Camera"),onTap: (){pickercamera();Navigator.of(context).pop();},),
                                                        ],),
                                                                      ),
                                                  actions: <Widget>[
                                                    new FlatButton(
                                                      onPressed: () {
                                                        Navigator.of(context, rootNavigator: true)
                                                            .pop(false); // dismisses only the dialog and returns false
                                                      },
                                                      child: Text('Quiter'),
                                                    ),
                                                  //   FlatButton(
                                                  //     onPressed: () {
                                                  //       Navigator.of(context, rootNavigator: true)
                                                  //           .pop(true); // dismisses only the dialog and returns true
                                                  //     },
                                                  //     child: Text(''),
                                                  //   ),
                                                  ],
                                               );
                                        
                                    },
                                  );
                                  },
                                ),
                           ),
                           Positioned(
                            //  top:120,
                            right: 0,
                             left: 0,
                             child:Container(
                               margin: EdgeInsets.all(8),
                               padding: EdgeInsets.all(8),
                               height:220,
                               width: MediaQuery.of(context).size.width,
                              //  color: Colors.amber,
                               child:ListView(
                                //  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      TextFormField(
                                        controller: _titreController,
                                        style: TextStyle(fontSize: 20,color: kTextColor),
                                          // controller: _emailController,
                                          decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.transparent)),
                                            focusedBorder: UnderlineInputBorder(
                                                 borderSide: BorderSide(color: Colors.transparent)
                                            ),
                                            hintText: "Ecrir le Titre",
                                            hintStyle: TextStyle(
                                                color: kTextColor, fontSize: 20),
                                          ),
                                        ),

                                     Container(padding: EdgeInsets.only(top:10,bottom: 10),child: Divider(color: Colors.grey,)),
                                        TextFormField(
                                           controller: _descriptionController,
                                           minLines: 6,
                                           maxLength: 200,
                                           maxLines: null,
                                          style: TextStyle(fontSize: 16,color:Colors.grey),
                                          decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Colors.transparent)),
                                            focusedBorder: UnderlineInputBorder(
                                                 borderSide: BorderSide(color: Colors.transparent)
                                            ),
                                            hintText: "Ecrir le Discription",
                                            hintStyle: TextStyle(
                                                color: Colors.grey, fontSize: 16),
                                          ),
                                        ),

                                  ],
                               )
                             )
                           )

                      ],  

                  ) ,
                ),

                 Center(
                   child: GestureDetector(
                     child: Container(
                       margin: EdgeInsets.only(top:20),
                            padding: EdgeInsets.all(8),
                            alignment:Alignment.center,
                            width: 250,
                          height: MediaQuery.of(context).size.height*0.08,
                          decoration: BoxDecoration(
                            color: kSecondryColor,
                            borderRadius: BorderRadius.circular(50)
                            ),
                            child: Text("Demende Embouche",style: TextStyle(fontSize: 20,color: kTextColor),),
                        ),
                      onTap: (){
                            if(_titreController.text.isEmpty)
                                              {
                                                _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("Please Enter Titre")));
                                                return;
                                              }
                                              
                            if(_titreController.text.length>10)
                            {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("Please Entre Le Titre inferiuer a 10 caractere")));
                              return;
                            }
                              if(_descriptionController.text.isEmpty){
                                  _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("Please Enter la description")));
                                return;
                              }
                              if(_file == null ){
                                  _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("Please Selectioner Image")));
                                return;
                              }

                              upload(widget.employe.id,id,name,_titreController.text,_descriptionController.text);
                                             
                                  
                      },
                   ),
                 ),


                // Container(
                //   margin: EdgeInsets.only(left:16,top:30,bottom: 16,),
                //   child: Stack(
                //     alignment: Alignment.center,
                //     children: [
                //        Container(
                //         height: MediaQuery.of(context).size.height*0.25,
                //         decoration: BoxDecoration(
                //           color: kTextColor,
                //           borderRadius: BorderRadius.only(
                //             bottomLeft: Radius.circular(50),
                //           )
                //           ),
                //       ),

                //     Positioned(
                //       // top: 80,
                //       // left: 0,
                //       child: Container(
                //         padding: EdgeInsets.all(8),
                //         alignment:Alignment.center,
                //         width: 250,
                //       height: MediaQuery.of(context).size.height*0.08,
                //       decoration: BoxDecoration(
                //         color: kSecondryColor,
                //         borderRadius: BorderRadius.circular(50)
                //         ),
                //         child: Text("Demende Embouche",style: TextStyle(fontSize: 20,color: kTextColor),),
                //     ),
                //     )

                //     ],),
                // )








              ],

            ),
          ),
        ),
      ),
    );
  }
}