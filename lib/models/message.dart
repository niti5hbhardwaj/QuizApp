enum Sender { user, chatGPT }

class Message {
  final String messageText;
  final Sender sender;

  Message({required this.messageText, required this.sender});
}
