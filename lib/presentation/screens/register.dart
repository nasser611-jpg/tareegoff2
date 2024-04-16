import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tareegoff22/core/styles.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:tareegoff22/presentation/widgets/social_network.dart';

class Regesteration extends StatelessWidget {
  const Regesteration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
            padding: EdgeInsets.only(top: 14.h, left: 10.w),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0xffD9D9D9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Welcome',
                  style: Styles.textStyle30Title,
                ),
                Text(
                  '''Please login or sign up to continue using
our app''',
                  style: Styles.textStyle12,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.020,
                ),
                Container(
                  height: 200,
                  width: 300,
                  child: SvgPicture.asset(
                    'assets/images/icon3.svg',
                  ),
                ),
                Divider(
                  height: 2,
                  color: Colors.white.withOpacity(0.5),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.020,
                ),
                SocialNetworkWidget()
              ],
            ));
      },
    );
  }
}
