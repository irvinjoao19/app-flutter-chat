import 'package:app_chat/helper/util.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Text(
        "Irvin",
        style: TextStyle(color: kBlackColor),
      ),
      backgroundColor: kWhiteColor,
      actions: [
        IconButton(
          color: kBlackColor,
          icon: Icon(Icons.logout_outlined),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget body() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: kDefaultPadding * 0.7),
        child: Column(
          children: [
            Image(
              width: 200,
              image: AssetImage('assets/images/user_2.png'),
            ),
            SizedBox(height: kDefaultPadding * 0.9),
            Text('Irvin',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
