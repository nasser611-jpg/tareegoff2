import 'package:flutter/material.dart';
import 'package:tareegoff22/core/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:tareegoff22/presentation/screens/login.dart';

class SignSocialNetworksWidget extends StatefulWidget {
  const SignSocialNetworksWidget({Key? key}) : super(key: key);

  @override
  _SignSocialNetworksWidgetState createState() =>
      _SignSocialNetworksWidgetState();
}

class _SignSocialNetworksWidgetState extends State<SignSocialNetworksWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
      AwesomeDialog(
              // ignore: use_build_context_synchronously
              context: context,
              dialogType: DialogType.success,
              animType: AnimType.rightSlide,
              headerAnimationLoop: true,
              title: 'عفواً',
              desc:
                  '   اذهب الى الايميل وقم بالضغط على لينك التحقق لتفعيل حسابك ثم سجل الدخول به',
              btnOkText: 'حسناً')
          .show();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AwesomeDialog(
          // ignore: use_build_context_synchronously
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.rightSlide,
          headerAnimationLoop: true,
          title: 'عذراً',
          desc: 'كلمة المرور ضعيفه جدا',
        ).show();
      } else if (e.code == 'email-already-in-use') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.rightSlide,
          headerAnimationLoop: true,
          title: 'عذراً',
          desc: 'هذا الحساب مستخدم بالفعل ',
        ).show();
        print('The account already exists for that email.');
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.rightSlide,
          headerAnimationLoop: true,
          title: 'عذراً',
          desc: '${e.code}',
        ).show();
      }
    } catch (e) {
      print(e);
    }
  }
  // Here you can handle the SignUp logic with the state values

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
                SizedBox(height: MediaQuery.of(context).size.height * 0.040),
                Text(' SignUp with email',
                    style: Styles.textStyle12
                        .copyWith(fontSize: 15, color: Colors.black)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.038),
                Container(
                  padding: const EdgeInsets.all(6),
                  height: 65,
                  width: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xffD8D8D8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Material(
                    color: Colors.transparent,
                    child: TextField(
                      decoration: InputDecoration(
                        suffix: Text(
                          '(Optional)',
                          style: TextStyle(fontSize: 12),
                        ),
                        hintText: 'Enter username',
                        prefixIcon: Icon(Icons.person_outline_outlined,
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                Container(
                  height: 59,
                  width: 308,
                  decoration: BoxDecoration(
                      color: const Color(0xff702FDB),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: TextButton(
                        child: Text(
                          'Sign up',
                          style: Styles.textStyle30Title
                              .copyWith(color: Colors.white),
                        ),
                        onPressed: _submitForm),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('You already have an account?',
                        style: Styles.textStyle12
                            .copyWith(color: Colors.black, fontSize: 13)),
                    SizedBox(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return const LoginScreen();
                            },
                          ));
                        },
                        child: Text('Login',
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
