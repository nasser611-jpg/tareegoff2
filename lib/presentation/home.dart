import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:tareegoff22/presentation/screens/user_complaines_screen.dart';
import 'package:tareegoff22/presentation/screens/user_send_complaines.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [Expanded(child: UserSendComplainesScreen())],
    );
  }
}
