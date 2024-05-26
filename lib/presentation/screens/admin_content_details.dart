import 'package:flutter/material.dart';
import 'package:tareegoff22/core/styles.dart';
import 'package:tareegoff22/presentation/screens/google_map_screen.dart';

class AdminContentDetails extends StatelessWidget {
  final String date, imgUrl, decription;
  final double lan, long;
  const AdminContentDetails({
    super.key,
    required this.date,
    required this.imgUrl,
    required this.decription,
    required this.lan,
    required this.long,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 169, 169, 168),
      child: Column(
        children: [
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(
                  top: 70, left: 15, right: 15, bottom: 20),
              height: MediaQuery.of(context).size.height * 0.450,
              width: MediaQuery.of(context).size.height * 0.320,
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(imgUrl)),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Divider(
            thickness: 4,
            color: const Color.fromARGB(255, 236, 228, 228).withOpacity(
              0.2,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(right: 15, left: 10, top: 30),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(7)),
            child: Column(children: [
              Text(
                '''$decription  ''',
                style: Styles.textStyle12,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.0300,
              ),
              Text(
                date,
                style: Styles.textStyle12.copyWith(
                    fontSize: 10, color: const Color.fromARGB(255, 47, 46, 46)),
              )
            ]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.100,
          ),
          Container(
            padding: const EdgeInsets.only(right: 8),
            alignment: Alignment.center,
            height: 50,
            width: 160,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 110, 108, 108),
                borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) {
                        return GoogleMapsScreen(lan: lan, long: long);
                      },
                    ));
                GoogleMapsScreen(lan: lan, long: long);
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (context) {
                                return GoogleMapsScreen(lan: lan, long: long);
                              },
                            ));
                      },
                      icon: const Icon(Icons.location_on_outlined),
                      iconSize: 25,
                      color: const Color.fromARGB(255, 228, 232, 230),
                    ),
                    Text(
                      ' انقر لرؤية الموقــع',
                      style: Styles.textStyle12.copyWith(
                          fontSize: 11,
                          color: const Color.fromARGB(223, 241, 238, 238)),
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
