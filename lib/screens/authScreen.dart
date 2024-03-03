import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindcareflutterapp/screens/chatScreen.dart';
import 'dart:io';
import 'package:mindcareflutterapp/services/authServices.dart';
import 'package:mindcareflutterapp/screens/forgotPassword.dart';
import 'package:mindcareflutterapp/services/chatServices.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String username = '';
  File? image;
  bool showForm = false;
  double maxHeight = 450;
  late Timer _timer;
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animations();
     
    AuthServices().getToken().then((value) {
      
      if (value==null||value.isEmpty) {
       
      }else{
         Get.off(const ChatScreen());
      }
    });
  }

  @override
  void dispose() {
    _timer
        .cancel(); // Cancel the timer to prevent calling setState after dispose
    super.dispose();
  }

  void animations() {
    _timer = Timer(const Duration(seconds: 2), () {
      setState(() {
        showForm = true;
      });
    });
  }

  void saveForm(BuildContext context) {
    final validation = _formKey.currentState!.validate();
    if (!validation) {
      return;
    }
    _formKey.currentState!.save();
    if (!isLogin) {
      AuthServices().Login(email, password);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text('Account Type')),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      Navigator.of(context).pop(); // Close the dialog
                      await AuthServices()
                          .SignUp(username, email, password, 'parent');
                      _formKey.currentState!.reset();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromARGB(255, 1, 171, 33)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Parent',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      // Close the dialog
                      await AuthServices()
                          .SignUp(username, email, password, 'psychologist');
                      _formKey.currentState!.reset();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromARGB(255, 1, 171, 33)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Psychologist',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isLogin) {
      maxHeight = 400;
    } else {
      maxHeight = 500;
    }
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        decoration: const BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/images/image-remove.png')),
              const SizedBox(
                height: 26,
              ),
              AnimatedContainer(
                duration: const Duration(seconds: 2),
                height: showForm ? maxHeight : 0,
                curve: Curves.fastEaseInToSlowEaseOut,
                margin: const EdgeInsets.symmetric(horizontal: 25),
                padding: showForm
                    ? const EdgeInsets.symmetric(horizontal: 10)
                    : const EdgeInsets.symmetric(horizontal: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          if (isLogin)
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(98, 241, 241, 241),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    hintText: 'Username',
                                    border: InputBorder.none),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().length <= 0 ||
                                      value.isEmpty) {
                                    return 'Invalid username';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  username = value!;
                                },
                              ),
                            ),
                          if (isLogin)
                            const SizedBox(
                              height: 20,
                            ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(98, 241, 241, 241),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().length <= 0 ||
                                    value.isEmpty ||
                                    !value.contains('@')) {
                                  return 'Invalid email address';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                email = value!;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(98, 241, 241, 241),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  hintText: 'Password',
                                  border: InputBorder.none),
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().length <= 0 ||
                                    value.isEmpty) {
                                  return 'Invalid Password';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                password = value!;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              saveForm(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40.0)),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                isLogin ? 'Signup' : 'Login',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            const SizedBox(
                              height: 2,
                            ),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    isLogin = !isLogin;
                                  });
                                },
                                child: Text(
                                  isLogin
                                      ? 'Account exists?'
                                      : 'Create an account?',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.green),
                                )),
                            if (!isLogin) const Spacer(),
                            if (!isLogin)
                              TextButton(
                                  onPressed: () {
                                    if (!isLogin) {
                                      Get.to(const ForgotPasswordScreen(),
                                          transition: Transition.fadeIn,
                                          duration: const Duration(seconds: 1));
                                    }
                                  },
                                  child: const Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                        fontSize: 13),
                                  )),
                          ])
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
