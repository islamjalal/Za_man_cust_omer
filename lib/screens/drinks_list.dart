import 'package:flutter/material.dart';




class DrinksList extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height ;
    final totalWidth = MediaQuery.of(context).size.width ;
    return Scaffold(
        body: Container(
         width: totalWidth,
         height: totalHeight,
         decoration: const BoxDecoration(
          image: DecorationImage(
          image: AssetImage('assets/drinks.jpg'),
          fit: BoxFit.fill,
          )),
         child: Column(
           children: <Widget>[
             Container(
               padding: EdgeInsets.only( top: 0.16*totalHeight , left: 0.48*totalWidth ),
               child: Container(
                 height: 0.15*totalHeight,
                 width: 0.52*totalWidth,
                 child: InkWell(
                   onTap: (){
                     Navigator.pushNamed(context, 'DrinkDetails',arguments: 'd1');
                   },

                 ),
               ),
             ),
             Container(
               padding:  EdgeInsets.only( top: 0.128*totalHeight , right: 0.48*totalWidth),
               child: Container(
                 height: 0.15*totalHeight,
                 width: 0.52*totalWidth,
                 child: InkWell(
                   onTap: (){
                     Navigator.pushNamed(context, 'DrinkDetails',arguments: 'd2');
                   },

                 ),
               ),
             ),
             Container(
               padding: EdgeInsets.only( top: 0.11*totalHeight , left: 0.48*totalWidth ),
               child: Container(
                 height: 0.15*totalHeight,
                 width: 0.52*totalWidth,
                 child: InkWell(
                   onTap: (){
                     Navigator.pushNamed(context, 'DrinkDetails',arguments: 'd3');
                   },

                 ),
               ),
             ),
           ],
         ),
    ));
  }
}
