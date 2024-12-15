import 'package:flutter/material.dart';
import 'screens/career_path_screen.dart';
import 'screens/learning_recommendation_screen.dart';
import 'screens/resume_builder_screen.dart';
import 'screens/interview_preparation_screen.dart';
import 'screens/progress_tracker_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    CareerPathScreen(),
    LearningRecommendationScreen(),
    ResumeBuilderScreen(),
    ProgressTrackerScreen(),
    InterviewPreparationScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  final List<String> _titles = [
    'Career Path Analysis',
    'Learning Recommendations',
    'Resume Builder',
    'Progress Tracker',
    'Interview Preparation',
    'User Profile',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            _titles[_currentIndex],
          ),
          backgroundColor: Colors.blue[900],
          foregroundColor: Colors.white),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[900],
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Career Path',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Learning',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.document_scanner),
            label: 'Resume',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
            label: 'Interview',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
