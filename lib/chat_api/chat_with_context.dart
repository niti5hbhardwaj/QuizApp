import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'api_key.dart';

class ChatGPT {
  final List<Map<String, String>> messages = [];

  Future<String> getResponse(String messageText) async {
    messages.add({
      'role': 'user',
      'content': messageText,
    });
    Uri uri = Uri.parse("https://api.openai.com/v1/chat/completions");
    Map<String, dynamic> body = {
      "model": "gpt-3.5-turbo",
      "messages": messages,
      "max_tokens": 200,
    };
    try {
      final response = await http
          .post(
            uri,
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $apiKey"
            },
            body: json.encode(body),
          )
          .timeout(const Duration(seconds: 30));
      if (response.statusCode == 200) {
        Map<String, dynamic> parsedResponse =
            json.decode(utf8.decode(response.bodyBytes));
        final reply = parsedResponse["choices"][0]["message"]["content"];
        messages.add({
          'role': 'assistant',
          'content': reply,
        });
        return reply;
      } else {
        throw "url response error";
      }
    } catch (e) {
      log(e.toString());
      return "Encountered error while fetching the response";
    }
  }
}
