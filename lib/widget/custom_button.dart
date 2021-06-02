import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color colorPrimary;
  final Color colorPrimaryText;
  final Function onPress;

  const CustomButton({
    required this.title,
    required this.onPress,
    this.colorPrimary = Colors.blue,
    this.colorPrimaryText = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        primary: this.colorPrimary,
        shape: StadiumBorder(),
      ),
      onPressed: () {},
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
            child: Text(
          this.title,
          style: TextStyle(color: this.colorPrimaryText, fontSize: 17),
        )),
      ),
    );
  }
}
