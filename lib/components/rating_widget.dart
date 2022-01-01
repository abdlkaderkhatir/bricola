import 'package:flutter/material.dart';
class RatingWidget extends StatefulWidget {


  final int maximumRating;
  final Function(int) onRatingSelected;

  RatingWidget(this.onRatingSelected, [this.maximumRating = 5]);
  

  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
    int _currentRating = 0;
   Widget _buildRatingStar(int index) {

     if (index < _currentRating) {
      return Icon(Icons.star, color: Colors.orange);
    } else {
      return Icon(Icons.star_border_outlined);
    }

   }

   Widget _buildBody() {

      final stars = List<Widget>.generate(this.widget.maximumRating, (index) {
      return GestureDetector(
        child: _buildRatingStar(index),
        onTap: () {
          // print(index);
            setState(() {
              _currentRating = index + 1;
            });

          this.widget.onRatingSelected(_currentRating);
        },
      );
    });

    return Row(children: stars,mainAxisAlignment: MainAxisAlignment.center,);
   }


  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
  }