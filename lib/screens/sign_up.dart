import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../models/http_exception.dart';
import '../providers/user_orders.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Map<String, String> _authData = {
    'name': '',
    'password': '',
    'mobileNumber': '',
    'email': '',
  };

  final passwordFocusNode = FocusNode();
  final confirmFocusNode = FocusNode();
  final mobileFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final passwordController = TextEditingController();

  var isLoading = false;

  void showErrorDialog(String message) {
      showGeneralDialog(
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

  @override
  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      isLoading = true;
    });

    try {
      await Provider.of<Auth>(context, listen: false)
          .signUp(_authData['email'], _authData['password']);
    } on HttpException catch (error) {
      var errorMessage = 'فشل الدخول';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'هذا الإيميل الذى أدخلته يتم استخدامه بواسطة مستخدم آخر';
      } else if (error.toString().contains('OPERATION_NOT_ALLOWED')) {
        errorMessage = 'غير مسموح بإجراء عملية دخولك';
      } else if (error.toString().contains('TOO_MANY_ATTEMPTS_TRY_LATER')) {
        errorMessage = 'حاول مرة أخرى لاحقا';
      }
      showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'تحقق من وجود انترنت أولا';
      showErrorDialog(errorMessage);
    }
    if (Provider.of<Auth>(context, listen: false).isAuth) {


     await  Provider.of<UserOrders>(context, listen: false).saveUserData(
          _authData['name'], _authData['mobileNumber'], _authData['email']);

     Navigator.of(context).pushReplacementNamed('/');



    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height;
    final totalWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffE8D6AB),
      body: isLoading
          ? Center(child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
      ))
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/pagetwo.png'),
                    fit: BoxFit.fill,
                  )),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.only(
                        bottom: 0.05 * totalHeight,
                        top: 0.28 * totalHeight,
                        left: 0.03 * totalWidth,
                        right: 0.03 * totalWidth),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 7,
                          child: Container(
                            padding: EdgeInsets.all(0.03 * totalWidth),
                            decoration: BoxDecoration(
                              color: const Color(0xffEAD2AE),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Text(
                                    'التسجيل',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      width: 0.9*totalWidth,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          labelText: 'Name',
                                          labelStyle:
                                              Theme.of(context).textTheme.title,
                                          prefixIcon: const Icon(
                                            Icons.person,
                                            size: 20,
                                          ),
                                          suffixStyle: const TextStyle(
                                            fontSize: 40,
                                            color: Colors.white,
                                          ),
                                          filled: true,
                                          fillColor: const Color(0xffA99575),
                                        ),
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(25),
                                          WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]"),
                                          )
                                        ],
                                        obscureText: false,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (_) {
                                          FocusScope.of(context)
                                              .requestFocus(mobileFocusNode);
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Enter your name';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          _authData['name'] = value;
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      width: 0.9*totalWidth,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          labelText: 'Mobile Number',
                                          labelStyle:
                                              Theme.of(context).textTheme.title,
                                          prefixIcon: const Icon(
                                            Icons.mobile_screen_share,
                                            size: 20,
                                          ),
                                          suffixStyle: const TextStyle(
                                            fontSize: 40,
                                            color: Colors.white,
                                          ),
                                          filled: true,
                                          fillColor: const Color(0xffA99575),
                                        ),
                                        inputFormatters: [
                                          WhitelistingTextInputFormatter(RegExp("[0-9]")),
                                          LengthLimitingTextInputFormatter(11),
                                        ],
                                        obscureText: false,
                                        focusNode: mobileFocusNode,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (_) {
                                          FocusScope.of(context)
                                              .requestFocus(emailFocusNode);
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Enter your mobile number';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          _authData['mobileNumber'] = value;
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      width: 0.9*totalWidth,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          labelText: 'Email',
                                          labelStyle:
                                              Theme.of(context).textTheme.title,
                                          prefixIcon: const Icon(
                                            Icons.mail,
                                            size: 20,
                                          ),
                                          suffixStyle: const TextStyle(
                                            fontSize: 40,
                                            color: Colors.white,
                                          ),
                                          filled: true,
                                          fillColor: const Color(0xffA99575),
                                        ),
                                        inputFormatters: [
                                          BlacklistingTextInputFormatter(RegExp("[ ]"))
                                        ],
                                        obscureText: false,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        focusNode: emailFocusNode,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (_) {
                                          FocusScope.of(context)
                                              .requestFocus(passwordFocusNode);
                                        },
                                        validator: (value) {
                                          if (value.isEmpty ||
                                              !value.contains('@')) {
                                            return 'Enter your email correctly';
                                          }

                                          return null;
                                        },
                                        onSaved: (value) {
                                          _authData['email'] = value;
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      width: 0.9*totalWidth,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          labelText: 'Password',
                                          labelStyle:
                                              Theme.of(context).textTheme.title,
                                          prefixIcon: const Icon(
                                            Icons.lock,
                                            size: 20,
                                          ),
                                          suffixStyle: const TextStyle(
                                            fontSize: 40,
                                            color: Colors.white,
                                          ),
                                          filled: true,
                                          fillColor: const Color(0xffA99575),
                                        ),
                                        inputFormatters: [
                                          BlacklistingTextInputFormatter(RegExp("[ ]"))
                                        ],
                                        obscureText: true,
                                        keyboardType:
                                            TextInputType.text,
                                        controller: passwordController,
                                        focusNode: passwordFocusNode,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (_) {
                                          FocusScope.of(context)
                                              .requestFocus(confirmFocusNode);
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Enter your password';
                                          }
                                          if (value.length < 5) {
                                            return 'Password is too short!';
                                          }

                                          return null;
                                        },
                                        onSaved: (value) {
                                          _authData['password'] = value;
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      width: 0.9*totalWidth,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          labelText: 'Confirm Password',
                                          labelStyle:
                                              Theme.of(context).textTheme.title,
                                          prefixIcon: const Icon(
                                            Icons.lock,
                                            size: 20,
                                          ),
                                          suffixStyle: const TextStyle(
                                            fontSize: 40,
                                            color: Colors.white,
                                          ),
                                          filled: true,
                                          fillColor: const Color(0xffA99575),
                                        ),
                                        obscureText: true,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        focusNode: confirmFocusNode,
                                        textInputAction: TextInputAction.done,
                                        validator: (value) {
                                          if (value !=
                                              passwordController.text) {
                                            return 'Passwords do not match!';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 0.024 * totalHeight,
                        ),
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            onPressed: () {
                              _submit();
                            },
                            color: const Color(0xffECC53C),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: const Center(
                                child: Text(
                                  'رجعني زمان',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
