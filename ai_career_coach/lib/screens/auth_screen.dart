// import 'package:flutter/material.dart';
// import '../services/auth_service.dart';

// class AuthScreen extends StatefulWidget {
//   final bool isSignUp;

//   const AuthScreen({Key? key, required this.isSignUp}) : super(key: key);

//   @override
//   _AuthScreenState createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   final AuthService _authService = AuthService();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   Future<void> _handleAuth() async {
//     if (widget.isSignUp) {
//       await _authService
//           .signUpWithEmail(_emailController.text, _passwordController.text)
//           .then((user) {
//         if (user != null) {
//           Navigator.pushReplacementNamed(context, '/profileSetup');
//         }
//       });
//     } else {
//       await _authService
//           .loginWithEmail(_emailController.text, _passwordController.text)
//           .then((user) {
//         if (user != null) {
//           Navigator.pushReplacementNamed(context, '/careerPath');
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.isSignUp ? 'Sign Up' : 'Log In'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.isSignUp ? 'Create Account' : 'Welcome Back',
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 15),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 border: OutlineInputBorder(),
//               ),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _handleAuth,
//               style: ElevatedButton.styleFrom(
//                 minimumSize: Size(double.infinity, 50),
//                 backgroundColor: Colors.blueAccent,
//               ),
//               child: Text(widget.isSignUp ? 'Sign Up' : 'Log In'),
//             ),
//             Center(
//               child: TextButton(
//                 onPressed: () async {
//                   final user = await _authService.signInWithGoogle();
//                   if (user != null) {
//                     Navigator.pushReplacementNamed(context, '/careerPath');
//                   }
//                 },
//                 child: Text('Sign in with Google'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  final bool isSignUp;

  const AuthScreen({Key? key, required this.isSignUp}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _handleAuth() async {
    if (widget.isSignUp) {
      await _authService
          .signUpWithEmail(_emailController.text, _passwordController.text)
          .then((user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/profileSetup');
        }
      });
    } else {
      await _authService
          .loginWithEmail(_emailController.text, _passwordController.text)
          .then((user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/careerPath');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSignUp ? 'Sign Up' : 'Log In',
            style: TextStyle(
              color: Colors.white,
            )),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isSignUp ? 'Create Account' : 'Welcome Back',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.blue[900]),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.blue[900]),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleAuth,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.blue[900],
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                widget.isSignUp ? 'Sign Up' : 'Log In',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () async {
                  final user = await _authService.signInWithGoogle();
                  if (user != null) {
                    Navigator.pushReplacementNamed(context, '/careerPath');
                  }
                },
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(color: Colors.blue[900]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
