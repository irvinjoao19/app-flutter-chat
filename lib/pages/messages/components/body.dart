import 'package:flutter/material.dart';

import 'package:app_chat/helper/util.dart';
import 'package:app_chat/models/ChatMessage.dart';

import 'message.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  final _textController = TextEditingController();

  final _focusNode = FocusNode();

  bool _isWriting = false;

  List<Message> _message = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _message.length,
            reverse: true,
            itemBuilder: (context, index) => _message[index],
            //Message(message: demeChatMessages[index]),
          ),
        )),
        chatInputField(),
      ],
    );
  }

  Widget chatInputField() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            /*  Icon(Icons.mic, color: kPrimaryColor),
            SizedBox(width: kDefaultPadding), */
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.64),
                    ),
                    SizedBox(width: kDefaultPadding / 4),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        controller: _textController,
                        minLines: 1,
                        maxLines: 5,
                        onSubmitted: _submit,
                        onChanged: (text) {
                          setState(() {
                            if (text.trim().length > 0) {
                              _isWriting = true;
                            } else {
                              _isWriting = false;
                            }
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                        focusNode: _focusNode,
                      ),
                    ),
                    Icon(
                      Icons.attach_file,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.64),
                    ),
                    SizedBox(width: kDefaultPadding / 4),
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.64),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              /*     decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(100),
              ), */
              child: IconTheme(
                data: IconThemeData(color: kPrimaryColor),
                child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _isWriting
                      ? () => _submit(_textController.text.trim())
                      : null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _submit(String texto) {
    _textController.clear();
    _focusNode.requestFocus();
    setState(() {
      _isWriting = false;
    });

    final message = new ChatMessage(
      text: texto,
      messageType: ChatMessageType.text,
      messageStatus: MessageStatus.viewed,
      isSender: true,
    );

    final mensaje = Message(
      message: message,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 400)),
    );

    _message.insert(0, mensaje);
    mensaje.animationController.forward();
  }
}
