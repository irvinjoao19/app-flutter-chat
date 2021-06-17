import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:app_chat/routes/routes.dart';

import 'package:app_chat/services/chat_services.dart';
import 'package:app_chat/services/auth_services.dart';
import 'package:app_chat/services/socket.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (_) => ChatService()),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}
