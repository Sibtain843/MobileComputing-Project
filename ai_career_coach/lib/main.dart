// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'screens/welcome_screen.dart';
// import 'screens/auth_screen.dart';
// import 'screens/profile_setup_screen.dart';
// import 'screens/career_path_screen.dart';
// import 'screens/learning_recommendation_screen.dart';
// import 'screens/resume_builder_screen.dart';
// import 'screens/interview_preparation_screen.dart';
// import 'screens/progress_tracker_screen.dart';
// import 'screens/notification_trigger.dart';
// import './home_screen.dart';
// import './firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize Firebase with the generated options
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions
//         .currentPlatform, // Uses the correct config for the current platform
//   );
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'AI Career Coach',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: AuthCheck(),
//       routes: {
//         '/welcome': (context) => WelcomeScreen(),
//         '/login': (context) => AuthScreen(isSignUp: false),
//         '/signup': (context) => AuthScreen(isSignUp: true),
//         '/profileSetup': (context) => ProfileSetupScreen(),
//         '/careerPath': (context) => CareerPathScreen(),
//         '/learningRecommendations': (context) => LearningRecommendationScreen(),
//         '/resumeBuilder': (context) => ResumeBuilderScreen(),
//         '/interviewPreparation': (context) => InterviewPreparationScreen(),
//         '/progressTracker': (context) => ProgressTrackerScreen(),
//         '/notifications': (context) => NotificationTriggerScreen(),
//         '/home': (context) => HomeScreen(),
//       },
//     );
//   }
// }

// class AuthCheck extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasData) {
//           return HomeScreen(); // User is logged in
//         } else {
//           return WelcomeScreen(); // User is not logged in
//         }
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/welcome_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/profile_setup_screen.dart';
import 'screens/career_path_screen.dart';
import 'screens/learning_recommendation_screen.dart';
import 'screens/resume_builder_screen.dart';
import 'screens/interview_preparation_screen.dart';
import 'screens/progress_tracker_screen.dart';
import 'screens/notification_trigger.dart'; // Ensure this screen exists
import './home_screen.dart';
import './firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the generated options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Career Coach',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AuthCheck(),
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/login': (context) => AuthScreen(isSignUp: false),
        '/signup': (context) => AuthScreen(isSignUp: true),
        '/profileSetup': (context) => ProfileSetupScreen(),
        '/careerPath': (context) => CareerPathScreen(),
        '/learningRecommendations': (context) => LearningRecommendationScreen(),
        '/resumeBuilder': (context) => ResumeBuilderScreen(),
        '/interviewPreparation': (context) => InterviewPreparationScreen(),
        '/progressTracker': (context) => ProgressTrackerScreen(),
        '/notifications': (context) =>
            NotificationTriggerScreen(), // Ensure this exists
        '/home': (context) => HomeScreen(),
      },
    );
  }
}

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return HomeScreen(); // User is logged in
        } else {
          return WelcomeScreen(); // User is not logged in
        }
      },
    );
  }
}
