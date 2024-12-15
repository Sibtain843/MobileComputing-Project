import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Save user profile data to Firestore
  Future<Map<String, String>> getUserProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("No user is signed in");
      }

      final userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        // Profile not found, handle accordingly
        throw Exception("User profile not found in Firestore.");
      }

      return {
        'name': userDoc['name'] ?? 'No Name',
        'email': userDoc['email'] ?? 'No Email',
        'skills': userDoc['skills'] ?? 'No Skills',
        'goals': userDoc['goals'] ?? 'No Goals',
      };
    } catch (e) {
      print("Error retrieving user profile from Firestore: $e");
      return {};
    }
  }

  // Save user profile data (you might want to call this after first login)
  Future<void> saveUserProfile(String name, String email, String education,
      String skills, String goals) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await _firestore.collection('users').doc(user.uid).set({
        'name': name,
        'email': email,
        'education': education,
        'skills': skills,
        'goals': goals,
      });
    } catch (e) {
      print("Error saving user profile to Firestore: $e");
    }
  }

  // Clear user data from Firestore upon logout
  Future<void> clearUserProfile() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).delete();
      }
    } catch (e) {
      print("Error clearing user profile from Firestore: $e");
    }
  }
}
