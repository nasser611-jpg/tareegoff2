import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tareegoff22/core/styles.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:tareegoff22/presentation/screens/login.dart';
import 'package:tareegoff22/presentation/screens/sign_up.dart';
























// ignore: must_be_immutable
class SocialNetworkWidget extends StatefulWidget {
  SocialNetworkWidget({Key? key}) : super(key: key);

  @override
  State<SocialNetworkWidget> createState() => _SocialNetworkWidgetState();
}

class _SocialNetworkWidgetState extends State<SocialNetworkWidget> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

@override
  void dispose() {
  emailController.dispose();
  passController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 337,
      height: MediaQuery.of(context).size.height * 0.450,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 234, 230, 230),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white54.withOpacity(0.5))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Enter via Social Networks',
              style: Styles.textStyle12
                  .copyWith(fontSize: 17, color: const Color(0xff702FDB)),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.020,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 22,
                ),
                GestureDetector(
                  onTap: () {
                     AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.rightSlide,
                      headerAnimationLoop: true,
                      title: 'عفواً',
                      desc:
                          '  انتقل  الى صفحة تسجيل الدخول لاستخدام هذه الخاصيه',btnOkOnPress: () {
                           
                          },
                          btnOkText: 'حسناً'
                   
                    ).show();
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: const Color(0xffD8D8D8),
                    child: SvgPicture.asset(
                      'assets/images/google.svg',
                      width: 25,
                      height: MediaQuery.of(context).size.height * 0.030,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 22,
                ),
              
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.044,
            ),
            Text(
              '''Or login with email''',
              style: Styles.textStyle12
                  .copyWith(fontSize: 15, color: Colors.black),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.044,
            ),
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
                    style:
                        Styles.textStyle30Title.copyWith(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return const SignUpScreen();
                      },
                    ));
                  },
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.020,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You already have an account? ',
                  style: Styles.textStyle12
                      .copyWith(color: Colors.black, fontSize: 13),
                ),
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
            )
          ],
        ),
      ),
    );
  }
}
