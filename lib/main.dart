import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:tareegoff22/presentation/screens/register.dart';
import 'package:tareegoff22/presentation/screens/user_complaines_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyAD-OlRc47SFXmIpKvrbROSfpBY0g4aFH8',
    appId: '1:584108663058:android:3cbc820261092fed57d3cb',
    messagingSenderId: '584108663058',
    projectId: 'tareeqoff',
    storageBucket: 'tareeqoff.appspot.com',
  ));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // ignore: avoid_print
        print('====================User is currently signed out!');
      } else {
        // ignore: avoid_print
        print('====================User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
            locale: const Locale('ar', 'sa'),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: FirebaseAuth.instance.currentUser != null &&
                    FirebaseAuth.instance.currentUser!.emailVerified
                ? const UserComplainesScreen()
                : const Regesteration());
      },
    );
  }
}
