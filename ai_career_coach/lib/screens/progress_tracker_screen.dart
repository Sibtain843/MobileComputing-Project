import 'package:flutter/material.dart';
import 'package:charts_flutter_updated/flutter.dart' as charts;
import '../services/user_service.dart';

class ProgressTrackerScreen extends StatefulWidget {
  @override
  _ProgressTrackerScreenState createState() => _ProgressTrackerScreenState();
}

class _ProgressTrackerScreenState extends State<ProgressTrackerScreen> {
  final UserService _userService = UserService();
  List<charts.Series<SkillProgress, String>> _chartData = [];
  List<Map<String, dynamic>> _skillProgress =
      []; // Changed to dynamic for flexibility

  @override
  void initState() {
    super.initState();
    _fetchSkillProgress();
  }

  Future<void> _fetchSkillProgress() async {
    try {
      final userProfile = await _userService.getUserProfile();
      final skills = (userProfile['skills'] ?? '')
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();

      // Mock progress for each skill
      _skillProgress = skills
          .asMap()
          .entries
          .map((entry) => {
                'skill': entry.value,
                'progress':
                    20.0 + entry.key * 10.0, // Mock progress calculation
              })
          .toList();

      setState(() {
        _chartData = [
          charts.Series<SkillProgress, String>(
            id: 'Skill Progress',
            domainFn: (SkillProgress skillData, _) => skillData.skill,
            measureFn: (SkillProgress skillData, _) => skillData.progress,
            data: _skillProgress
                .map((sp) => SkillProgress(
                      sp['skill'] ?? 'Unknown Skill',
                      sp['progress'] ?? 0.0,
                    ))
                .toList(),
          ),
        ];
      });
    } catch (e) {
      print("Error fetching progress data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Progress Tracker',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue[900],
          foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _chartData.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Text(
                    'Skill Development Progress:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: charts.BarChart(
                      _chartData,
                      animate: true,
                      barRendererDecorator: charts.BarLabelDecorator<String>(),
                      domainAxis: charts.OrdinalAxisSpec(
                        renderSpec: charts.SmallTickRendererSpec(
                          labelRotation: 45,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class SkillProgress {
  final String skill;
  final double progress;

  SkillProgress(this.skill, this.progress);
}
