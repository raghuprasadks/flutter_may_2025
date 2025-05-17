import 'package:flutter/material.dart';
import 'package:ui/widgets/Login.dart';
import 'widgets/VideoStore.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Store',
      debugShowCheckedModeBanner: false, 
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Video Store'),
          centerTitle: true, // Center the title
        ),
        body: const LoginScreen(),
      ),
    );
  }
}/**
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _login() {
    // For demo, accept any non-empty credentials
    if (_username.text.isNotEmpty && _password.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => VideoStoreScreen(onLogout: _logout)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter username and password')),
      );
    }
  }

  void _gotoSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignupScreen()),
    );
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: _username, decoration: const InputDecoration(labelText: 'Username')),
            TextField(controller: _password, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _login, child: const Text('Login')),
            TextButton(onPressed: _gotoSignup, child: const Text('Signup'))
          ],
        ),
      ),
    );
  }
}
*/
// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});
//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final TextEditingController _username = TextEditingController();
//   final TextEditingController _password = TextEditingController();

//   void _signup() {
//     // For demo, just go back to login
//     Navigator.pop(context);
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Signup successful! Please login.')),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Signup')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(controller: _username, decoration: const InputDecoration(labelText: 'Username')),
//             TextField(controller: _password, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
//             const SizedBox(height: 16),
//             ElevatedButton(onPressed: _signup, child: const Text('Signup')),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Wrap VideoStore with logout button
/**
class VideoStoreScreen extends StatelessWidget {
  final VoidCallback onLogout;
  const VideoStoreScreen({super.key, required this.onLogout});

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Store'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // This will remove all previous routes and show LoginScreen
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => false,
              );
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: const VideoStore(),
    );
  }
}
 */