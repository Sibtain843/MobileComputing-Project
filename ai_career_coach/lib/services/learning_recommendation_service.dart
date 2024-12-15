import 'dart:convert';
import 'package:http/http.dart' as http;

class LearningRecommendationService {
  final String courseraApiUrl = "https://api.coursera.com/ent/courses.v1";
  final String authUrl =
      "https://api.coursera.com/oauth2/client_credentials/token";

  // Replace with your Coursera API key and secret
  final String clientId = '3qhawfACdJwj3xsuvsWKsl3omGitHYRH7hM4Mrt91VClrbGc';
  final String clientSecret =
      '5wuxxfF8HeqMYDNLA2i5O4avqicW5fKBH4YUtthdeDsQQPEZtWAecjCI7GEVmbiG';

  /// Fetch OAuth 2.0 access token
  Future<String> getAccessToken() async {
    final String credentials =
        base64Encode(utf8.encode('$clientId:$clientSecret'));

    try {
      final response = await http.post(
        Uri.parse(authUrl),
        headers: {
          'Authorization': 'Basic $credentials',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {'grant_type': 'client_credentials'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['access_token'];
      } else {
        throw Exception(
            "Failed to retrieve token: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error getting access token: $e");
      throw Exception("Failed to get access token.");
    }
  }

  /// Fetch courses from Coursera API based on skill
  Future<List<Map<String, String>>> fetchCourses(String skill) async {
    try {
      // Step 1: Retrieve OAuth Token
      final String accessToken = await getAccessToken();

      // Step 2: Make GET request to Coursera API
      final response = await http.get(
        Uri.parse("$courseraApiUrl?q=search&query=$skill"),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Accept': 'application/json',
        },
      );

      // Step 3: Parse the response
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Assuming 'elements' holds the courses
        final List<dynamic> courses = data['elements'];
        return courses.map((course) {
          return {
            'title': (course['name'] ?? 'No Title').toString(),
            'description':
                (course['description'] ?? 'No Description').toString(),
            'link': (course['courseHomeLink'] ?? '').toString(),
          };
        }).toList();
      } else {
        throw Exception(
            "Failed to fetch courses: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error fetching courses: $e");
      throw Exception("Failed to fetch courses.");
    }
  }
}
