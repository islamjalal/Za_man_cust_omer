import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/http_exception.dart';
import '../providers/auth.dart';
import 'package:flutter/services.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  final passwordFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey();

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
                backgroundColor: const Color(0xffECC53C),
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
          .signIn(_authData['email'], _authData['password']);
    } on HttpException catch (error) {
      //USER_DISABLED
      var errorMessage = 'فشل الدخول';
      if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'فشل العثور على إيميل كهذا فى قاعدة بياناتنا';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'كلمة المرور ضعيفة جدا';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'كلمة المرور غير صحيحة';
      } else if (error.toString().contains('USER_DISABLED')) {
        errorMessage =
            'تم حظر هذا المستخدم بواسطة الإدارة';
      }
      showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'تحقق من وجود انترنت أولا';
      showErrorDialog(errorMessage);
    }
    if (Provider.of<Auth>(context, listen: false).isAuth) {
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
      backgroundColor: Color(0xffE8D6AB),
      body: isLoading
          ? Center(child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
      ))
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
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
                        top: 0.45 * totalHeight,
                        left: 0.03 * totalWidth,
                        right: 0.03 * totalWidth),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 10,
                          child: Container(
                            padding: EdgeInsets.all(0.035 * totalWidth),
                            decoration: BoxDecoration(
                              color: const Color(0xffEAD2AE),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.all(0.01*totalHeight),
                                      child: const Text(
                                        'تسجيل الدخول',
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
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
                                      keyboardType: TextInputType.emailAddress,
                                      obscureText: false,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context)
                                            .requestFocus(passwordFocusNode);
                                      },
                                      validator: (value) {
                                        if (value.isEmpty ||
                                            !value.contains('@')) {
                                          return 'Enter your Email correctly';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _authData['email'] = value;
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
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
                                        suffixStyle: TextStyle(
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
                                      focusNode: passwordFocusNode,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Enter your password';
                                        }
                                        if (value.length <= 5) {
                                          return 'Password is too short';
                                        }

                                        return null;
                                      },
                                      onSaved: (value) {
                                        _authData['password'] = value;
                                      },
                                    ),
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
                          flex: 2,
                          child: RaisedButton(
                            onPressed: () {
                              _submit();
                            },
                            color: const Color(0xffECC53C),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red)),
                            child: Container(
                              // margin: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: const Center(
                                child: Text(
                                  'تفضل بالدخول',
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
