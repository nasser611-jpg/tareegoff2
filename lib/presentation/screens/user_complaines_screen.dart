import 'dart:ffi';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tareegoff22/core/utils.dart';
import 'package:tareegoff22/core/styles.dart';
import 'package:tareegoff22/presentation/widgets/custom_app_bar.dart';
import 'package:tareegoff22/presentation/screens/google_map_screen.dart';

class UserComplainesScreen extends StatefulWidget {
  const UserComplainesScreen({Key? key}) : super(key: key);

  @override
  State<UserComplainesScreen> createState() => _UserComplainesScreenState();
}

class _UserComplainesScreenState extends State<UserComplainesScreen> {
  List<String> comp = [
    'تحت المراجعه',
    'مقبول',
    'مرفوض',
    'تحت المراجعه',
    'مقبول',
    'مرفوض',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('طلباتي', Icons.account_circle),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.builder(
            itemCount: comp.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                height: MediaQuery.of(context).size.height * 0.099,
                width: MediaQuery.of(context).size.width * 0.850,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                        color:
                            Color.fromARGB(255, 216, 115, 115).withOpacity(0.2),
                        width: 2)),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return GoogleMapsScreen(
                                      lan: 15.840799375481271,
                                      long: 48.46553424859829);
                                },
                              ));
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Color.fromARGB(255, 93, 141, 118),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'الموقع',
                                  style: Styles.textStyle12,
                                )
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 22,
                          width: 88,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: comp[index] == 'مقبول'
                                  ? Color.fromARGB(255, 81, 237, 161)
                                  : comp[index] == 'مرفوض'
                                      ? Color.fromARGB(255, 239, 105, 105)
                                      : Color.fromARGB(255, 234, 190, 115)),
                          child: Text(
                            comp[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromARGB(212, 83, 69, 47)),
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Text(
                              '2342424',
                              style: Styles.textStyle12,
                            ),
                            Text(
                              'رقم الطلب : ',
                              textDirection: TextDirection.rtl,
                            )
                          ],
                        ),
                        Spacer(),
                        Text(
                          formattedDateTime,
                          style: TextStyle(fontSize: 11),
                        )
                      ],
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
