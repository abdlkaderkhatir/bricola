import 'dart:io';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class Images extends StatefulWidget {
  // const Images({ Key? key }) : super(key: key);

  @override
  _ImagesState createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
 File _file;


 Future pickercamera()async{
   final myfile=await ImagePicker().getImage(source: ImageSource.gallery);
   setState(() {
     _file=File(myfile.path);
   });
 }



 Future upload() async {

   if(_file==null) return ;
   String base64 = convert.base64Encode(_file.readAsBytesSync());
   String imagename=_file.path.split("/").last;
   String image=imagename.substring(0,7)+imagename.substring(12);
    print(imagename);
    print(image);
    print(base64);
  
    var url = "http://192.168.1.39//werikhedmtk/image.php";
                  var data = new Map<String, dynamic>();
                                data['imagename']=image;
                                data['base64']=base64;
                  print(data.toString());

                  var response= await http.post(url, body: data,);
   
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('image'),
      ),
      body: Container(
        child: Column(
          children: [
            RaisedButton(
              child: Text("get image"),
              onPressed: (){
                pickercamera();
              }
            ),
           Center(child:_file == null ?Text("Image Not Selected"):Image.file(_file,height: MediaQuery.of(context).size.height*0.5,) ,),
            RaisedButton(
              child: Text("upload image"),
              onPressed: (){
                upload();
              }
            ),
          ],
        ),
      ),
    );
  }
}