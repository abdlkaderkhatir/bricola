import 'package:flutter/material.dart';
import 'package:myfirstapp/constants.dart';
class SearchBox extends StatelessWidget {
  SearchBox({
    Key key, this.onChanged, this.controller,
  }) : super(key: key);
  final ValueChanged onChanged;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding/4,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller ,
        onChanged: onChanged,
        style: TextStyle(color:Colors.white),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          icon:Icon(Icons.search_outlined),
          hintText: 'Search',
          hintStyle: TextStyle(color:Colors.white)
        ),
      ),
    );
  }
}