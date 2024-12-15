import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/learning_recommendation_service.dart';
import '../services/user_service.dart';

class LearningRecommendationScreen extends StatefulWidget {
  @override
  _LearningRecommendationScreenState createState() =>
      _LearningRecommendationScreenState();
}

class _LearningRecommendationScreenState
    extends State<LearningRecommendationScreen> {
  final LearningRecommendationService _learningService =
      LearningRecommendationService();
  final UserService _userService = UserService();

  List<Map<String, String>> _courses = [];
  List<String> _skills = [];
  bool _isLoading = true;
  double _overallProgress = 0;
  int _completedCourses = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserSkillsAndCourses();
  }

  Future<void> _fetchUserSkillsAndCourses() async {
    try {
      setState(() => _isLoading = true);

      final userProfile = await _userService.getUserProfile();
      setState(() {
        _skills = (userProfile['skills'] ?? '')
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();
      });

      if (_skills.isNotEmpty) {
        final List<Map<String, String>> courses =
            await _learningService.fetchCourses(_skills[0]);
        setState(() {
          _courses = courses
              .map((course) => {
                    'title': course['title'] ?? 'No Title',
                    'description': course['description'] ?? 'No Description',
                    'link': course['link'] ?? '',
                    'completed': 'false',
                  })
              .toList();
        });
      }
    } catch (e) {
      print("Error fetching skills or courses: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _openCourseLink(String url) async {
    final Uri courseUrl = Uri.parse(url);
    if (await canLaunchUrl(courseUrl)) {
      await launchUrl(courseUrl);
    } else {
      print("Could not launch $url");
    }
  }

  void _markCourseCompleted(int index) {
    setState(() {
      if (_courses[index]['completed'] == 'false') {
        _courses[index]['completed'] = 'true';
        _completedCourses++;
        _overallProgress = (_completedCourses / _courses.length) * 100;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Learning Recommendations'),
          backgroundColor: Colors.blue[900],
          foregroundColor: Colors.white),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Skills:',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    children: _skills.map((skill) {
                      return Chip(
                        label:
                            Text(skill, style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.blue[900]!.withOpacity(0.7),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Overall Progress:',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: _overallProgress / 100,
                    backgroundColor: Colors.grey[300],
                    color: Colors.blue[900]!,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Recommended Courses:',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _courses.length,
                      itemBuilder: (context, index) {
                        final course = _courses[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          color: Colors.blue[900]!.withOpacity(0.8),
                          child: ListTile(
                            title: Text(course['title'] ?? 'No Title',
                                style: TextStyle(color: Colors.white)),
                            subtitle: Text(
                                course['description'] ?? 'No Description',
                                style: TextStyle(color: Colors.white70)),
                            trailing: IconButton(
                              icon: Icon(
                                course['completed'] == 'true'
                                    ? Icons.check_circle
                                    : Icons.circle_outlined,
                                color: course['completed'] == 'true'
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                              onPressed: () => _markCourseCompleted(index),
                            ),
                            onTap: () => _openCourseLink(course['link'] ?? ''),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
