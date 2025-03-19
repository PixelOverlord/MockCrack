import 'dart:convert';

import 'package:mockcrack/utils/constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<String>> generateInterview({
    required String role,
    required String experience,
    required List<String> techstacks,
  }) async {
    final prompt = customInterviewMessage(role, experience, techstacks);

    final response = await http.post(
        Uri.parse(
            "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${AppConstants.geminiAPI}"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": prompt}
              ]
            }
          ]
        }));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final text =
          data["candidates"]?[0]?["content"]?["parts"]?[0]?["text"] ?? "";
      print(text);
      // Extract questions using regex
      final regex = RegExp(r'\d+\.\s*(.*)');
      final matches = regex.allMatches(text);
      return matches.map((match) => match.group(1)!.trim()).toList();
    } else {
      throw Exception(
          "Failed to generate interview questions: ${response.body}");
    }
  }

  // evaluate answer

  Future<Answer> evaluateScore(String question, String answer) async {
    final prompt = """
  Given the user's question: "{$question}" and their provided answer: "{$answer}", evaluate the response based on correctness, completeness, and relevance.
  
  Provide:
  1. A score from 0 to 10 (where 0 is completely incorrect and 10 is fully correct).
  2. An accuracy statement providing feedback on how well the answer is formed and suggesting improvements if needed.

  Format your response as:
  Score: X/10
  Accuracy: "Your response is [feedback]. It can be improved by [suggestion]."
  """;

    final response = await http.post(
      Uri.parse(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${AppConstants.geminiAPI}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": prompt}
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final text =
          data["candidates"]?[0]?["content"]?["parts"]?[0]?["text"] ?? "";

      // Extracting score and accuracy statement using RegExp
      final scoreMatch = RegExp(r'Score:\s*(\d+)/10').firstMatch(text);
      final accuracyMatch = RegExp(r'Accuracy:\s*"(.*?)"').firstMatch(text);

      final int score =
          scoreMatch != null ? int.parse(scoreMatch.group(1)!) : 0;
      final String accuracy = accuracyMatch != null
          ? accuracyMatch.group(1)!
          : "No feedback available.";

      return Answer(
          question: question, answer: answer, score: score, accuracy: accuracy);
    } else {
      throw Exception("Failed to evaluate answer: ${response.body}");
    }
  }
}

class Answer {
  final String question;
  final String answer;
  final int score;
  final String accuracy;

  Answer(
      {required this.question,
      required this.answer,
      required this.score,
      required this.accuracy});
}
