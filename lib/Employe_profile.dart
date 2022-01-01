import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfirstapp/Edit_profile.dart';
import 'package:myfirstapp/components/Profile_widget.dart';
import 'package:myfirstapp/components/number_widget.dart';
import 'package:myfirstapp/models/user.dart';
import 'package:myfirstapp/util/pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeProfile extends StatefulWidget {
  // const EmployeProfile({ Key? key }) : super(key: key);

  @override
  _EmployeProfileState createState() => _EmployeProfileState();
}

class _EmployeProfileState extends State<EmployeProfile> {
  User user=UserPreferences().myUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        leading: BackButton(color: Colors.white,),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(icon:Icon(Icons.logout,color: Colors.white,),
          onPressed: () async {
             SharedPreferences preferences = await SharedPreferences.getInstance();
              preferences.remove("name");
              preferences.remove("id");
              // preferences.commit();
               Navigator.pushReplacementNamed(context, '/clientoremploye');
          },),
        ],
      ),
      body: Column(
        children: [
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: (){
               Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditProfile()),
                  );
            },
            isEdit:false,
          ),
           const SizedBox(height: 24),
              buildName(user),
              // const SizedBox(height: 24),
              // Center(child: buildUpgradeButton()),
              const SizedBox(height: 24),
              NumbersWidget(),
              const SizedBox(height: 48),
              // buildAbout(user),

             Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     FlatButton(onPressed: (){},child:Container(
                       padding: EdgeInsets.all(10),
                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                       border: Border.all(color: Colors.white)
                       ),
                       child: Text("Modifier les Information",style: TextStyle(fontSize: 18,color: Colors.white),)),),
                       SizedBox(height: 20,),
                     FlatButton(onPressed: (){},child:Container(
                       padding: EdgeInsets.all(10),
                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                       border: Border.all(color: Colors.white),
                       ),
                       child: Text("Se deconecter",style: TextStyle(fontSize: 18,color: Colors.white),)),),
             
                   ]
                ),
              ),
            
      ],
      ),
      );


  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.white),
          )
        ],
      );

  // Widget buildUpgradeButton() => ButtonWidget(
  //       text: 'Upgrade To PRO',
  //       onClicked: () {},
  //     );

  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              user.about,
              style: TextStyle(fontSize: 16, height: 1.4,color: Colors.white),
            ),
          ],
        ),
      );
}