import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:mindcareflutterapp/screens/changePassword.dart';
import 'package:mindcareflutterapp/services/authServices.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool isLogin = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String username = '';

  void saveForm() {
    final validation = _formKey.currentState!.validate();
    if (!validation) {
      return;
    }
    _formKey.currentState!.save();

    AuthServices().ForgotPassword(username);

    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
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
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
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
                                borderRadius: BorderRadius.circular(20.0)),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Enter Username',
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
                          const SizedBox(
                            height: 30,
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
                              child: const Text(
                                'Send Code',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
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
