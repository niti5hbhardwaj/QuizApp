import 'dart:convert';
import 'dart:developer';
import '../data/question_bank.dart';
import 'package:http/http.dart' as http;
import 'api_key.dart';

class TextDavinci {
  Uri uri = Uri.parse("https://api.openai.com/v1/completions");

  Future<String> getQuestions(String topic) async {
    String message =
        '5 $topic questions as a list of json with fields "id" as int, "question_text" as string, "options" as a list of strings, "answer_index" as int, "explanation" as string without any leading text.';
    Map<String, dynamic> body = {
      "model": "text-davinci-003",
      "prompt": message,
    };
    try {
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apiKey"
        },
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> parsedResponse =
            json.decode(utf8.decode(response.bodyBytes));
        try {
          final parsedJson = parsedResponse["choices"][0]["text"];
          List<Map<String, dynamic>> questionData =
              List<Map<String, dynamic>>.from(json.decode(parsedJson));
          questionBank.replaceRange(0, questionBank.length, questionData);
          return "none";
        } on Exception catch (e) {
          log("Caught here: $e");
          return "unknown";
        }
      } else {
        log("url response error");
        return "timeout";
      }
    } catch (e) {
      log("Timeout: $e");
      return "timeout";
    }
  }

  Future<String> getResponse(String messageText) async {
    try {
      final response = await http
          .post(
            uri,
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $apiKey"
            },
            body: json.encode({
              "model": "text-davinci-003",
              "prompt": messageText,
            }),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        Map<String, dynamic> parsedResponse =
            json.decode(utf8.decode(response.bodyBytes));
        final reply = parsedResponse["choices"][0]["text"].toString().trim();
        return reply;
      } else {
        log("url response error");
        return "Encountered error while fetching the response";
      }
    } catch (e) {
      log(e.toString());
      return "Encountered error while fetching the response";
    }
  }
}
