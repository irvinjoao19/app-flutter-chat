import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:app_chat/helpers/util.dart';
import 'package:app_chat/models/ChatMessage.dart';
import 'package:app_chat/services/auth_services.dart';

class AudioMessage extends StatelessWidget {
  final ChatMessage message;

  const AudioMessage({required this.message});
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.75,
        vertical: kDefaultPadding / 2.5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: kPrimaryColor
            .withOpacity(message.uid == authService.usuario.uid ? 1 : 0.1),
      ),
      child: Row(
        children: [
          Icon(
            Icons.play_arrow,
            color: message.uid == authService.usuario.uid
                ? Colors.white
                : kPrimaryColor,
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: message.uid == authService.usuario.uid
                        ? Colors.white
                        : kPrimaryColor.withOpacity(0.4),
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: message.uid == authService.usuario.uid
                            ? Colors.white
                            : kPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text(
            "0.37",
            style: TextStyle(
                fontSize: 12,
                color: message.uid == authService.usuario.uid
                    ? Colors.white
                    : null),
          ),
        ],
      ),
    );
  }
}
