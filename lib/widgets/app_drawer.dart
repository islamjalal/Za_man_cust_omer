import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';


class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height ;
    final totalWidth = MediaQuery.of(context).size.width ;
    return Container(
      height: 0.47*totalHeight,
      decoration: const BoxDecoration(
          color: Color(0xffD6AC71),
          image: DecorationImage(
              image:
              AssetImage('assets/background.png'), fit: BoxFit.fill)),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 0.55*totalWidth, top: 0.05*totalHeight),
            height: 0.065*totalHeight,
            width: 0.6*totalWidth,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                    'UserDataScreen',);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 0.55*totalWidth, top: 0.006*totalHeight),
            height: 0.065*totalHeight,
            width: 0.6*totalWidth,
            child: InkWell(
                onTap: () => Navigator.pushNamed(context, 'ContactUs' , arguments: 0) ,

            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 0.55*totalWidth, top: 0.006*totalHeight),
            height: 0.06*totalHeight,
            width: 0.6*totalWidth,
            child: InkWell(
                onTap: () =>  Navigator.pushNamed(context, 'ContactUs' , arguments: 1) ,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 0.55*totalWidth, top: 0.006*totalHeight),
            height: 0.06*totalHeight,
            width: 0.6*totalWidth,
            child: InkWell(
              onTap: () =>  Navigator.pushNamed(context, 'ContactUs' , arguments: 2) ,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 0.55*totalWidth, top: 0.006*totalHeight),
            height: 0.06*totalHeight,
            width: 0.6*totalWidth,
            child: InkWell(
              onTap: () =>  Navigator.pushNamed(context, 'ContactUs' , arguments: 3) ,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 0.55*totalWidth, top: 0.006*totalHeight),
            height: 0.08*totalHeight,
            width: 0.6*totalWidth,
            child: Consumer<Auth>(
              builder: (context , auth , _) => InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/');
                  auth.logOut();

                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
