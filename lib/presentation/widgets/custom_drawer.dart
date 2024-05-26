import 'package:flutter/material.dart';
import 'package:tareegoff22/core/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tareegoff22/presentation/screens/login.dart';
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 216, 223, 229),
            ),
            child:Row(
              children: [
                Text(FirebaseAuth.instance.currentUser!.email.toString()),
                const SizedBox(width: 5,),
                CircleAvatar(
                  child:Image.asset('assets/images/logo 1.png',width: 50,height: 70,fit: BoxFit.fill,),
                  )
              ],
            )
          ),
          ListTile(trailing: const Icon(Icons.logout),
            title: Text('تسجيل الخروج',style: Styles.titlePage.copyWith(color: Colors.black,fontSize: 14),),
            onTap: () async{
                Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>const LoginScreen(),
      ),
        );
        try {
      await FirebaseAuth.instance.signOut();
      
      // Initialize GoogleSignIn
      GoogleSignIn googleSignIn = GoogleSignIn();
      // Disconnect GoogleSignIn
      await googleSignIn.disconnect();
      
        } catch (e) {
      // ignore: avoid_print
      print('error: $e');
        }
      }
      ,
         
            
          ),
        ],
      ),
    );
  }
}