import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:mindcareflutterapp/services/authServices.dart';
import 'package:mindcareflutterapp/screens/forgotPassword.dart';

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
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showForm = true;
      });
    });
    super.initState();
  }

  void saveForm() {
    final validation = _formKey.currentState!.validate();
    if (!validation) {
      return;
    }
    _formKey.currentState!.save();
    if (!isLogin) {
      AuthServices().Login(username, password);
    } else {
      AuthServices().SignUp(username, email, password);
    }
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    if (!isLogin) {
      maxHeight = 300;
    } else {
      maxHeight = 400;
    }
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 234, 241, 255),
          Color.fromARGB(255, 255, 249, 223)
        ])),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/images/mindcare-logo.png')),
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
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                               color: Color.fromARGB(255, 255, 252, 252),
                               borderRadius: BorderRadius.circular(20.0)
                            ),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Username',
                                border: InputBorder.none
                              ),
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
                          if (isLogin)
                               Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                               color: Color.fromARGB(255, 255, 252, 252),
                               borderRadius: BorderRadius.circular(20.0)
                            ),
                            child:
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                border: InputBorder.none
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
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                               color: Color.fromARGB(255, 255, 252, 252),
                               borderRadius: BorderRadius.circular(20.0)
                            ),
                            child:
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              border: InputBorder.none
                            ),
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
                            onTap: saveForm,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.blue,
                                  Color.fromARGB(255, 22, 7, 234)
                                ]),
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
                          SizedBox(height: 10,),
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
                                      color: Color.fromARGB(255, 65, 52, 255)),
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
                                        color: Color.fromARGB(255, 23, 7, 255),
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
