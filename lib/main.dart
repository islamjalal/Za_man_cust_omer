import 'package:flutter/material.dart';
import 'screens/firstscreen.dart';
import 'screens/welcome_screen.dart';
import 'screens/meals_list.dart';
import 'screens/meal_details.dart';
import 'screens/drinks_list.dart';
import 'screens/drink_details.dart';
import 'settings/userdata.dart';
import 'settings/contactus.dart';
import 'screens/sign_in.dart';
import 'screens/sign_up.dart';
import 'package:provider/provider.dart';
import './providers/order.dart';
import './screens/meal_waiting.dart';
import './screens/drink_waiting.dart';
import './providers/user_orders.dart';
import './providers/auth.dart';
import './widgets/splash_screen.dart';
import './screens/in_or_out.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth, UserOrders>(
          create: null,
          update: (ctx, auth, previousOrders) => UserOrders(
            auth.token,
            auth.userId,
          ),
        ),
        ChangeNotifierProvider.value(value: Orders()),
        //ChangeNotifierProvider.value(value: Users()),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
              textTheme: TextTheme(
                  title: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ))),
          home: auth.isAuth
              ? InOrOutScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : FirstScreen(), //UserData
                ),
          routes: {
            'UserDataScreen': (context) => UserDataScreen(),
            'InOrOutScreen': (context) => InOrOutScreen(),
            'FirstScreen': (context) => FirstScreen(),
            'SignUp': (context) => SignUp(),
            'SignIn': (context) => SignIn(),
            'WelcomeScreen': (context) => WelcomeScreen(),
            'MealsList': (context) => MealsList(),
            'DrinksList': (context) => DrinksList(),
            'MealDetails': (context) => MealDetails(),
            'DrinkDetails': (context) => DrinkDetails(),
            'ContactUs': (context) => ContactUs(),
            'MealWaiting': (context) => MealWaiting(),
            'DrinkWaiting': (context) => DrinkWaiting(),
          },
        ),
      ),
    );
  }
}
