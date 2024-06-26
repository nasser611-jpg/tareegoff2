import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:tareegoff22/core/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tareegoff22/presentation/screens/sign_up.dart';
import 'package:tareegoff22/presentation/screens/user_complaines_screen.dart';
import 'package:tareegoff22/presentation/screens/admin_show_users_requset.dart';

class LoginSocialNetworkWidget extends StatefulWidget {
  const LoginSocialNetworkWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginSocialNetworkWidgetState createState() =>
      _LoginSocialNetworkWidgetState();
}

class _LoginSocialNetworkWidgetState extends State<LoginSocialNetworkWidget> {
  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => const UserComplainesScreen(),
        ));
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateAndSubmit() async {
    String? newEmailError;
    String? newPasswordError;

    if (_emailController.text.isEmpty ||
        !RegExp(
          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
        ).hasMatch(_emailController.text)) {
      newEmailError = 'Please enter a valid email';
    }

    if (_passwordController.text.isEmpty ||
        _passwordController.text.length < 8) {
      newPasswordError = 'Password must be at least 8 characters';
    }

    if (newEmailError == null && newPasswordError == null) {
      try {
        setState(() {
          isLoading = true;
        });
        if (_emailController.text == 'admin@gmail.com' &&
            _passwordController.text == 'admin123') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const AdminShowUsers()));
        }
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);

        setState(() {
          isLoading = false;
        });

        if (credential.user!.emailVerified) {
          Navigator.pushReplacement(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(
                  builder: (context) => const UserComplainesScreen()));
        } else {
          // ignore: avoid_print
          print('===================================Verify email please');
        }
      } on FirebaseAuthException catch (e) {
        isLoading = false;

        if (e.code == 'user-not-found') {
          // ignore: avoid_print
          print('user not found');
        } else if (e.code == 'wrong-password') {
          // ignore: avoid_print
          print('password not correct');
        }
      }
    } else {
      // Display errors if any
      setState(() {
        _emailError = newEmailError;
        _passwordError = newPasswordError;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        margin: const EdgeInsets.only(right: 30),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.622,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 234, 230, 230),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white54.withOpacity(0.5))),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                Text('Enter via Social Networks',
                    style: Styles.textStyle12.copyWith(
                        fontSize: 17, color: const Color(0xff702FDB))),
                SizedBox(height: MediaQuery.of(context).size.height * 0.020),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 22),
                    GestureDetector(
                      onTap: signInWithGoogle,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: const Color(0xffD8D8D8),
                        child: SvgPicture.asset('assets/images/google.svg',
                            width: 25, height: 30),
                      ),
                    ),
                    const SizedBox(width: 22),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.040),
                Text('Or login with email',
                    style: Styles.textStyle12.copyWith(
                        fontSize: 15, color: const Color(0xff702FDB))),
                SizedBox(height: MediaQuery.of(context).size.height * 0.038),
                Container(
                  padding: const EdgeInsets.all(6),
                  height: 65,
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xffD8D8D8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter Email',
                        errorText: _emailError,
                        prefixIcon: const Icon(Icons.email,
                            color: Color.fromARGB(255, 125, 123, 123)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.020),
                Container(
                  padding: const EdgeInsets.all(6),
                  height: 65,
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xffD8D8D8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter Password',
                        errorText: _passwordError,
                        prefixIcon: const Icon(Icons.lock,
                            color: Color.fromARGB(255, 125, 123, 123)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.010),
                GestureDetector(
                  onTap: () async {
                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: _emailController.text);
                      AwesomeDialog(
                              // ignore: use_build_context_synchronously
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.topSlide,
                              headerAnimationLoop: true,
                              title: 'عفواً',
                              desc:
                                  'لقد تم ارسال لينك على ايميلك انقر عليه لتغيير كلمة المرور الخاصه بك!...',
                              btnOkOnPress: () {},
                              btnOkText: 'حسناً')
                          .show();
                    } on Exception catch (e) {
                      AwesomeDialog(
                              // ignore: use_build_context_synchronously
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.topSlide,
                              headerAnimationLoop: true,
                              title: 'عفواً',
                              desc: '$e',
                              btnOkOnPress: () {},
                              btnOkText: 'تمام')
                          .show();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 28.0),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'forget Password',
                          style: Styles.textStyle12
                              .copyWith(color: const Color(0xff702FDB)),
                        )),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                Container(
                  height: 59,
                  width: 308,
                  decoration: BoxDecoration(
                      color: const Color(0xff702FDB),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: TextButton(
                        onPressed: _validateAndSubmit,
                        child: Text(
                          'Login ',
                          style: Styles.textStyle30Title
                              .copyWith(color: Colors.white),
                        )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don’t have an account?  ',
                        style: Styles.textStyle12
                            .copyWith(color: Colors.black, fontSize: 13)),
                    SizedBox(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return const SignUpScreen();
                            },
                          ));
                        },
                        child: Text('Sign up',
                            style: Styles.textStyle12.copyWith(
                                color: const Color(0xff702FDB), fontSize: 13)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
