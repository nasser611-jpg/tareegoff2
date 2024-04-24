import 'package:flutter/material.dart';
import 'package:tareegoff22/core/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tareegoff22/presentation/screens/login.dart';
import 'package:tareegoff22/presentation/widgets/custom_app_logo.dart';
class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 216, 223, 229),
            ),
            child:CustomAppLogo()
          ),
          ListTile(trailing: Icon(Icons.logout),
            title: Text('تسجيل الخروج',style: Styles.titlePage.copyWith(color: Colors.black,fontSize: 14),),
            onTap: () async{
                Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
        );
        try {
      await FirebaseAuth.instance.signOut();
      
      // Initialize GoogleSignIn
      GoogleSignIn googleSignIn = GoogleSignIn();
      // Disconnect GoogleSignIn
      await googleSignIn.disconnect();
      
        } catch (e) {
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