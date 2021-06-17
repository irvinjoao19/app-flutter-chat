import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:app_chat/helpers/util.dart';
import 'package:app_chat/services/auth_services.dart';
import 'package:app_chat/services/socket.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socket = Provider.of<SocketService>(context);
    final usuario = authService.usuario;

    return Scaffold(
      appBar: AppBar(
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
              socket.disconnect();
              Navigator.pushReplacementNamed(context, 'login');
              AuthService.deleteToken();
            },
          ),
        ],
      ),
      body: body(usuario),
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
              image: AssetImage(usuario.image),
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
