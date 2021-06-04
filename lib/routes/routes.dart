import 'package:flutter/material.dart';

import 'package:app_chat/pages/chats/chat_page.dart';
import 'package:app_chat/pages/signinOrSignUp/loading_page.dart';
import 'package:app_chat/pages/signinOrSignUp/login_page.dart';
import 'package:app_chat/pages/signinOrSignUp/register_page.dart';
import 'package:app_chat/pages/signinOrSignUp/profile_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'chat': (_) => ChatPage(),
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage(),
  'profile': (_) => ProfilePage(),
};
