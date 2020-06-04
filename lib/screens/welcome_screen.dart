import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../providers/user_orders.dart';
import 'package:provider/provider.dart';


class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  var isInit = true ;

  @override
  void didChangeDependencies() {
    if(isInit){
      Provider.of<UserOrders>(context,listen: false).getUserDataFromDevice();
    }
    isInit = false;
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height ;
    final totalWidth = MediaQuery.of(context).size.width ;


    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/pagethree.jpg'),
              fit: BoxFit.fill,

            )
        ),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 0.36*totalHeight, right: 0.5*totalWidth),
              child: Container(
                height: 0.217*totalHeight,
                width: 0.04*totalWidth,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'DrinksList');
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 0.56*totalWidth),
              child: Container(
                height: 0.188*totalHeight,
                width: 0.04*totalWidth,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'MealsList');
                  },
                ),
              ),
            ),
            SizedBox(
              height: 0.07*totalHeight,
            ),
            Container(
              padding: EdgeInsets.only(right: 0.84*totalWidth),
              child: Container(
                height: 0.08*totalHeight,
                width: 0.04*totalWidth,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return AppDrawer();
                        });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
