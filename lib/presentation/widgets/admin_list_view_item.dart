import 'package:flutter/material.dart';
import 'package:tareegoff22/presentation/widgets/custom_animate_dots.dart';

class CustomListViewItem extends StatefulWidget {
  const CustomListViewItem({Key? key}) : super(key: key);

  @override
  _CustomListViewItemState createState() => _CustomListViewItemState();
}

class _CustomListViewItemState extends State<CustomListViewItem> {
  final List<String> imgUrl = const [
    'assets/images/kh1.jpg',
    'assets/images/kh2.jpg',
    'assets/images/kh5.jpg',
    'assets/images/kh1.jpg',
    'assets/images/kh2.jpg',
    'assets/images/kh5.jpg',
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      height: MediaQuery.of(context).size.height * 0.250,
      padding: EdgeInsets.only(left: 1, right: 1, top: 1, bottom: 1),
      child: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imgUrl.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Container(
                  margin: const EdgeInsets.all(6),

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          width: 1, color: Color.fromARGB(255, 80, 160, 226)),
                      image: DecorationImage(
                          image: AssetImage(
                            imgUrl[index],
                          ),
                          fit: BoxFit.cover)),
                  // child: Image.asset(
                  //   imgUrl[index],
                  //   fit: BoxFit.cover,
                  // ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: AnimatedDots(
              currentIndex: _currentIndex,
              itemCount: imgUrl.length,
            ),
          ),
        ],
      ),
    );
  }
}
