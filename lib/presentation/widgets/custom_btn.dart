import 'package:flutter/material.dart';
import 'package:tareegoff22/core/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.txt}) : super(key: key);
  final String txt;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 59,
      width: 308,
      decoration: BoxDecoration(
          color: Color(0xff702FDB), borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: TextButton(
          child: Text(
            txt,
            style: Styles.textStyle30Title.copyWith(color: Colors.white),
          ),
          onPressed: () {
            print('hello button');
          },
        ),
      ),
    );
  }
}
