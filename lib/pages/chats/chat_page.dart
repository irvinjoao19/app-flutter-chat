import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:app_chat/helpers/util.dart';

import 'package:app_chat/services/usuarios_services.dart';
import 'package:app_chat/services/socket.dart';
import 'package:app_chat/services/chat_services.dart';
import 'package:app_chat/services/auth_services.dart';

import 'package:app_chat/pages/chats/components/chat_card.dart';
import 'package:app_chat/pages/messages/message_screen.dart';

import 'package:app_chat/models/usuario.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final usuarioService = new UsuarioService();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<Usuario> users = [];
  int _selectedIndex = 1;

  @override
  void initState() {
    this._downloadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kPrimaryColor,
        child: Icon(
          Icons.person_add_alt_1,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
    final socket = Provider.of<SocketService>(context);
    final authService = Provider.of<AuthService>(context);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
        final routeName = (value == 3) ? 'profile' : 'chat';
        Navigator.pushNamed(context, routeName);
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.messenger), label: "Chats"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
        BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundImage: AssetImage(authService.usuario.image),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  height: 11,
                  width: 11,
                  decoration: BoxDecoration(
                    color: (socket.serverStatus == ServerStatus.Online)
                        ? kConnectColor
                        : kDisconnectColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 2),
                  ),
                ),
              )
            ],
          ),
          label: "Yo",
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Text("Chats"),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget body() {
    return Column(
      children: [
        /*   Container(
          padding: EdgeInsets.fromLTRB(
              kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
          color: kPrimaryColor,
          child: Row(
            children: [
              FillOutlineButton(press: () {}, text: "Recent Message"),
              SizedBox(width: kDefaultPadding),
              FillOutlineButton(
                press: () {},
                text: "Active",
                isFilled: false,
              ),
            ],
          ),
        ), */
        Expanded(
          child: SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            onRefresh: _downloadData,
            header: WaterDropHeader(
              complete: Icon(Icons.check, color: kPrimaryColor),
              waterDropColor: kPrimaryColor,
            ),
            child: _chatList(),
          ),
        ),
      ],
    );
  }

  ListView _chatList() {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) => ChatCard(
          user: users[index],
          press: () {
            final chatService =
                Provider.of<ChatService>(context, listen: false);
            chatService.usuarioPara = users[index];
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MessagesScreen(),
              ),
            );
          }),
    );
  }

  _downloadData() async {
    this.users = await usuarioService.getUsuarios();
    if (mounted) setState(() {});
    _refreshController.refreshCompleted();
  }
}
