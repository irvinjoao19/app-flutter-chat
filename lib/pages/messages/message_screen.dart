import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'components/body.dart';
import 'package:app_chat/helpers/util.dart';

import 'package:app_chat/services/chat_services.dart';

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatService = Provider.of<ChatService>(context);
    final usuarioPara = chatService.usuarioPara;

    return Scaffold(
      appBar: _buildAppBar(usuarioPara),
      body: Body(),
    );
  }

  AppBar _buildAppBar(usuarioPara) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(),
          CircleAvatar(
            backgroundImage: AssetImage(usuarioPara.image),
          ),
          SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                usuarioPara.nombre,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                usuarioPara.email,
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.local_phone),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.videocam),
          onPressed: () {},
        ),
        SizedBox(width: kDefaultPadding / 2),
      ],
    );
  }
}
