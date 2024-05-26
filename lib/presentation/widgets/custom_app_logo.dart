import 'package:flutter/widgets.dart';

class CustomAppLogo extends StatelessWidget {
  const CustomAppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 60),
      alignment: Alignment.center,
      height: 50,
      width: 100,
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(255, 163, 124, 5), offset: Offset(1, 1)),
            BoxShadow(
                color: Color.fromARGB(255, 223, 206, 18),
                offset: Offset(1, 1),
                blurRadius: 0.5,
                spreadRadius: 0.7),
          ],
          image: DecorationImage(image: AssetImage('assets/images/logo 1.png')),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20), topRight: Radius.circular(20)),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 23, 118, 197),
                Color.fromARGB(228, 128, 146, 177),
                Color.fromARGB(201, 87, 117, 142)
              ])),
    );
  }
}
