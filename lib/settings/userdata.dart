import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_orders.dart';

class UserDataScreen extends StatefulWidget {
  @override
  _UserDataScreenState createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  var isInit = true;
  var isLoading = false;
  @override


  void showErrorDialog(String message) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                backgroundColor:  const Color(0xffECC53C),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                title: Text(
                  message , textAlign: TextAlign.center,),
                content: null,
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 600),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }

  void didChangeDependencies() async {
    if (isInit) {

        setState(() {
          isLoading = true;
        });
        await Provider.of<UserOrders>(context).getUserDataFromDevice();
      setState(() {
        isLoading = false;
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height ;
    final totalWidth = MediaQuery.of(context).size.width ;
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: totalHeight,
              width: totalWidth ,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/backgrounddata.png',
                      ),
                      fit: BoxFit.cover)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                    width: 6,
                  ),
                ),
                padding: EdgeInsets.only(left: 0.056*totalWidth),
                margin: EdgeInsets.only(
                  top: 0.29*totalHeight,
                  right: 0.083*totalWidth,
                  bottom: 0.29*totalHeight,
                  left: 0.083*totalWidth,
                ),
                child: Consumer<UserOrders>(
                  builder: (context, userData, _) => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(color: Colors.white),
                              text: 'Name : \n',
                              children: <TextSpan>[
                            TextSpan(
                                text: '${userData.userName}',
                                style:  const TextStyle(color: Colors.yellow))
                          ])),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(color: Colors.white),
                              text: 'Mobile Number : \n',
                              children: <TextSpan>[
                                TextSpan(
                                    text: '${userData.userMobilNumber}',
                                    style:  const TextStyle(color: Colors.yellow))
                              ])),
                      RichText(
                          text: TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(color: Colors.white),
                              text: 'Email : \n',
                              children: <TextSpan>[
                                TextSpan(
                                    text: '${userData.userEmail}',
                                    style:  const TextStyle(color: Colors.yellow))
                              ])),

                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
