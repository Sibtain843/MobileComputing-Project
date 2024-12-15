import 'package:flutter/material.dart';
import '../services/career_analysis_service.dart';
import '../services/user_service.dart';

class CareerPathScreen extends StatefulWidget {
  @override
  _CareerPathScreenState createState() => _CareerPathScreenState();
}

class _CareerPathScreenState extends State<CareerPathScreen> {
  final CareerAnalysisService _careerService = CareerAnalysisService();
  final UserService _userService = UserService();

  List<String> _skills = [];
  String _selectedJobRole = '';
  String _analysisResult = '';
  bool _isLoading = false;
  final List<String> _jobRoles = [
    'Full Stack Developer',
    'Data Scientist',
    'UI/UX Designer'
  ];

  @override
  void initState() {
    super.initState();
    _fetchUserSkills();
  }

  Future<void> _fetchUserSkills() async {
    try {
      final userProfile = await _userService.getUserProfile();
      setState(() {
        // Add null check and default value for 'skills'
        _skills = (userProfile['skills'] ?? '')
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty) // Filter out empty strings
            .toList();
      });
    } catch (e) {
      print("Error fetching user skills: $e");
    }
  }

  Future<void> _analyzeSkillGap() async {
    if (_selectedJobRole.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a job role first.")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await _careerService.analyzeSkillGap(
          _skills.join(', '), _selectedJobRole);
      setState(() => _analysisResult = result);
    } catch (e) {
      print("Error analyzing skill gap: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to analyze skill gap.")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Career Path Analysis',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue[900],
          foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Skills:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: _skills.map((skill) {
                return Chip(
                  label: Text(skill),
                  backgroundColor: Colors.blue.withOpacity(0.2),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Select a Job Role:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              items: _jobRoles.map((jobRole) {
                return DropdownMenuItem(value: jobRole, child: Text(jobRole));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedJobRole = value!;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Job Role',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _analyzeSkillGap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                minimumSize: Size(double.infinity, 50),
              ),
              child: _isLoading
                  ? CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    )
                  : Text('Analyze Skill Gap'),
            ),
            SizedBox(height: 20),
            Text(
              'Analysis Result:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _analysisResult.isEmpty
                      ? 'Skill gap analysis results will appear here.'
                      : _analysisResult,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
