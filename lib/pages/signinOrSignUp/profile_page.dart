import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:app_chat/helpers/util.dart';
import 'package:app_chat/services/auth_services.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;

    return Scaffold(
      appBar: buildAppBar(usuario, context),
      body: body(usuario),
    );
  }

  AppBar buildAppBar(usuario, context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      elevation: 0,
      title: Text(
        usuario.email,
        style: TextStyle(color: kBlackColor),
      ),
      backgroundColor: kWhiteColor,
      actions: [
        IconButton(
          icon: Icon(Icons.logout_outlined),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          },
        ),
      ],
    );
  }

  Widget body(usuario) {
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
            Text(usuario.nombre,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
