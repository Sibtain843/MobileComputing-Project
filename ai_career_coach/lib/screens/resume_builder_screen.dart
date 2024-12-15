import 'dart:convert'; // Add this import
import 'dart:io'; // For mobile file handling
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/foundation.dart'; // Import for kIsWeb

import '../services/resume_builder_service.dart';
import '../services/user_service.dart';

class ResumeBuilderScreen extends StatefulWidget {
  @override
  _ResumeBuilderScreenState createState() => _ResumeBuilderScreenState();
}

class _ResumeBuilderScreenState extends State<ResumeBuilderScreen> {
  final ResumeBuilderService _resumeService = ResumeBuilderService();
  final UserService _userService = UserService();

  String _resumeContent = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _generateResume();
  }

  Future<void> _generateResume() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Fetch user profile data from Firestore
      final userProfile = await _userService.getUserProfile();
      final userData = '''
      Name: ${userProfile['name']}
      Education: ${userProfile['education']}
      Skills: ${userProfile['skills']}
      Career Goals: ${userProfile['goals']}
      ''';

      // Generate resume based on user data
      final resume = await _resumeService.generateResume(userData);
      setState(() {
        _resumeContent = resume;
      });
    } catch (e) {
      print("Error generating resume: $e");
      setState(() {
        _resumeContent = 'Failed to generate resume.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _downloadResume() async {
    try {
      // Generate the PDF document
      final document = PdfDocument();
      final page = document.pages.add();
      page.graphics.drawString(
        _resumeContent,
        PdfStandardFont(PdfFontFamily.helvetica, 12),
      );

      if (kIsWeb) {
        // For web: create a downloadable link
        final bytes = await document.save();
        final buffer =
            Uint8List.fromList(bytes); // Convert List<int> to Uint8List
        final base64Data = base64Encode(buffer); // Convert to base64 string
        // final anchor =
        //     html.AnchorElement(href: "data:application/pdf;base64,$base64Data")
        //       ..target = 'blank'
        //       ..download = 'resume.pdf'; // Ensure download behavior
        // anchor.click(); // Trigger the click event to download the file
      } else {
        // For mobile: save to the device
        final output = await getTemporaryDirectory();
        final filePath = '${output.path}/resume.pdf';

        // Write the PDF to a file
        final file = File(filePath);
        await file.writeAsBytes(await document.save());
        document.dispose();

        // Show a success message with the file path
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Resume downloaded to $filePath')),
        );
      }
    } catch (e) {
      print("Error downloading resume: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download resume.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Resume Builder',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue[900],
          foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Generated Resume:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        _resumeContent.isEmpty
                            ? 'Resume content will appear here.'
                            : _resumeContent,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _downloadResume,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Colors.blue[900],
                    ),
                    child: Text(
                      'Download Resume as PDF',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
