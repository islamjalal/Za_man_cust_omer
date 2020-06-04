import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';



class starrating extends StatefulWidget {

 starrating({this.OnRatingChanged , this.rating , this.starCount , this.Colour});
 final Function OnRatingChanged ;
 final double rating ;
 final int starCount ;
 final Color Colour ;





  @override
  _starratingState createState() => _starratingState();
}

class _starratingState extends State<starrating> {

  @override


  @override

  Widget build(BuildContext context) {
    return StarRating(
      size: 20.0,
      rating: widget.rating,
      color: widget.Colour,
      //Color(0xff795B41), // Color(0xff70ADA8)
      borderColor:  const Color(0xff795B41),
      starCount: widget.starCount,
      onRatingChanged: widget.OnRatingChanged ,

    );
  }
}