import 'package:flutter/material.dart';
import 'package:tareegoff22/core/styles.dart';

// ignore: non_constant_identifier_names
AppBar CustomAppBar(String title, IconData myIcon) {
  return AppBar(
    flexibleSpace: Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blueAccent,
                Color.fromARGB(255, 126, 160, 204),
                Color.fromARGB(255, 17, 87, 144)
              ])),
      padding: const EdgeInsets.only(
        top: 30,
        left: 15,
        right: 15,
      ),
      width: double.infinity,
      height: 90,
      child: Row(
        children: [
          const CustomLogo(),
          const Spacer(),
          Text(
            title,
            style:
                Styles.textStyle12.copyWith(fontSize: 13, color: Colors.white),
          ),
          const SizedBox(
            width: 3,
          ),
          Icon(
            myIcon,
            color: const Color.fromARGB(212, 255, 255, 255),
          )
        ],
      ),
    ),
  );
}

class CustomLogo extends StatelessWidget {
  const CustomLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 28,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
              image: AssetImage('assets/images/logo 1.png'))),
    );
  }
}
