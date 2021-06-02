import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Color color;
  final bool isPassword;

  const CustomInput({
    required this.hintText,
    required this.icon,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.color = Colors.white,
    this.isPassword = false,
  });

  /* const CustomInput({
    this.icon = Icons.email_outlined,
    // ignore: invalid_required_named_param
    @required this.hintText = 'Email',
    this.color = Colors.white,
     @required this.controller,
  }); */

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 20),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]),
      child: TextField(
        controller: this.controller,
        obscureText: this.isPassword,
        autocorrect: false,
        keyboardType: this.keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(this.icon),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: this.hintText,
        ),
      ),
    );
  }
}
