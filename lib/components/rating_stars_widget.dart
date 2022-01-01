import 'dart:ffi';

import 'package:flutter/material.dart';
class RatingStarsWidget extends StatefulWidget {
  final double rating;

  const RatingStarsWidget({Key key, this.rating}) : super(key: key);
  @override
  _RatingStarsWidgetState createState() => _RatingStarsWidgetState();
}

class _RatingStarsWidgetState extends State<RatingStarsWidget> {
   int maximumRating=5;
   Widget _buildRatingStar(int index) {

     if (index < widget.rating) {
      return Icon(Icons.star, color: Colors.orange);
    } else {
      return Icon(Icons.star_border_outlined);
    }

   }

   Widget _buildBody() {

      final stars = List<Widget>.generate(maximumRating, (index) {
      return  _buildRatingStar(index);
    });

    return Row(children: stars,mainAxisAlignment: MainAxisAlignment.center,);
   }


  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
  }