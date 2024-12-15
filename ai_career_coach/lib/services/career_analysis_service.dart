// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class CareerAnalysisService {
//   final String apiUrl = "https://api.openai.com/v1/chat/completions";
//   final String apiKey =
//       "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"; // Replace with your OpenAI API key

//   Future<String> analyzeSkillGap(String skills, String jobRole) async {
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {
//           "Authorization": "Bearer $apiKey",
//           "Content-Type": "application/json",
//         },
//         body: jsonEncode({
//           "model": "gpt-4", // Use "gpt-3.5-turbo" if preferred
//           "messages": [
//             {"role": "system", "content": "You are an expert career advisor."},
//             {
//               "role": "user",
//               "content":
//                   "Analyze the skill gap for these skills: $skills for the job role: $jobRole."
//             }
//           ],
//           "max_tokens": 150,
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return data['choices'][0]['message']['content']?.trim() ??
//             'No response received.';
//       } else {
//         throw Exception(
//             "Failed to analyze skill gap: ${response.reasonPhrase}");
//       }
//     } catch (e) {
//       print("Error analyzing skill gap: $e");
//       throw e;
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

class CareerAnalysisService {
  final String apiUrl = "https://api.openai.com/v1/chat/completions";
  final String apiKey =
      "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";

  Future<String> analyzeSkillGap(String skills, String jobRole) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "system", "content": "You are a career advisor."},
            {
              "role": "user",
              "content":
                  "Analyze the skill gap for these skills: $skills for the job role: $jobRole."
            }
          ],
          "max_tokens": 150,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content']?.trim() ??
            'No data received.';
      } else {
        throw Exception("Failed to analyze skill gap: ${response.body}");
      }
    } catch (e) {
      print("Error analyzing skill gap: $e");
      return 'Skill gap analysis failed.';
    }
  }
}
