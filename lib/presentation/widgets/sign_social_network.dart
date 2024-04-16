import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:tareegoff22/core/styles.dart';
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

  void _validateAndSubmit() {
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
      // Here, you would usually handle form submission
      print('data submiitted succefully');
    } else {
      // Displaying error messages
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
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: const Color(0xffD8D8D8),
                      child: SvgPicture.asset('assets/images/google.svg',
                          width: 25, height: 30),
                    ),
                    const SizedBox(width: 22),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: const Color(0xffD8D8D8),
                      child: SvgPicture.asset('assets/images/facebook.svg',
                          width: 25, height: 30),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.040),
                Text('Or login with email',
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
                        prefixIcon: Icon(Icons.lock,
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
                      color: Color(0xff702FDB),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: TextButton(
                        child: Text(
                          'Sign up',
                          style: Styles.textStyle30Title
                              .copyWith(color: Colors.white),
                        ),
                        onPressed: _validateAndSubmit),
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
                              return LoginScreen();
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
