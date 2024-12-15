import 'package:flutter/material.dart';
import '../services/interview_service.dart';

class InterviewPreparationScreen extends StatefulWidget {
  @override
  _InterviewPreparationScreenState createState() =>
      _InterviewPreparationScreenState();
}

class _InterviewPreparationScreenState
    extends State<InterviewPreparationScreen> {
  final InterviewService _interviewService = InterviewService();

  List<String> _interviewTips = [];
  List<String> _interviewQuestions = [];
  bool _isLoadingTips = true;
  bool _isLoadingQuestions = true;
  final String _jobRole = "Full Stack Developer"; // Example job role

  @override
  void initState() {
    super.initState();
    _fetchInterviewData();
  }

  Future<void> _fetchInterviewData() async {
    try {
      setState(() {
        _isLoadingTips = true;
        _isLoadingQuestions = true;
      });

      final tips = await _interviewService.fetchInterviewTips(_jobRole);
      final questions =
          await _interviewService.fetchInterviewQuestions(_jobRole);

      setState(() {
        _interviewTips = tips;
        _interviewQuestions = questions;
        _isLoadingTips = false;
        _isLoadingQuestions = false;
      });
    } catch (e) {
      print("Error fetching interview data: $e");
      setState(() {
        _isLoadingTips = false;
        _isLoadingQuestions = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Interview Preparation',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Interview Questions:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _isLoadingQuestions
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    flex: 1,
                    child: ListView.builder(
                      itemCount: _interviewQuestions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.question_answer),
                          title: Text(_interviewQuestions[index]),
                        );
                      },
                    ),
                  ),
            SizedBox(height: 20),
            Text(
              'Interview Tips:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _isLoadingTips
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    flex: 1,
                    child: ListView.builder(
                      itemCount: _interviewTips.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.lightbulb),
                          title: Text(_interviewTips[index]),
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
