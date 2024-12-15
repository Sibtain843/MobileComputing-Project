import 'package:flutter/material.dart';
import '../services/user_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserService _userService = UserService();
  Map<String, String> _userProfile = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final profile = await _userService.getUserProfile();
      setState(() {
        _userProfile = profile;
        _isLoading = false;
      });
    } catch (e) {
      print("Error retrieving user profile: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('User Profile', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue[900],
          foregroundColor: Colors.white // Changed to blue[900]
          ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.blue[900], // Card background color
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.blue[900], // Icon color
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        _buildProfileItem(
                          icon: Icons.person,
                          label: 'Name',
                          value: _userProfile['name'] ?? 'N/A',
                        ),
                        Divider(),
                        _buildProfileItem(
                          icon: Icons.email,
                          label: 'Email',
                          value: _userProfile['email'] ?? 'N/A',
                        ),
                        Divider(),
                        _buildProfileItem(
                          icon: Icons.school,
                          label: 'Education',
                          value: _userProfile['education'] ?? 'N/A',
                        ),
                        Divider(),
                        _buildProfileItem(
                          icon: Icons.code,
                          label: 'Skills',
                          value: _userProfile['skills'] ?? 'N/A',
                        ),
                        Divider(),
                        _buildProfileItem(
                          icon: Icons.flag,
                          label: 'Career Goals',
                          value: _userProfile['goals'] ?? 'N/A',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildProfileItem(
      {required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[300], // Lighter gray text
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text for visibility
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
