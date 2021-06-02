import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String title;

  const Logo({required this.title});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        width: size.width * 0.6,
        margin: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/tag-logo.png'),
            ),
            SizedBox(height: 20),
            Text(
              this.title,
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
