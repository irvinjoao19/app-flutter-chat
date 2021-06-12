import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:app_chat/pages/chats/components/chat_card.dart';
import 'package:app_chat/pages/messages/message_screen.dart';
import 'package:app_chat/models/Chat.dart';
import 'package:app_chat/helpers/util.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int _selectedIndex = 1;
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
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
        final routeName = (value == 3) ? 'profile' : 'chat';
        Navigator.pushNamed(context, routeName);

/* Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessagesScreen(),
          ),
 */
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.messenger), label: "Chats"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
        BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 14,
            backgroundImage: AssetImage("assets/images/user_2.png"),
          ),
          label: "Profile",
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
      itemCount: chatsData.length,
      itemBuilder: (context, index) => ChatCard(
        chat: chatsData[index],
        press: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessagesScreen(),
          ),
        ),
      ),
    );
  }

  _downloadData() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
