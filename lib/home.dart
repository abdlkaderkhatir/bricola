import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfirstapp/client_or_employe.dart';

import 'package:myfirstapp/models/ExplanationData.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  


@override
  void initState() {
    //  getPref();
    super.initState();
  }


   final _controller = PageController(initialPage: 0);

   int _currentIndex = 0;

 
  @override
  Widget build(BuildContext context) {
     return Scaffold(
         body: SafeArea(
          child: Column(
            children: [
              Expanded(
               child: PageView.builder( 
                 controller: _controller,
                 onPageChanged: (int index){
                   setState(() {
                     _currentIndex=index;
                   });
                 },
                 itemCount: data.length,
                 itemBuilder: (context,index){
                   return Padding(
                    padding: EdgeInsets.all(40),
                    child: Column(
                       children: [
                         SvgPicture.asset(data[index].localImageSrc ,
                            height: MediaQuery.of(context).size.height * 0.33,
                            alignment: Alignment.center),
                          SizedBox(height: 30,),
                         Text(data[index].title,style: Theme.of(context).textTheme.headline6,) ,
                         SizedBox(height: 20,),
                         Text( data[index].description,style: TextStyle(fontSize: 18,color: Colors.grey,),textAlign:TextAlign.center,)   
                          
                       ],
                     ),
                   );
                 },
               ),
              ),
              Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:List.generate(data.length, (index) => Container(
                      height: 10,
                      width: _currentIndex == index ? 15 : 10,
                      margin: EdgeInsets.only(right: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue[800],
                      ),
                      

                    )),
                  ),
              ),
              Container(
                margin:EdgeInsets.symmetric(horizontal: 40,vertical: 20) ,
                height: 55,
                width: double.infinity,
                
                child: FlatButton(
                  onPressed: (){
                    if(_currentIndex==data.length-1){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ClientOrEmploye()));
                    }
                    _controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                  },
                  color: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  textColor: Colors.white,
                  child: _currentIndex==(data.length-1) ? Text("Continue") :Text("Next"),
                   ),
              )
            ],
          ),
         ),
     );

  }
  
}