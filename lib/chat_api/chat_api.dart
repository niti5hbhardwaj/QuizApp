import 'dart:convert';
import '../data/question_bank.dart';
import 'package:http/http.dart' as http;
import 'api_key.dart';

Future<bool> getQuestions(String topic) async {
  String message =
      '5 $topic questions as a list of json with fields "id" as int, "question_text" as string, "options" as a list of strings, "answer_index" as int, "explanation" as string';
  Uri uri = Uri.parse("https://api.openai.com/v1/chat/completions");
  Map<String, dynamic> body = {
    "model": "gpt-3.5-turbo",
    "messages": [
      {"role": "user", "content": message},
    ],
    "max_tokens": 500,
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
    Map<String, dynamic> parsedResponse = json.decode(response.body);
    final parsedJson = parsedResponse["choices"][0]["message"]["content"];

    List<Map<String, dynamic>> questionData =
        List<Map<String, dynamic>>.from(json.decode(parsedJson));
    sampleData.replaceRange(0, sampleData.length, questionData);
    return true;
  } catch (e) {
    return false;
  }
}
