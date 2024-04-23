import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tareegoff22/presentation/screens/login.dart';
import 'package:tareegoff22/presentation/screens/admin_complaines.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [Expanded(child:FirebaseAuth.instance.currentUser!=null&&FirebaseAuth.instance.currentUser!.emailVerified? AdminComplainesScreen():LoginScreen()
)],
    );
  }
}