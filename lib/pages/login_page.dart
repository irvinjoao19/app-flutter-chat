import 'package:app_chat/widget/custom_button.dart';
import 'package:flutter/material.dart';

import 'package:app_chat/widget/logo.dart';
import 'package:app_chat/widget/custom_input.dart';
import 'package:app_chat/widget/labels.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo(title: 'Messenger'),
                  _Form(),
                  Labels(ruta: 'register'),
                  Text(
                    'Terminos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.symmetric(horizontal: sizeWidth * 0.10),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.email_outlined,
            hintText: 'Email',
            controller: emailCtrl,
            keyboardType: TextInputType.emailAddress,
          ),
          CustomInput(
            icon: Icons.lock_clock_outlined,
            hintText: 'Password',
            controller: passCtrl,
            keyboardType: TextInputType.visiblePassword,
            isPassword: true,
          ),
          CustomButton(
            colorPrimary: Colors.blue,
            colorPrimaryText: Colors.white,
            title: 'Ingrese',
            onPress: () {
              print("${emailCtrl.text} ${passCtrl.text}");
            },
          )
        ],
      ),
    );
  }
}
