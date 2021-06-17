import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:app_chat/services/auth_services.dart';
import 'package:app_chat/services/socket.dart';

import 'package:app_chat/pages/chats/chat_page.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Center(
            child: Text('Espere...'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socket = Provider.of<SocketService>(context, listen: false);
    final autenticado = await authService.isLoggedIn();
    if (autenticado) {
      socket.connect();
      Navigator.pushReplacementNamed(context, 'chat');

      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                ChatPage(),
            transitionDuration: Duration(milliseconds: 500),
            transitionsBuilder:
                (context, animation, secondatyAnimation, child) {
              final curvedAnimation =
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut);

              return RotationTransition(
                child: FadeTransition(
                    opacity: Tween<double>(begin: 0.5, end: 1.0)
                        .animate(curvedAnimation),
                    child: child),
                turns: Tween<double>(begin: 0.95, end: 1.0)
                    .animate(curvedAnimation),
              );
            },
          ));
    } else {
      //socket.disconnect();
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}
