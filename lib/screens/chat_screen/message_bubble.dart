import 'package:flutter/material.dart';
import 'package:quiz_app/models/message.dart';

class MessageBubble extends StatelessWidget {
  final String messageText;
  final Sender sender;
  const MessageBubble(
      {super.key, required this.messageText, required this.sender});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: (sender == Sender.user)
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
          padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 20),
          decoration: BoxDecoration(
            color:
                (sender == Sender.user) ? Colors.lightBlueAccent : Colors.white,
            borderRadius: (sender == Sender.user)
                ? const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
          ),
          child: Text(
            messageText,
            style: TextStyle(
              color: (sender == Sender.user) ? Colors.white : Colors.black,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
