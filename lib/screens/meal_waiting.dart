import 'package:flutter/material.dart';

class MealWaiting extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height ;
    final totalWidth = MediaQuery.of(context).size.width ;
    final MealDescription =
        ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            width: totalWidth ,
            height: totalHeight,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/waitingmeals.png'),
              fit: BoxFit.fill,
            )),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 0.135*totalWidth, right: 0.113*totalWidth, bottom: 0.00005*totalHeight),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 0.57*totalHeight,
                      ),
                      Container(
                          width: 0.48*totalWidth,
                          height: 0.164*totalHeight,
                          child: Text(
                            MealDescription,
                            style: const TextStyle(
                                color: Color(0xff402208),
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.146*totalHeight,
                ),
                RaisedButton(
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, 'WelcomeScreen');
                  } ,

                  color: Color(0xffECC53C),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)),
                  child: Container(
                    width: 0.417*totalWidth,
                    height: 0.07*totalHeight,
                    child: const Center(
                      child: Text(
                        '!طلبات أخرى',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
