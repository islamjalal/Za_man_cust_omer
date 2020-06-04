import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {


  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  String text = '' ;


  List<String> texts = [
    'Mail : Zaman@gmail.com  \n   \nNumber : +20123456789 ',
    'The App is set to its default settings !!',
    'Zaman is a local restaurant which provides the meal-delivary-sevices in Cairo and its branches !!',
    'The points\' number is not available at this moment !! ',
  ];


  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height ;
    final totalWidth = MediaQuery.of(context).size.width ;
    final textIndex =  ModalRoute.of(context).settings.arguments as int ;
    text = texts[textIndex];
    return Scaffold(

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/backgrounddata.png',
                ),
                fit: BoxFit.fill)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
              width: 6,
            ),
          )
          ,
          padding:  const EdgeInsets.all( 20 ),
          margin: EdgeInsets.only(
            top: 0.3*totalHeight , right: 0.063*totalWidth ,
            bottom: 0.3*totalHeight , left: 0.063*totalWidth ,
          ),


          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Center(
                child: Text( text ,
                  style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
