import 'package:flutter/material.dart';

class AnimatedDots extends StatelessWidget {
  final int currentIndex;
  final int itemCount;

  AnimatedDots({
    required this.currentIndex,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          height: 3,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Color.fromARGB(235, 10, 172, 72).withOpacity(
              index == currentIndex ? 0.7 : 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
