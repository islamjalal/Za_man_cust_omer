import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height ;
    final totalWidth = MediaQuery.of(context).size.width ;

    return Scaffold(

      body: Container(
        height: totalHeight,
        width: totalWidth,
        padding: EdgeInsets.only(bottom: 0.05 * totalHeight),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/pageone.jpg',
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisingButtons(
              title: 'عميل قديم',
              OnPressed: () {
                Navigator.of(context).pushNamed('SignIn');
              },
            ),
            RaisingButtons(
              title: 'عميل جديد',
              OnPressed: () {
                Navigator.of(context).pushNamed('SignUp');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RaisingButtons extends StatelessWidget {
  RaisingButtons({this.title, this.OnPressed});
  final String title;
  final Function OnPressed;
  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height ;
    final totalWidth = MediaQuery.of(context).size.width ;
    return RaisedButton(
      onPressed: OnPressed,
      color:  const Color(0xffECC53C),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.red)),
      child: Container(
        width: 0.36 * totalWidth, //180
        height: 0.094 * totalHeight, //80
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
