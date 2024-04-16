import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tareegoff22/core/styles.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:tareegoff22/presentation/widgets/custom_app_logo.dart';
import 'package:tareegoff22/presentation/widgets/login_social_network.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
            padding: EdgeInsets.only(top: 14.h, left: 10.w),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: const Color(0xffD9D9D9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: Styles.textStyle12
                      .copyWith(color: const Color(0xff702FDB), fontSize: 30),
                ),
                const Text(
                  '''Please login or sign up to continue using
        our app''',
                  style: Styles.textStyle12,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.020,
                ),
                const CustomAppLogo(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.020,
                ),
                const LoginSocialNetworkWidget()
              ],
            ));
      },
    );
  }
}
