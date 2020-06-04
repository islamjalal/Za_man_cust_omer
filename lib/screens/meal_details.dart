import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:provider/provider.dart';
import '../providers/order.dart';
import '../providers/user_orders.dart';

class MealDetails extends StatefulWidget {
  @override
  _MealDetailsState createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  var isLoading = false;
  var noOfOrders = 1;
  var price;

  double rating = 3;
  int starCount = 5;
  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height;
    final totalWidth = MediaQuery.of(context).size.width;
    final mealID = ModalRoute.of(context).settings.arguments as String;
    final requiredMeal =
        Provider.of<Orders>(context, listen: false).findById(mealID);
    return Scaffold(
      backgroundColor: const Color(0xff7F5336),
      body: isLoading
          ? Center(child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
      ))
          : SingleChildScrollView(
              child: Container(
                width: totalWidth,
                height: totalHeight,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/mealdetails.jpg'),
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
                              height: 0.215 * totalHeight,
                              child: Text(
                                requiredMeal.description,
                                style: TextStyle(
                                    color: Color(0xff402208),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                textAlign: TextAlign.center,
                              )),
                          SizedBox(
                            height: 0.03 * totalHeight,
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
                                  ),
                                ),
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
                                    '${price == null ? requiredMeal.price : price}',
                                    style: const TextStyle(
                                        color: Color(0xff402208),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
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
                                          requiredMeal,
                                          Provider.of<UserOrders>(context,
                                                  listen: false)
                                              .trueOrfalse[0],
                                      price == null ? requiredMeal.price : price,
                                          noOfOrders,
                                          rating)
                                      .then((_) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  });
                                } catch (error) {
                                  return showGeneralDialog(
                                      barrierColor: Colors.black.withOpacity(0.5),
                                      transitionBuilder: (context, a1, a2, widget) {
                                        return Transform.scale(
                                          scale: a1.value,
                                          child: Opacity(
                                            opacity: a1.value,
                                            child: AlertDialog(
                                              backgroundColor: Color(0xffECC53C),
                                              shape: OutlineInputBorder(
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
                                    context, 'MealWaiting',
                                    arguments: requiredMeal.preparingTime);
                              },
                              child: Text(''),
                            ),
                          ),
                          SizedBox(
                            width: 0.12 * totalWidth,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: Color(0xffE9C590),
                                shape: BoxShape.circle
                            ),
                            height: 0.055 * totalHeight,
                            width: 0.06 * totalHeight,
                            child: IconButton(
                              onPressed: () {
                                if (!(noOfOrders < 1) && !(noOfOrders > 9)) {
                                  setState(() {
                                    noOfOrders = ++noOfOrders;
                                    price = noOfOrders * requiredMeal.price;
                                  });
                                } else {
                                  setState(() {
                                    noOfOrders = 1;
                                    price = noOfOrders * requiredMeal.price;
                                  });
                                }
                              },
                              icon: const Icon(
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
                                color: Color(0xffE9C590),
                                shape: BoxShape.circle
                            ),
                            height: 0.055 * totalHeight,
                            width: 0.06 * totalHeight,
                            child: IconButton(
                              onPressed: () {
                                if (!(noOfOrders < 2) && !(noOfOrders > 11)) {
                                  setState(() {
                                    noOfOrders = --noOfOrders;
                                    price = noOfOrders * requiredMeal.price;
                                  });
                                } else {
                                  setState(() {
                                    noOfOrders = 10;
                                    price = noOfOrders * requiredMeal.price;
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
