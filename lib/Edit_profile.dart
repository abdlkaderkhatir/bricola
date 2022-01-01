import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfirstapp/components/Profile_widget.dart';
import 'package:myfirstapp/util/pref.dart';

import 'components/textfield_widget.dart';
import 'models/user.dart';
class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  User user = UserPreferences().myUser;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading: BackButton(color: Colors.black,),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(icon:Icon(CupertinoIcons.moon_stars,color: Colors.black,),onPressed: (){},),
        ],
      ),

      body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              // physics: BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath: user.imagePath,
                  isEdit: true,
                  onClicked: () async {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Full Name',
                  text: user.name,
                  onChanged: (name) {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Email',
                  text: user.email,
                  onChanged: (email) {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'About',
                  text: user.about,
                  maxLines: 5,
                  onChanged: (about) {},
                ),
              ],
            ),
      
    );
  }
}