import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:app_chat/models/ChatMessage.dart';
import 'package:app_chat/services/auth_services.dart';
import 'package:app_chat/helpers/util.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    required this.message,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.75,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: kPrimaryColor
            .withOpacity(message.uid == authService.usuario.uid ? 1 : 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        message.text,
        style: TextStyle(
          color: message.uid == authService.usuario.uid
              ? Colors.white
              : Theme.of(context).textTheme.bodyText1!.color,
        ),
      ),
    );
  }
}
