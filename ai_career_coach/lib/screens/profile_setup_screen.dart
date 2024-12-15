import 'package:flutter/material.dart';
import '../services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart'; // To access the current user
import 'package:flutter_typeahead/flutter_typeahead.dart';

class ProfileSetupScreen extends StatefulWidget {
  @override
  _ProfileSetupScreenState createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final UserService _userService = UserService();
  final _educationController = TextEditingController();
  final _skillsController = TextEditingController();
  final _goalsController = TextEditingController();

  bool _isLoading = false;
  bool _isFormValid = true;
  String _name = '';
  String _email = '';

  // Lists of valid keywords for each field
  List<String> skillsList = [
    "Python",
    "Java",
    "C++",
    "JavaScript",
    "Project Management",
    "UI/UX Design",
    "Data Analysis",
    "Machine Learning"
  ];

  List<String> educationList = [
    "Bachelor's in Computer Science",
    "Master's in Business Administration",
    "Bachelor's in Mechanical Engineering",
    "PhD in Physics"
  ];

  List<String> careerGoalsList = [
    "Become a Full Stack Developer",
    "Become a Project Manager",
    "Pursue Leadership Role",
    "Become a Data Scientist"
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Fetch user data from Google account (name, email)
  void _loadUserData() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _name = user.displayName ?? ''; // Name from Google account
        _email = user.email ?? ''; // Email from Google account
      });
    }
  }

  Future<void> _saveProfile() async {
    setState(() {
      _isLoading = true;
      _isFormValid = true; // Reset validation
    });

    try {
      // Get user input from controllers
      final education = _educationController.text;
      final skills = _skillsController.text;
      final goals = _goalsController.text;

      // Validation: Check if the skills, education, and career goals match valid options
      if (!_validateInput(skills, education, goals)) {
        setState(() {
          _isFormValid = false; // If validation fails, prevent save
          _isLoading = false;
        });
        return;
      }

      // If valid, save the profile (you can modify the service to handle saving)
      await _userService.saveUserProfile(
          _name, _email, education, skills, goals);

      // Navigate to the Career Path screen after saving the profile
      Navigator.pushReplacementNamed(context, '/careerPath');
    } catch (e) {
      print("Error saving profile: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save profile. Please try again.")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Validate user input against predefined lists of valid keywords
  bool _validateInput(String skills, String education, String goals) {
    final skillsValid =
        skills.split(',').every((skill) => skillsList.contains(skill.trim()));
    final educationValid = educationList.contains(education);
    final goalsValid = careerGoalsList.contains(goals);

    return skillsValid && educationValid && goalsValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Profile Setup', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue[900],
          foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller:
                        TextEditingController(text: _name), // Pre-fill name
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    enabled: false, // Make name field non-editable
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller:
                        TextEditingController(text: _email), // Pre-fill email
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    enabled: false, // Make email field non-editable
                  ),
                  SizedBox(height: 15),
                  TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _educationController,
                      decoration: InputDecoration(
                        labelText: 'Education',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    suggestionsCallback: (pattern) {
                      return educationList
                          .where((education) => education
                              .toLowerCase()
                              .contains(pattern.toLowerCase()))
                          .toList();
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      _educationController.text = suggestion;
                    },
                  ),
                  SizedBox(height: 15),
                  TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _skillsController,
                      decoration: InputDecoration(
                        labelText: 'Skills (comma separated)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    suggestionsCallback: (pattern) {
                      return skillsList
                          .where((skill) => skill
                              .toLowerCase()
                              .contains(pattern.toLowerCase()))
                          .toList();
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      _skillsController.text = suggestion;
                    },
                  ),
                  SizedBox(height: 15),
                  TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _goalsController,
                      decoration: InputDecoration(
                        labelText: 'Career Goals',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    suggestionsCallback: (pattern) {
                      return careerGoalsList
                          .where((goal) => goal
                              .toLowerCase()
                              .contains(pattern.toLowerCase()))
                          .toList();
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      _goalsController.text = suggestion;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Colors.blue[900],
                    ),
                    child: Text('Save Profile'),
                  ),
                  if (!_isFormValid)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Please enter valid skills, education, and career goals.',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
