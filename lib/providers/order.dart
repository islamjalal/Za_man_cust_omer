

import 'package:flutter/cupertino.dart';


class Order  {
  Order({this.name,this.price, this.id, this.description, this.NoOfOrders,this.preparingTime});
  final String name;
  final String id;
  final int price;
  final String description;
  final int NoOfOrders;
  final String preparingTime ;




}


class Orders with ChangeNotifier {

  List<Order> _orders = [
    Order(
      id: 'm1',
      name: 'وجبة كفتة', // 'Koffta meal'
      price: 75,
      description: 'خمس قطع من اللحم يتم تتبيلها و شيها بأسياخ على الفحم'
      , // 'Aromatic and savory spices are added to the meat and it is shaped around a skewer for grilling. It is a lot like a sausage, but without the casing'
      NoOfOrders: 1,
      preparingTime: 'جاري إعداد الوجبة خلال 30 دقيقة' , // 'The meal will be ready in 30 minutes !!'
    ),
    Order(
      id: 'm2',
      name:'وجبة بيض' , // 'Eggs meal'
      price: 15,
      description: 'يتم طهو البيض بطريقة الأومليت أو سلقه أو قليه فى الزيت المقلى '
      , // 'Refrigerated foods are heated. Shredded cheese and room temperature foods, such as jams and jellies, are fine as is.'
      NoOfOrders: 1,
      preparingTime: 'جاري إعداد الوجبة خلال 20 دقيقة',
    ),
    Order(
      id: 'm3',
      name: 'وجبة تونة' , // 'Tona meal'
      price: 20,
      description: 'طبق من لحم التونة المحاط بأوراق الخس وقطع الطماطم الطازجة'
      , // 'A tuna salad with the crunchiness of fresh vegetables on a plate lined with lettuce leaves and garnish with quartered tomatoes.'
      NoOfOrders: 1,
      preparingTime: 'جاري إعداد الوجبة خلال 25 دقيقة',
    ),
    Order(
      id: 'd1',
      name: 'مشروب قهوة' , // 'Coffee drink'
      price: 12,
      description: 'يتم إعداد 95 ملى جرام من الكافيين مع ملعقتى سكر فى فنجان قهوة متوسط الحجم'
      , // 'You can expect to get around 95 mg of caffeine from an average cup of coffee.'
      NoOfOrders: 1,
      preparingTime: 'جاري إعداد المشروب خلال 15 دقيقة',
    ),
    Order(
      id: 'd2',
      name: "مشروب كوكتيل", // 'Coctel drink'
      price: 20,
      description: "مزيج من عصارة الفواكه مع الكريمة أعلاه"
      ,
      // 'a combination of spirits, or one or more spirits mixed with other ingredients such as fruit juice, flavored syrup, or cream.'
      NoOfOrders: 1,
      preparingTime: 'جاري إعداد المشروب خلال 15 دقيقة',
    ),
    Order(
      id: 'd3',
      name: "مشروب عصير" , // 'Juice drink'
      price: 15,
      description: "ليمون , تفاح , مشمش , فراولة", // 'Limoon , Sahlab , Karkade or Yansoon'
      NoOfOrders: 1,
      preparingTime: 'جاري إعداد المشروب خلال 15 دقيقة',
    ),
  ];

 List<Order> get orders {
   return [..._orders];
 }

 Order findById (String id ){
   return orders.firstWhere((meal)=> meal.id == id );
 }








}


