// // import 'dart:convert';
// // import 'package:http/http.dart' as http;

// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class InterviewService {
//   final String apiUrl =
//       "https://api.openai.com/v1/chat/completions"; // Updated URL for chat models
//   final String apiKey =
//       "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"; // Replace with your OpenAI API key

//   // Fetch interview tips for a specific job role
//   Future<List<String>> fetchInterviewTips(String jobRole) async {
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
//             {
//               "role": "system",
//               "content":
//                   "You are a career expert providing interview tips and advice."
//             },
//             {
//               "role": "user",
//               "content": "Provide 5 interview tips for the job role: $jobRole."
//             }
//           ],
//           "max_tokens": 200,
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final resultText = data['choices'][0]['message']['content'];
//         return resultText
//             .split('\n')
//             .where((tip) => tip.trim().isNotEmpty)
//             .toList();
//       } else {
//         throw Exception(
//             "Failed to fetch interview tips: ${response.reasonPhrase}");
//       }
//     } catch (e) {
//       print("Error fetching interview tips: $e");
//       throw e;
//     }
//   }

//   // Fetch interview questions for a specific job role
//   Future<List<String>> fetchInterviewQuestions(String jobRole) async {
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
//             {
//               "role": "system",
//               "content":
//                   "You are a career expert providing interview questions for various job roles."
//             },
//             {
//               "role": "user",
//               "content":
//                   "Provide 5 interview questions for the job role: $jobRole."
//             }
//           ],
//           "max_tokens": 200,
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final resultText = data['choices'][0]['message']['content'];
//         return resultText
//             .split('\n')
//             .where((q) => q.trim().isNotEmpty)
//             .toList();
//       } else {
//         throw Exception(
//             "Failed to fetch interview questions: ${response.reasonPhrase}");
//       }
//     } catch (e) {
//       print("Error fetching interview questions: $e");
//       throw e;
//     }
//   }
// }

// // import 'dart:convert';
// // import 'package:http/http.dart' as http;

// // class InterviewService {
// //   final String apiUrl = "https://api.openai.com/v1/completions";
// //   final String apiKey =
// //       "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";

// //   // Fetch interview tips for a specific job role
// //   Future<List<String>> fetchInterviewTips(String jobRole) async {
// //     try {
// //       final response = await http.post(
// //         Uri.parse(apiUrl),
// //         headers: {
// //           "Authorization": "Bearer $apiKey",
// //           "Content-Type": "application/json",
// //         },
// //         body: jsonEncode({
// //           "model": "text-davinci-003",
// //           "prompt": "Provide 5 interview tips for the job role: $jobRole.",
// //           "max_tokens": 100,
// //         }),
// //       );

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         final resultText = data['choices'][0]['text'];
// //         return resultText
// //             .split('\n')
// //             .where((tip) => tip.trim().isNotEmpty)
// //             .toList();
// //       } else {
// //         throw Exception(
// //             "Failed to fetch interview tips: ${response.reasonPhrase}");
// //       }
// //     } catch (e) {
// //       print("Error fetching interview tips: $e");
// //       throw e;
// //     }
// //   }

// //   // Fetch interview questions for a specific job role
// //   Future<List<String>> fetchInterviewQuestions(String jobRole) async {
// //     try {
// //       final response = await http.post(
// //         Uri.parse(apiUrl),
// //         headers: {
// //           "Authorization": "Bearer $apiKey",
// //           "Content-Type": "application/json",
// //         },
// //         body: jsonEncode({
// //           "model": "text-davinci-003",
// //           "prompt": "Provide 5 interview questions for the job role: $jobRole.",
// //           "max_tokens": 150,
// //         }),
// //       );

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         final resultText = data['choices'][0]['text'];
// //         return resultText
// //             .split('\n')
// //             .where((q) => q.trim().isNotEmpty)
// //             .toList();
// //       } else {
// //         throw Exception(
// //             "Failed to fetch interview questions: ${response.reasonPhrase}");
// //       }
// //     } catch (e) {
// //       print("Error fetching interview questions: $e");
// //       throw e;
// //     }
// //   }
// // }

import 'dart:convert';
import 'package:http/http.dart' as http;

class InterviewService {
  final String apiUrl = "https://api.openai.com/v1/chat/completions";
  final String apiKey =
      "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";

  Future<List<String>> fetchInterviewTips(String jobRole) async {
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
            {"role": "system", "content": "Provide career advice."},
            {
              "role": "user",
              "content": "Give me 5 interview tips for the job role: $jobRole."
            }
          ],
          "max_tokens": 150,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final result = data['choices'][0]['message']['content'];
        return result
            .split('\n')
            .where((tip) => tip.trim().isNotEmpty)
            .toList();
      } else {
        throw Exception("Failed to fetch interview tips: ${response.body}");
      }
    } catch (e) {
      print("Error fetching interview tips: $e");
      return ['Failed to fetch interview tips.'];
    }
  }

  Future<List<String>> fetchInterviewQuestions(String jobRole) async {
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
            {
              "role": "system",
              "content": "Provide job-specific interview questions."
            },
            {
              "role": "user",
              "content":
                  "List 5 interview questions for the job role: $jobRole."
            }
          ],
          "max_tokens": 150,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final result = data['choices'][0]['message']['content'];
        return result
            .split('\n')
            .where((question) => question.trim().isNotEmpty)
            .toList();
      } else {
        throw Exception(
            "Failed to fetch interview questions: ${response.body}");
      }
    } catch (e) {
      print("Error fetching interview questions: $e");
      return ['Failed to fetch interview questions.'];
    }
  }
}
