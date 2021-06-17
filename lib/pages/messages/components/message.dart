import 'package:app_chat/services/auth_services.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:app_chat/helpers/util.dart';
import 'package:app_chat/models/ChatMessage.dart';
import 'package:app_chat/services/chat_services.dart';

import 'audio_message.dart';
import 'text_message.dart';
import 'video_message.dart';

class Message extends StatelessWidget {
  final ChatMessage message;
  final AnimationController animationController;

  const Message({
    required this.message,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    Widget messageContaint(ChatMessage message) {
      switch (message.messageType) {
        case ChatMessageType.text:
          return TextMessage(message: message);
        case ChatMessageType.audio:
          return AudioMessage(message: message);
        case ChatMessageType.video:
          return VideoMessage();
        default:
          return SizedBox();
      }
    }

    final chatService = Provider.of<ChatService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Padding(
          padding: const EdgeInsets.only(top: kDefaultPadding),
          child: Row(
            mainAxisAlignment: message.uid == authService.usuario.uid
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              if (!(message.uid == authService.usuario.uid)) ...[
                CircleAvatar(
                  radius: 12,
                  backgroundImage: AssetImage(chatService.usuarioPara.image),
                ),
                SizedBox(width: kDefaultPadding / 2),
              ],
              messageContaint(message),
              if (message.uid == authService.usuario.uid)
                MessageStatusDot(status: message.messageStatus)
            ],
          ),
        ),
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final MessageStatus status;

  const MessageStatusDot({required this.status});
  @override
  Widget build(BuildContext context) {
    Color dotColor(MessageStatus status) {
      switch (status) {
        case MessageStatus.not_sent:
          return kDisconnectColor;
        case MessageStatus.not_view:
          return Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1);
        case MessageStatus.viewed:
          return kPrimaryColor;
        default:
          return Colors.transparent;
      }
    }

    return Container(
      margin: EdgeInsets.only(left: kDefaultPadding / 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: dotColor(status),
        shape: BoxShape.circle,
      ),
      child: Icon(
        status == MessageStatus.not_sent ? Icons.close : Icons.done,
        size: 8,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
