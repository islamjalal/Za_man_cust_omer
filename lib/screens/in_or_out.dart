import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaman/providers/user_orders.dart';
import '../widgets/app_drawer.dart';


class InOrOutScreen extends StatefulWidget {
  @override
  _InOrOutScreenState createState() => _InOrOutScreenState();
}

class _InOrOutScreenState extends State<InOrOutScreen> {


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
              image: AssetImage('assets/inOrOut.jpg'),
              fit: BoxFit.fill,

            )
        ),
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 0.49*totalHeight, left: 0.6*totalWidth ),
                  child: Container(
                    // color: Colors.red,
                    height: 0.27 *totalHeight,
                    width: 0.4*totalWidth,
                    child: Consumer<UserOrders>(
                      builder: (ctx , ordersData , _) =>  InkWell(
                        onTap: () {
                          ordersData.trueOrfalse.insert(0, true);
                          print(ordersData.trueOrfalse);
                          Navigator.pushNamed(context, 'WelcomeScreen');
                        },
                      ),
                    ) ,

                  ),
                ),
                Container(
                   padding: EdgeInsets.only(top: .32 * totalHeight),
                  child: Container(
                   // color: Colors.white,
                    height: 0.26 *totalHeight,
                    width: 0.45*totalWidth,
                    child:  Consumer<UserOrders>(
                      builder: (ctx , ordersData , _) =>  InkWell(
                        onTap: () {
                          ordersData.trueOrfalse.insert(0, false);
                          print(ordersData.trueOrfalse);
                          Navigator.pushNamed(context, 'WelcomeScreen');
                        },
                      ),
                    ),),
                  ),

              ],
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
