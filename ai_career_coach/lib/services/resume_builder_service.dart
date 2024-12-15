// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ResumeBuilderService {
//   final String apiUrl =
//       "https://api.openai.com/v1/chat/completions"; // Updated URL
//   final String apiKey =
//       "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"; // Replace with your actual API key

//   // Generate a resume using OpenAI API based on user data
//   Future<String> generateResume(String userData) async {
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
//                   "You are a professional resume builder. Create detailed and professional resumes based on user-provided information."
//             },
//             {
//               "role": "user",
//               "content":
//                   "Generate a professional resume for the following details: $userData"
//             }
//           ],
//           "max_tokens": 500, // Increased token limit for detailed responses
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return data['choices'][0]['message']['content']?.trim() ??
//             'No resume generated.';
//       } else {
//         throw Exception("Failed to generate resume: ${response.reasonPhrase}");
//       }
//     } catch (e) {
//       print("Error generating resume: $e");
//       throw e;
//     }
//   }
// }

// // import 'dart:convert';
// // import 'package:http/http.dart' as http;

// // class ResumeBuilderService {
// //   final String apiUrl = "https://api.openai.com/v1/completions";
// //   final String apiKey =
// //       "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"; // Replace with your actual API key

// //   // Generate a resume using OpenAI API based on user data
// //   Future<String> generateResume(String userData) async {
// //     try {
// //       final response = await http.post(
// //         Uri.parse(apiUrl),
// //         headers: {
// //           "Authorization": "Bearer $apiKey",
// //           "Content-Type": "application/json",
// //         },
// //         body: jsonEncode({
// //           "model": "text-davinci-003",
// //           "prompt":
// //               "Generate a professional resume for the following details: $userData",
// //           "max_tokens": 300,
// //         }),
// //       );

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         return data['choices'][0]['text']?.trim() ?? 'No resume generated.';
// //       } else {
// //         throw Exception("Failed to generate resume: ${response.reasonPhrase}");
// //       }
// //     } catch (e) {
// //       print("Error generating resume: $e");
// //       throw e;
// //     }
// //   }
// // }

import 'dart:convert';
import 'package:http/http.dart' as http;

class ResumeBuilderService {
  final String apiUrl = "https://api.openai.com/v1/chat/completions";
  final String apiKey =
      "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";

  Future<String> generateResume(String userData) async {
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
            {"role": "system", "content": "Create professional resumes."},
            {
              "role": "user",
              "content": "Generate a resume with this information: $userData"
            }
          ],
          "max_tokens": 500,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content']?.trim() ??
            'Resume generation failed.';
      } else {
        throw Exception("Failed to generate resume: ${response.body}");
      }
    } catch (e) {
      print("Error generating resume: $e");
      return 'Failed to generate resume.';
    }
  }
}
