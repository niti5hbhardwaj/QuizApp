import 'package:flutter/material.dart';
import '../../chat_api/chat_api.dart';
import '../../models/message.dart';
import 'message_bubble.dart';

class ChatScreen extends StatefulWidget {
  static const id = 'chat_screen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  List<Message> messages = [];

  void insertMessage(String messageText, Sender sender) async {
    setState(() {
      messages.insert(0, Message(messageText: messageText, sender: sender));
      _messageController.clear();
    });
    String reply = await getResponse("Using 100 words or less: $messageText");
    setState(() {
      messages.insert(0, Message(messageText: reply, sender: Sender.chatGPT));
    });
  }

  void initializeChatScreen(String questionText) async {
    setState(() {
      messages.insert(
        0,
        Message(
          messageText: "I still have a doubt",
          sender: Sender.user,
        ),
      );
    });
    String reply = await getResponse(
        "I have a doubt. Can you explain the answer for: $questionText");
    setState(() {
      messages.insert(0, Message(messageText: reply, sender: Sender.chatGPT));
    });
  }

  @override
  void didChangeDependencies() {
    String questionText = ModalRoute.of(context)?.settings.arguments as String;
    initializeChatScreen(questionText);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        foregroundColor: Colors.blueGrey.shade900,
        title: Text(
          "ChatGPT",
          style: TextStyle(color: Colors.blueGrey.shade900),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(
                  messageText: messages[index].messageText,
                  sender: messages[index].sender,
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.only(right: 5),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration.collapsed(
                      hintText: "Type your message here",
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  splashRadius: 1,
                  onPressed: () {
                    String messageText = _messageController.text.trim();
                    if (messageText != '') {
                      insertMessage(messageText, Sender.user);
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.blueGrey.shade900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
