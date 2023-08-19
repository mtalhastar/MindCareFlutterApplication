import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mindcareflutterapp/screens/authScreen.dart';
import 'dart:io';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:mindcareflutterapp/services/authServices.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool isLogin = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String password = '';
  String verificationPin = '';

  void saveForm() {
    final validation = _formKey.currentState!.validate();
    if (!validation) {
      return;
    }
    if (verificationPin.isEmpty) {
      Get.snackbar('PIN:', ' is Empty');
      return;
    }
    _formKey.currentState!.save();
     AuthServices().ChangePassword(verificationPin, password);
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
                height: 30,
              ),
              const Text(
                'Enter verification code sent to your Email',
                style: TextStyle(color: Color.fromARGB(255, 62, 129, 255)),
              ),
              const SizedBox(
                height: 20,
              ),
              OTPTextField(
                length: 6,
                width: 200,
                fieldWidth: 30,
                style: const TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 114, 126, 255)),
                textFieldAlignment: MainAxisAlignment.spaceBetween,
                fieldStyle: FieldStyle.underline,
                onCompleted: (pin) {
                  verificationPin = pin;
                },
              ),
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
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Enter New Password',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.2,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 3, 19,
                                        243)), // Change this color to the desired border color
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
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
                                'Reset Password',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
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
