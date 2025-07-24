import 'package:facultytracker/admin_pages/admin_help.dart';
import 'package:facultytracker/admin_pages/admin_home.dart';
import 'package:facultytracker/admin_pages/admin_login.dart';
import 'package:facultytracker/admin_pages/faculty_approval.dart';
import 'package:facultytracker/admin_pages/faculty_approval_info.dart';
import 'package:facultytracker/admin_pages/faculty_info.dart';
import 'package:facultytracker/admin_pages/leave_applications.dart';
import 'package:facultytracker/admin_pages/map_page.dart';
import 'package:facultytracker/firebase_options.dart';
import 'package:facultytracker/pages/Home.dart';
import 'package:facultytracker/pages/Login.dart';
import 'package:facultytracker/pages/Register.dart';
import 'package:facultytracker/pages/aboutus.dart';
import 'package:facultytracker/pages/settings.dart';
import 'package:facultytracker/pages/user_help.dart';
import 'package:facultytracker/pages/user_home.dart';
import 'package:facultytracker/pages/user_leave.dart';
import 'package:facultytracker/pages/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:facultytracker/utils/local_notification_service.dart';

// The cloud_firestore and firebase_storage packages are used to interact with Firebase Firestore (a NoSQL database) and Firebase Storage (for storing files like images, videos, etc.)


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize local notifications
  await LocalNotificationService.initialize();

  // Set logger level
  Logger.level = Level.debug;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while checking auth state
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.hasData && snapshot.data != null) {
            // User is logged in, go to UserHome
            return const UserHome();
          } else {
            // No user logged in, go to Home
            return const Home();
          }
        },
      ),
      routes: {
        '/home': (context) => const Home(),
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/user_home': (context) => UserHome(),
        '/user_help': (context) => UserHelpPage(),
        '/user_leave': (context) => const UserLeave(),
        '/user_profile': (context) => const ProfilePage(),
        '/aboutus': (context) => const AboutUsPage(),
        '/settings': (context) => const SettingsPage(),
        '/admin_login': (context) => AdminLogin(),
        '/admin_home': (context) => const AdminHome(),
        '/faculty_info': (context) => const FacultyInfoPage(),
        '/leave_applications': (context) => const LeaveApplicationsPage(),
        '/admin_help': (context) => const AdminHelpPage(),
        '/faculty_approval': (context) => const FacultyApproval(),
        '/map_page': (context) => MapPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/faculty_approval_info') {
          final userId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => FacultyApprovalInfoPage(userId: userId),
          );
        }
        return null;
      },
    );
  }
}





// class Home extends StatefulWidget {
//   const Home({super.key});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/login6.jpg'), // Path to your background image
//             fit: BoxFit.cover, // Ensures the image covers the entire background
//           ),
//         ),
//         child:
//         Center(
//           child: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(18.0),
//               child: Column(
//                 children: [
//                   Image.asset(
//                     'assets/dit_logo.png',
//                     height: 150,
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'DPU UNITECH SOCIETY',
//                     style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.purple
//                     ),
//                   ),
//                   Text(
//                     'ENGINEERING',
//                     style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.purple
//                     ),
//                   ),
//                   SizedBox(
//                     height: 25,
//                   ),
//                   Text(
//                     'Welcome to DIT Pimpri',
//                     style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.purple
//                     ),
//                   ),
//                   SizedBox(height: 25),
//                   Text('New User?'),
//                   SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/register');
//                     },
//                     style: ElevatedButton.styleFrom(
//                       minimumSize: Size(double.infinity, 50),
//                       backgroundColor: Colors.purple,
//                       foregroundColor: Colors.white,
//                     ),
//                     child: Text('Register'),
//                   ),
//                   SizedBox(height: 35),
//                   Text('Already have an account?'),
//                   SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
//                       Navigator.pushNamed(context, '/login');
//                     },
//                     style: ElevatedButton.styleFrom(
//                       minimumSize: Size(double.infinity, 50),
//                       backgroundColor: Colors.purple,
//                       foregroundColor: Colors.white,
//                     ),
//                     child: Text('Login'),
//                   ),
//                   SizedBox(height: 95),
//                   Text('Admin Login Options'),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/admin_login');
//                     },
//                     style: ElevatedButton.styleFrom(
//                       minimumSize: Size(double.infinity, 50),
//                       backgroundColor: Colors.purple,
//                       foregroundColor: Colors.white,
//                     ),
//                     child: Text('Admin Login'),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }










// void main() {
//   runApp(MaterialApp(
//     home: Home(),
//     theme: ThemeData(
//       fontFamily: 'Roboto', // Modern font
//       primarySwatch: Colors.purple,
//     ),
//   ));
// }
//
// class Home extends StatefulWidget {
//   const Home({super.key});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.purple.shade100,
//               Colors.purple.shade300,
//               Colors.purple.shade700,
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(18.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Logo
//                 Image.asset(
//                   'assets/dit_logo.png',
//                   height: 100,
//                   width: 100,
//                 ),
//                 const SizedBox(height: 15),
//
//                 // Title
//                 const Text(
//                   'DPU UNITECH SOCIETY',
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     letterSpacing: 1.5,
//                   ),
//                 ),
//                 const Text(
//                   'ENGINEERING',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.white70,
//                   ),
//                 ),
//
//                 const SizedBox(height: 30),
//
//                 // Welcome text
//                 const Text(
//                   'Welcome to DIT Pimpri',
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//
//                 const SizedBox(height: 40),
//
//                 // Register Button
//                 const Text(
//                   'New User?',
//                   style: TextStyle(color: Colors.white70),
//                 ),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: const Text('Register'),
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size(double.infinity, 50),
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.purple,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 30),
//
//                 // Login Button
//                 const Text(
//                   'Already have an account?',
//                   style: TextStyle(color: Colors.white70),
//                 ),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: const Text('Log in'),
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size(double.infinity, 50),
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.purple,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                 ),
//
//                 const Spacer(),
//
//                 // Admin Login Button
//                 const Text(
//                   'Admin Login Options',
//                   style: TextStyle(color: Colors.white70),
//                 ),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: const Text('Admin Login'),
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size(double.infinity, 50),
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.purple,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }







// void main() {
//   runApp(MaterialApp(
//     home: Home(),
//     theme: ThemeData(
//       fontFamily: 'Roboto', // Modern font
//       primarySwatch: Colors.deepPurple,
//     ),
//   ));
// }
//
// class Home extends StatefulWidget {
//   const Home({super.key});
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.deepPurple.shade900,
//               Colors.deepPurple.shade600,
//               Colors.deepPurple.shade300,
//               Colors.deepPurple.shade100,
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Logo
//                 Image.asset(
//                   'assets/dit_logo.png',
//                   height: 120,
//                   width: 120,
//                 ),
//                 const SizedBox(height: 20),
//
//                 // Title
//                 const Text(
//                   'DPU UNITECH SOCIETY',
//                   style: TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     letterSpacing: 2.0,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const Text(
//                   'ENGINEERING',
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.white70,
//                   ),
//                 ),
//
//                 const SizedBox(height: 30),
//
//                 // Welcome text
//                 const Text(
//                   'Welcome to DIT Pimpri',
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     shadows: [
//                       Shadow(
//                         blurRadius: 10.0,
//                         color: Colors.black54,
//                         offset: Offset(2, 2),
//                       ),
//                     ],
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//
//                 const SizedBox(height: 40),
//
//                 // Register Button
//                 const Text(
//                   'New User?',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 18,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: const Text('Register'),
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size(double.infinity, 60),
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.deepPurple,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                     elevation: 5,
//                   ),
//                 ),
//
//                 const SizedBox(height: 30),
//
//                 // Login Button
//                 const Text(
//                   'Already have an account?',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 18,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: const Text('Log in'),
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size(double.infinity, 60),
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.deepPurple,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                     elevation: 5,
//                   ),
//                 ),
//
//                 const Spacer(),
//
//                 // Admin Login Button
//                 const Text(
//                   'Admin Login Options',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 18,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: const Text('Admin Login'),
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size(double.infinity, 60),
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.deepPurple,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                     elevation: 5,
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }