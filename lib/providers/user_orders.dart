import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../providers/order.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class UserOrder {
  UserOrder({ this.orderName, this.orderPrice, this.orderDate,this.orderTime});
  final String orderName;
  final int orderPrice;
  final String orderTime;
  final String orderDate;
}

class UserOrders with ChangeNotifier {
  UserOrders(this.authToken, this.userId);

  final String authToken;
  final String userId;

  String userMobilNumber ;
  String userName ;
  String userEmail ;


  var trueOrfalse = [];

  Future<void> addingOrder(Order order, bool X , var price , var noOfOrders , double rating) async {
    if (X) {
      return _addOrder(order, 'deliveryOrders', price ,  noOfOrders , rating);
    } else {
      return _addOrder(order, 'zamanOrders', price ,  noOfOrders , rating );
    }
  }

  Future<void> getUserDataFromDevice()async{

    final pref = await SharedPreferences.getInstance();

    if(!pref.containsKey('userInfomation')){
      userMobilNumber = 'not Available now';
      userName = 'not Available now';
      userEmail = 'not Available now';
      return true ;
    }
    final extractedUserData = json.decode(pref.getString('userInfomation')) as Map<String , Object> ;
    userMobilNumber =  extractedUserData['userMobilNumber'] ;
    userName = extractedUserData['userName'] ;
    userEmail = extractedUserData['userEmail'];
    notifyListeners();
    return true ;
  }


  Future<void> _addOrder(Order order, String fileName , price , noOfOrders , rating) async {
    final url =
        'https://zaman-8acf7.firebaseio.com/$fileName.json?auth=$authToken';
    try {
      final timestamp = DateTime.now();
      final response = await http.post(url,
          body: json.encode({
            'orderDate': DateFormat("dd-MM-yyyy").format(timestamp),
            'orderTime': DateFormat("H:mm").format(timestamp),
            'orderName': order.name,
            'orderPrice': price.toString(),
            'noOfOrders': noOfOrders.toString(),
            'rating' : rating.toString(),
            'userName': userName ,
            'userMobilNumber': userMobilNumber,
            'userId':userId,
          }));

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }


  Future<void> saveUserData(String name, String mobileNumber,
      String email) async {
      final pref = await SharedPreferences.getInstance();
      final userInformation = json.encode({
        'userName': name,
        'userMobilNumber':mobileNumber,
        'userEmail':email,
      });
      pref.setString('userInfomation', userInformation);
      notifyListeners();
  }

}