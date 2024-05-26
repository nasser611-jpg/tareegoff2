import 'package:flutter/material.dart';

class AnimatedDots extends StatelessWidget {
  final int currentIndex;
  final int itemCount;

  const AnimatedDots({super.key, 
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
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 3,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: const Color.fromARGB(235, 10, 172, 72).withOpacity(
              index == currentIndex ? 0.7 : 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
