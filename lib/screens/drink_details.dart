import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:provider/provider.dart';
import '../providers/order.dart';
import '../providers/user_orders.dart';

class DrinkDetails extends StatefulWidget {
  @override
  _DrinkDetailsState createState() => _DrinkDetailsState();
}

class _DrinkDetailsState extends State<DrinkDetails> {
  var isLoading = false;
  var noOfOrders = 1;
  var price;


  double rating = 3;
  int starCount = 5;
  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height;
    final totalWidth = MediaQuery.of(context).size.width;
    final drinkId = ModalRoute.of(context).settings.arguments as String;
    final requiredDrink =
        Provider.of<Orders>(context, listen: false).findById(drinkId);

    return Scaffold(
      backgroundColor: Color(0xff5F9D98),
      body: isLoading
          ? Center(child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
      ))
          : SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/drinkdetails.jpg'),
                  fit: BoxFit.fill,
                )),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: 0.13 * totalWidth,
                          right: 0.11 * totalWidth,
                          bottom: 0.05 * totalHeight),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 0.515 * totalHeight,
                          ),
                          Container(
                              width: 0.55 * totalWidth,
                              height: 0.2 * totalHeight,
                              child: Text(
                                requiredDrink.description,
                                style: const TextStyle(
                                    color: Color(0xff402208),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                textAlign: TextAlign.center,
                              )),
                          SizedBox(
                            height: 0.045 * totalHeight,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Container(
                                    height: 0.05 * totalHeight,
                                    width: 0.15 * totalWidth,
                                    child: Text(
                                      '$noOfOrders',
                                      style: const TextStyle(
                                          color: Color(0xff402208),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                              SizedBox(
                                width: 0.17 * totalWidth,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                    height: 0.05 * totalHeight,
                                    width: 0.1 * totalWidth,
                                    child: Text(
                                      '${price == null ? requiredDrink.price : price}',
                                      style: const TextStyle(
                                          color: Color(0xff402208),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                              SizedBox(
                                width: 0.125 * totalWidth,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 0.07 * totalHeight,
                            width: 0.25 * totalWidth,
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                try {
                                  await Provider.of<UserOrders>(context,
                                          listen: false)
                                      .addingOrder(
                                          requiredDrink,
                                          Provider.of<UserOrders>(context,
                                                  listen: false)
                                              .trueOrfalse[0],
                                      price == null ? requiredDrink.price : price,
                                          noOfOrders,
                                          rating)
                                      .then((_) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  });
                                } catch (error) {
                                  return  showGeneralDialog(
                                      barrierColor: Colors.black.withOpacity(0.5),
                                      transitionBuilder: (context, a1, a2, widget) {
                                        return Transform.scale(
                                          scale: a1.value,
                                          child: Opacity(
                                            opacity: a1.value,
                                            child: AlertDialog(
                                              backgroundColor: const Color(0xffECC53C),
                                              shape:  OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(16.0)),
                                              title: Text(
                                                'تحقق من وجود انترنت أولا' , textAlign: TextAlign.center,),
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

                                Navigator.pushReplacementNamed(
                                    context, 'DrinkWaiting',
                                    arguments: requiredDrink.preparingTime);
                              },
                              child: Text(''),
                            ),
                          ),
                          SizedBox(
                            width: 0.12 * totalWidth,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: Color(0xffEFDAC5),
                                shape: BoxShape.circle
                            ),

                            height: 0.055 * totalHeight,
                            width: 0.06 * totalHeight,
                            child: IconButton(
                              onPressed: () {
                                if (!(noOfOrders < 1) && !(noOfOrders > 9)) {
                                  setState(() {
                                    noOfOrders = ++noOfOrders;
                                    price = noOfOrders * requiredDrink.price;
                                    print(noOfOrders);
                                    print(price);
                                  });
                                } else {
                                  setState(() {
                                    noOfOrders = 1;
                                    price = noOfOrders * requiredDrink.price;
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.add,
                                size: 25,
                                color: Color(0xff402208),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 0.08 * totalWidth,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: Color(0xffEFDAC5),
                                shape: BoxShape.circle
                            ),
                            height: 0.055 * totalHeight,
                            width: 0.06 * totalHeight,
                            child: IconButton(
                              onPressed: () {
                                if (!(noOfOrders < 2) && !(noOfOrders > 11)) {
                                  setState(() {
                                    noOfOrders = --noOfOrders;
                                    price = noOfOrders * requiredDrink.price;
                                  });
                                } else {
                                  setState(() {
                                    noOfOrders = 10;
                                    price = noOfOrders * requiredDrink.price;
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.remove,
                                size: 25,
                                color: Color(0xff402208),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: 0.063 * totalWidth,
                            bottom: 0.01 * totalHeight),
                        child: StarRating(
                          size: 20.0,
                          rating: rating,
                          color: Colors.orange,
                          borderColor: Colors.grey,
                          starCount: starCount,
                          onRatingChanged: (rating) => setState(
                            () {
                              this.rating = rating;
                            },
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
